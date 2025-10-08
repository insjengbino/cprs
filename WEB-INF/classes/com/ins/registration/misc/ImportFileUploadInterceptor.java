// Secure, Java 1.5 compatible rewrite of ImportFileUploadInterceptor
// - No try-with-resources
// - No Java 7+ APIs
// - Preserves Struts2 FileUploadInterceptor contract
// author: Jem (fixed)

package com.ins.registration.misc;

import com.opensymphony.xwork2.ValidationAware;
import com.opensymphony.xwork2.util.LocalizedTextUtil;
import java.awt.Graphics2D;
import java.awt.Image;
import java.awt.image.BufferedImage;
import java.io.BufferedReader;
import java.io.File;
import java.io.FileInputStream;
import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.FileReader;
import java.io.IOException;
import java.io.InputStream;
import java.util.HashSet;
import java.util.Locale;
import java.util.Set;
import javax.imageio.ImageIO;
import javax.imageio.stream.ImageInputStream;
import org.apache.commons.logging.Log;
import org.apache.commons.logging.LogFactory;
import org.apache.struts2.interceptor.FileUploadInterceptor;

public class ImportFileUploadInterceptor extends FileUploadInterceptor {
    private final Log log = LogFactory.getLog(this.getClass());
    private static final String DEFAULT_MESSAGE = "no.message.found";
    private static final int MAX_RESIZE_PASSES = 1; // limit resizing to avoid potential abuse

    // allowed types set is instance-level because it is configured per-interceptor instance
    private Set<String> allowedTypesSet = new HashSet<String>();

    public ImportFileUploadInterceptor() {
        log.info("ImportFileUploadInterceptor initialized");
    }

    protected boolean acceptFile(File file, String contentType, String inputName, ValidationAware validation, Locale locale) {
        boolean fileIsAcceptable = false;

        if (file == null) {
            String errMsg = this.getTextMessage("struts.messages.error.uploading", new Object[] { inputName }, locale);
            if (validation != null) {
                validation.addFieldError(inputName, errMsg);
            }
            this.log.error(errMsg);
            return false;
        }

        log.debug("File name: " + file.getName() + ", raw contentType: " + contentType + ", size: " + file.length());

        // Normalize contentType (strip parameters and trim)
        String normalizedContentType = "";
        if (contentType != null) {
            String tmp = contentType.toLowerCase().trim();
            String[] parts = tmp.split(";");
            normalizedContentType = (parts.length > 0) ? parts[0].trim() : tmp;
        }
        log.debug("Normalized content type: [" + normalizedContentType + "]");

        // 1) Basic content-type whitelist check if configured (keeps original behaviour)
        if (this.allowedTypesSet != null && !this.allowedTypesSet.isEmpty()) {
            log.debug("Allowed types: " + this.allowedTypesSet);
            if (!containsItem(this.allowedTypesSet, normalizedContentType)) {
                String logMsg = this.getTextMessage("struts.messages.error.content.type.not.allowed",
                        new Object[] { inputName, file.getName(), normalizedContentType }, locale);
                String errMsg = "Content-type not allowed.";
                if (validation != null) {
                    validation.addFieldError(inputName, errMsg);
                }
                this.log.error(logMsg);
                return false;
            }
        }

        // 2) filename sanitization (still log only; do not rely on temp name for extension)
        String sanitized = sanitizeFilename(file.getName());
        if (!sanitized.equals(file.getName())) {
            this.log.warn("Filename sanitized from '" + file.getName() + "' to '" + sanitized + "'");
        }

        // 3) Validate actual image headers (magic bytes) using ImageIO readers
        //    This is the authoritative check whether the file is an image.
        if (!isValidImage(file)) {
            String logMsg = this.getTextMessage("struts.messages.error.content.type.not.allowed",
                    new Object[] { inputName, file.getName(), normalizedContentType }, locale);
            String errMsg = "The uploaded image appears to be invalid or corrupted. Please use a valid JPG or PNG image.";
            if (validation != null) {
                validation.addFieldError(inputName, errMsg);
            }
            this.log.error(logMsg);
            this.log.error("File failed image header validation: " + file.getName());
            return false;
        }

        // 4) Size handling
        if (this.maximumSize != null && this.maximumSize < file.length()) {
            if (normalizedContentType.startsWith("text")) {
                String errMsg = this.getTextMessage("struts.messages.error.file.too.large",
                        new Object[] { this.maximumSize, file.length() }, locale);
                if (validation != null) {
                    validation.addFieldError(inputName, errMsg);
                }
                this.log.error(errMsg);
                return false;
            }

            // Try a limited resize pass. If still too large, reject.
            boolean resized = false;
            try {
                resized = resizeImageFile(file, this.maximumSize, MAX_RESIZE_PASSES);
            } catch (IOException e) {
                this.log.debug("Error while attempting to resize: " + e.getMessage(), e);
                resized = false;
            }

            if (this.maximumSize != null && this.maximumSize < file.length()) {
                String errMsg = this.getTextMessage("struts.messages.error.file.too.large",
                        new Object[] { this.maximumSize, file.length() }, locale);
                if (validation != null) {
                    validation.addFieldError(inputName, errMsg);
                }
                this.log.error(errMsg);
                return false;
            } else {
                fileIsAcceptable = true;
            }

        } else {
            // For text files: light validation for CSV-like content (preserve original behaviour but safer)
            if (normalizedContentType.startsWith("text")) {
                BufferedReader reader = null;
                try {
                    reader = new BufferedReader(new FileReader(file));
                    String s;
                    while ((s = reader.readLine()) != null) {
                        // split on comma, keep empty tokens
                        String[] tokens = s.split(",", -1);
                        if (tokens.length < 3) {
                            String logMsg = this.getTextMessage("struts.messages.error.content.type.not.allowed",
                                    new Object[] { inputName, file.getName(), normalizedContentType }, locale);
                            String errMsg = "Invalid file type.";
                            if (validation != null) {
                                validation.addFieldError(inputName, errMsg);
                            }
                            this.log.error(logMsg);
                            return false;
                        }
                        // additional safety: reject lines that contain angle brackets or suspicious sequences
                        if (s.indexOf('<') != -1 || s.indexOf('>') != -1) {
                            String errMsg = "Text file contains suspicious characters";
                            if (validation != null) {
                                validation.addFieldError(inputName, errMsg);
                            }
                            this.log.error(errMsg + " in file: " + file.getName());
                            return false;
                        }
                    }
                } catch (FileNotFoundException e) {
                    this.log.debug(e);
                } catch (IOException e) {
                    this.log.debug(e);
                } finally {
                    if (reader != null) {
                        try { reader.close(); } catch (IOException e) { this.log.debug(e); }
                    }
                }
            }

            fileIsAcceptable = true;
        }

        return fileIsAcceptable;
    }

    /**
     * Case-insensitive contains check
     */
    private boolean containsItem(Set<String> set, String value) {
        if (set == null || value == null) return false;
        String lw = value.toLowerCase().trim();
        for (String o : set) {
            if (o != null && lw.equals(o.toLowerCase().trim())) {
                return true;
            }
        }
        return false;
    }

    private Set<String> getDelimitedValues(String str) {
        Set<String> set = new HashSet<String>();
        if (str != null) {
            String[] values = str.split("[,\\s]+");
            for (int i = 0; i < values.length; i++) {
                String val = values[i];
                if (val != null && val.trim().length() > 0) {
                    set.add(val.trim().toLowerCase());
                }
            }
        }
        return set;
    }

    private static boolean isNonEmpty(Object[] objArray) {
        boolean result = false;
        for (int index = 0; index < objArray.length && !result; ++index) {
            if (objArray[index] != null) {
                result = true;
            }
        }
        return result;
    }

    private String getTextMessage(String messageKey, Object[] args, Locale locale) {
        if (args != null && args.length != 0) {
            return LocalizedTextUtil.findText(this.getClass(), messageKey, locale, DEFAULT_MESSAGE, args);
        } else {
            return LocalizedTextUtil.findText(this.getClass(), messageKey, locale);
        }
    }

    private String sanitizeFilename(String filename) {
        if (filename == null) return "";
        // remove path separators and replace suspicious chars
        String name = filename.replaceAll("[\\\\/]+", "_");
        name = name.replaceAll("[^a-zA-Z0-9._-]", "_");
        return name;
    }

    private boolean isValidImage(File file) {
        ImageInputStream iis = null;
        try {
            iis = ImageIO.createImageInputStream(file);
            if (iis == null) return false;
            return ImageIO.getImageReaders(iis).hasNext();
        } catch (IOException e) {
            this.log.debug("Error validating image header: " + e.getMessage(), e);
            return false;
        } finally {
            if (iis != null) {
                try { iis.close(); } catch (IOException e) { this.log.debug(e); }
            }
        }
    }

    /**
     * Attempt to resize the image up to maxPasses times. Writes to a temp file and replaces the original
     * if resize succeeds. Returns true if a resize was performed (not necessarily that file is now under limit).
     */
    private boolean resizeImageFile(File file, long maxSize, int maxPasses) throws IOException {
        if (file == null) return false;
        boolean resizedAny = false;

        for (int pass = 0; pass < maxPasses && file.length() > maxSize; pass++) {
            BufferedImage src = ImageIO.read(file);
            if (src == null) {
                // not a readable image
                return false;
            }

            int newW = Math.max(1, src.getWidth() / 2);
            int newH = Math.max(1, src.getHeight() / 2);

            BufferedImage dest = new BufferedImage(newW, newH, BufferedImage.TYPE_INT_RGB);
            Graphics2D g = dest.createGraphics();
            try {
                g.drawImage(src.getScaledInstance(newW, newH, Image.SCALE_SMOOTH), 0, 0, null);
            } finally {
                g.dispose();
            }

            // write to temporary file to avoid partial writes
            String ext = "jpg"; // fallback
            File tmp = File.createTempFile("upload_resize_", "." + ext);
            try {
                ImageIO.write(dest, "jpg", tmp);
            } finally {
                // no streams from ImageIO.write to close here
            }

            // replace original file (try simple rename; if fails, copy bytes)
            boolean replaced = tmp.renameTo(file);
            if (!replaced) {
                InputStream in = null;
                FileOutputStream out = null;
                try {
                    in = new FileInputStream(tmp);
                    out = new FileOutputStream(file);
                    byte[] buffer = new byte[4096];
                    int read;
                    while ((read = in.read(buffer)) != -1) {
                        out.write(buffer, 0, read);
                    }
                } finally {
                    if (in != null) try { in.close(); } catch (IOException e) { this.log.debug(e); }
                    if (out != null) try { out.close(); } catch (IOException e) { this.log.debug(e); }
                    try { tmp.delete(); } catch (SecurityException se) { /* ignore */ }
                }
            }

            resizedAny = true;
        }

        return resizedAny;
    }

    private String getExtension(String filename) {
        if (filename == null) return null;
        int dot = filename.lastIndexOf('.');
        if (dot == -1) return null;
        return filename.substring(dot + 1).toLowerCase();
    }

    // Struts setter invoked from XML param
    public void setAllowedTypes(String allowedTypes) {
        this.allowedTypesSet = getDelimitedValues(allowedTypes);
    }
}

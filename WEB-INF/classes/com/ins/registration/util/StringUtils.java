package com.ins.registration.util;


public final class StringUtils {

    // Prevent instantiation
    private StringUtils() {}

    /**
     * Checks if a string is null or empty ("").
     */
    public static boolean isEmpty(String s) {
        return (s == null || s.length() == 0);
    }

    /**
     * Checks if a string is NOT null or empty ("").
     */
    public static boolean isNotEmpty(String s) {
        return !isEmpty(s);
    }

    /**
     * Checks if a string is null, empty, or only whitespace.
     */
    public static boolean isBlank(String s) {
        return (s == null || s.trim().length() == 0);
    }


    /**
     * Checks if a string is null, empty, or only whitespace.
     */
    public static boolean isNotBlank(String s) {
        return !isBlank(s);
    }

    /**
     * Returns a default string if input is null.
     */
    public static String defaultIfNull(String s, String defaultStr) {
        return (s == null ? defaultStr : s);
    }

    /**
     * Safely trims a string (returns null if input is null).
     */
    public static String safeTrim(String s) {
        return (s == null ? null : s.trim());
    }

    /**
     * Checks if two strings are equal, handling nulls safely.
     */
    public static boolean equals(String a, String b) {
        return (a == null ? b == null : a.equals(b));
    }

    /**
     * Checks if two strings are equal ignoring case, handling nulls safely.
     */
    public static boolean equalsIgnoreCase(String a, String b) {
        return (a == null ? b == null : a.equalsIgnoreCase(b));
    }
}
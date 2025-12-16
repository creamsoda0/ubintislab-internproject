package com.ubintis.board.util;

public class MaskingUtil {

    // 아이디 마스킹 (앞 3자리 노출, 나머지 *)
    public static String maskId(String id) {
        if (id == null || id.length() < 3) {
            return id; // 너무 짧으면 그대로 반환하거나 별도 처리
        }
        return id.substring(0, 3) + "*".repeat(id.length() - 3);
    }

    // 이름 마스킹 (2글자면 뒤 1자, 3글자 이상이면 가운데 *)
    public static String maskName(String name) {
        if (name == null || name.length() < 2) {
            return name;
        }

        if (name.length() == 2) {
            return name.substring(0, 1) + "*"; // 김철 -> 김*
        } else {
            
            String first = name.substring(0, 1);
            String last = name.substring(name.length() - 1);
            String middle = "*".repeat(name.length() - 2);
            return first + middle + last;
        }
    }
}
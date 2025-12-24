package com.ubintis.board.util;

import java.io.BufferedReader;
import java.io.DataOutputStream;
import java.io.InputStreamReader;
import java.net.URL;

import javax.net.ssl.HttpsURLConnection;

public class VerifyRecaptcha {
    public static final String SITE_VERIFY_URL = " https://www.google.com/recaptcha/api/siteverify";

    public static boolean verify(String gRecaptchaResponse, String secretKey) throws Exception {
        if (gRecaptchaResponse == null || gRecaptchaResponse.isEmpty()) return false;

        URL url = new URL(SITE_VERIFY_URL);
        HttpsURLConnection con = (HttpsURLConnection) url.openConnection();
        con.setRequestMethod("POST");

        String postParams = "secret=" + secretKey + "&response=" + gRecaptchaResponse;
        con.setDoOutput(true);
        try (DataOutputStream wr = new DataOutputStream(con.getOutputStream())) {
            wr.writeBytes(postParams);
            wr.flush();
        }

        // 응답 JSON 파싱 (간단하게 BufferedReader 사용)
        BufferedReader in = new BufferedReader(new InputStreamReader(con.getInputStream()));
        StringBuilder response = new StringBuilder();
        String inputLine;
        while ((inputLine = in.readLine()) != null) response.append(inputLine);
        in.close();

        // 결과 중 "success": true 여부 확인 (Jackson이나 Gson 라이브러리 권장)
        return response.toString().contains("\"success\": true");
    }
}

package org.seckill.utils;

import org.seckill.entity.WeixinMedia;
import org.seckill.web.InteractController;

import javax.servlet.http.Cookie;
import javax.servlet.http.HttpServletRequest;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.util.UUID;

public class CommUtil {

    public static String httpRequestToFile(String fileName, String method, String mediaId) {
        if (method == null) {
            return null;
        }
        String error = "";
        String access_token = InteractController.ACCESS_TOKEN;
        String path = "https://qyapi.weixin.qq.com/cgi-bin/media/get?access_token=" + access_token + "&media_id=" + mediaId;

        HttpURLConnection conn = null;
        InputStream inputStream = null;
        try {
            //请求微信URL
            URL url = new URL(path);
            conn = (HttpURLConnection) url.openConnection();
            conn.setRequestMethod(method);
            conn.setDoOutput(true);
            conn.setDoInput(true);
            conn.setUseCaches(false);
            inputStream = conn.getInputStream();


            //fileName = fileName + mediaId + ".jpg";
            //写入文件
            if (inputStream != null) {
                BufferedOutputStream bos = new BufferedOutputStream(new FileOutputStream(fileName));
                byte[] data = new byte[1024];
                int len = -1;
                while ((len = inputStream.read(data)) != -1) {
                    bos.write(data, 0, len);
                }
                bos.close();
                inputStream.close();
            } else {
                return "错误";
            }
        } catch (Exception e) {
            e.printStackTrace();
            error = e.getMessage();
            System.out.println("error:" + e.getMessage());
        } finally {
            if (conn != null) {
                conn.disconnect();
            }
        }
        return "最后" + error;
    }


    public static String showUserIdCookie(HttpServletRequest request) {

        Cookie[] cookies = request.getCookies();//这样便可以获取一个cookie数组
        if (null == cookies) {
            System.out.println("没有cookie=========");
            return null;
        } else {
            for (Cookie cookie : cookies) {
                //logger.error("cookieName:" + cookie.getName() + ",value:" + cookie.getValue());
                if ("user_id".equals(cookie.getName())) {
                    return cookie.getValue();
                }
            }
        }
        return null;
    }

    public static String showIsAdminCookie(HttpServletRequest request) {

        Cookie[] cookies = request.getCookies();//这样便可以获取一个cookie数组
        if (null == cookies) {
            System.out.println("没有cookie=========");
            return null;
        } else {
            for (Cookie cookie : cookies) {
                //logger.error("cookieName:" + cookie.getName() + ",value:" + cookie.getValue());
                if ("is_admin".equals(cookie.getName())) {

                    return cookie.getValue();
                }
            }
        }
        return null;
    }

    public static String showSelectUuidCookie(HttpServletRequest request) {

        Cookie[] cookies = request.getCookies();//这样便可以获取一个cookie数组
        if (null == cookies) {

            return null;
        } else {
            for (Cookie cookie : cookies) {
                //logger.error("cookieName:" + cookie.getName() + ",value:" + cookie.getValue());
                if ("selectUuid".equals(cookie.getName())) {

                    return cookie.getValue();
                }
            }
        }
        return null;
    }

    public static void setSelectUuidCookie(HttpServletRequest request) {

        Cookie[] cookies = request.getCookies();//这样便可以获取一个cookie数组
        if (null == cookies) {
            System.out.println("没有cookie=========");

        } else {
            for (Cookie cookie : cookies) {
                //logger.error("cookieName:" + cookie.getName() + ",value:" + cookie.getValue());
                if ("selectUuid".equals(cookie.getName())) {

                    cookie.setValue("1");
                }
            }
        }

    }

    /**
     * 使用java正则表达式去掉多余的.与0
     *
     * @param s
     * @return
     */
    public static String zero(String s) {
        if (s.indexOf(".") > 0) {
            s = s.replaceAll("0+?$", "");//去掉多余的0
            s = s.replaceAll("[.]$", "");//如最后一位是.则去掉
        }
        return s;
    }

    /**
     * uuid生成
     *
     * @return
     */
    public static String getUUID32() {
        String uuid = UUID.randomUUID().toString().replace("-", "").toLowerCase();
        return uuid;
//  return UUID.randomUUID().toString().replace("-", "").toLowerCase();
    }

}

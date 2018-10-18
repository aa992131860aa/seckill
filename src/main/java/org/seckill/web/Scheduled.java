package org.seckill.web;

import com.google.gson.Gson;
import org.seckill.entity.WeixinToken;
import org.seckill.service.ContractService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import javax.servlet.http.HttpServletResponse;
import java.io.BufferedReader;
import java.io.InputStream;
import java.io.InputStreamReader;
import java.io.PrintWriter;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;

@Controller
public class Scheduled {
    @Autowired
    ContractService contractService;
    private int index = 0;

    /**
     * 0 0 10,14,16 * * ? 每天上午10点，下午2点，4点
     * 0 0/30 9-17 * * ?   朝九晚五工作时间内每半小时
     * 0 0 12 ? * WED 表示每个星期三中午12点
     * "0 0 12 * * ?" 每天中午12点触发
     * "0 15 10 ? * *" 每天上午10:15触发
     * "0 15 10 * * ?" 每天上午10:15触发
     * "0 15 10 * * ? *" 每天上午10:15触发
     * "0 15 10 * * ? 2005" 2005年的每天上午10:15触发
     * "0 * 14 * * ?" 在每天下午2点到下午2:59期间的每1分钟触发
     * "0 0/5 14 * * ?" 在每天下午2点到下午2:55期间的每5分钟触发
     * "0 0/5 14,18 * * ?" 在每天下午2点到2:55期间和下午6点到6:55期间的每5分钟触发
     * "0 0-5 14 * * ?" 在每天下午2点到下午2:05期间的每1分钟触发
     * "0 10,44 14 ? 3 WED" 每年三月的星期三的下午2:10和2:44触发
     * "0 15 10 ? * MON-FRI" 周一至周五的上午10:15触发
     * "0 15 10 15 * ?" 每月15日上午10:15触发
     * "0 15 10 L * ?" 每月最后一日的上午10:15触发
     * "0 15 10 ? * 6L" 每月的最后一个星期五上午10:15触发
     * "0 15 10 ? * 6L 2002-2005" 2002年至2005年的每月的最后一个星期五上午10:15触发
     * "0 15 10 ? * 6#3" 每月的第三个星期五上午10:15触发
     * 0  0  0  *  *  ?
     **/
//物业费有个坑
    @org.springframework.scheduling.annotation.Scheduled(cron = "0  0/1  *  *  *  ?")
    public void task() {
        System.out.println("1分钟时间到了,开不开心");
        //处理合同到期,客户的职员登记的车位回写

        contractService.updateDeadline();

        contractService.updateDeadlineDel();
        contractService.updateDeadlineNo();

        if (index % 20 == 0) {
            String urlStr = "https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=" + InteractController.CORPID + "&corpsecret=" + InteractController.CORPSECRET;
            String result = processUrl(urlStr);
            WeixinToken weixinToken = new Gson().fromJson(result, WeixinToken.class);
            InteractController.ACCESS_TOKEN = weixinToken.getAccess_token();
            System.out.println("result:" + result);
        }
        index++;
    }

    private String processUrl(String urlStr) {
        URL url;
        try {
            url = new URL(urlStr);
            URLConnection URLconnection = url.openConnection();
            HttpURLConnection httpConnection = (HttpURLConnection) URLconnection;
            int responseCode = httpConnection.getResponseCode();
            if (responseCode == HttpURLConnection.HTTP_OK) {
                InputStream urlStream = httpConnection.getInputStream();
                BufferedReader bufferedReader = new BufferedReader(new InputStreamReader(urlStream));
                String sCurrentLine = "";
                String sTotalString = "";
                while ((sCurrentLine = bufferedReader.readLine()) != null) {
                    sTotalString += sCurrentLine;
                }

                return sTotalString;
            } else {
                System.err.println("失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
        return "";
    }
}

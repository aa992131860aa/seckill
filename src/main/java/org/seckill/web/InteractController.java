package org.seckill.web;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.seckill.entity.*;
import org.seckill.service.InteractService;
import org.seckill.utils.CONST;
import org.seckill.utils.CommUtil;
import org.seckill.utils.ExcelUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.net.HttpURLConnection;
import java.net.URL;
import java.net.URLConnection;
import java.security.MessageDigest;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/seckill")
public class InteractController {
    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    //public final static String CORPID = "wwe075ae31020813cf";

    public final static String CORPID = "ww3074360d47d2b7ed";
    //public final static String CORPSECRET = "A_Q2l9BQQ_1osvE4nE7g9s49vEcmBIY323wD13KPdM0";
    public final static String CORPSECRET = "Japxj2gozyp0N4ZgN1yrb17flBdQM-XQz--G2-B7wyg";

    public static String ACCESS_TOKEN = "";

    @Autowired
    InteractService interactService;

    @RequestMapping(value = "/interact_safe/{userId}/{page}/{type}/safe", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String list(Model model, HttpServletRequest request, @PathVariable("type") String type, @PathVariable("userId") int userId, @PathVariable("page") int page) {


        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String date = sdf.format(new Date());
        model.addAttribute("date", date);

        List<Safe> safeList = interactService.gainSafeList(type, date, page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = interactService.gainSafeListTotal(type, date);
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        model.addAttribute("safeList", safeList);
        model.addAttribute("total", total);
        model.addAttribute("date", date);

        model.addAttribute("access_token", InteractController.ACCESS_TOKEN);
        return "interact_safe";
    }

    @RequestMapping(value = "/display/{floor}/{style}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String display(Model model, HttpServletRequest request,@PathVariable("style")String style, @PathVariable("floor") int floor) {


        List<House> houseList = interactService.gainHouseList(floor,style);
        model.addAttribute("houseList", houseList);
        HouseSite houseSite = interactService.gainHouseSite();
        model.addAttribute("houseSite", houseSite);
        model.addAttribute("floor", floor);
        List<List<House>> houseListList = dealColumnRow(houseList);
        model.addAttribute("houseListList", houseListList);
        model.addAttribute("style",style);
        return "display";
    }

    private List<List<House>> dealColumnRow(List<House> houseList) {
        List<List<House>> houseListList = new ArrayList<List<House>>();
        //遍历横20行,竖20行
        int columnSize = 50, rowSize = 50;
        for (int i = 0; i < rowSize; i++) {

            List<House> tempHouseList = new ArrayList<House>();

            for (int j = 0; j < columnSize; j++) {
                //原本的house,是否存在
                String flag1 = (i + 1) + "," + (j + 1), flag2 = (i + 1) + "，" + (j + 1);
                int flag = 0;
                for (int m = 0; m < houseList.size(); m++) {
                    if (houseList.get(m).getChartLoc().trim().equals(flag1) || houseList.get(m).getChartLoc().trim().equals(flag2)) {
                        flag = 1;
                        tempHouseList.add(houseList.get(m));
                        break;
                    }
                }
                if (flag == 0) {
                    tempHouseList.add(new House());
                }
            }
            houseListList.add(tempHouseList);
        }

        return houseListList;
    }

    @RequestMapping(value = "/display/{column}/{row}/{floor}/{type}/{style}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String displayUpdate(Model model, HttpServletRequest request,@PathVariable("style")String style, @PathVariable("floor") int floor, @PathVariable("column") int column, @PathVariable("row") int row, @PathVariable("type") String type) {

        if ("addColumn".equals(type)) {
            column++;
        }
        if ("minusColumn".equals(type)) {
            column--;
        }
        if ("addRow".equals(type)) {
            row++;
        }
        if ("minusRow".equals(type)) {
            row--;
        }
        if (column > 50) {
            column = 50;
        }
        if (row > 50) {
            row = 50;
        }
        if (column < 4) {
            column = 4;
        }
        if (row < 4) {
            row = 4;
        }
        interactService.updateHouseSite(column, row);
        HouseSite houseSite = interactService.gainHouseSite();
        List<House> houseList = interactService.gainHouseList(floor,style);
        model.addAttribute("houseSite", houseSite);
        model.addAttribute("floor", floor);
        List<List<House>> houseListList = dealColumnRow(houseList);
        model.addAttribute("houseListList", houseListList);
        model.addAttribute("style",style);
        return "display";
    }

    @RequestMapping(value = "/interact_feedback/{userId}/{page}/{userName}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String listFeedback(Model model, HttpServletRequest request, @PathVariable("userName") String userName, @PathVariable("userId") int userId, @PathVariable("page") int page) {


        List<Feedback> feedbackList = interactService.gainFeedbackList(userName, page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);

        int total = interactService.gainFeedbackListTotal(userName);
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        model.addAttribute("feedbackList", feedbackList);
        model.addAttribute("total", total);


        return "interact_feedback";
    }

    @RequestMapping(value = "/interact_feedback/{userId}/{page}/deal", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String listFeedbackDeal(Model model, HttpServletRequest request, @PathVariable("userId") int userId, @PathVariable("page") int page) {


        List<Feedback> feedbackList = interactService.gainFeedbackAllList(page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);

        int total = interactService.gainFeedbackAllListTotal();
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        model.addAttribute("feedbackList", feedbackList);
        model.addAttribute("total", total);


        return "interact_feedback_deal";
    }

    @RequestMapping(value = "/interact_feedback/{userId}/{page}/{userName}/{startDate}/{endDate}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String listFeedbackDealQuery(Model model, HttpServletRequest request, @PathVariable("userId") int userId, @PathVariable("page") int page,
                                        @PathVariable("userName") String userName, @PathVariable("startDate") String startDate, @PathVariable("endDate") String endDate) {

        String fantasy = "fantasy";
        if (userName.equals(fantasy)) {
            userName = "";
        }
        if (startDate.equals(fantasy)) {
            startDate = "";
        }
        if (endDate.equals(fantasy)) {
            endDate = "";
        }
        List<Feedback> feedbackList = interactService.gainFeedbackQuery(userName, startDate, endDate, page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);

        int total = interactService.gainFeedbackQueryTotal(userName, startDate, endDate);
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        model.addAttribute("feedbackList", feedbackList);
        model.addAttribute("total", total);
        model.addAttribute("query", "query");
        model.addAttribute("userName", userName);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);


        return "interact_feedback_deal";
    }

    @RequestMapping(value = "/interact_clean/{userId}/{page}/{type}/clean", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String clean(Model model, HttpServletRequest request, @PathVariable("type") String type, @PathVariable("userId") int userId, @PathVariable("page") int page) {


        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String date = sdf.format(new Date());
        model.addAttribute("date", date);

        List<Safe> safeList = interactService.gainSafeList(type, date, page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = interactService.gainSafeListTotal(type, date);
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        model.addAttribute("safeList", safeList);
        model.addAttribute("total", total);
        model.addAttribute("date", date);

        model.addAttribute("access_token", InteractController.ACCESS_TOKEN);
        return "interact_clean";
    }

    @RequestMapping(value = "/interact_safe_deal/{userId}/{page}/{type}/safe", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String listDeal(Model model, HttpServletRequest request, @PathVariable("type") String type, @PathVariable("userId") int userId, @PathVariable("page") int page) {


        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String date = sdf.format(new Date());
        model.addAttribute("date", date);

        List<Safe> safeList = interactService.gainSafeListAll(type, page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = interactService.gainSafeListAllTotal(type);
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        model.addAttribute("safeList", safeList);
        model.addAttribute("total", total);
        model.addAttribute("date", date);

        model.addAttribute("access_token", InteractController.ACCESS_TOKEN);
        return "interact_safe_deal";
    }

    @RequestMapping(value = "/interact_safe_deal/{userId}/{page}/{type}/safe/{userName}/{startDate}/{endDate}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String listDealQuery(Model model, HttpServletRequest request, @PathVariable("userName") String userName, @PathVariable("startDate") String startDate, @PathVariable("endDate") String endDate, @PathVariable("type") String type, @PathVariable("userId") int userId, @PathVariable("page") int page) {
        String fantasy = "fantasy";
        if (userName.equals(fantasy)) {
            userName = "";
        }
        if (startDate.equals(fantasy)) {
            startDate = "";
        }
        if (endDate.equals(fantasy)) {
            endDate = "";
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String date = sdf.format(new Date());
        model.addAttribute("date", date);

        List<Safe> safeList = interactService.gainSafeListQuery(type, userName, startDate, endDate, page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = interactService.gainSafeListTotalQuery(type, userName, startDate, endDate);
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        model.addAttribute("safeList", safeList);
        model.addAttribute("total", total);
        model.addAttribute("date", date);
        model.addAttribute("query", "query");
        model.addAttribute("userName", userName);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        model.addAttribute("access_token", InteractController.ACCESS_TOKEN);
        return "interact_safe_deal";
    }


    @RequestMapping(value = "/interact_clean_deal/{userId}/{page}/{type}/clean", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String listClean(Model model, HttpServletRequest request, @PathVariable("type") String type, @PathVariable("userId") int userId, @PathVariable("page") int page) {


        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String date = sdf.format(new Date());
        model.addAttribute("date", date);

        List<Safe> safeList = interactService.gainSafeListAll(type, page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = interactService.gainSafeListAllTotal(type);
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        model.addAttribute("safeList", safeList);
        model.addAttribute("total", total);
        model.addAttribute("date", date);

        model.addAttribute("access_token", InteractController.ACCESS_TOKEN);
        return "interact_clean_deal";
    }

    @RequestMapping(value = "/interact_clean_deal/{userId}/{page}/{type}/clean/{userName}/{startDate}/{endDate}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String listCleanQuery(Model model, HttpServletRequest request, @PathVariable("userName") String userName, @PathVariable("startDate") String startDate, @PathVariable("endDate") String endDate, @PathVariable("type") String type, @PathVariable("userId") int userId, @PathVariable("page") int page) {
        String fantasy = "fantasy";
        if (userName.equals(fantasy)) {
            userName = "";
        }
        if (startDate.equals(fantasy)) {
            startDate = "";
        }
        if (endDate.equals(fantasy)) {
            endDate = "";
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String date = sdf.format(new Date());
        model.addAttribute("date", date);

        List<Safe> safeList = interactService.gainSafeListQuery(type, userName, startDate, endDate, page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = interactService.gainSafeListTotalQuery(type, userName, startDate, endDate);
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        model.addAttribute("safeList", safeList);
        model.addAttribute("total", total);
        model.addAttribute("date", date);
        model.addAttribute("query", "query");
        model.addAttribute("userName", userName);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        model.addAttribute("access_token", InteractController.ACCESS_TOKEN);
        return "interact_clean_deal";
    }


    @RequestMapping(value = "/interact_safe/{userId}/{page}/{type}/{userName}/{startDate}/{endDate}/query", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String listQuery(Model model, HttpServletRequest request, @PathVariable("endDate") String endDate, @PathVariable("userName") String userName, @PathVariable("startDate") String startDate, @PathVariable("type") String type, @PathVariable("userId") int userId, @PathVariable("page") int page) {


        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String date = sdf.format(new Date());
        String fantasy = "fantasy";
        if (userName.equals(fantasy)) {
            userName = "";
        }
        if (startDate.equals(fantasy)) {
            startDate = "";
        }
        if (endDate.equals(fantasy)) {
            endDate = "";
        }


        List<Safe> safeList = interactService.gainSafeListQuery(type, userName, startDate, endDate, page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = interactService.gainSafeListTotalQuery(type, userName, startDate, endDate);
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        model.addAttribute("safeList", safeList);
        model.addAttribute("total", total);
        model.addAttribute("date", date);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        model.addAttribute("userName", userName);
        model.addAttribute("query", "query");
        model.addAttribute("access_token", InteractController.ACCESS_TOKEN);
        return "interact_safe";
    }

    @RequestMapping(value = "/interact_feedback_deal/{id}/{type}/{insert}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String listAddFeedbackDeal(Model model, HttpServletRequest request, @PathVariable("insert") String insert, @PathVariable("id") int id, @PathVariable("type") String type) {
        String flag1 = "@@";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String date = sdf.format(new Date());
        Feedback feedback = interactService.gainFeedback(id);
        List<FeedbackDeal> feedbackDealList = new ArrayList<FeedbackDeal>();

        if (feedback != null) {
            feedbackDealList = interactService.gainFeedbackDeal(feedback.getId());
            feedback.setContentList(feedback.getContent().split(flag1));
            feedback.setUrlsList(feedback.getUrls().split(flag1));
        }
        model.addAttribute("type", type);

        model.addAttribute("date", date);
        model.addAttribute("access_token", InteractController.ACCESS_TOKEN);
        if (feedbackDealList == null) {
            insert = "insert";
        } else {

            insert = "update";


        }
        if (insert.equals("insert")) {
            model.addAttribute("insert", "insert");
        } else if (insert.equals("update")) {
            model.addAttribute("insert", "update");
        }


        model.addAttribute("feedbackDealList", feedbackDealList);
        model.addAttribute("feedback", feedback);

        return "interact_feedback_deal_add";
    }

    @RequestMapping(value = "/interact_safe_deal/{dot}/{type}/{insert}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String listAddDeal(Model model, HttpServletRequest request, @PathVariable("insert") String insert, @PathVariable("dot") String dot, @PathVariable("type") String type) {
        String flag1 = "@@";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String date = sdf.format(new Date());
        Safe safe = interactService.gainSafe(dot, date);
        List<SafeDeal> safeDealList = new ArrayList<SafeDeal>();
        model.addAttribute("dot", dot);
        model.addAttribute("type", type);

        model.addAttribute("date", date);
        model.addAttribute("access_token", InteractController.ACCESS_TOKEN);


        if (safe != null) {

            safeDealList = interactService.gainSafeDealList(safe.getId());
            safe.setContentList(safe.getContent().split(flag1));
            safe.setUrlsList(safe.getUrls().split(flag1));
        }


        if (safeDealList == null) {
            insert = "insert";
        } else {

            insert = "update";


        }
        if (insert.equals("insert")) {
            model.addAttribute("insert", "insert");
        } else if (insert.equals("update")) {
            model.addAttribute("insert", "update");
        }


        model.addAttribute("safeDealList", safeDealList);
        model.addAttribute("safe", safe);

        return "interact_safe_deal_add";
    }

    @RequestMapping(value = "/interact_safe/{dot}/{type}/{insert}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String listAdd(Model model, HttpServletRequest request, @PathVariable("insert") String insert, @PathVariable("dot") String dot, @PathVariable("type") String type) {
        String flag1 = "@@";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String date = sdf.format(new Date());
        Safe safe = interactService.gainSafe(dot, date);
        model.addAttribute("dot", dot);
        model.addAttribute("type", type);

        model.addAttribute("date", date);
        model.addAttribute("access_token", InteractController.ACCESS_TOKEN);
        List<SafeDeal> safeDealList = new ArrayList<SafeDeal>();
        if (safe == null) {
            insert = "insert";
        } else {
            if (!insert.equals("detail")) {
                insert = "update";
            }
            safeDealList = interactService.gainSafeDealList(safe.getId());

        }
        if (insert.equals("insert")) {
            model.addAttribute("insert", "insert");
        } else if (insert.equals("update")) {
            model.addAttribute("insert", "update");
        } else {
            model.addAttribute("insert", "detail");
        }
        if (safe != null) {
            safe.setContentList(safe.getContent().split(flag1));
            safe.setUrlsList(safe.getUrls().split(flag1));
        }
        model.addAttribute("safe", safe);
        model.addAttribute("safeDealList", safeDealList);
        return "interact_safe_add";
    }

    @RequestMapping(value = "/interact_feedback/{id}/{insert}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String listFeedbackAdd(Model model, HttpServletRequest request, @PathVariable("insert") String insert, @PathVariable("id") int id) {
        String flag1 = "@@";
        Feedback feedback = interactService.gainFeedback(id);
        List<FeedbackDeal> feedbackDealList = new ArrayList<FeedbackDeal>();
        if (feedback != null) {
            feedback.setContentList(feedback.getContent().split(flag1));
            feedback.setUrlsList(feedback.getUrls().split(flag1));
            feedbackDealList = interactService.gainFeedbackDeal(feedback.getId());
        }
        model.addAttribute("feedback", feedback);
        model.addAttribute("feedbackDealList", feedbackDealList);
        model.addAttribute("insert", insert);
        model.addAttribute("access_token", InteractController.ACCESS_TOKEN);
        return "interact_feedback_add";
    }


    @RequestMapping(value = "/interact_clean/{dot}/{type}/{insert}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String listCleanAdd(Model model, HttpServletRequest request, @PathVariable("insert") String insert, @PathVariable("dot") String dot, @PathVariable("type") String type) {
        String flag1 = "@@";
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String date = sdf.format(new Date());
        Safe safe = interactService.gainSafe(dot, date);
        model.addAttribute("dot", dot);
        model.addAttribute("type", type);

        model.addAttribute("date", date);
        model.addAttribute("access_token", InteractController.ACCESS_TOKEN);
        List<SafeDeal> safeDealList = new ArrayList<SafeDeal>();
        if (safe == null) {
            insert = "insert";
        } else {
            if (!insert.equals("detail")) {
                insert = "update";
            }
            safeDealList = interactService.gainSafeDealList(safe.getId());

        }
        if (insert.equals("insert")) {
            model.addAttribute("insert", "insert");
        } else if (insert.equals("update")) {
            model.addAttribute("insert", "update");
        } else {
            model.addAttribute("insert", "detail");
        }
        if (safe != null) {
            safe.setContentList(safe.getContent().split(flag1));
            safe.setUrlsList(safe.getUrls().split(flag1));
        }
        model.addAttribute("safe", safe);
        model.addAttribute("safeDealList", safeDealList);
        return "interact_clean_add";
    }

    @RequestMapping(value = "/interact_safe/{mediaId}/{access_token}/{type}/upload", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public String upload(Model model, HttpServletRequest request, @PathVariable("access_token") String access_token, @PathVariable("mediaId") String mediaId, @PathVariable("type") String type) {
        //  String fileName = this.getClass().getClassLoader().getResource("/download").getPath() + mediaId + ".jpg";
        String fileName = "/usr/local/tomcat/tomcat7/webapps/ROOT/seckill/resources/download/" + mediaId + ".jpg";
        model.addAttribute("access_token", InteractController.ACCESS_TOKEN);
        return CommUtil.httpRequestToFile(fileName, "GET", mediaId);

//        model.addAttribute("type", type);
//        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//        model.addAttribute("date", sdf.format(new Date()));


    }

    @RequestMapping(value = "/interact_feedback_deal/{feedbackId}/{contents}/{userName}/{dates}/{isDeal}/insert", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int uploadFeedbackConfirmSeal(Model model, HttpServletRequest request, @PathVariable("feedbackId") int feedbackId, @PathVariable("contents") String contents, @PathVariable("userName") String userName, @PathVariable("dates") String dates, @PathVariable("isDeal") int isDeal) {
        //    var url = "/seckill/interact_dot/" + dot + "/" + isNormal + "/" + content + "/" + srcUrls + "/add";
        String flag1 = "@@";
        String fantasy = "fantasy";
        if (contents.equals(fantasy)) {
            contents = "";
        }
        if (dates.equals(fantasy)) {
            dates = "";
        }

        interactService.delFeedbackDeal(feedbackId);
        interactService.updateFeedbackIsDeal(feedbackId, isDeal);

        String[] contentsSplit = contents.split(flag1);
        String[] datesSplit = dates.split(flag1);

        for (int i = 0; i < datesSplit.length; i++) {
            if (!"".equals(datesSplit[i])) {
                String content = "";
                if (i < contentsSplit.length) {
                    content = contentsSplit[i];
                }
                interactService.insertFeedbackDeal(feedbackId, datesSplit[i], content, userName);
            }

        }

        return 1;

    }

    @RequestMapping(value = "/interact_safe_deal/{safeId}/{contents}/{userName}/{dates}/{isDeal}/insert", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int uploadConfirmSeal(Model model, HttpServletRequest request, @PathVariable("safeId") int safeId, @PathVariable("contents") String contents, @PathVariable("userName") String userName, @PathVariable("dates") String dates, @PathVariable("isDeal") int isDeal) {
        //    var url = "/seckill/interact_dot/" + dot + "/" + isNormal + "/" + content + "/" + srcUrls + "/add";
        String flag1 = "@@";
        String fantasy = "fantasy";
        if (contents.equals(fantasy)) {
            contents = "";
        }
        if (dates.equals(fantasy)) {
            dates = "";
        }

        interactService.delSafeDeal(safeId);
        interactService.updateSafeIsDeal(safeId, isDeal);

        String[] contentsSplit = contents.split(flag1);
        String[] datesSplit = dates.split(flag1);

        for (int i = 0; i < datesSplit.length; i++) {
            if (!"".equals(datesSplit[i])) {
                String content = "";
                if (i < contentsSplit.length) {
                    content = contentsSplit[i];
                }
                interactService.insertSafeDeal(safeId, datesSplit[i], content, userName);
            }

        }

        return 1;

    }


    @RequestMapping(value = "/interact_clean/{id}/{dot}/{isNormal}/{content}/{srcUrls}/{userName}/{insert}", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int uploadCleanConfirm(Model model, HttpServletRequest request, @PathVariable("id") int id, @PathVariable("insert") String insert, @PathVariable("userName") String userName, @PathVariable("dot") String dot, @PathVariable("isNormal") int isNormal, @PathVariable("content") String content, @PathVariable("srcUrls") String srcUrls) {
        //    var url = "/seckill/interact_dot/" + dot + "/" + isNormal + "/" + content + "/" + srcUrls + "/add";
        String flag1 = "@@";
        String fantasy = "fantasy";
        if (content.equals(fantasy)) {
            content = "";
        }
        if (srcUrls.equals(fantasy)) {
            srcUrls = "";
        }

        String[] srcUrlsSplit = srcUrls.split(flag1);
        String srcUrlNew = "";
        for (int i = 0; i < srcUrlsSplit.length; i++) {
            if (!srcUrlsSplit[i].contains(".jpg")) {
                String host = "http://hssy.online/seckill/resources/download/" + srcUrlsSplit[i] + ".jpg";
                //String fileName = this.getClass().getClassLoader().getResource("/download").getPath() + srcUrlsSplit[i] + ".jpg";
                String fileName = "/usr/local/tomcat/tomcat7/webapps/ROOT/seckill/resources/download/" + srcUrlsSplit[i] + ".jpg";

                CommUtil.httpRequestToFile(fileName, "GET", srcUrlsSplit[i]);
                srcUrlNew += host + flag1;
            } else {
                String host = "http://hssy.online/seckill/resources/download/" + srcUrlsSplit[i];
                srcUrlNew += host + flag1;
            }

        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String date = sdf.format(new Date());
        if (insert.equals("insert")) {
            return interactService.insertSafe(date, "clean", dot, isNormal, content, srcUrlNew, userName);
        } else {
            return interactService.updateSafe(id, dot, isNormal, content, srcUrlNew, userName);
        }
    }

    @RequestMapping(value = "/interact_feedback/{id}/{title}/{isNormal}/{content}/{srcUrls}/{userName}/{insert}", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int uploadFeedbackConfirm(Model model, HttpServletRequest request, @PathVariable("id") int id, @PathVariable("insert") String insert, @PathVariable("userName") String userName, @PathVariable("title") String title, @PathVariable("isNormal") int isNormal, @PathVariable("content") String content, @PathVariable("srcUrls") String srcUrls) {
        //    var url = "/seckill/interact_dot/" + dot + "/" + isNormal + "/" + content + "/" + srcUrls + "/add";
        String flag1 = "@@";
        String fantasy = "fantasy";
        if (content.equals(fantasy)) {
            content = "";
        }
        if (srcUrls.equals(fantasy)) {
            srcUrls = "";
        }
        if (title.equals(fantasy)) {
            title = "";
        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String date = sdf.format(new Date());
        String[] srcUrlsSplit = srcUrls.split(flag1);
        String srcUrlNew = "";
        for (int i = 0; i < srcUrlsSplit.length; i++) {
            if (!srcUrlsSplit[i].contains(".jpg")) {
                String host = "http://hssy.online/seckill/resources/download/" + srcUrlsSplit[i] + ".jpg";
                //String fileName = this.getClass().getClassLoader().getResource("/download").getPath() + srcUrlsSplit[i] + ".jpg";
                String fileName = "/usr/local/tomcat/tomcat7/webapps/ROOT/seckill/resources/download/" + srcUrlsSplit[i] + ".jpg";

                CommUtil.httpRequestToFile(fileName, "GET", srcUrlsSplit[i]);
                srcUrlNew += host + flag1;
            } else {
                String host = "http://hssy.online/seckill/resources/download/" + srcUrlsSplit[i];
                srcUrlNew += host + flag1;
            }

        }


        if (insert.equals("insert")) {
            return interactService.insertFeedback(content, isNormal, date, srcUrlNew, "", userName, 0, title);
        } else {
            return interactService.updateFeedback(id, content, isNormal, date, srcUrlNew, "", userName, 0, title);
        }
    }

    @RequestMapping(value = "/interact_dot/{id}/{dot}/{isNormal}/{content}/{srcUrls}/{userName}/{insert}", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int uploadConfirm(Model model, HttpServletRequest request, @PathVariable("id") int id, @PathVariable("insert") String insert, @PathVariable("userName") String userName, @PathVariable("dot") String dot, @PathVariable("isNormal") int isNormal, @PathVariable("content") String content, @PathVariable("srcUrls") String srcUrls) {
        //    var url = "/seckill/interact_dot/" + dot + "/" + isNormal + "/" + content + "/" + srcUrls + "/add";
        String flag1 = "@@";
        String fantasy = "fantasy";
        if (content.equals(fantasy)) {
            content = "";
        }
        if (srcUrls.equals(fantasy)) {
            srcUrls = "";
        }

        String[] srcUrlsSplit = srcUrls.split(flag1);
        String srcUrlNew = "";
        for (int i = 0; i < srcUrlsSplit.length; i++) {
            if (!srcUrlsSplit[i].contains(".jpg")) {
                String host = "http://hssy.online/seckill/resources/download/" + srcUrlsSplit[i] + ".jpg";
                //String fileName = this.getClass().getClassLoader().getResource("/download").getPath() + srcUrlsSplit[i] + ".jpg";
                String fileName = "/usr/local/tomcat/tomcat7/webapps/ROOT/seckill/resources/download/" + srcUrlsSplit[i] + ".jpg";

                CommUtil.httpRequestToFile(fileName, "GET", srcUrlsSplit[i]);
                srcUrlNew += host + flag1;
            } else {
                String host = "http://hssy.online/seckill/resources/download/" + srcUrlsSplit[i];
                srcUrlNew += host + flag1;
            }

        }

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        String date = sdf.format(new Date());
        if (insert.equals("insert")) {
            return interactService.insertSafe(date, "safe", dot, isNormal, content, srcUrlNew, userName);
        } else {
            return interactService.updateSafe(id, dot, isNormal, content, srcUrlNew, userName);
        }
    }


    @RequestMapping(value = "/interact/{id}/{type}/add", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String add(Model model, HttpServletRequest request, @PathVariable("id") int id, @PathVariable("type") String type) {
        Finance finance = interactService.gainFinance(id);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        model.addAttribute("date", sdf.format(new Date()));
        model.addAttribute("finance", finance);
        model.addAttribute("type", type);

        return "interact_finance_add";
    }

    @RequestMapping(value = "/interact/{userId}/{page}/{isAdmin}/{export}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String finance(Model model, HttpServletResponse response, HttpServletRequest request, @PathVariable("userId") int userId, @PathVariable("page") int page, @PathVariable("isAdmin") int isAdmin, @PathVariable("export") String export) {

        List<Finance> financeList = interactService.gainFinanceList(userId, isAdmin, page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = interactService.gainFinanceListTotal(userId, isAdmin);
        model.addAttribute("financeList", financeList);
        model.addAttribute("total", total);
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);


        double saleTotal = 0;
        double profitTotal = 0;
        double taxTotal = 0;
        for (int i = 0; i < financeList.size(); i++) {
            saleTotal += financeList.get(i).getSale();
            profitTotal += financeList.get(i).getProfit();
            taxTotal += financeList.get(i).getTax();
        }
        model.addAttribute("saleTotal", saleTotal);
        model.addAttribute("profitTotal", profitTotal);
        model.addAttribute("taxTotal", taxTotal);
        if ("export".equals(export)) {
            //获取数据

            String content[][] = new String[financeList.size()+1][];

            //excel标题
            String[] title = {"序号", "公司名称", "销售收入", "利润", "税收", "时间"};
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
            //excel文件名
            String fileName = "财务数据汇总表" + sdf.format(new Date()) + ".xls";

            //sheet名
            String sheetName = "财务数据汇总表";

            for (int i = 0; i < financeList.size(); i++) {
                content[i] = new String[title.length];

                content[i][0] = financeList.get(i).getId() + "";
                content[i][1] = financeList.get(i).getName();
                content[i][2] = financeList.get(i).getSale() + "";
                content[i][3] = financeList.get(i).getProfit() + "";
                content[i][4] = financeList.get(i).getTax() + "";
                content[i][5] = financeList.get(i).getDate();


            }

            content[financeList.size()] = new String[title.length];
            content[financeList.size()][0] = "合计" + "";
            content[financeList.size()][2] = saleTotal + "";
            content[financeList.size()][3] = profitTotal + "";
            content[financeList.size()][4] = taxTotal + "";
            //创建HSSFWorkbook
            HSSFWorkbook wb = ExcelUtil.getHSSFWorkbook(sheetName, title, content, null);

            //响应到客户端
            try {
                this.setResponseHeader(response, fileName);
                OutputStream os = response.getOutputStream();
                wb.write(os);
                os.flush();
                os.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return "interact_finance";
    }

    @RequestMapping(value = "/interact_dot/{userId}/{page}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String dot(Model model, HttpServletRequest request, @PathVariable("userId") int userId, @PathVariable("page") int page) {

        List<Dot> dotList = interactService.gainDotList(page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = interactService.gainDotListTotal();
        model.addAttribute("dotList", dotList);
        model.addAttribute("total", total);
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        return "interact_dot";
    }

    @RequestMapping(value = "/interact_dot/{userId}/{page}/{isAdmin}/{no}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String DotQuery(Model model, HttpServletRequest request, @PathVariable("userId") int userId,
                           @PathVariable("page") int page, @PathVariable("isAdmin") int isAdmin,
                           @PathVariable("no") String no) {
        String fantasy = "fantasy";
        if (no.equals(fantasy)) {
            no = "";
        }


        List<Dot> dotList = interactService.gainQueryDotList(no, page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = interactService.gainQueryDotListTotal(no);
        model.addAttribute("dotList", dotList);
        model.addAttribute("total", total);
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        model.addAttribute("no", no);
        model.addAttribute("query", "query");
        return "interact_dot";
    }

    @RequestMapping(value = "/interact_dot/{id}/{type}/add", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String addDot(Model model, HttpServletRequest request, @PathVariable("id") int id, @PathVariable("type") String type) {
        Dot dot = interactService.gainDot(id);

        model.addAttribute("dot", dot);
        model.addAttribute("type", type);
        return "interact_dot_add";
    }

    @RequestMapping(value = "/interact_dot/{id}/{no}/{content}/{remark}/{type}", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int updateDot(Model model, HttpServletRequest request, @PathVariable("id") int id, @PathVariable("no") String no,
                         @PathVariable("content") String content,
                         @PathVariable("remark") String remark, @PathVariable("type") String type) {

        String fantasy = "fantasy";

        if (no.equals(fantasy)) {
            no = "";
        }
        if (content.equals(fantasy)) {
            content = "";
        }
        if (remark.equals(fantasy)) {
            remark = "";
        }
        if ("update".equals(type)) {
            return interactService.updateDotId(id, no, content, remark);
        } else if ("insert".equals(type)) {
            return interactService.insertDot(no, content, remark);
        }
        return 0;
    }

    @RequestMapping(value = "/interact/{userId}/{page}/{isAdmin}/{code}/{startDate}/{endDate}/{export}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String financeQuery(Model model, HttpServletResponse response, HttpServletRequest request, @PathVariable("userId") int userId,
                               @PathVariable("page") int page, @PathVariable("isAdmin") int isAdmin,
                               @PathVariable("code") String code, @PathVariable("startDate") String startDate,
                               @PathVariable("endDate") String endDate, @PathVariable("export") String export) {
        String fantasy = "fantasy";
        if (code.equals(fantasy)) {
            code = "";
        }
        if (startDate.equals(fantasy)) {
            startDate = "";
        }
        if (endDate.equals(fantasy)) {
            endDate = "";
        }

        List<Finance> financeList = interactService.gainQueryFinanceList(code, startDate, endDate, userId, isAdmin, page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = interactService.gainQueryFinanceListTotal(code, startDate, endDate, userId, isAdmin);
        model.addAttribute("financeList", financeList);
        model.addAttribute("total", total);
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        model.addAttribute("code", code);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        model.addAttribute("query", "query");


        double saleTotal = 0;
        double profitTotal = 0;
        double taxTotal = 0;
        for (int i = 0; i < financeList.size(); i++) {
            saleTotal += financeList.get(i).getSale();
            profitTotal += financeList.get(i).getProfit();
            taxTotal += financeList.get(i).getTax();
        }
        model.addAttribute("saleTotal", saleTotal);
        model.addAttribute("profitTotal", profitTotal);
        model.addAttribute("taxTotal", taxTotal);
        if ("export".equals(export)) {
            //获取数据

            String content[][] = new String[financeList.size()+1][];

            //excel标题
            String[] title = {"序号", "公司名称", "销售收入", "利润", "税收", "时间"};
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
            //excel文件名
            String fileName = "财务数据汇总表" + sdf.format(new Date()) + ".xls";

            //sheet名
            String sheetName = "财务数据汇总表";

            for (int i = 0; i < financeList.size(); i++) {
                content[i] = new String[title.length];

                content[i][0] = financeList.get(i).getId() + "";
                content[i][1] = financeList.get(i).getName();
                content[i][2] = financeList.get(i).getSale() + "";
                content[i][3] = financeList.get(i).getProfit() + "";
                content[i][4] = financeList.get(i).getTax() + "";
                content[i][5] = financeList.get(i).getDate();


            }

            content[financeList.size()] = new String[title.length];
            content[financeList.size()][0] = "合计" + "";
            content[financeList.size()][2] = saleTotal + "";
            content[financeList.size()][3] = profitTotal + "";
            content[financeList.size()][4] = taxTotal + "";
            //创建HSSFWorkbook
            HSSFWorkbook wb = ExcelUtil.getHSSFWorkbook(sheetName, title, content, null);

            //响应到客户端
            try {
                this.setResponseHeader(response, fileName);
                OutputStream os = response.getOutputStream();
                wb.write(os);
                os.flush();
                os.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return "interact_finance";
    }

    //发送响应流方法
    public void setResponseHeader(HttpServletResponse response, String fileName) {
        try {
            try {
                fileName = new String(fileName.getBytes(), "ISO8859-1");
            } catch (UnsupportedEncodingException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            response.setContentType("application/octet-stream;charset=ISO8859-1");
            response.setHeader("Content-Disposition", "attachment;filename=" + fileName);
            response.addHeader("Pargam", "no-cache");
            response.addHeader("Cache-Control", "no-cache");
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

//    @RequestMapping(value = "/interact/{name}/{code}/{customId}/{sale}/{profit}/{tax}/{userId}/{date}/insert", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
//    @ResponseBody
//    public int insertFantasy(Model model, HttpServletRequest request, @PathVariable("name") String name,
//                             @PathVariable("code") String code, @PathVariable("customId") int customId,
//                             @PathVariable("sale") double sale, @PathVariable("profit") double profit,
//                             @PathVariable("tax") double tax, @PathVariable("userId") int userId,
//                             @PathVariable("date") String date) {
//
//        String fantasy = "fantasy";
//
//        if (name.equals(fantasy)) {
//            name = "";
//        }
//        if (code.equals(fantasy)) {
//            code = "";
//        }
//        if (date.equals(fantasy)) {
//            date = "";
//        }
//        return interactService.insertFinance(name, code, customId, sale, profit, tax, userId, date);
//    }

    @RequestMapping(value = "/interact/{id}/del", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int delFantasy(Model model, HttpServletRequest request, @PathVariable("id") int id) {


        return interactService.delFinanceId(id);
    }

    @RequestMapping(value = "/interact_dot/{id}/del", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int delDot(Model model, HttpServletRequest request, @PathVariable("id") int id) {


        return interactService.delDotId(id);
    }

    @RequestMapping(value = "/interact/{id}/{name}/{code}/{customId}/{sale}/{profit}/{tax}/{userId}/{date}/{type}", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int updateFantasy(Model model, HttpServletRequest request, @PathVariable("id") int id, @PathVariable("name") String name,
                             @PathVariable("code") String code, @PathVariable("customId") int customId,
                             @PathVariable("sale") double sale, @PathVariable("profit") double profit,
                             @PathVariable("tax") double tax, @PathVariable("userId") int userId,
                             @PathVariable("date") String date, @PathVariable("type") String type) {

        String fantasy = "fantasy";

        if (name.equals(fantasy)) {
            name = "";
        }
        if (code.equals(fantasy)) {
            code = "";
        }
        if (date.equals(fantasy)) {
            date = "";
        }
        if ("update".equals(type)) {
            return interactService.updateFinanceId(id, name, code, customId, sale, profit, tax, userId, date);
        } else if ("insert".equals(type)) {
            return interactService.insertFinance(name, code, customId, sale, profit, tax, userId, date);
        }
        return 0;
    }

    /**
     * 获取access_token
     *
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping("/getAccessToken")
    public void getAccessToken(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String urlStr = "https://qyapi.weixin.qq.com/cgi-bin/gettoken?corpid=" + CORPID + "&corpsecret=" + CORPSECRET;
        processUrl(response, urlStr);
    }

    /**
     * 获取jsapi_ticket
     *
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping("/getJsapiTicket")
    public void getJsapiTicket(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String access_token = request.getParameter("access_token");
        String urlStr = "https://qyapi.weixin.qq.com/cgi-bin/get_jsapi_ticket?access_token=" + access_token;
        processUrl(response, urlStr);
    }

    /**
     * 获取签名signature
     *
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping("/getJsSdkSign")
    public void getJsSdkSign(HttpServletRequest request, HttpServletResponse response) throws Exception {
        String noncestr = request.getParameter("noncestr");
        String tsapiTicket = request.getParameter("jsapi_ticket");
        String timestamp = request.getParameter("timestamp");
        String url = request.getParameter("url");
        String jsSdkSign = getJsSdkSign(noncestr, tsapiTicket, timestamp, url);
        PrintWriter out = response.getWriter();
        out.print(jsSdkSign);
    }

    private void processUrl(HttpServletResponse response, String urlStr) {
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
                PrintWriter out = response.getWriter();
                out.print(sTotalString);
            } else {
                System.err.println("失败");
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }

    /**
     * 获得加密后的签名
     *
     * @param noncestr
     * @param tsapiTicket
     * @param timestamp
     * @param url
     * @return
     */
    public static String getJsSdkSign(String noncestr, String tsapiTicket, String timestamp, String url) {
        String content = "jsapi_ticket=" + tsapiTicket + "&noncestr=" + noncestr + "&timestamp=" + timestamp + "&url=" + url;
        String ciphertext = getSha1(content);

        return ciphertext;
    }

    /**
     * 进行sha1加密
     *
     * @param str
     * @return
     */
    public static String getSha1(String str) {
        if (str == null || str.length() == 0) {
            return null;
        }
        char hexDigits[] = {'0', '1', '2', '3', '4', '5', '6', '7', '8', '9',
                'a', 'b', 'c', 'd', 'e', 'f'};
        try {
            MessageDigest mdTemp = MessageDigest.getInstance("SHA1");
            mdTemp.update(str.getBytes("UTF-8"));

            byte[] md = mdTemp.digest();
            int j = md.length;
            char buf[] = new char[j * 2];
            int k = 0;
            for (int i = 0; i < j; i++) {
                byte byte0 = md[i];
                buf[k++] = hexDigits[byte0 >>> 4 & 0xf];
                buf[k++] = hexDigits[byte0 & 0xf];
            }
            return new String(buf);
        } catch (Exception e) {
            // TODO: handle exception
            return null;
        }
    }

    /**
     * 获得随机串
     *
     * @return
     */
    public static String create_noncestr() {
        return UUID.randomUUID().toString();
    }

}

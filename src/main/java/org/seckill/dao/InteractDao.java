package org.seckill.dao;

import org.apache.ibatis.annotations.Param;
import org.seckill.entity.*;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

public interface InteractDao {
    //    private String name;
//    private String code;
//    private int customId;
//    private double sale;
//    private double profit;
//    private double tax;
//    private int userId;
//    private  String date;

    List<Finance> gainFinanceList(@Param("userId") int userId, @Param("isAdmin") int isAdmin, @Param("page") int page, @Param("pageSize") int pageSize);

    int gainFinanceListTotal(@Param("userId") int userId, @Param("isAdmin") int isAdmin);

    int insertFinance(@Param("name") String name, @Param("code") String code,
                      @Param("customId") int customId, @Param("sale") double sale,
                      @Param("profit") double profit, @Param("tax") double tax,
                      @Param("userId") int userId, @Param("date") String date);

    int updateFinanceId(@Param("id") int id, @Param("name") String name, @Param("code") String code,
                        @Param("customId") int customId, @Param("sale") double sale,
                        @Param("profit") double profit, @Param("tax") double tax,
                        @Param("userId") int userId, @Param("date") String date);

    List<Finance> gainQueryFinanceList(@Param("code") String code, @Param("startDate") String startDate, @Param("endDate") String endDate, @Param("userId") int userId, @Param("isAdmin") int isAdmin, @Param("page") int page, @Param("pageSize") int pageSize);

    int gainQueryFinanceListTotal(@Param("code") String code, @Param("startDate") String startDate, @Param("endDate") String endDate, @Param("userId") int userId, @Param("isAdmin") int isAdmin);

    int delFinanceId(@Param("id") int id);

    Finance gainFinance(@Param("id") int id);


    List<Dot> gainDotList(@Param("page") int page, @Param("pageSize") int pageSize);

    int gainDotListTotal();

    int insertDot(@Param("no") String no, @Param("content") String content, @Param("remark") String remark);

    int updateDotId(@Param("id") int id, @Param("no") String no, @Param("content") String content, @Param("remark") String remark);

    List<Dot> gainQueryDotList(@Param("no") String no, @Param("page") int page, @Param("pageSize") int pageSize);

    int gainQueryDotListTotal(@Param("no") String no);

    int delDotId(@Param("id") int id);

    Dot gainDot(@Param("id") int id);

    List<Safe> gainSafeList(@Param("type") String type, @Param("date") String date, @Param("page") int page, @Param("pageSize") int pageSize);

    int gainSafeListTotal(@Param("type") String type, @Param("date") String date);

    List<Safe> gainSafeListAll(@Param("type") String type, @Param("page") int page, @Param("pageSize") int pageSize);

    int gainSafeListAllTotal(@Param("type") String type);

    List<Safe> gainSafeListQuery(@Param("type") String type, @Param("userName") String userName, @Param("startDate") String startDate, @Param("endDate") String endDate, @Param("page") int page, @Param("pageSize") int pageSize);

    int gainSafeListTotalQuery(@Param("type") String type, @Param("userName") String userName, @Param("startDate") String startDate, @Param("endDate") String endDate);


    int insertSafe(@Param("date") String date, @Param("type") String type, @Param("dot") String dot, @Param("isNormal") int isNormal, @Param("content") String content, @Param("srcUrls") String srcUrls, @Param("userName") String userName);

    Safe gainSafe(@Param("dot") String dot, @Param("date") String date);

    int updateSafe(@Param("id") int id, @Param("dot") String dot, @Param("isNormal") int isNormal, @Param("content") String content, @Param("srcUrls") String srcUrls, @Param("userName") String userName);

    int insertSafeDeal(@Param("safeId") int safeId, @Param("date") String date, @Param("content") String content, @Param("userName") String userName);

    int updateSafeIsDeal(@Param("safeId") int safeId, @Param("isDeal") int isDeal);

    int delSafeDeal(@Param("safeId") int safeId);

    List<SafeDeal> gainSafeDealList(@Param("safeId") int safeId);

    List<Feedback> gainFeedbackList(@Param("userName") String userName, @Param("page") int page, @Param("pageSize") int pageSize);

    int gainFeedbackListTotal(@Param("userName") String userName);

    List<Feedback> gainFeedbackAllList(@Param("page") int page, @Param("pageSize") int pageSize);

    int gainFeedbackAllListTotal();

    List<Feedback> gainFeedbackQuery(@Param("userName") String userName, @Param("startDate") String startDate, @Param("endDate") String endDate, @Param("page") int page, @Param("pageSize") int pageSize);

    int gainFeedbackQueryTotal(@Param("userName") String userName, @Param("startDate") String startDate, @Param("endDate") String endDate);


    int updateFeedback(@Param("id") int id, @Param("content") String content, @Param("type") int type,
                       @Param("date") String date, @Param("urls") String urls,
                       @Param("text") String text, @Param("userName") String userName,
                       @Param("isDeal") int isDeal, @Param("title") String title);

    int insertFeedback(@Param("content") String content, @Param("type") int type,
                       @Param("date") String date, @Param("urls") String urls,
                       @Param("text") String text, @Param("userName") String userName,
                       @Param("isDeal") int isDeal, @Param("title") String title);

    int insertFeedbackDeal(@Param("feedbackId") int feedbackId, @Param("date") String date, @Param("content") String content, @Param("userName") String userName);

    int updateFeedbackIsDeal(@Param("feedbackId") int feedbackId, @Param("isDeal") int isDeal);

    int delFeedbackDeal(@Param("feedbackId") int feedbackId);

    Feedback gainFeedback(@Param("id") int id);

    List<FeedbackDeal> gainFeedbackDeal(@Param("feedbackId") int feedbackId);

    List<House> gainHouseList(@Param("floor")int floor,@Param("type")String type);

    HouseSite gainHouseSite();
    int updateHouseSite(@Param("column") int column,@Param("row") int row);
}

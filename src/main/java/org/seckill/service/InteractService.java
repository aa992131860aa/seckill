package org.seckill.service;

import org.apache.ibatis.annotations.Param;
import org.seckill.entity.*;

import java.util.List;

public interface InteractService {
    List<Finance> gainFinanceList(int userId, int isAdmin, int page, int pageSize);

    int gainFinanceListTotal(int userId, int isAdmin);

    int insertFinance(String name, String code,
                      int customId, double sale,
                      double profit, double tax,
                      int userId, String date);

    int updateFinanceId(int id, String name, String code,
                        int customId, double sale,
                        double profit, double tax,
                        int userId, String date);

    List<Finance> gainQueryFinanceList(String code, String startDate, String endDate, int userId, int isAdmin, int page, int pageSize);

    int gainQueryFinanceListTotal(String code, String startDate, String endDate, int userId, int isAdmin);

    int delFinanceId(int id);

    Finance gainFinance(int id);

    List<Dot> gainDotList(int page, int pageSize);

    int gainDotListTotal();

    int insertDot(String no, String content, String remark);

    int updateDotId(int id, String no, String content, String remark);

    List<Dot> gainQueryDotList(String no, int page, int pageSize);

    int gainQueryDotListTotal(String no);

    int delDotId(int id);

    Dot gainDot(int id);


    List<Safe> gainSafeList(String type, String date, int page, int pageSize);

    int gainSafeListTotal(String type, String date);

    List<Safe> gainSafeListAll(String type, int page, int pageSize);

    int gainSafeListAllTotal(String type);

    List<Safe> gainSafeListQuery(String type, String userName, String startDate, String endDate, int page, int pageSize);

    int gainSafeListTotalQuery(String type, String userName, String startDate, String endDate);


    int insertSafe(String date, String type, String dot, int isNormal, String content, String srcUrls, String userName);

    Safe gainSafe(String dot, String date);

    int updateSafe(int id, String dot, int isNormal, String content, String srcUrls, String userName);

    int insertSafeDeal(int safeId, String date, String content, String userName);

    int updateSafeIsDeal(int safeId, int isDeal);

    int delSafeDeal(int safeId);

    List<SafeDeal> gainSafeDealList(int safeId);


    List<Feedback> gainFeedbackList(String userName, int page, int pageSize);

    int gainFeedbackListTotal(String userName);

    List<Feedback> gainFeedbackAllList(int page, int pageSize);

    int gainFeedbackAllListTotal();

    List<Feedback> gainFeedbackQuery(String userName, String startDate, String endDate, int page, int pageSize);

    int gainFeedbackQueryTotal(String userName, String startDate, String endDate);


    int updateFeedback(int id, String content, int type,
                       String date, String urls,
                       String text, String userName,
                       int isDeal, String title);

    int insertFeedback(String content, int type,
                       String date, String urls,
                       String text, String userName,
                       int isDeal, String title);

    int insertFeedbackDeal(int feedbackId, String date, String content, String userName);

    int updateFeedbackIsDeal(int feedbackId, int isDeal);

    int delFeedbackDeal(int feedbackId);

    Feedback gainFeedback(int id);

    List<FeedbackDeal> gainFeedbackDeal( int feedbackId);

    List<House> gainHouseList(int floor,String type);
    HouseSite gainHouseSite();
    int updateHouseSite(int column,int row);
 }

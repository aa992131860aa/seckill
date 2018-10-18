package org.seckill.service.impl;

import org.seckill.dao.InteractDao;
import org.seckill.entity.*;
import org.seckill.service.InteractService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class InteractServiceImpl implements InteractService {

    @Autowired
    InteractDao interactDao;

    public List<Finance> gainFinanceList(int userId, int isAdmin, int page, int pageSize) {
        return interactDao.gainFinanceList(userId, isAdmin, page, pageSize);
    }

    public int gainFinanceListTotal(int userId, int isAdmin) {
        return interactDao.gainFinanceListTotal(userId, isAdmin);
    }

    public int insertFinance(String name, String code,
                             int customId, double sale,
                             double profit, double tax,
                             int userId, String date) {
        return interactDao.insertFinance(name, code, customId, sale, profit, tax, userId, date);
    }

    public int updateFinanceId(int id, String name, String code,
                               int customId, double sale,
                               double profit, double tax,
                               int userId, String date) {
        return interactDao.updateFinanceId(id, name, code, customId, sale, profit, tax, userId, date);
    }

    public List<Finance> gainQueryFinanceList(String code, String startDate, String endDate, int userId, int isAdmin, int page, int pageSize) {
        return interactDao.gainQueryFinanceList(code, startDate, endDate, userId, isAdmin, page, pageSize);
    }

    public int gainQueryFinanceListTotal(String code, String startDate, String endDate, int userId, int isAdmin) {
        return interactDao.gainQueryFinanceListTotal(code, startDate, endDate, userId, isAdmin);
    }

    public int delFinanceId(int id) {
        return interactDao.delFinanceId(id);
    }

    public Finance gainFinance(int id) {
        return interactDao.gainFinance(id);
    }

    public List<Dot> gainDotList(int page, int pageSize) {
        return interactDao.gainDotList(page, pageSize);
    }

    public int gainDotListTotal() {
        return interactDao.gainDotListTotal();
    }

    public int insertDot(String no, String content, String remark) {
        return interactDao.insertDot(no, content, remark);
    }

    public int updateDotId(int id, String no, String content, String remark) {
        return interactDao.updateDotId(id, no, content, remark);
    }

    public List<Dot> gainQueryDotList(String no, int page, int pageSize) {
        return interactDao.gainQueryDotList(no, page, pageSize);
    }

    public int gainQueryDotListTotal(String no) {
        return interactDao.gainQueryDotListTotal(no);
    }

    public int delDotId(int id) {
        return interactDao.delDotId(id);
    }

    public Dot gainDot(int id) {
        return interactDao.gainDot(id);
    }


    public List<Safe> gainSafeList(String type, String date, int page, int pageSize) {
        return interactDao.gainSafeList(type, date, page, pageSize);
    }

    public int gainSafeListTotal(String type, String date) {
        return interactDao.gainSafeListTotal(type, date);
    }

    public List<Safe> gainSafeListAll(String type, int page, int pageSize) {
        return interactDao.gainSafeListAll(type, page, pageSize);
    }

    public int gainSafeListAllTotal(String type) {
        return interactDao.gainSafeListAllTotal(type);
    }

    public List<Safe> gainSafeListQuery(String type, String userName, String startDate, String endDate, int page, int pageSize) {
        return interactDao.gainSafeListQuery(type, userName, startDate, endDate, page, pageSize);
    }

    public int gainSafeListTotalQuery(String type, String userName, String startDate, String endDate) {
        return interactDao.gainSafeListTotalQuery(type, userName, startDate, endDate);
    }

    public int insertSafe(String date, String type, String dot, int isNormal, String content, String srcUrls, String userName) {
        return interactDao.insertSafe(date, type, dot, isNormal, content, srcUrls, userName);
    }

    public Safe gainSafe(String dot, String date) {
        return interactDao.gainSafe(dot, date);
    }

    public int updateSafe(int id, String dot, int isNormal, String content, String srcUrls, String userName) {
        return interactDao.updateSafe(id, dot, isNormal, content, srcUrls, userName);
    }

    public int insertSafeDeal(int safeId, String date, String content, String userName) {
        return interactDao.insertSafeDeal(safeId, date, content, userName);
    }

    public int updateSafeIsDeal(int safeId, int isDeal) {
        return interactDao.updateSafeIsDeal(safeId, isDeal);
    }

    public int delSafeDeal(int safeId) {
        return interactDao.delSafeDeal(safeId);
    }

    public List<SafeDeal> gainSafeDealList(int safeId) {
        return interactDao.gainSafeDealList(safeId);
    }


    public List<Feedback> gainFeedbackList(String userName, int page, int pageSize) {
        return interactDao.gainFeedbackList(userName, page, pageSize);
    }

    public int gainFeedbackListTotal(String userName) {
        return interactDao.gainFeedbackListTotal(userName);
    }

    public List<Feedback> gainFeedbackAllList(int page, int pageSize) {
        return interactDao.gainFeedbackAllList(page, pageSize);
    }

    public int gainFeedbackAllListTotal() {
        return interactDao.gainFeedbackAllListTotal();
    }

    public List<Feedback> gainFeedbackQuery(String userName, String startDate, String endDate, int page, int pageSize) {
        return interactDao.gainFeedbackQuery(userName, startDate, endDate, page, pageSize);
    }

    public int gainFeedbackQueryTotal(String userName, String startDate, String endDate) {
        return interactDao.gainFeedbackQueryTotal(userName, startDate, endDate);
    }


    public int updateFeedback(int id, String content, int type,
                              String date, String urls,
                              String text, String userName,
                              int isDeal, String title) {
        return interactDao.updateFeedback(id, content, type, date, urls, text, userName, isDeal, title);
    }

    public int insertFeedbackDeal(int feedbackId, String date, String content, String userName) {
        return interactDao.insertFeedbackDeal(feedbackId, date, content, userName);
    }

    public int updateFeedbackIsDeal(int feedbackId, int isDeal) {
        return interactDao.updateFeedbackIsDeal(feedbackId, isDeal);
    }

    public int delFeedbackDeal(int feedbackId) {
        return interactDao.delFeedbackDeal(feedbackId);
    }

    public int insertFeedback(String content, int type,
                              String date, String urls,
                              String text, String userName,
                              int isDeal, String title) {
        return interactDao.insertFeedback(content, type, date, urls, text, userName, isDeal, title);
    }

    public Feedback gainFeedback(int id) {
        return interactDao.gainFeedback(id);
    }

    public List<FeedbackDeal> gainFeedbackDeal(int feedbackId) {
        return interactDao.gainFeedbackDeal(feedbackId);
    }

    public List<House> gainHouseList(int floor,String type) {
        return interactDao.gainHouseList(floor,type);
    }

    public HouseSite gainHouseSite() {
        return interactDao.gainHouseSite();
    }

    public int updateHouseSite(int column, int row) {
        return interactDao.updateHouseSite(column, row);
    }
}

package org.seckill.service.impl;

import org.seckill.dao.ContractDao;
import org.seckill.entity.*;
import org.seckill.service.ContractService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class ContractServiceImpl implements ContractService {
    @Autowired
    ContractDao contractDao;

    public List<Free> gainFree() {
        return contractDao.gainFree();
    }

    public List<GoodsStatus> gainGoodsStatus() {
        return contractDao.gainGoodsStatus();
    }

    public List<Contact> gainContact() {
        return contractDao.gainContact();
    }

    public List<House> gainHouse(String loc) {
        return contractDao.gainHouse(loc);
    }

    public List<House> gainAd(String loc) {
        return contractDao.gainAd(loc);
    }

    public List<House> gainCar(String loc) {
        return contractDao.gainCar(loc);
    }


    public List<Contract> gainContractList(String style, int page, int pageSize) {
        return contractDao.gainContractList(style, page, pageSize);
    }

    public int gainContractListTotal(String style) {
        return contractDao.gainContractListTotal(style);
    }

    public List<Contract> gainContractListDel(String style, int page, int pageSize) {
        return contractDao.gainContractListDel(style, page, pageSize);
    }

    public int gainContractListDelTotal(String style) {
        return contractDao.gainContractListDelTotal(style);
    }

    public Contract gainContract(String uuid) {
        return contractDao.gainContract(uuid);
    }

    public int insertContract(String userName, String house1, String house2, String house3, String code, String no, String uuid, String codeAuto, String remark
            , String linkMan, String phone, String startDate,
                              String endDate, String warnDay, String type, String style,
                              String table1, String table2, String table2H, String table3,
                              String table11, String table22, String table33, String table44,
                              String table55, String table66, String table77, String table88, String explain, int customId, double total) {
        if ("".equals(warnDay)) {
            warnDay = "0";
        }
        return contractDao.insertContract(userName, house1, house2, house3, code, no, uuid, codeAuto, remark, linkMan, phone, startDate, endDate, warnDay, type, style,
                table1, table2, table2H, table3, table11, table22, table33, table44, table55, table66, table77, table88, explain, customId, total);
    }

    public int modifyContract(String userName, String house1, String house2, String house3, String code, String uuid, String codeAuto, String remark
            , String linkMan, String phone, String startDate,
                              String endDate, String warnDay, String type, String style,
                              String table1, String table2, String table2H, String table3,
                              String table11, String table22, String table33, String table44,
                              String table55, String table66, String table77, String table88, String explain, int customId, double total) {
        return contractDao.modifyContract(userName, house1, house2, house3, code, uuid, codeAuto, remark, linkMan, phone, startDate, endDate, warnDay, type, style,
                table1, table2, table2H, table3, table11, table22, table33, table44, table55, table66, table77, table88, explain, customId, total);
    }

    public int dateTotal(String date) {
        return contractDao.dateTotal(date);
    }

    public List<Contract> query(String style, String code, String linkMan, String no, String number, String startDate, String endDate, int page, int pageSize) {
        return contractDao.query(style, code, linkMan, no, number, startDate, endDate, page, pageSize);
    }

    public int queryTotal(String style, String code, String linkMan, String no, String number, String startDate, String endDate) {
        return contractDao.queryTotal(style, code, linkMan, no, number, startDate, endDate);
    }

    public List<Contract> queryDel(String style, String code, String linkMan, String no, String number, String startDate, String endDate, int page, int pageSize) {
        return contractDao.queryDel(style, code, linkMan, no, number, startDate, endDate, page, pageSize);
    }

    public int queryDelTotal(String style, String code, String linkMan, String no, String number, String startDate, String endDate) {
        return contractDao.queryDelTotal(style, code, linkMan, no, number, startDate, endDate);
    }

    public int del(String uuid) {
        return contractDao.del(uuid);
    }

    public String gainContactSort(int id) {
        return contractDao.gainContactSort(id);
    }


    public int insertAdContract(String userName, String code, String no, String uuid, String codeAuto, String remark
            , String linkMan, String phone, String startDate,
                                String endDate, String warnDay, String type, String style,
                                String table1, String table2, String table2H, String table3,
                                String table11, String table33, String explain, int customId, double total
    ) {
        return contractDao.insertAdContract(userName, code, no, uuid, codeAuto, remark, linkMan, phone, startDate, endDate, warnDay, type, style, table1, table2, table2H, table3, table11, table33, explain, customId, total);
    }

    public int modifyAdContract(String userName, String code, String uuid, String codeAuto, String remark
            , String linkMan, String phone, String startDate,
                                String endDate, String warnDay, String type, String style,
                                String table1, String table2, String table2H, String table3,
                                String table11, String table33, String explain, int customId, double total) {
        return contractDao.modifyAdContract(userName, code, uuid, codeAuto, remark, linkMan, phone, startDate, endDate, warnDay, type, style, table1, table2, table2H, table3, table11, table33, explain, customId, total);
    }

    public int insertCarContract(String userName, String code, String no, String uuid, String codeAuto, String remark
            , String linkMan, String phone, String startDate,
                                 String endDate, String warnDay, String type, String style,
                                 String table1, String table2, String table2H, String table3,
                                 String table11, String table33, String explain, int customId, double total
    ) {
        return contractDao.insertCarContract(userName, code, no, uuid, codeAuto, remark, linkMan, phone, startDate, endDate, warnDay, type, style, table1, table2, table2H, table3, table11, table33, explain, customId, total);
    }

    public int modifyCarContract(String userName, String code, String uuid, String codeAuto, String remark
            , String linkMan, String phone, String startDate,
                                 String endDate, String warnDay, String type, String style,
                                 String table1, String table2, String table2H, String table3,
                                 String table11, String table33, String explain, int customId, double total) {
        return contractDao.modifyCarContract(userName, code, uuid, codeAuto, remark, linkMan, phone, startDate, endDate, warnDay, type, style, table1, table2, table2H, table3, table11, table33, explain, customId, total);
    }

    public int updateDel(String uuid) {
        return contractDao.updateDel(uuid);
    }

    public List<Contract> gainCustomByLinkManAndRemark(String linkMan, String remark) {
        return contractDao.gainCustomByLinkManAndRemark(linkMan, remark);
    }

    public List<Contract> gainCustomWarn(int page, int pageSize) {
        return contractDao.gainCustomWarn(page, pageSize);
    }

    public int gainCustomWarnTotal() {
        return contractDao.gainCustomWarnTotal();
    }

    public int insertTable38(String uuid, String style, String table33Money, String table33Date, String table33Warn, String table88StartDate, String table88EndDate, String table88Warn) {
        return contractDao.insertTable38(uuid, style, table33Money, table33Date, table33Warn, table88StartDate, table88EndDate, table88Warn);
    }

    public int delTable38(String uuid) {
        return contractDao.delTable38(uuid);
    }

    public int insertTable1(String uuid, String style, String loc, String payDate, int goodsStatusId) {
        System.out.println("loc:" + loc + ",goodsStatusId:" + goodsStatusId);
        contractDao.updateHouse(goodsStatusId, loc);
        return contractDao.insertTable1(uuid, style, loc, payDate);
    }

    public int updateHouse(int goodsStatusId, String loc) {
        return contractDao.updateHouse(goodsStatusId, loc);
    }

    public int repeatHouse(String loc) {
        return contractDao.repeatHouse(loc);
    }

    public int delTable1(String uuid) {
        return contractDao.delTable1(uuid);
    }

    public List<Contract> gainContractWarn(int page, int pageSize) {
        return contractDao.gainContractWarn(page, pageSize);
    }

    public int gainContractWarnTotal() {
        return contractDao.gainContractWarnTotal();
    }

    public List<Contract> gainContractListConfirm(int page, int pageSize) {
        return contractDao.gainContractListConfirm(page, pageSize);
    }

    public int gainContractListConfirmTotal() {
        return contractDao.gainContractListConfirmTotal();
    }

    public List<Contract> gainContractListCancel(int page, int pageSize) {
        return contractDao.gainContractListCancel(page, pageSize);
    }

    public int gainContractListCancelTotal() {
        return contractDao.gainContractListCancelTotal();
    }

    public int updateIsOk(String uuid, int isOk, String explain, String approval, String approvalDate) {
        return contractDao.updateIsOk(uuid, isOk, explain, approval, approvalDate);
    }

    public int gainFreeExportByLocAndDate(String loc, String date) {
        return contractDao.gainFreeExportByLocAndDate(loc, date);
    }

    public int updateCustomCarReg(String no, String person, String phone, String loc, int customId) {
        return contractDao.updateCustomCarReg(no, person, phone, loc, customId);
    }

    public int updateDeadline() {
        return contractDao.updateDeadline();
    }

    public int updateDeadlineNo() {
        return contractDao.updateDeadlineNo();
    }

    public int updateDeadlineDel() {
        return contractDao.updateDeadlineDel();
    }

    public List<Contract> queryCancel(String code, String startDate, String endDate, int page, int pageSize) {
        return contractDao.queryCancel(code, startDate, endDate, page, pageSize);
    }

    public int queryCancelTotal(String code, String startDate, String endDate) {
        return contractDao.queryCancelTotal(code, startDate, endDate);
    }

    public int insertTable77(String uuid, String startDate, String endDate, String total, String discount, String discountTotal) {
        return contractDao.insertTable77(uuid, startDate, endDate, total, discount, discountTotal);
    }

    public String gainMinDate(String uuid) {
        return contractDao.gainMinDate(uuid);
    }

    public int updateTable77IsConfirm(int isConfirm, int id) {
        return contractDao.updateTable77IsConfirm(isConfirm, id);
    }

    public int delTable77(String uuid) {
        return contractDao.delTable77(uuid);
    }

    public List<FreeExport> gainMaxDegree(String loc, String type) {
        return contractDao.gainMaxDegree(loc, type);
    }

    public int updateContractWater(int isWater, String contractUuid, String loc,String type) {
        return contractDao.updateContractWater(isWater, contractUuid, loc,type);
    }

    public int updateWaterLoc(String loc,String type) {
        return contractDao.updateWaterLoc(loc,type);
    }
}

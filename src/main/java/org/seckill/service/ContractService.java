package org.seckill.service;

import org.apache.ibatis.annotations.Param;
import org.seckill.entity.*;

import java.util.List;

public interface ContractService {
    List<Free> gainFree();

    List<GoodsStatus> gainGoodsStatus();

    List<Contact> gainContact();

    int updateDel(String uuid);

    List<House> gainHouse(String loc);

    List<House> gainAd(String loc);

    List<House> gainCar(String loc);

    List<Contract> gainContractList(String style, int page, int pageSize);

    int gainContractListTotal(String style);

    List<Contract> gainContractListDel(String style, int page, int pageSize);

    int gainContractListDelTotal(String style);

    Contract gainContract(String uuid);

    int updateHouse(int goodsStatusId, String loc);


    int insertContract(String userName, String house1, String house2, String house3, String code, String no, String uuid, String codeAuto, String remark
            , String linkMan, String phone, String startDate,
                       String endDate, String warnDay, String type, String style,
                       String table1, String table2, String table2H, String table3,
                       String table11, String table22, String table33, String table44,
                       String table55, String table66, String table77, String table88, String explain, int customId, double total
    );

    int modifyContract(String userName, String house1, String house2, String house3, String code, String uuid, String codeAuto, String remark
            , String linkMan, String phone, String startDate,
                       String endDate, String warnDay, String type, String style,
                       String table1, String table2, String table2H, String table3,
                       String table11, String table22, String table33, String table44,
                       String table55, String table66, String table77, String table88, String explain, int customId, double total);

    int dateTotal(String date);

    List<Contract> query(String style, String code, String linkMan, String no, String number, String startDate, String endDate, int page, int pageSize);

    int queryTotal(String style, String code, String linkMan, String no, String number, String startDate, String endDate);

    List<Contract> queryDel(String style, String code, String linkMan, String no, String number, String startDate, String endDate, int page, int pageSize);

    int queryDelTotal(String style, String code, String linkMan, String no, String number, String startDate, String endDate);


    int del(String uuid);

    String gainContactSort(int id);


    int insertAdContract(String userName, String code, String no, String uuid, String codeAuto, String remark
            , String linkMan, String phone, String startDate,
                         String endDate, String warnDay, String type, String style,
                         String table1, String table2, String table2H, String table3,
                         String table11, String table33, String explain, int customId, double total
    );

    int modifyAdContract(String userName, String code, String uuid, String codeAuto, String remark
            , String linkMan, String phone, String startDate,
                         String endDate, String warnDay, String type, String style,
                         String table1, String table2, String table2H, String table3,
                         String table11, String table33, String explain, int customId, double total);

    int insertCarContract(String userName, String code, String no, String uuid, String codeAuto, String remark
            , String linkMan, String phone, String startDate,
                          String endDate, String warnDay, String type, String style,
                          String table1, String table2, String table2H, String table3,
                          String table11, String table33, String explain, int customId, double total
    );

    int modifyCarContract(String userName, String code, String uuid, String codeAuto, String remark
            , String linkMan, String phone, String startDate,
                          String endDate, String warnDay, String type, String style,
                          String table1, String table2, String table2H, String table3,
                          String table11, String table33, String explain, int customId, double total);

    List<Contract> gainCustomByLinkManAndRemark(String linkMan, String remark);

    List<Contract> gainCustomWarn(int page, int pageSize);

    int gainCustomWarnTotal();


    int insertTable38(String uuid, String style, String table33Money, String table33Date, String table33Warn, String table88StartDate, String table88EndDate, String table88Warn);

    int delTable38(String uuid);

    int delTable77(String uuid);

    List<FreeExport> gainMaxDegree(String loc, String type);

    String gainMinDate(String uuid);

    int insertTable1(String uuid, String style, String loc, String payDate, int goodsStatusId);

    int updateCustomCarReg(String no, String person, String phone, String loc, int customId);

    int delTable1(String uuid);


    int repeatHouse(String loc);

    List<Contract> gainContractWarn(int page, int pageSize);

    int gainContractWarnTotal();

    List<Contract> gainContractListConfirm(int page, int pageSize);

    int gainContractListConfirmTotal();


    List<Contract> gainContractListCancel(int page, int pageSize);

    int gainContractListCancelTotal();

    int updateIsOk(String uuid, int isOk, String explain, String approval, String approvalDate);

    int gainFreeExportByLocAndDate(String loc, String date);

    int updateDeadline();
    int updateDeadlineNo();
    int updateDeadlineDel();

    List<Contract> queryCancel(String code, String startDate, String endDate, int page, int pageSize);

    int queryCancelTotal(String code, String startDate, String endDate);

    int insertTable77(String uuid, String startDate, String endDate, String total, String discount, String discountTotal);

    int updateTable77IsConfirm(int isConfirm, int id);

    int updateContractWater(int isWater, String contractUuid, String loc,String type);
    int updateWaterLoc(String loc,String type);
}

package org.seckill.dao;

import org.apache.ibatis.annotations.Param;
import org.seckill.entity.*;

import java.util.List;

public interface ContractDao {
    List<Free> gainFree();

    List<GoodsStatus> gainGoodsStatus();

    List<Contact> gainContact();

    List<House> gainHouse(@Param("loc") String loc);

    List<House> gainAd(@Param("loc") String loc);

    List<House> gainCar(@Param("loc") String loc);

    int updateCustomCarReg(@Param("no") String no, @Param("person") String person, @Param("phone") String phone, @Param("loc") String loc, @Param("customId") int customId);

    List<Contract> gainContractList(@Param("style") String style, @Param("page") int page, @Param("pageSize") int pageSize);

    int gainContractListTotal(@Param("style") String style);

    List<Contract> gainContractListDel(@Param("style") String style, @Param("page") int page, @Param("pageSize") int pageSize);

    int gainContractListDelTotal(@Param("style") String style);

    List<Contract> gainContractListConfirm(@Param("page") int page, @Param("pageSize") int pageSize);

    int gainContractListConfirmTotal();

    List<Contract> gainContractListCancel(@Param("page") int page, @Param("pageSize") int pageSize);

    int gainContractListCancelTotal();

    int updateIsOk(@Param("uuid") String uuid, @Param("isOk") int isOk, @Param("explain") String explain, @Param("approval") String approval, @Param("approvalDate") String approvalDate);

    Contract gainContract(@Param("uuid") String uuid);

    List<Contract> queryCancel(@Param("code") String code, @Param("startDate") String startDate, @Param("endDate") String endDate, @Param("page") int page, @Param("pageSize") int pageSize);

    int queryCancelTotal(@Param("code") String code, @Param("startDate") String startDate, @Param("endDate") String endDate);

    int insertContract(@Param("userName") String userName, @Param("house1") String house1, @Param("house2") String house2, @Param("house3") String house3, @Param("code") String code, @Param("no") String no, @Param("uuid") String uuid, @Param("codeAuto") String codeAuto, @Param("remark") String remark
            , @Param("linkMan") String linkMan, @Param("phone") String phone, @Param("startDate") String startDate,
                       @Param("endDate") String endDate, @Param("warnDay") String warnDay, @Param("type") String type, @Param("style") String style,
                       @Param("table1") String table1, @Param("table2") String table2, @Param("table2H") String table2H, @Param("table3") String table3,
                       @Param("table11") String table11, @Param("table22") String table22, @Param("table33") String table33, @Param("table44") String table44,
                       @Param("table55") String table55, @Param("table66") String table66, @Param("table77") String table77, @Param("table88") String table88, @Param("explain") String explain, @Param("customId") int customId,@Param("total")double total);

    int modifyContract(@Param("userName") String userName, @Param("house1") String house1, @Param("house2") String house2, @Param("house3") String house3, @Param("code") String code, @Param("uuid") String uuid, @Param("codeAuto") String codeAuto, @Param("remark") String remark
            , @Param("linkMan") String linkMan, @Param("phone") String phone, @Param("startDate") String startDate,
                       @Param("endDate") String endDate, @Param("warnDay") String warnDay, @Param("type") String type, @Param("style") String style,
                       @Param("table1") String table1, @Param("table2") String table2, @Param("table2H") String table2H, @Param("table3") String table3,
                       @Param("table11") String table11, @Param("table22") String table22, @Param("table33") String table33, @Param("table44") String table44,
                       @Param("table55") String table55, @Param("table66") String table66, @Param("table77") String table77, @Param("table88") String table88, @Param("explain") String explain, @Param("customId") int customId,@Param("total")double total);

    int dateTotal(@Param("date") String date);

    int queryTotal(@Param("style") String style, @Param("code") String code, @Param("linkMan") String linkMan, @Param("no") String no, @Param("number") String number, @Param("startDate") String startDate, @Param("endDate") String endDate);

    List<Contract> query(@Param("style") String style, @Param("code") String code, @Param("linkMan") String linkMan, @Param("no") String no, @Param("number") String number, @Param("startDate") String startDate, @Param("endDate") String endDate, @Param("page") int page, @Param("pageSize") int pageSize);

    int queryDelTotal(@Param("style") String style, @Param("code") String code, @Param("linkMan") String linkMan, @Param("no") String no, @Param("number") String number, @Param("startDate") String startDate, @Param("endDate") String endDate);

    List<Contract> queryDel(@Param("style") String style, @Param("code") String code, @Param("linkMan") String linkMan, @Param("no") String no, @Param("number") String number, @Param("startDate") String startDate, @Param("endDate") String endDate, @Param("page") int page, @Param("pageSize") int pageSize);

    int del(@Param("uuid") String uuid);

    int updateDel(@Param("uuid") String uuid);

    String gainContactSort(@Param("id") int id);


    int insertAdContract(@Param("userName") String userName, @Param("code") String code, @Param("no") String no, @Param("uuid") String uuid, @Param("codeAuto") String codeAuto, @Param("remark") String remark
            , @Param("linkMan") String linkMan, @Param("phone") String phone, @Param("startDate") String startDate,
                         @Param("endDate") String endDate, @Param("warnDay") String warnDay, @Param("type") String type, @Param("style") String style,
                         @Param("table1") String table1, @Param("table2") String table2, @Param("table2H") String table2H, @Param("table3") String table3,
                         @Param("table11") String table11, @Param("table33") String table33, @Param("explain") String explain, @Param("customId") int customId,@Param("total")double total);

    int modifyAdContract(@Param("userName") String userName, @Param("code") String code, @Param("uuid") String uuid, @Param("codeAuto") String codeAuto, @Param("remark") String remark
            , @Param("linkMan") String linkMan, @Param("phone") String phone, @Param("startDate") String startDate,
                         @Param("endDate") String endDate, @Param("warnDay") String warnDay, @Param("type") String type, @Param("style") String style,
                         @Param("table1") String table1, @Param("table2") String table2, @Param("table2H") String table2H, @Param("table3") String table3,
                         @Param("table11") String table11, @Param("table33") String table33, @Param("explain") String explain, @Param("customId") int customId,@Param("total")double total);

    int insertCarContract(@Param("userName") String userName, @Param("code") String code, @Param("no") String no, @Param("uuid") String uuid, @Param("codeAuto") String codeAuto, @Param("remark") String remark
            , @Param("linkMan") String linkMan, @Param("phone") String phone, @Param("startDate") String startDate,
                          @Param("endDate") String endDate, @Param("warnDay") String warnDay, @Param("type") String type, @Param("style") String style,
                          @Param("table1") String table1, @Param("table2") String table2, @Param("table2H") String table2H, @Param("table3") String table3,
                          @Param("table11") String table11, @Param("table33") String table33, @Param("explain") String explain, @Param("customId") int customId,@Param("total")double total);

    int modifyCarContract(@Param("userName") String userName, @Param("code") String code, @Param("uuid") String uuid, @Param("codeAuto") String codeAuto, @Param("remark") String remark
            , @Param("linkMan") String linkMan, @Param("phone") String phone, @Param("startDate") String startDate,
                          @Param("endDate") String endDate, @Param("warnDay") String warnDay, @Param("type") String type, @Param("style") String style,
                          @Param("table1") String table1, @Param("table2") String table2, @Param("table2H") String table2H, @Param("table3") String table3,
                          @Param("table11") String table11, @Param("table33") String table33, @Param("explain") String explain, @Param("customId") int customId,@Param("total")double total);

    List<Contract> gainCustomByLinkManAndRemark(@Param("linkMan") String linkMan, @Param("remark") String remark);

    List<Contract> gainCustomWarn(@Param("page") int page, @Param("pageSize") int pageSize);

    int gainCustomWarnTotal();

    int insertTable38(@Param("uuid") String uuid, @Param("style") String style, @Param("table33Money") String table33Money, @Param("table33Date") String table33Date, @Param("table33Warn") String table33Warn, @Param("table88StartDate") String table88StartDate, @Param("table88EndDate") String table88EndDate, @Param("table88Warn") String table88Warn);

    int insertTable77(@Param("uuid") String uuid, @Param("startDate") String startDate, @Param("endDate") String endDate, @Param("total") String total, @Param("discount") String discount, @Param("discountTotal") String discountTotal);

    int updateTable77IsConfirm(@Param("isConfirm") int isConfirm, @Param("id") int id);

    int delTable38(@Param("uuid") String uuid);

    int insertTable1(@Param("uuid") String uuid, @Param("style") String style, @Param("loc") String loc, @Param("payDate") String payDate);

    int delTable1(@Param("uuid") String uuid);

    int updateHouse(@Param("goodsStatusId") int goodsStatusId, @Param("loc") String loc);

    int repeatHouse(@Param("loc") String loc);

    List<Contract> gainContractWarn(@Param("page") int page, @Param("pageSize") int pageSize);

    int gainContractWarnTotal();

    int gainFreeExportByLocAndDate(@Param("loc") String loc, @Param("date") String date);

    String gainMinDate(@Param("uuid") String uuid);

    /**
     * 更新合同到期的资源
     *
     * @return
     */
    int updateDeadline();
    int updateDeadlineNo();
    int updateDeadlineDel();

    int delTable77(@Param("uuid") String uuid);

    List<FreeExport> gainMaxDegree(@Param("loc") String loc, @Param("type") String type);

    int updateContractWater(@Param("isWater") int isWater, @Param("contractUuid") String contractUuid,@Param("loc")String loc,@Param("type")String type);
    int updateWaterLoc(@Param("loc")String loc,@Param("type")String type);

}

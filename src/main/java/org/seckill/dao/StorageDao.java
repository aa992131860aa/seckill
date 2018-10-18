package org.seckill.dao;

import org.apache.ibatis.annotations.Param;
import org.seckill.entity.*;

import java.util.Date;
import java.util.List;

public interface StorageDao {
    /**
     * 房源资源
     */
    List<GoodsName> gainGoodsName();

    List<GoodsStatus> gainGoodsStatus();

    List<Ad> gainAd();

    List<Car> gainCar();

    Integer addHouse(@Param("userId") int userId, @Param("goodsNameId") int goodsNameId, @Param("location") String location
            , @Param("useArea") double useArea, @Param("buildArea") double buildArea, @Param("num") int num, @Param("linkHouse") String linkHouse, @Param("unit") double unit
            , @Param("cash") double cash, @Param("waterNo") String waterNo, @Param("powerNo") String powerNo, @Param("airNo") String airNo, @Param("startTime") String startTime, @Param("endTime") String endTime, @Param("modifyTime") String modifyTime
            , @Param("goodsStatusId") int goodsStatusId, @Param("floor") int floor, @Param("isWindow") int isWindow, @Param("remark") String remark, @Param("chartLoc") String chartLoc);

    Integer modifyHouse(@Param("id") int id, @Param("userId") int userId, @Param("goodsNameId") int goodsNameId, @Param("location") String location
            , @Param("useArea") double useArea, @Param("buildArea") double buildArea, @Param("num") int num, @Param("linkHouse") String linkHouse, @Param("unit") double unit
            , @Param("cash") double cash, @Param("waterNo") String waterNo, @Param("powerNo") String powerNo, @Param("airNo") String airNo, @Param("startTime") String startTime, @Param("endTime") String endTime, @Param("modifyTime") String modifyTime
            , @Param("goodsStatusId") int goodsStatusId, @Param("floor") int floor, @Param("isWindow") int isWindow, @Param("remark") String remark, @Param("chartLoc") String chartLoc);

    Integer modifyHouseAd(@Param("id") int id, @Param("userId") int userId, @Param("goodsNameId") int goodsNameId, @Param("location") String location
            , @Param("useArea") double useArea, @Param("num") int num, @Param("startTime") String startTime,
                          @Param("endTime") String endTime, @Param("modifyTime") String modifyTime
            , @Param("goodsStatusId") int goodsStatusId, @Param("floor") int floor, @Param("adType") int adType, @Param("chartLoc") String chartLoc);

    Integer modifyHouseCar(@Param("id") int id, @Param("userId") int userId, @Param("goodsNameId") int goodsNameId, @Param("location") String location
            , @Param("useArea") double useArea, @Param("num") int num, @Param("startTime") String startTime,
                           @Param("endTime") String endTime, @Param("modifyTime") String modifyTime
            , @Param("goodsStatusId") int goodsStatusId, @Param("floor") int floor, @Param("carType") int carType, @Param("chartLoc") String chartLoc);

    Integer addHouseAd(@Param("userId") int userId, @Param("goodsNameId") int goodsNameId, @Param("location") String location
            , @Param("useArea") double useArea, @Param("num") int num, @Param("startTime") String startTime,
                       @Param("endTime") String endTime, @Param("modifyTime") String modifyTime
            , @Param("goodsStatusId") int goodsStatusId, @Param("floor") int floor, @Param("adType") int adType, @Param("chartLoc") String chartLoc);

    Integer addHouseCar(@Param("userId") int userId, @Param("goodsNameId") int goodsNameId, @Param("location") String location
            , @Param("useArea") double useArea, @Param("num") int num, @Param("startTime") String startTime,
                        @Param("endTime") String endTime, @Param("modifyTime") String modifyTime
            , @Param("goodsStatusId") int goodsStatusId, @Param("floor") int floor, @Param("carType") int carType, @Param("chartLoc") String chartLoc);

    List<House> gainHouse(@Param("page") int page, @Param("pageSize") int pageSize, @Param("type") int type);

    int totalNum(@Param("page") int page, @Param("pageSize") int pageSize, @Param("type") int type);

    House gainOneHouse(@Param("id") int id);

    int gainHouseTotal(@Param("type") int type);

    int delHouse(@Param("id") int id);

    List<Custom> gainHistoryHouse(@Param("loc") String loc);

    List<Contract> gainHistoryContract(@Param("loc") String loc);

    int updateCustomIdByUuid(@Param("uuid") String uuid, @Param("id") int id);

    List<House> gainHouseQuery(@Param("page") int page, @Param("pageSize") int pageSize, @Param("type") int type, @Param("typeId") int typeId, @Param("goodsNameId") int goodsNameId, @Param("location") String location, @Param("goodsStatusId") String goodsStatusId, @Param("floor") int floor, @Param("startTime") String startTime, @Param("endTime") String endTime, @Param("startArea") String startArea, @Param("endArea") String endArea, @Param("isWindow") String isWindow, @Param("house1") String house1, @Param("house2") String house2, @Param("house3") String house3, @Param("adTypeIn") String adTypeIn, @Param("carTypeIn") String carTypeIn);

    int gainHouseQueryTotal(@Param("type") int type, @Param("typeId") int typeId, @Param("goodsNameId") int goodsNameId, @Param("location") String location, @Param("goodsStatusId") String goodsStatusId, @Param("floor") int floor, @Param("startTime") String startTime, @Param("endTime") String endTime, @Param("startArea") String startArea, @Param("endArea") String endArea, @Param("isWindow") String isWindow, @Param("adTypeIn") String adTypeIn, @Param("carTypeIn") String carTypeIn);

    int gainHouseQueryNum(@Param("page") int page, @Param("pageSize") int pageSize, @Param("type") int type, @Param("typeId") int typeId, @Param("goodsNameId") int goodsNameId, @Param("location") String location, @Param("goodsStatusId") String goodsStatusId, @Param("floor") int floor, @Param("startTime") String startTime, @Param("endTime") String endTime, @Param("startArea") String startArea, @Param("endArea") String endArea, @Param("isWindow") String isWindow, @Param("house1") String house1, @Param("house2") String house2, @Param("house3") String house3, @Param("adTypeIn") String adTypeIn, @Param("carTypeIn") String carTypeIn);

    /**
     * 客户管理
     */

    int addWorker(@Param("name") String name, @Param("phone") String phone, @Param("duty") String duty, @Param("link") String link, @Param("uuid") String uuid);

    int addCompany(@Param("name") String name, @Param("no") String no, @Param("uuid") String uuid);

    int addCarReg(@Param("name") String name, @Param("phone") String phone, @Param("no") String no, @Param("uuid") String uuid);

    int addBad(@Param("date") String date, @Param("place") String place, @Param("content") String content, @Param("uuid") String uuid);

    int addCustom(@Param("name") String name, @Param("remark") String remark, @Param("code") String code, @Param("uuid") String uuid, @Param("registerInfo") String registerInfo);

    int updateCustom(@Param("name") String name, @Param("remark") String remark, @Param("code") String code, @Param("uuid") String uuid);

    int delWorker(@Param("uuid") String uuid);

    int delCompany(@Param("uuid") String uuid);

    int delCarReg(@Param("uuid") String uuid);

    int delBad(@Param("uuid") String uuid);

    int delCustom(@Param("uuid") String uuid);

    List<Worker> gainWorker(@Param("uuid") String uuid);

    List<Company> gainCompany(@Param("uuid") String uuid);

    List<CarReg> gainCarReg(@Param("uuid") String uuid);

    List<Bad> gainBad(@Param("uuid") String uuid);

    List<Custom> gainCustom(@Param("page") int page, @Param("pageSize") int pageSize);

    Custom gainCustomOne(@Param("uuid") String uuid);

    Custom gainCustomName(@Param("name") String name);

    List<Custom> gainCustomNameList(@Param("name") String name);

    int delCustomByName(@Param("name") String name);

    List<Custom> gainCustomQuery(@Param("code") String code, @Param("linkMan") String linkMan, @Param("page") int page, @Param("pageSize") int pageSize);

    Integer gainCustomTotal();

    List<Integer> gainCustomQueryTotal(@Param("code") String code, @Param("linkMan") String linkMan);

    List<Custom> gainCustomByCode(@Param("code") String code);

    List<Contract> gainStatus(@Param("loc") String loc, @Param("style") String style);

    int insertFreeExport(@Param("loc") String loc, @Param("no") String no, @Param("date") String date, @Param("degree") String degree, @Param("type") String type, @Param("source") String source, @Param("createTime") String createTime, @Param("contractDegree") String contractDegree, @Param("contractUuid") String contractUuid);

    int updateFreeExport(@Param("loc") String loc, @Param("no") String no, @Param("date") String date, @Param("degree") String degree, @Param("type") String type, @Param("source") String source, @Param("createTime") String createTime, @Param("contractDegree") String contractDegree, @Param("contractUuid") String contractUuid);

    List<FreeExport> gainFreeExport(@Param("type") String type, @Param("page") int page, @Param("pageSize") int pageSize);

    int gainFreeExportTotal(@Param("type") String type);

    List<FreeExport> gainFreeExportBy(@Param("loc") String loc, @Param("type") String type);

    int delFreeExport(@Param("id") int id);

    List<FreeExport> gainFreeExportGroup(@Param("type") String type);

    List<Custom> gainCustomById(@Param("id") int id);

    int gainRentCustom(@Param("id") int id);

    int gainRentCustomNum(@Param("id") int id);

    int updateFreeExportDateAndDegree(@Param("id") int id, @Param("date") String date, @Param("degree") String degree);

    List<FreeExport> gainFreeExportDateAndLoc(@Param("type") String type, @Param("page") int page, @Param("pageSize") int pageSize);

    int gainFreeExportDateAndLocTotal(@Param("type") String type);

    FreeExport gainFreeExportByDateAndLoc(@Param("loc") String loc, @Param("date") String date, @Param("type") String type);
}

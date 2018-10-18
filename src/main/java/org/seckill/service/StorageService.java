package org.seckill.service;

import org.apache.ibatis.annotations.Param;
import org.seckill.entity.*;

import java.util.List;

public interface StorageService {
    List<GoodsName> gainGoodsName();

    List<GoodsStatus> gainGoodsStatus();

    House gainOneHouse(int id);

    Integer addHouse(int userId, int goodsNameId, String location
            , double useArea, double buildArea, int num, String linkHouse, double unit
            , double cash, String waterNo, String powerNo, String airNo, String startTime, String endTime, String modifyTime
            , int goodsStatusId, int floor, int isWindow, String remark, String chartLoc);

    Integer modifyHouse(int id, int userId, int goodsNameId, String location
            , double useArea, double buildArea, int num, String linkHouse, double unit
            , double cash, String waterNo, String powerNo, String airNo, String startTime, String endTime, String modifyTime
            , int goodsStatusId, int floor, int isWindow, String remark, String chartLoc);

    Integer modifyHouseAd(int id, int userId, int goodsNameId, String location
            , double useArea, int num, String startTime, String endTime, String modifyTime
            , int goodsStatusId, int floor, int adType, String chartLoc);

    Integer addHouseAd(int userId, int goodsNameId, String location
            , double useArea, int num, String startTime, String endTime, String modifyTime
            , int goodsStatusId, int floor, int adType, String chartLoc);

    Integer modifyHouseCar(int id, int userId, int goodsNameId, String location
            , double useArea, int num, String startTime, String endTime, String modifyTime
            , int goodsStatusId, int floor, int carType, String chartLoc);

    Integer addHouseCar(int userId, int goodsNameId, String location
            , double useArea, int num, String startTime, String endTime, String modifyTime
            , int goodsStatusId, int floor, int carType, String chartLoc);

    List<House> gainHouse(int page, int pageSize, int type);

    int gainHouseTotal(int type);

    int delHouse(int id);

    List<Ad> gainAd();

    List<Car> gainCar();

    List<House> gainHouseQuery(int page, int pageSize, int type, int typeId, int goodsNameId, String location, String goodsStatusId, int floor, String startTime, String endTime, String startArea, String endArea, String isWindow, String house1, String house2, String house3, String adTypeIn, String carTypeIn);

    int gainHouseQueryNum(int page, int pageSize, int type, int typeId, int goodsNameId, String location, String goodsStatusId, int floor, String startTime, String endTime, String startArea, String endArea, String isWindow, String house1, String house2, String house3, String adTypeIn, String carTypeIn);

    int gainHouseQueryTotal(int type, int typeId, int goodsNameId, String location, String goodsStatusId, int floor, String startTime, String endTime, String startArea, String endArea, String isWindow, String adTypeIn, String carTypeIn);

    List<Custom> gainHistoryHouse(String loc);

    List<Contract> gainHistoryContract(String loc);

    int updateCustomIdByUuid(String uuid, int id);

    /**
     * 客户管理
     */
    int addWorker(String name, String phone, String duty, String link, String uuid);

    int addCompany(String name, String no, String uuid);

    int addCarReg(String name, String phone, String no, String uuid);

    int addBad(String date, String place, String content, String uuid);

    int addCustom(String name, String remark, String code, String uuid, String registerInfo);

    int updateCustom(String name, String remark, String code, String uuid);

    int delWorker(String uuid);

    int delCompany(String uuid);

    int delCarReg(String uuid);

    int delBad(String uuid);

    int delCustom(String uuid);

    List<Worker> gainWorker(String uuid);

    List<Company> gainCompany(String uuid);

    List<CarReg> gainCarReg(String uuid);

    List<Bad> gainBad(String uuid);

    List<Custom> gainCustom(int page, int pageSize);

    Integer gainCustomTotal();

    Custom gainCustomOne(String uuid);

    Custom gainCustomName(String name);

    List<Custom> gainCustomNameList(String name);

    int delCustomByName(String name);

    List<Custom> gainCustomQuery(String code, String linkMan, int page, int pageSize);

    List<Integer> gainCustomQueryTotal(String code, String linkMan);

    List<Custom> gainCustomByCode(String code);

    List<Contract> gainStatus(String loc, String style);

    int totalNum(int page, int pageSize, int type);

    int insertFreeExport(String loc, String no, String date, String degree, String type, String source, String createTime, String contractDegree, String contractUuid);

    int updateFreeExport(String loc, String no, String date, String degree, String type, String source, String createTime, String contractDegree, String contractUuid);

    int updateFreeExportDateAndDegree(int id, String date, String degree);

    List<FreeExport> gainFreeExport(String type, int page, int pageSize);

    int gainFreeExportTotal(String type);

    List<FreeExport> gainFreeExportBy(String loc, String type);

    int delFreeExport(int id);

    List<FreeExport> gainFreeExportGroup(String type);

    List<Custom> gainCustomById(int id);

    int gainRentCustom(int id);

    int gainRentCustomNum(int id);

    List<FreeExport> gainFreeExportDateAndLoc(String type, int page, int pageSize);

    FreeExport gainFreeExportByDateAndLoc(String loc, String date, String type);

    int gainFreeExportDateAndLocTotal(String type);
}

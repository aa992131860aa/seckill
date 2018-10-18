package org.seckill.service.impl;

import org.seckill.dao.StorageDao;
import org.seckill.entity.*;
import org.seckill.service.StorageService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class StorageServiceImpl implements StorageService {
    @Autowired
    StorageDao storageDao;

    public List<GoodsName> gainGoodsName() {
        return storageDao.gainGoodsName();
    }

    public List<GoodsStatus> gainGoodsStatus() {
        return storageDao.gainGoodsStatus();
    }

    public Integer addHouse(int userId, int goodsNameId, String location
            , double useArea, double buildArea, int num, String linkHouse, double unit
            , double cash, String waterNo, String powerNo, String airNo, String startTime, String endTime, String modifyTime
            , int goodsStatusId, int floor, int isWindow, String remark, String chartLoc) {
        return storageDao.addHouse(userId, goodsNameId, location
                , useArea, buildArea, num, linkHouse, unit
                , cash, waterNo, powerNo, airNo, startTime, endTime, modifyTime
                , goodsStatusId, floor, isWindow, remark, chartLoc);
    }

    public House gainOneHouse(int id) {
        return storageDao.gainOneHouse(id);
    }

    public Integer modifyHouse(int id, int userId, int goodsNameId, String location
            , double useArea, double buildArea, int num, String linkHouse, double unit
            , double cash, String waterNo, String powerNo, String airNo, String startTime, String endTime, String modifyTime
            , int goodsStatusId, int floor, int isWindow, String remark, String chartLoc) {
        return storageDao.modifyHouse(id, userId, goodsNameId, location
                , useArea, buildArea, num, linkHouse, unit
                , cash, waterNo, powerNo, airNo, startTime, endTime, modifyTime
                , goodsStatusId, floor, isWindow, remark, chartLoc);
    }

    public Integer modifyHouseAd(int id, int userId, int goodsNameId, String location
            , double useArea, int num, String startTime, String endTime, String modifyTime
            , int goodsStatusId, int floor, int adType, String chartLoc) {
        return storageDao.modifyHouseAd(id, userId, goodsNameId, location
                , useArea, num, startTime, endTime, modifyTime
                , goodsStatusId, floor, adType, chartLoc);
    }

    public Integer addHouseAd(int userId, int goodsNameId, String location
            , double useArea, int num, String startTime, String endTime, String modifyTime
            , int goodsStatusId, int floor, int adType, String chartLoc) {
        return storageDao.addHouseAd(userId, goodsNameId, location
                , useArea, num, startTime, endTime, modifyTime
                , goodsStatusId, floor, adType, chartLoc);
    }

    public Integer modifyHouseCar(int id, int userId, int goodsNameId, String location
            , double useArea, int num, String startTime, String endTime, String modifyTime
            , int goodsStatusId, int floor, int adType, String chartLoc) {
        return storageDao.modifyHouseCar(id, userId, goodsNameId, location
                , useArea, num, startTime, endTime, modifyTime
                , goodsStatusId, floor, adType, chartLoc);
    }

    public Integer addHouseCar(int userId, int goodsNameId, String location
            , double useArea, int num, String startTime, String endTime, String modifyTime
            , int goodsStatusId, int floor, int carType, String chartLoc) {
        return storageDao.addHouseCar(userId, goodsNameId, location
                , useArea, num, startTime, endTime, modifyTime
                , goodsStatusId, floor, carType, chartLoc);
    }


    public List<House> gainHouse(int page, int pageSize, int type) {
        return storageDao.gainHouse(page, pageSize, type);
    }

    public int gainHouseTotal(int type) {
        return storageDao.gainHouseTotal(type);
    }

    public int delHouse(int id) {
        return storageDao.delHouse(id);
    }

    public List<Ad> gainAd() {
        return storageDao.gainAd();
    }

    public List<Car> gainCar() {
        return storageDao.gainCar();
    }

    public List<House> gainHouseQuery(int page, int pageSize, int type, int typeId, int goodsNameId, String location, String goodsStatusId, int floor, String startTime, String endTime, String startArea, String endArea, String isWindow, String house1, String house2, String house3, String adTypeIn, String carTypeIn) {
        return storageDao.gainHouseQuery(page, pageSize, type, typeId, goodsNameId, location, goodsStatusId, floor, startTime, endTime, startArea, endArea, isWindow, house1, house2, house3, adTypeIn, carTypeIn);
    }

    public int gainHouseQueryNum(int page, int pageSize, int type, int typeId, int goodsNameId, String location, String goodsStatusId, int floor, String startTime, String endTime, String startArea, String endArea, String isWindow, String house1, String house2, String house3, String adTypeIn, String carTypeIn) {
        return storageDao.gainHouseQueryNum(page, pageSize, type, typeId, goodsNameId, location, goodsStatusId, floor, startTime, endTime, startArea, endArea, isWindow, house1, house2, house3, adTypeIn, carTypeIn);
    }

    public int gainHouseQueryTotal(int type, int typeId, int goodsNameId, String location, String goodsStatusId, int floor, String startTime, String endTime, String startArea, String endArea, String isWindow, String adTypeIn, String carTypeIn) {
        return storageDao.gainHouseQueryTotal(type, typeId, goodsNameId, location, goodsStatusId, floor, startTime, endTime, startArea, endArea, isWindow, adTypeIn, carTypeIn);
    }

    public List<Custom> gainHistoryHouse(String loc) {
        return storageDao.gainHistoryHouse(loc);
    }

    public List<Contract> gainHistoryContract(String loc) {
        return storageDao.gainHistoryContract(loc);
    }

    public int addWorker(String name, String phone, String duty, String link, String uuid) {
        return storageDao.addWorker(name, phone, duty, link, uuid);
    }

    public int updateCustomIdByUuid(String uuid, int id) {
        return storageDao.updateCustomIdByUuid(uuid, id);
    }

    public int addCompany(String name, String no, String uuid) {
        return storageDao.addCompany(name, no, uuid);
    }

    public int addCarReg(String name, String phone, String no, String uuid) {
        return storageDao.addCarReg(name, phone, no, uuid);
    }

    public int addBad(String date, String place, String content, String uuid) {
        return storageDao.addBad(date, place, content, uuid);
    }

    public int addCustom(String name, String remark, String code, String uuid, String registerInfo) {
        return storageDao.addCustom(name, remark, code, uuid, registerInfo);
    }

    public int updateCustom(String name, String remark, String code, String uuid) {
        return storageDao.updateCustom(name, remark, code, uuid);
    }

    public int delWorker(String uuid) {
        return storageDao.delWorker(uuid);
    }

    public int delCompany(String uuid) {
        return storageDao.delCompany(uuid);
    }

    public int delCarReg(String uuid) {
        return storageDao.delCarReg(uuid);
    }

    public int delBad(String uuid) {
        return storageDao.delBad(uuid);
    }

    public int delCustom(String uuid) {
        return storageDao.delCustom(uuid);
    }

    public List<Worker> gainWorker(String uuid) {
        return storageDao.gainWorker(uuid);
    }

    public List<Company> gainCompany(String uuid) {
        return storageDao.gainCompany(uuid);
    }

    public List<CarReg> gainCarReg(String uuid) {
        return storageDao.gainCarReg(uuid);
    }

    public List<Bad> gainBad(String uuid) {
        return storageDao.gainBad(uuid);
    }

    public List<Custom> gainCustom(int page, int pageSize) {
        return storageDao.gainCustom(page, pageSize);
    }

    public Integer gainCustomTotal() {
        return storageDao.gainCustomTotal();
    }

    public Custom gainCustomOne(String uuid) {
        return storageDao.gainCustomOne(uuid);
    }

    public Custom gainCustomName(String name) {
        return storageDao.gainCustomName(name);
    }

    public List<Custom> gainCustomNameList(String name) {
        return storageDao.gainCustomNameList(name);
    }

    public int delCustomByName(String name) {
        return storageDao.delCustomByName(name);
    }

    public List<Custom> gainCustomQuery(String code, String linkMan, int page, int pageSize) {
        return storageDao.gainCustomQuery(code, linkMan, page, pageSize);
    }

    public List<Integer> gainCustomQueryTotal(String code, String linkMan) {
        return storageDao.gainCustomQueryTotal(code, linkMan);
    }

    public int totalNum(int page, int pageSize, int type) {
        return storageDao.totalNum(page, pageSize, type);
    }

    public List<Custom> gainCustomByCode(String code) {
        return storageDao.gainCustomByCode(code);
    }

    public List<Contract> gainStatus(String loc, String style) {
        return storageDao.gainStatus(loc, style);
    }

    public int insertFreeExport(String loc, String no, String date, String degree, String type, String source, String createTime, String contractDegree, String contractUuid) {
        return storageDao.insertFreeExport(loc, no, date, degree, type, source, createTime, contractDegree, contractUuid);
    }

    public int updateFreeExport(String loc, String no, String date, String degree, String type, String source, String createTime, String contractDegree, String contractUuid) {
        return storageDao.updateFreeExport(loc, no, date, degree, type, source, createTime, contractDegree, contractUuid);
    }

    public List<FreeExport> gainFreeExport(String type, int page, int pageSize) {
        return storageDao.gainFreeExport(type, page, pageSize);
    }

    public int gainFreeExportTotal(String type) {
        return storageDao.gainFreeExportTotal(type);
    }

    public List<FreeExport> gainFreeExportBy(String loc, String type) {
        return storageDao.gainFreeExportBy(loc, type);
    }

    public int delFreeExport(int id) {
        return storageDao.delFreeExport(id);
    }

    public List<FreeExport> gainFreeExportGroup(String type) {
        return storageDao.gainFreeExportGroup(type);
    }

    public List<Custom> gainCustomById(int id) {
        return storageDao.gainCustomById(id);
    }

    public int gainRentCustom(int id) {
        return storageDao.gainRentCustom(id);
    }

    public int gainRentCustomNum(int id) {
        return storageDao.gainRentCustomNum(id);
    }

    public int updateFreeExportDateAndDegree(int id, String date, String degree) {
        return storageDao.updateFreeExportDateAndDegree(id, date, degree);
    }

    public List<FreeExport> gainFreeExportDateAndLoc(String type, int page, int pageSize) {
        return storageDao.gainFreeExportDateAndLoc(type, page, pageSize);
    }

    public int gainFreeExportDateAndLocTotal(String type) {
        return storageDao.gainFreeExportDateAndLocTotal(type);
    }

    public FreeExport gainFreeExportByDateAndLoc(String loc, String date, String type) {
        return storageDao.gainFreeExportByDateAndLoc(loc, date, type);
    }
}

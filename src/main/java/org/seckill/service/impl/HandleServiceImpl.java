package org.seckill.service.impl;

import org.apache.ibatis.annotations.Param;
import org.seckill.dao.HandleDao;
import org.seckill.entity.Contact;
import org.seckill.entity.Contract;
import org.seckill.entity.ContractFree;
import org.seckill.entity.TableM;
import org.seckill.service.HandleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class HandleServiceImpl implements HandleService {
    @Autowired
    HandleDao handleDao;

    public List<Contract> gainContractOne(String loc) {
        return handleDao.gainContractOne(loc);
    }

    public List<Contract> gainContractList(int page, int pageSize) {
        return handleDao.gainContractList(page, pageSize);
    }

    public int gainContractListTotal() {
        return handleDao.gainContractListTotal();
    }

    public List<Contract> gainContractListQuery(String code, String startDate, String endDate, int page, int pageSize) {
        return handleDao.gainContractListQuery(code, startDate, endDate, page, pageSize);
    }

    public int gainContractListTotalQuery(String code, String startDate, String endDate) {
        return handleDao.gainContractFinishListTotalQuery(code, startDate, endDate);
    }

    public List<Contract> gainContract(String codeAuto, String remark) {
        return handleDao.gainContract(codeAuto, remark);
    }

    public List<Contract> gainContractId(int id) {
        return handleDao.gainContractId(id);
    }

    public int updateDebt(String codeAuto, String remark, double debt, int contractId) {
        return handleDao.updateDebt(codeAuto, remark, debt, contractId);
    }

    public int updateTableM(String codeAuto, String remark, String tableM, int customId) {
        return handleDao.updateTableM(codeAuto, remark, tableM, customId);
    }

    public int insertTableM(String uuid, String codeAuto, String remark, String dateM,
                            String moneyM, String contentM, String remarkM,
                            String pay1, String pay2, String pay3, String pay4, int customId, String pay5, String pay) {
        return handleDao.insertTableM(uuid, codeAuto, remark, dateM, moneyM, contentM, remarkM, pay1, pay2, pay3, pay4, customId, pay5, pay);
    }

    public List<TableM> gainTableMList(int contractId, String codeAuto, String remark) {
        return handleDao.gainTableMList(contractId, codeAuto, remark);
    }

    public int delTableM(String uuid) {
        return handleDao.delTableM(uuid);
    }

    public String gainTableM(String codeAuto, String remark) {
        return handleDao.gainTableM(codeAuto, remark)
                ;
    }

    public String gainTableMId(int id) {
        String tableU = handleDao.gainTableMId(id);
        if (tableU == null) {
            tableU = "";
        }
        return tableU;
    }

    public int updateIsConfirm(String codeAuto, String remark, int isConfirm) {
        return handleDao.updateIsConfirm(codeAuto, remark, isConfirm);
    }

    public int updateIsConfirmId(int id, int isConfirm) {
        return handleDao.updateIsConfirmId(id, isConfirm);
    }

    public List<Contract> gainContractFinishList(int page, int pageSize) {
        return handleDao.gainContractFinishList(page, pageSize);
    }

    public int gainContractFinishListTotal() {
        return handleDao.gainContractFinishListTotal();
    }

    public List<TableM> gainTableMAllList(String codeAuto, String remark, int page, int pageSize) {
        return handleDao.gainTableMAllList(codeAuto, remark, page, pageSize);
    }

    public int gainTableMAllListTotal(String codeAuto, String remark) {
        return handleDao.gainTableMAllListTotal(codeAuto, remark);
    }

    public List<TableM> gainTableMAllListQuery(String code, String codeAuto, String remark, int page, int pageSize) {
        return handleDao.gainTableMAllListQuery(code, codeAuto, remark, page, pageSize);
    }

    public int gainTableMAllListTotalQuery(String code, String codeAuto, String remark) {
        return handleDao.gainTableMAllListTotalQuery(code, codeAuto, remark);
    }

    public int updatePay(int isPay, int isFree, String freeReason, String otherIn, String otherOut, String reason, String uuid, String payTotal, int isOver, String payIn, String payOut, String contractEnd, double payFree) {
        return handleDao.updatePay(isPay, isFree, freeReason, otherIn, otherOut, reason, uuid, payTotal, isOver, payIn, payOut, contractEnd, payFree);
    }

    public List<Contract> gainContractPayList(int page, int pageSize) {
        return handleDao.gainContractPayList(page, pageSize);
    }

    public int gainContractPayListTotal() {
        return handleDao.gainContractPayListTotal();
    }

    public List<Contract> gainContractPayListQuery(String code, String startDate, String endDate, int page, int pageSize) {
        return handleDao.gainContractPayListQuery(code, startDate, endDate, page, pageSize);
    }

    public int gainContractPayListTotalQuery(String code, String startDate, String endDate) {
        return handleDao.gainContractPayListTotalQuery(code, startDate, endDate);
    }

    public int insertTableMPay(String uuid, String codeAuto, String remark, String dateM,
                               String moneyM, int contractId, String pay, String payOut) {
        return handleDao.insertTableMPay(uuid, codeAuto, remark, dateM, moneyM, contractId, pay, payOut);
    }

    public int updateTableMPay(String uuid, String codeAuto, String remark, String dateM,
                               String moneyM, int contractId, String pay, String payOut) {
        return handleDao.updateTableMPay(uuid, codeAuto, remark, dateM, moneyM, contractId, pay, payOut);
    }

    public int updatePayFinish(int id, int isFinish) {
        return handleDao.updatePayFinish(id, isFinish);
    }

    public List<Contract> gainContractByCustomId(int customId) {
        return handleDao.gainContractByCustomId(customId);
    }

    public int delTableMContractId(int contractId) {
        return handleDao.delTableMContractId(contractId);
    }

    public List<Contract> gainContractFinishListQuery(String code, String startDate, String endDate, int page, int pageSize) {
        return handleDao.gainContractFinishListQuery(code, startDate, endDate, page, pageSize);
    }

    public int gainContractFinishListTotalQuery(String code, String startDate, String endDate) {
        return handleDao.gainContractFinishListTotalQuery(code, startDate, endDate);
    }

    public TableM gainTableMContractId(int contractId) {
        return handleDao.gainTableMContractId(contractId);
    }

    public List<String> gainTableMCustomId(int customId) {
        return handleDao.gainTableMCustomId(customId);
    }

    public int updateTableMCustomId(String tableM, int customId) {
        return handleDao.updateTableMCustomId(tableM, customId);
    }

    public int updateisWaterCustomId(int isWater, int customId) {
        return handleDao.updateisWaterCustomId(isWater, customId);
    }

    public List<Contract> gainContractListAll(String codeCheck, String locCheck) {
        return handleDao.gainContractListAll(codeCheck, locCheck);
    }

    public int gainContractListTotalAll() {
        return handleDao.gainContractListTotalAll();
    }

    public int insertContractFree(int customId, String name, String loc, String no, double money){
        return handleDao.insertContractFree(customId, name, loc, no, money);
    }

    public List<ContractFree> gainContractFreeList(int customId){
        return  handleDao.gainContractFreeList(customId);
    }
}

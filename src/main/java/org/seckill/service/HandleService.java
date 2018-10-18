package org.seckill.service;

import org.apache.ibatis.annotations.Param;
import org.seckill.entity.Contact;
import org.seckill.entity.Contract;
import org.seckill.entity.TableM;

import java.util.List;

public interface HandleService {

    List<Contract> gainContractOne(String loc);

    List<Contract> gainContractList(int page, int pageSize);

    int gainContractListTotal();

    List<Contract> gainContractListQuery(String code, String startDate, String endDate, int page, int pageSize);

    int gainContractListTotalQuery(String code, String startDate, String endDate);

    List<Contract> gainContract(String codeAuto, String remark);

    List<Contract> gainContractId(int id);

    int updateDebt(String codeAuto, String remark, double debt, int contractId);

    int updateTableM(String codeAuto, String remark, String tableM, int customId);

    int insertTableM(String uuid, String codeAuto, String remark, String dateM,
                     String moneyM, String contentM, String remarkM,
                     String pay1, String pay2, String pay3, String pay4, int customId, String pay5, String pay);

    List<TableM> gainTableMList(int contractId, String codeAuto, String remark);

    int delTableM(String uuid);

    String gainTableM(String codeAuto, String remark);

    String gainTableMId(int id);

    int updateIsConfirm(String codeAuto, String remark, int isConfirm);

    int updateIsConfirmId(int id, int isConfirm);

    List<Contract> gainContractFinishList(int page, int pageSize);

    int gainContractFinishListTotal();

    List<Contract> gainContractFinishListQuery(String code, String startDate, String endDate, int page, int pageSize);

    int gainContractFinishListTotalQuery(String code, String startDate, String endDate);

    List<TableM> gainTableMAllList(String codeAuto, String remark, int page, int pageSize);

    int gainTableMAllListTotal(String codeAuto, String remark);

    List<TableM> gainTableMAllListQuery(String code, String codeAuto, String remark, int page, int pageSize);

    int gainTableMAllListTotalQuery(String code, String codeAuto, String remark);

    int updatePay(int isPay, int isFree, String freeReason, String otherIn, String otherOut, String reason, String uuid, String payTotal, int isOver, String payIn, String payOut, String contractEnd, double payFree);

    List<Contract> gainContractPayList(int page, int pageSize);

    int gainContractPayListTotal();

    List<Contract> gainContractPayListQuery(String code, String startDate, String endDate, int page, int pageSize);

    int gainContractPayListTotalQuery(String code, String startDate, String endDate);

    int insertTableMPay(String uuid, String codeAuto, String remark, String dateM,
                        String moneyM, int contractId, String pay, String payOut);

    int updateTableMPay(String uuid, String codeAuto, String remark, String dateM,
                        String moneyM, int contractId, String pay, String payOut);

    int updatePayFinish(int id, int isFinish);

    List<Contract> gainContractByCustomId(int customId);

    int delTableMContractId(int contractId);

    TableM gainTableMContractId(int contractId);

    List<String> gainTableMCustomId(int customId);

    int updateTableMCustomId(String tableM, int customId);

    int updateisWaterCustomId(int isWater, int customId);


    List<Contract> gainContractListAll(String codeCheck, String locCheck);

    int gainContractListTotalAll();
}

package org.seckill.dao;

import org.apache.ibatis.annotations.Param;
import org.seckill.entity.Contact;
import org.seckill.entity.Contract;
import org.seckill.entity.ContractFree;
import org.seckill.entity.TableM;
import org.springframework.web.bind.annotation.PathVariable;

import java.util.List;

public interface HandleDao {

    List<Contract> gainContractOne(@Param("loc") String loc);

    List<Contract> gainContractList(@Param("page") int page, @Param("pageSize") int pageSize);

    int gainContractListTotal();

    List<Contract> gainContractListAll(@Param("codeCheck") String codeCheck, @Param("locCheck") String locCheck);

    int gainContractListTotalAll();

    List<Contract> gainContractListQuery(@Param("code") String code, @Param("startDate") String startDate, @Param("endDate") String endDate, @Param("page") int page, @Param("pageSize") int pageSize);

    int gainContractListTotalQuery(@Param("code") String code, @Param("startDate") String startDate, @Param("endDate") String endDate);

    List<Contract> gainContract(@Param("codeAuto") String codeAuto, @Param("remark") String remark);

    List<Contract> gainContractId(@Param("id") int id);

    int updateDebt(@Param("codeAuto") String codeAuto, @Param("remark") String remark, @Param("debt") double debt, @Param("contractId") int contractId);

    int updateTableM(@Param("codeAuto") String codeAuto, @Param("remark") String remark, @Param("tableM") String tableM, @Param("customId") int customId);

    String gainTableM(@Param("codeAuto") String codeAuto, @Param("remark") String remark);

    String gainTableMId(@Param("id") int id);

    int insertTableMPay(@Param("uuid") String uuid, @Param("codeAuto") String codeAuto, @Param("remark") String remark, @Param("dateM") String dateM,
                        @Param("moneyM") String moneyM, @Param("contractId") int contractId, @Param("pay") String pay, @Param("payOut") String payOut);

    int updateTableMPay(@Param("uuid") String uuid, @Param("codeAuto") String codeAuto, @Param("remark") String remark, @Param("dateM") String dateM,
                        @Param("moneyM") String moneyM, @Param("contractId") int contractId, @Param("pay") String pay, @Param("payOut") String payOut);

    int insertTableM(@Param("uuid") String uuid, @Param("codeAuto") String codeAuto, @Param("remark") String remark, @Param("dateM") String dateM,
                     @Param("moneyM") String moneyM, @Param("contentM") String contentM, @Param("remarkM") String remarkM,
                     @Param("pay1") String pay1, @Param("pay2") String pay2, @Param("pay3") String pay3, @Param("pay4") String pay4, @Param("customId") int customId, @Param("pay5") String pay5, @Param("pay") String pay);

    int updatePayFinish(@Param("id") int id, @Param("isFinish") int isFinish);

    List<TableM> gainTableMList(@Param("contractId") int contractId, @Param("codeAuto") String codeAuto, @Param("remark") String remark);

    int delTableM(@Param("uuid") String uuid);

    //修改冲账
    int updateIsConfirm(@Param("codeAuto") String codeAuto, @Param("remark") String remark, @Param("isConfirm") int isConfirm);

    int updateIsConfirmId(@Param("id") int id, @Param("isConfirm") int isConfirm);

    List<Contract> gainContractFinishList(@Param("page") int page, @Param("pageSize") int pageSize);

    int gainContractFinishListTotal();

    List<Contract> gainContractFinishListQuery(@Param("code") String code, @Param("startDate") String startDate, @Param("endDate") String endDate, @Param("page") int page, @Param("pageSize") int pageSize);

    int gainContractFinishListTotalQuery(@Param("code") String code, @Param("startDate") String startDate, @Param("endDate") String endDate);

    List<TableM> gainTableMAllList(@Param("codeAuto") String codeAuto, @Param("remark") String remark, @Param("page") int page, @Param("pageSize") int pageSize);

    int gainTableMAllListTotal(@Param("codeAuto") String codeAuto, @Param("remark") String remark);

    List<TableM> gainTableMAllListQuery(@Param("code") String code, @Param("codeAuto") String codeAuto, @Param("remark") String remark, @Param("page") int page, @Param("pageSize") int pageSize);

    int gainTableMAllListTotalQuery(@Param("code") String code, @Param("codeAuto") String codeAuto, @Param("remark") String remark);


    int updatePay(@Param("isPay") int isPay, @Param("isFree") int isFree, @Param("freeReason") String freeReason, @Param("otherIn") String otherIn, @Param("otherOut") String otherOut, @Param("reason") String reason, @Param("uuid") String uuid, @Param("payTotal") String payTotal, @Param("isOver") int isOver, @Param("payIn") String payIn, @Param("payOut") String payOut, @Param("contractEnd") String contractEnd, @Param("payFree") double payFree);

    List<Contract> gainContractPayList(@Param("page") int page, @Param("pageSize") int pageSize);

    int gainContractPayListTotal();

    List<Contract> gainContractPayListQuery(@Param("code") String code, @Param("startDate") String startDate, @Param("endDate") String endDate, @Param("page") int page, @Param("pageSize") int pageSize);

    int gainContractPayListTotalQuery(@Param("code") String code, @Param("startDate") String startDate, @Param("endDate") String endDate);

    List<Contract> gainContractByCustomId(@Param("customId") int customId);

    int delTableMContractId(@Param("contractId") int contractId);

    TableM gainTableMContractId(@Param("contractId") int contractId);

    List<String> gainTableMCustomId(@Param("customId") int customId);

    int updateTableMCustomId(@Param("tableM") String tableM, @Param("customId") int customId);

    int updateisWaterCustomId(@Param("isWater") int isWater, @Param("customId") int customId);

    int insertContractFree(@Param("customId") int customId, @Param("name") String name, @Param("loc") String loc, @Param("no") String no, @Param("money") double money);

    List<ContractFree> gainContractFreeList(@Param("customId") int customId);
}

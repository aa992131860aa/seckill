package org.seckill.entity;

import java.util.List;

public class TableM {
    private int id;
    private String uuid;
    private String codeAuto;
    private String remark;
    private String dateM;
    private String moneyM;
    private String contentM;
    private String remarkM;
    private String pay1;
    private String pay2;
    private String pay3;
    private String pay4;
    private String pay5;
    private List<TableM> tableMList;
    private int contractId;
    private String pay;
    private String payOut;
    private int customId;

    public int getCustomId() {
        return customId;
    }

    public void setCustomId(int customId) {
        this.customId = customId;
    }

    public String getPayOut() {
        return payOut;
    }

    public void setPayOut(String payOut) {
        this.payOut = payOut;
    }

    public String getPay() {
        return pay;
    }

    public void setPay(String pay) {
        this.pay = pay;
    }

    public String getPay5() {
        return pay5;
    }

    public void setPay5(String pay5) {
        this.pay5 = pay5;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public String getCodeAuto() {
        return codeAuto;
    }

    public void setCodeAuto(String codeAuto) {
        this.codeAuto = codeAuto;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getDateM() {
        return dateM;
    }

    public void setDateM(String dateM) {
        this.dateM = dateM;
    }

    public String getMoneyM() {
        return moneyM;
    }

    public void setMoneyM(String moneyM) {
        this.moneyM = moneyM;
    }

    public String getContentM() {
        return contentM;
    }

    public void setContentM(String contentM) {
        this.contentM = contentM;
    }

    public String getRemarkM() {
        return remarkM;
    }

    public void setRemarkM(String remarkM) {
        this.remarkM = remarkM;
    }

    public String getPay1() {
        return pay1;
    }

    public void setPay1(String pay1) {
        this.pay1 = pay1;
    }

    public String getPay2() {
        return pay2;
    }

    public void setPay2(String pay2) {
        this.pay2 = pay2;
    }

    public String getPay3() {
        return pay3;
    }

    public void setPay3(String pay3) {
        this.pay3 = pay3;
    }

    public String getPay4() {
        return pay4;
    }

    public void setPay4(String pay4) {
        this.pay4 = pay4;
    }

    public List<TableM> getTableMList() {
        return tableMList;
    }

    public void setTableMList(List<TableM> tableMList) {
        this.tableMList = tableMList;
    }

    public int getContractId() {
        return contractId;
    }

    public void setContractId(int contractId) {
        this.contractId = contractId;
    }
}

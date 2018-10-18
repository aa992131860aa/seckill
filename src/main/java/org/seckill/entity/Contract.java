package org.seckill.entity;

import java.util.ArrayList;
import java.util.List;

public class Contract {
    private int id;
    private String uuid;
    private String type;
    private String warnDay;
    private String startDate;
    private String endDate;
    private String codeAuto;
    private String phone;
    private String linkMan;
    private String remark;
    private String style;
    private String table1;
    private String table2;
    private String table2H;
    private String table3;
    private String table11;
    private String table22;
    private String table33;
    private String table44;
    private String table55;
    private String table66;
    private String table77;
    private String table88;
    private String no;

    private String house1;
    private String house2;
    private String house3;
    private String userName;

    private String payDate = "";
    private double payTotal;

    private String adName;
    private double adPayTotal;
    //违约金
    private double debt;
    private long day;

    private int isOk;
    private String explain;
    private String createTime;
    private List<AdTemp> adTempList;


    private List<Table> tableList1 = new ArrayList<Table>();
    private List<Table> tableList2 = new ArrayList<Table>();
    private List<Table> tableList2H = new ArrayList<Table>();
    private List<Table> tableList3 = new ArrayList<Table>();
    private List<Table> tableList11 = new ArrayList<Table>();
    private List<Table> tableList22 = new ArrayList<Table>();
    private List<Table> tableList33 = new ArrayList<Table>();
    private List<Table> tableList44 = new ArrayList<Table>();
    private List<Table> tableList55 = new ArrayList<Table>();
    private List<Table> tableList66 = new ArrayList<Table>();
    private List<Table> tableList77 = new ArrayList<Table>();
    private List<Table> tableList88 = new ArrayList<Table>();

    private String table33Date;
    private String table88StartDate;
    private String table88EndDate;
    private int customId;

    private String approval;
    private String approvalDate;
    private double total;
    private double payFree;
    private List<Contract> contractDetailList;
    private String tableU;

    public long getDay() {
        return day;
    }

    public void setDay(long day) {
        this.day = day;
    }

    public String getTableU() {
        return tableU;
    }

    public void setTableU(String tableU) {
        this.tableU = tableU;
    }

    public List<Contract> getContractDetailList() {
        return contractDetailList;
    }

    public void setContractDetailList(List<Contract> contractDetailList) {
        this.contractDetailList = contractDetailList;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public double getPayFree() {
        return payFree;
    }

    public void setPayFree(double payFree) {
        this.payFree = payFree;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    //合同的预警 或者物业能耗费的预警
    private String warnStyle;

    //      `is_pay` int(11) DEFAULT '0' COMMENT '终止合同,1表示已终止',
//            `free_reason` varchar(255) DEFAULT NULL,
//  `is_free` int(11) DEFAULT '0' COMMENT '是否申免',
//            `other_in` varchar(255) DEFAULT NULL,
//  `other_out` varchar(255) DEFAULT NULL,
//  `reason` varchar(255) DEFAULT NULL,
//  `pay_total` varchar(255) DEFAULT NULL,
//  `is_over` int(11) DEFAULT '0' COMMENT '结束  正常 0    异常1',
//            `pay_in` varchar(255) DEFAULT NULL COMMENT '应收',
//            `pay_out` varchar(255) DEFAULT NULL COMMENT '应付',
    private int isPay;
    private String freeReason;
    private int isFree;
    private String otherIn;
    private String otherOut;
    private String reason;
    //    private String payTotal;
    private int isOver;
    private String payIn;
    private String payOut;
    private int isFinish;
    private String contractEnd;
    private int isWater;
    private int isPower;
    private int isAir;
    private double tableMTotal;
    private double payTableMMinus;


    public int getIsPower() {
        return isPower;
    }

    public void setIsPower(int isPower) {
        this.isPower = isPower;
    }

    public int getIsAir() {
        return isAir;
    }

    public void setIsAir(int isAir) {
        this.isAir = isAir;
    }

    public double getPayTableMMinus() {
        return payTableMMinus;
    }

    public void setPayTableMMinus(double payTableMMinus) {
        this.payTableMMinus = payTableMMinus;
    }

    public double getTableMTotal() {
        return tableMTotal;
    }

    public void setTableMTotal(double tableMTotal) {
        this.tableMTotal = tableMTotal;
    }

    public int getIsWater() {
        return isWater;
    }

    public void setIsWater(int isWater) {
        this.isWater = isWater;
    }

    public int getIsFinish() {
        return isFinish;
    }

    public void setIsFinish(int isFinish) {
        this.isFinish = isFinish;
    }

    public String getContractEnd() {
        return contractEnd;
    }

    public void setContractEnd(String contractEnd) {
        this.contractEnd = contractEnd;
    }

    public int getIsPay() {
        return isPay;
    }

    public void setIsPay(int isPay) {
        this.isPay = isPay;
    }

    public String getFreeReason() {
        return freeReason;
    }

    public void setFreeReason(String freeReason) {
        this.freeReason = freeReason;
    }

    public int getIsFree() {
        return isFree;
    }

    public void setIsFree(int isFree) {
        this.isFree = isFree;
    }

    public String getOtherIn() {
        return otherIn;
    }

    public void setOtherIn(String otherIn) {
        this.otherIn = otherIn;
    }

    public String getOtherOut() {
        return otherOut;
    }

    public void setOtherOut(String otherOut) {
        this.otherOut = otherOut;
    }

    public String getReason() {
        return reason;
    }

    public void setReason(String reason) {
        this.reason = reason;
    }

    public int getIsOver() {
        return isOver;
    }

    public void setIsOver(int isOver) {
        this.isOver = isOver;
    }

    public String getPayIn() {
        return payIn;
    }

    public void setPayIn(String payIn) {
        this.payIn = payIn;
    }

    public String getPayOut() {
        return payOut;
    }

    public void setPayOut(String payOut) {
        this.payOut = payOut;
    }

    public String getTable33Date() {
        return table33Date;
    }

    public void setTable33Date(String table33Date) {
        this.table33Date = table33Date;
    }

    public String getTable88StartDate() {
        return table88StartDate;
    }

    public void setTable88StartDate(String table88StartDate) {
        this.table88StartDate = table88StartDate;
    }

    public String getTable88EndDate() {
        return table88EndDate;
    }

    public void setTable88EndDate(String table88EndDate) {
        this.table88EndDate = table88EndDate;
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

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getWarnDay() {
        return warnDay;
    }

    public void setWarnDay(String warnDay) {
        this.warnDay = warnDay;
    }

    public String getStartDate() {
        return startDate;
    }

    public void setStartDate(String startDate) {
        this.startDate = startDate;
    }

    public String getEndDate() {
        return endDate;
    }

    public void setEndDate(String endDate) {
        this.endDate = endDate;
    }

    public String getCodeAuto() {
        return codeAuto;
    }

    public void setCodeAuto(String codeAuto) {
        this.codeAuto = codeAuto;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getLinkMan() {
        return linkMan;
    }

    public void setLinkMan(String linkMan) {
        this.linkMan = linkMan;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getStyle() {
        return style;
    }

    public void setStyle(String style) {
        this.style = style;
    }

    public String getTable1() {
        return table1;
    }

    public void setTable1(String table1) {
        this.table1 = table1;
    }

    public String getTable2() {
        return table2;
    }

    public void setTable2(String table2) {
        this.table2 = table2;
    }

    public String getTable2H() {
        return table2H;
    }

    public void setTable2H(String table2H) {
        this.table2H = table2H;
    }

    public String getTable3() {
        return table3;
    }

    public void setTable3(String table3) {
        this.table3 = table3;
    }

    public String getTable11() {
        return table11;
    }

    public void setTable11(String table11) {
        this.table11 = table11;
    }

    public String getTable22() {
        return table22;
    }

    public void setTable22(String table22) {
        this.table22 = table22;
    }

    public String getTable33() {
        return table33;
    }

    public void setTable33(String table33) {
        this.table33 = table33;
    }

    public String getTable44() {
        return table44;
    }

    public void setTable44(String table44) {
        this.table44 = table44;
    }

    public String getTable55() {
        return table55;
    }

    public void setTable55(String table55) {
        this.table55 = table55;
    }

    public String getTable66() {
        return table66;
    }

    public void setTable66(String table66) {
        this.table66 = table66;
    }

    public String getTable77() {
        return table77;
    }

    public void setTable77(String table77) {
        this.table77 = table77;
    }

    public String getTable88() {
        return table88;
    }

    public void setTable88(String table88) {
        this.table88 = table88;
    }

    public String getNo() {
        return no;
    }

    public void setNo(String no) {
        this.no = no;
    }

    public List<Table> getTableList1() {
        return tableList1;
    }

    public void setTableList1(List<Table> tableList1) {
        this.tableList1 = tableList1;
    }

    public List<Table> getTableList2() {
        return tableList2;
    }

    public void setTableList2(List<Table> tableList2) {
        this.tableList2 = tableList2;
    }

    public List<Table> getTableList2H() {
        return tableList2H;
    }

    public void setTableList2H(List<Table> tableList2H) {
        this.tableList2H = tableList2H;
    }

    public List<Table> getTableList3() {
        return tableList3;
    }

    public void setTableList3(List<Table> tableList3) {
        this.tableList3 = tableList3;
    }

    public List<Table> getTableList11() {
        return tableList11;
    }

    public void setTableList11(List<Table> tableList11) {
        this.tableList11 = tableList11;
    }

    public List<Table> getTableList22() {
        return tableList22;
    }

    public void setTableList22(List<Table> tableList22) {
        this.tableList22 = tableList22;
    }

    public List<Table> getTableList33() {
        return tableList33;
    }

    public void setTableList33(List<Table> tableList33) {
        this.tableList33 = tableList33;
    }

    public List<Table> getTableList44() {
        return tableList44;
    }

    public void setTableList44(List<Table> tableList44) {
        this.tableList44 = tableList44;
    }

    public List<Table> getTableList55() {
        return tableList55;
    }

    public void setTableList55(List<Table> tableList55) {
        this.tableList55 = tableList55;
    }

    public List<Table> getTableList66() {
        return tableList66;
    }

    public void setTableList66(List<Table> tableList66) {
        this.tableList66 = tableList66;
    }

    public List<Table> getTableList77() {
        return tableList77;
    }

    public void setTableList77(List<Table> tableList77) {
        this.tableList77 = tableList77;
    }

    public List<Table> getTableList88() {
        return tableList88;
    }

    public void setTableList88(List<Table> tableList88) {
        this.tableList88 = tableList88;
    }

    public String getHouse1() {
        return house1;
    }

    public void setHouse1(String house1) {
        this.house1 = house1;
    }

    public String getHouse2() {
        return house2;
    }

    public void setHouse2(String house2) {
        this.house2 = house2;
    }

    public String getHouse3() {
        return house3;
    }

    public void setHouse3(String house3) {
        this.house3 = house3;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getPayDate() {
        return payDate;
    }

    public void setPayDate(String payDate) {
        this.payDate = payDate;
    }

    public double getPayTotal() {
        return payTotal;
    }

    public void setPayTotal(double payTotal) {
        this.payTotal = payTotal;
    }

    public String getAdName() {
        return adName;
    }

    public void setAdName(String adName) {
        this.adName = adName;
    }

    public double getAdPayTotal() {
        return adPayTotal;
    }

    public void setAdPayTotal(double adPayTotal) {
        this.adPayTotal = adPayTotal;
    }

    public List<AdTemp> getAdTempList() {
        return adTempList;
    }

    public void setAdTempList(List<AdTemp> adTempList) {
        this.adTempList = adTempList;
    }

    public double getDebt() {
        return debt;
    }

    public void setDebt(double debt) {
        this.debt = debt;
    }

    public int getIsOk() {
        return isOk;
    }

    public void setIsOk(int isOk) {
        this.isOk = isOk;
    }

    public String getExplain() {
        return explain;
    }

    public void setExplain(String explain) {
        this.explain = explain;
    }

    public int getCustomId() {
        return customId;
    }

    public void setCustomId(int customId) {
        this.customId = customId;
    }

    public String getApproval() {
        return approval;
    }

    public void setApproval(String approval) {
        this.approval = approval;
    }

    public String getApprovalDate() {
        return approvalDate;
    }

    public void setApprovalDate(String approvalDate) {
        this.approvalDate = approvalDate;
    }

    public String getWarnStyle() {
        return warnStyle;
    }

    public void setWarnStyle(String warnStyle) {
        this.warnStyle = warnStyle;
    }

    @Override
    public String toString() {
        return "Contract{" +
                "id=" + id +
                ", uuid='" + uuid + '\'' +
                ", type='" + type + '\'' +
                ", warnDay='" + warnDay + '\'' +
                ", startDate='" + startDate + '\'' +
                ", endDate='" + endDate + '\'' +
                ", codeAuto='" + codeAuto + '\'' +
                ", phone='" + phone + '\'' +
                ", linkMan='" + linkMan + '\'' +
                ", remark='" + remark + '\'' +
                ", style='" + style + '\'' +
                ", table1='" + table1 + '\'' +
                ", table2='" + table2 + '\'' +
                ", table2H='" + table2H + '\'' +
                ", table3='" + table3 + '\'' +
                ", table11='" + table11 + '\'' +
                ", table22='" + table22 + '\'' +
                ", table33='" + table33 + '\'' +
                ", table44='" + table44 + '\'' +
                ", table55='" + table55 + '\'' +
                ", table66='" + table66 + '\'' +
                ", table77='" + table77 + '\'' +
                ", table88='" + table88 + '\'' +
                ", no='" + no + '\'' +
                ", house1='" + house1 + '\'' +
                ", house2='" + house2 + '\'' +
                ", house3='" + house3 + '\'' +
                ", userName='" + userName + '\'' +
                ", payDate='" + payDate + '\'' +
                ", payTotal=" + payTotal +
                ", adName='" + adName + '\'' +
                ", adPayTotal=" + adPayTotal +
                ", debt=" + debt +
                ", adTempList=" + adTempList +
                ", tableList1=" + tableList1 +
                ", tableList2=" + tableList2 +
                ", tableList2H=" + tableList2H +
                ", tableList3=" + tableList3 +
                ", tableList11=" + tableList11 +
                ", tableList22=" + tableList22 +
                ", tableList33=" + tableList33 +
                ", tableList44=" + tableList44 +
                ", tableList55=" + tableList55 +
                ", tableList66=" + tableList66 +
                ", tableList77=" + tableList77 +
                ", tableList88=" + tableList88 +
                '}';
    }
}

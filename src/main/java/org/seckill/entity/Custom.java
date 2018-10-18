package org.seckill.entity;

import java.util.List;

public class Custom {
    private int id;
    private String name;
    private String no;
    private String remark;
    private int departmentNo;
    private String code;
    private String createTime;
    private String uuid;
    private int c;

    private String selectUuid = "";

    private List<Worker> workerList;
    private List<Company> companyList;
    private List<CarReg> carRegList;
    private List<Bad> badList;

    private List<Custom> customList;
    private List<Contract> contractList;
    private Contract contract;
    private String startDate;
    private String endDate;
    private String registerInfo;
    private String isRent;
    //合同数量
    private int num;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getNo() {
        return no;
    }

    public void setNo(String no) {
        this.no = no;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public int getDepartmentNo() {
        return departmentNo;
    }

    public void setDepartmentNo(int departmentNo) {
        this.departmentNo = departmentNo;
    }

    public String getCode() {
        return code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getUuid() {
        return uuid;
    }

    public void setUuid(String uuid) {
        this.uuid = uuid;
    }

    public List<Worker> getWorkerList() {
        return workerList;
    }

    public void setWorkerList(List<Worker> workerList) {
        this.workerList = workerList;
    }

    public List<Company> getCompanyList() {
        return companyList;
    }

    public void setCompanyList(List<Company> companyList) {
        this.companyList = companyList;
    }

    public List<CarReg> getCarRegList() {
        return carRegList;
    }

    public void setCarRegList(List<CarReg> carRegList) {
        this.carRegList = carRegList;
    }

    public List<Bad> getBadList() {
        return badList;
    }

    public void setBadList(List<Bad> badList) {
        this.badList = badList;
    }


    public int getC() {
        return c;
    }

    public void setC(int c) {
        this.c = c;
    }

    public List<Custom> getCustomList() {
        return customList;
    }

    public void setCustomList(List<Custom> customList) {
        this.customList = customList;
    }

    public String getSelectUuid() {
        return selectUuid;
    }

    public void setSelectUuid(String selectUuid) {
        this.selectUuid = selectUuid;
    }

    public List<Contract> getContractList() {
        return contractList;
    }

    public void setContractList(List<Contract> contractList) {
        this.contractList = contractList;
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

    public Contract getContract() {
        return contract;
    }

    public void setContract(Contract contract) {
        this.contract = contract;
    }

    public String getRegisterInfo() {
        return registerInfo;
    }

    public void setRegisterInfo(String registerInfo) {
        this.registerInfo = registerInfo;
    }

    public String getIsRent() {
        return isRent;
    }

    public void setIsRent(String isRent) {
        this.isRent = isRent;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    @Override
    public String toString() {
        return "Custom{" +
                "id=" + id +
                ", name='" + name + '\'' +
                ", no='" + no + '\'' +
                ", remark='" + remark + '\'' +
                ", departmentNo=" + departmentNo +
                ", code='" + code + '\'' +
                ", createTime='" + createTime + '\'' +
                ", uuid='" + uuid + '\'' +
                ", c=" + c +
                ", selectUuid='" + selectUuid + '\'' +
                ", workerList=" + workerList +
                ", companyList=" + companyList +
                ", carRegList=" + carRegList +
                ", badList=" + badList +
                ", customList=" + customList +
                ", contractList=" + contractList +
                ", startDate='" + startDate + '\'' +
                ", endDate='" + endDate + '\'' +
                '}';
    }
}

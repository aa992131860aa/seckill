package org.seckill.entity;

public class House {
    private int id;
    private int goodsNameId;
    private String location;
    private double useArea;
    private double buildArea;
    private int num;
    private String linkHouse;
    private double unit;
    private double cash;
    private String startTime;
    private String endTime;
    private String createTime;
    private String modifyTime;
    private int goodsStatusId;
    private int userId;
    private String goodsName;
    private String goodsStatus;
    private int floor;
    private String waterNo;
    private String powerNo;
    private String airNo;
    //车牌的联系人和联系方式,车牌号
    private String person;
    private String phone;
    private String number;


    private int adId;
    private int carId;
    private String name;
    private String adName;
    private String carName;

    private int isWindow = 1;
    private String remark;

    private Custom custom;

    private String goodsStatusName;

    private String chartLoc;


    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public int getGoodsNameId() {
        return goodsNameId;
    }

    public void setGoodsNameId(int goodsNameId) {
        this.goodsNameId = goodsNameId;
    }

    public String getLocation() {
        return location;
    }

    public void setLocation(String location) {
        this.location = location;
    }

    public double getUseArea() {
        return useArea;
    }

    public void setUseArea(double useArea) {
        this.useArea = useArea;
    }

    public double getBuildArea() {
        return buildArea;
    }

    public void setBuildArea(double buildArea) {
        this.buildArea = buildArea;
    }

    public int getNum() {
        return num;
    }

    public void setNum(int num) {
        this.num = num;
    }

    public String getLinkHouse() {
        return linkHouse;
    }

    public void setLinkHouse(String linkHouse) {
        this.linkHouse = linkHouse;
    }

    public double getUnit() {
        return unit;
    }

    public void setUnit(double unit) {
        this.unit = unit;
    }

    public double getCash() {
        return cash;
    }

    public void setCash(double cash) {
        this.cash = cash;
    }

    public String getStartTime() {
        return startTime;
    }

    public void setStartTime(String startTime) {
        this.startTime = startTime;
    }

    public String getEndTime() {
        return endTime;
    }

    public void setEndTime(String endTime) {
        this.endTime = endTime;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(String modifyTime) {
        this.modifyTime = modifyTime;
    }

    public int getGoodsStatusId() {
        return goodsStatusId;
    }

    public void setGoodsStatusId(int goodsStatusId) {
        this.goodsStatusId = goodsStatusId;
    }

    public int getUserId() {
        return userId;
    }

    public void setUserId(int userId) {
        this.userId = userId;
    }

    public String getGoodsName() {
        return goodsName;
    }

    public void setGoodsName(String goodsName) {
        this.goodsName = goodsName;
    }

    public String getGoodsStatus() {
        return goodsStatus;
    }

    public void setGoodsStatus(String goodsStatus) {
        this.goodsStatus = goodsStatus;
    }

    public int getFloor() {
        return floor;
    }

    public void setFloor(int floor) {
        this.floor = floor;
    }

    public String getWaterNo() {
        return waterNo;
    }

    public void setWaterNo(String waterNo) {
        this.waterNo = waterNo;
    }

    public String getPowerNo() {
        return powerNo;
    }

    public void setPowerNo(String powerNo) {
        this.powerNo = powerNo;
    }

    public String getAirNo() {
        return airNo;
    }

    public void setAirNo(String airNo) {
        this.airNo = airNo;
    }

    public int getAdId() {
        return adId;
    }

    public void setAdId(int adId) {
        this.adId = adId;
    }

    public int getCarId() {
        return carId;
    }

    public void setCarId(int carId) {
        this.carId = carId;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public int getIsWindow() {
        return isWindow;
    }

    public void setIsWindow(int isWindow) {
        this.isWindow = isWindow;
    }

    public String getRemark() {
        return remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    public String getAdName() {
        return adName;
    }

    public void setAdName(String adName) {
        this.adName = adName;
    }

    public String getCarName() {
        return carName;
    }

    public void setCarName(String carName) {
        this.carName = carName;
    }

    public Custom getCustom() {
        return custom;
    }

    public void setCustom(Custom custom) {
        this.custom = custom;
    }

    public String getPerson() {
        return person;
    }

    public void setPerson(String person) {
        this.person = person;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getNumber() {
        return number;
    }

    public void setNumber(String number) {
        this.number = number;
    }

    public String getGoodsStatusName() {
        return goodsStatusName;
    }

    public void setGoodsStatusName(String goodsStatusName) {
        this.goodsStatusName = goodsStatusName;
    }


    public String getChartLoc() {
        return chartLoc;
    }

    public void setChartLoc(String chartLoc) {
        this.chartLoc = chartLoc;
    }

    @Override
    public String toString() {
        return "House{" +
                "id=" + id +
                ", goodsNameId=" + goodsNameId +
                ", location='" + location + '\'' +
                ", useArea=" + useArea +
                ", buildArea=" + buildArea +
                ", num=" + num +
                ", linkHouse='" + linkHouse + '\'' +
                ", unit=" + unit +
                ", cash=" + cash +
                ", startTime='" + startTime + '\'' +
                ", endTime='" + endTime + '\'' +
                ", createTime='" + createTime + '\'' +
                ", modifyTime='" + modifyTime + '\'' +
                ", goodsStatusId=" + goodsStatusId +
                ", userId=" + userId +
                ", goodsName='" + goodsName + '\'' +
                ", goodsStatus='" + goodsStatus + '\'' +
                ", floor=" + floor +
                ", waterNo='" + waterNo + '\'' +
                ", powerNo='" + powerNo + '\'' +
                ", airNo='" + airNo + '\'' +
                ", adId=" + adId +
                ", carId=" + carId +
                '}';
    }
}

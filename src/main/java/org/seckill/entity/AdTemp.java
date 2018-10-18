package org.seckill.entity;

public class AdTemp {
    private String name;
    private double total;
    private String loc;
    private String date;
    private String price;
    private String buildArea;
    private long day;
    private double money;
    private String type;
    private int contractId;
    private String degree;
    private String lastDegree;
    private String no;
    private double useDegree;

    public double getUseDegree() {
        return useDegree;
    }

    public void setUseDegree(double useDegree) {
        this.useDegree = useDegree;
    }

    public double getMoney() {
        return money;
    }

    public void setMoney(double money) {
        this.money = money;
    }

    public String getDegree() {
        return degree;
    }

    public void setDegree(String degree) {
        this.degree = degree;
    }

    public String getLastDegree() {
        return lastDegree;
    }

    public void setLastDegree(String lastDegree) {
        this.lastDegree = lastDegree;
    }

    public String getNo() {
        return no;
    }

    public void setNo(String no) {
        this.no = no;
    }

    public int getContractId() {
        return contractId;
    }

    public void setContractId(int contractId) {
        this.contractId = contractId;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public long getDay() {
        return day;
    }

    public void setDay(long day) {
        this.day = day;
    }

    public String getBuildArea() {
        return buildArea;
    }

    public void setBuildArea(String buildArea) {
        this.buildArea = buildArea;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public AdTemp(String name, double total, String loc, String date) {
        this.name = name;
        this.total = total;
        this.loc = loc;
        this.date = date;

    }

    public AdTemp(String name, double total, String loc, String date, String lastDegree, String degree, String price, String no, double useDegree) {
        this.name = name;
        this.total = total;
        this.loc = loc;
        this.date = date;
        this.lastDegree = lastDegree;
        this.degree = degree;
        this.price = price;
        this.no = no;
        this.useDegree = useDegree;
    }

    public AdTemp(String name, double total, String loc, String date, String type, int contractId) {
        this.name = name;
        this.total = total;
        this.loc = loc;
        this.date = date;
        this.type = type;
        this.contractId = contractId;
    }

    public AdTemp(String name, double total, String loc, String date, String price, String buildArea, long day) {
        this.name = name;
        this.total = total;
        this.loc = loc;
        this.date = date;
        this.price = price;
        this.buildArea = buildArea;
        this.day = day;

    }

    public AdTemp(String name, double total, String loc, String date, String price, String buildArea, long day, String type, int contractId) {
        this.name = name;
        this.total = total;
        this.loc = loc;
        this.date = date;
        this.price = price;
        this.buildArea = buildArea;
        this.day = day;
        this.type = type;
        this.contractId = contractId;

    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getLoc() {
        return loc;
    }

    public void setLoc(String loc) {
        this.loc = loc;
    }
}

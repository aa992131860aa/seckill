package org.seckill.entity;

public class FreeExport implements java.io.Serializable {
    private int id;
    private String loc = "";
    private String no = "";
    private String date = "";
    private String degree = "";
    private String type = "";
    private String createTime = "";
    private String source = "";
    private int count;
    private String contractDegree = "";
    private String useDegree = "0";
    private double total;
    private String price;
    private String name;
    private String buildArea;
    private String contractUuid;
    private int isOk;

    public int getIsOk() {
        return isOk;
    }

    public void setIsOk(int isOk) {
        this.isOk = isOk;
    }

    public String getContractUuid() {
        return contractUuid;
    }

    public void setContractUuid(String contractUuid) {
        this.contractUuid = contractUuid;
    }

    public String getBuildArea() {
        return buildArea;
    }

    public void setBuildArea(String buildArea) {
        this.buildArea = buildArea;
    }

    public String getName() {
        return name;
    }

    public void setName(String name) {
        this.name = name;
    }

    public String getPrice() {
        return price;
    }

    public void setPrice(String price) {
        this.price = price;
    }

    public double getTotal() {
        return total;
    }

    public void setTotal(double total) {
        this.total = total;
    }

    public String getLoc() {
        return loc;
    }

    public void setLoc(String loc) {
        this.loc = loc;
    }

    public String getNo() {
        return no;
    }

    public void setNo(String no) {
        this.no = no;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getDegree() {
        return degree;
    }

    public void setDegree(String degree) {
        this.degree = degree;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public int getCount() {
        return count;
    }

    public void setCount(int count) {
        this.count = count;
    }

    public String getSource() {
        return source;
    }

    public void setSource(String source) {
        this.source = source;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getContractDegree() {
        return contractDegree;
    }

    public String getUseDegree() {
        return useDegree;
    }

    public void setUseDegree(String useDegree) {
        this.useDegree = useDegree;
    }

    public void setContractDegree(String contractDegree) {
        this.contractDegree = contractDegree;
    }

    public FreeExport(String loc, String no, String date, String degree) {
        this.loc = loc;
        this.no = no;
        this.date = date;
        this.degree = degree;
    }

    public FreeExport() {

    }

    @Override
    public String toString() {
        return "FreeExport{" +
                "loc='" + loc + '\'' +
                ", no='" + no + '\'' +
                ", date='" + date + '\'' +
                ", degree='" + degree + '\'' +
                '}';
    }
}

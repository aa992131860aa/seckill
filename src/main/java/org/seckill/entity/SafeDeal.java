package org.seckill.entity;

public class SafeDeal {
    private int id;
    private String date;
    private String userName;
    private String content;
    private int safeId;

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public int getSafeId() {
        return safeId;
    }

    public void setSafeId(int safeId) {
        this.safeId = safeId;
    }
}

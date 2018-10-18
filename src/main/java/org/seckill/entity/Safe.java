package org.seckill.entity;

import java.util.List;

public class Safe {

    private int id;
    private String dot;
    private String date;
    private int isNormal;
    private String userName;
    private String content;
    private String urls;
    private String type;
    private String createTime;
    private String[] contentList;
    private String[] urlsList;
    private int isDeal;

    public int getIsDeal() {
        return isDeal;
    }

    public void setIsDeal(int isDeal) {
        this.isDeal = isDeal;
    }

    public String[] getContentList() {
        return contentList;
    }

    public void setContentList(String[] contentList) {
        this.contentList = contentList;
    }

    public String[] getUrlsList() {
        return urlsList;
    }

    public void setUrlsList(String[] urlsList) {
        this.urlsList = urlsList;
    }

    public String getCreateTime() {
        return createTime;
    }

    public void setCreateTime(String createTime) {
        this.createTime = createTime;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getDot() {
        return dot;
    }

    public void setDot(String dot) {
        this.dot = dot;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public int getIsNormal() {
        return isNormal;
    }

    public void setIsNormal(int isNormal) {
        this.isNormal = isNormal;
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

    public String getUrls() {
        return urls;
    }

    public void setUrls(String urls) {
        this.urls = urls;
    }
}

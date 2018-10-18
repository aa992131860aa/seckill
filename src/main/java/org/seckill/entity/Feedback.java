package org.seckill.entity;

public class Feedback {


    private int id;
    private String content;
    private String type;
    private String date;
    private String urls;
    private String text;
    private String userName;
    private int isDeal;
    private String title;
    private String[] contentList;
    private String[] urlsList;

    public String[] getUrlsList() {
        return urlsList;
    }

    public void setUrlsList(String[] urlsList) {
        this.urlsList = urlsList;
    }

    public String[] getContentList() {
        return contentList;
    }

    public void setContentList(String[] contentList) {
        this.contentList = contentList;
    }

    public int getId() {
        return id;
    }

    public void setId(int id) {
        this.id = id;
    }

    public String getContent() {
        return content;
    }

    public void setContent(String content) {
        this.content = content;
    }

    public String getType() {
        return type;
    }

    public void setType(String type) {
        this.type = type;
    }

    public String getDate() {
        return date;
    }

    public void setDate(String date) {
        this.date = date;
    }

    public String getUrls() {
        return urls;
    }

    public void setUrls(String urls) {
        this.urls = urls;
    }

    public String getText() {
        return text;
    }

    public void setText(String text) {
        this.text = text;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }

    public int getIsDeal() {
        return isDeal;
    }

    public void setIsDeal(int isDeal) {
        this.isDeal = isDeal;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }
}

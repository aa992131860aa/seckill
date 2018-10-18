package org.seckill.entity;

import java.util.List;

public class Role3 {
    private int id;
    private String name;
    private int parentId;
    private List<Role4> role4;

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

    public int getParentId() {
        return parentId;
    }

    public void setParentId(int parentId) {
        this.parentId = parentId;
    }

    public List<Role4> getRole4() {
        return role4;
    }

    public void setRole4(List<Role4> role4) {
        this.role4 = role4;
    }
}

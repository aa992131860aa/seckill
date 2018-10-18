package org.seckill.entity;

import java.util.List;

public class Role2 {
    private int id;
    private String name;
    private int parentId;
    private List<Role3> role3;

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

    public List<Role3> getRole3() {
        return role3;
    }

    public void setRole3(List<Role3> role3) {
        this.role3 = role3;
    }
}

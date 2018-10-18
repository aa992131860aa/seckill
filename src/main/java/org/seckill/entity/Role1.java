package org.seckill.entity;

import java.util.List;

public class Role1 {
    private int id;
    private String name;
    private List<Role2> role2;

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

    public List<Role2> getRole2() {
        return role2;
    }

    public void setRole2(List<Role2> role2) {
        this.role2 = role2;
    }
}

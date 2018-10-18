package org.seckill.dto;

import org.seckill.entity.SuccessKilled;
import org.seckill.enums.SeckillStateEnum;

public class SeckillExecution {
    //执行的状态
    private int state;
    //状态显示的标识
    private String stateInfo;
    private long seckillId;
    //返回的秒杀记录
    private SuccessKilled successKilled;
    private SeckillStateEnum seckillStateEnum;

    public SeckillExecution(int state, String stateInfo, long seckillId, SuccessKilled successKilled) {
        this.state = state;
        this.stateInfo = stateInfo;
        this.seckillId = seckillId;
        this.successKilled = successKilled;
    }

    public SeckillExecution(SeckillStateEnum seckillStateEnum, long seckillId) {
        this.seckillStateEnum = seckillStateEnum;
        this.seckillId = seckillId;
        this.stateInfo = seckillStateEnum.getStateInfo();
    }

    public int getState() {
        return state;
    }

    public void setState(int state) {
        this.state = state;
    }

    public String getStateInfo() {
        return stateInfo;
    }

    public void setStateInfo(String stateInfo) {
        this.stateInfo = stateInfo;
    }

    public long getSeckillId() {
        return seckillId;
    }

    public void setSeckillId(long seckillId) {
        this.seckillId = seckillId;
    }

    public SuccessKilled getSuccessKilled() {
        return successKilled;
    }

    public void setSuccessKilled(SuccessKilled successKilled) {
        this.successKilled = successKilled;
    }
}

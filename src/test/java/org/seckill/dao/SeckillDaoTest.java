package org.seckill.dao;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.seckill.entity.Seckill;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import javax.annotation.Resource;

import java.util.Date;
import java.util.List;

import static org.junit.Assert.*;

/**
 * 配置spring和junit的整合,junit启动是加载springIOC容器
 */
@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring/spring-dao.xml"})

public class SeckillDaoTest {

    @Resource
    SeckillDao seckillDao;

    @Test
    public void queryById() {
        long id = 1000;
        Seckill seckill = seckillDao.queryById(id);
        System.out.println(seckill.getName());
        System.out.println(seckill);
    }

    @Test
    public void queryAll() {
        List<Seckill> seckillList = seckillDao.queryAll(0,100);
        for(Seckill seckill:seckillList){
            System.out.println(seckill);
        }
    }

    @Test
    public void reduceNumber() {
       int updateCount = seckillDao.reduceNumber(1000L,new Date());
        System.out.println("updateCount:"+updateCount);
    }


}
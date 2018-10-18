package org.seckill.service;

import org.junit.Test;
import org.junit.runner.RunWith;
import org.seckill.entity.Seckill;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.test.context.ContextConfiguration;
import org.springframework.test.context.junit4.SpringJUnit4ClassRunner;

import java.util.List;

import static org.junit.Assert.*;

@RunWith(SpringJUnit4ClassRunner.class)
@ContextConfiguration({"classpath:spring/spring-dao.xml","classpath:spring/spring-service.xml"})
public class SeckillServiceTest {

    @Autowired
    SeckillService seckillService;

    Logger logger = LoggerFactory.getLogger(this.getClass());

    @Test
    public void getSeckillList() {
        List<Seckill> seckillList = seckillService.getSeckillList();
        logger.debug("list={}",seckillList);
    }

    @Test
    public void getById() {
        Seckill seckill = seckillService.getById(1000);
        logger.debug("seckill={}",seckill);
    }

    @Test
    public void exportSeckillUrl() {
    }

    @Test
    public void executionSeckill() {
    }
}
package org.seckill.service.impl;

import org.seckill.dao.SeckillDao;
import org.seckill.dao.SuccessKilledDao;
import org.seckill.dto.Exposer;
import org.seckill.dto.SeckillExecution;
import org.seckill.entity.Seckill;
import org.seckill.entity.SuccessKilled;
import org.seckill.enums.SeckillStateEnum;
import org.seckill.exception.SeckillCloseException;
import org.seckill.exception.SeckillException;
import org.seckill.exception.SeckillRepeatException;
import org.seckill.service.SeckillService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.util.DigestUtils;

import java.util.Date;
import java.util.List;

@Service
public class SeckillServiceImpl implements SeckillService {

    @Autowired
    private SeckillDao seckillDao;
    @Autowired
    private SuccessKilledDao successKilledDao;
    private String salt = "sadfjo#%@#$%sjg4534DFWE;';a";
    private Logger logger = LoggerFactory.getLogger(this.getClass());

    public List<Seckill> getSeckillList() {
        List<Seckill> seckillList = seckillDao.queryAll(0, 4);
        return seckillList;
    }

    public Seckill getById(long seckillId) {
        Seckill seckill = seckillDao.queryById(seckillId);
        return seckill;
    }

    public Exposer exportSeckillUrl(long seckillId) {
        Seckill seckill = seckillDao.queryById(seckillId);
        if (seckill == null) {
            return new Exposer(false, seckillId);
        }
        long start = seckill.getStartTime().getTime();
        long end = seckill.getEndTime().getTime();
        long now = new Date().getTime();
        if (now < start || now > end) {
            return new Exposer(false, seckillId, now, start, end);
        }
        String md5 = getMd5(seckillId);

        return new Exposer(true, seckillId, md5);
    }
     @Transactional
     /**
      * 使用注释的优点
      * 1.开发团队约定一致
      * 2.保证事物方法的执行尽可能的短,不要穿插RPC/HTTP请求或者剥离到事物方法外部
      * 3.不是所有的都需要事物,只插入一条或者只读不需要
      */
    public SeckillExecution executionSeckill(long seckillId, long userPhone, String md5) throws SeckillException, SeckillRepeatException, SeckillCloseException {
        if (md5 == null || !md5.equals(getMd5(seckillId))) {
            throw new SeckillException("seckill data rewrite");
        }
        //执行秒杀逻辑 减库存 + 记录购买记录
        try {
            //减库存
            Date now = new Date();
            int updateCount = seckillDao.reduceNumber(seckillId, now);
            if (updateCount <= 0) {
                throw new SeckillException("seckill is closed");
            } else {
                //记录购买记录
                int insertCount = successKilledDao.insertSuccessKilled(seckillId, userPhone, 0);
                if (insertCount <= 0) {
                    throw new SeckillException("seckill repeat");
                } else {
                    return new SeckillExecution(SeckillStateEnum.SUCCESS, seckillId);
                }
            }
        } catch (SeckillCloseException sce) {
            throw sce;
        } catch (SeckillRepeatException sre) {
            throw sre;
        } catch (Exception e) {
            logger.error(e.getMessage(), e);
            throw new SeckillException("内部异常" + e.getMessage());
        }

    }

    private String getMd5(long seckillId) {
        String falg = seckillId + "/" + salt;
        String md5 = DigestUtils.md5DigestAsHex(falg.getBytes());
        return md5;
    }
}

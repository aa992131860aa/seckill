package org.seckill.service;

import org.seckill.dto.Exposer;
import org.seckill.dto.SeckillExecution;
import org.seckill.entity.Seckill;
import org.seckill.exception.SeckillCloseException;
import org.seckill.exception.SeckillException;
import org.seckill.exception.SeckillRepeatException;

import java.util.List;

public interface SeckillService {
    /**
     * 获取所有的秒杀列
     *
     * @return
     */
    List<Seckill> getSeckillList();

    /**
     * 获取单个的秒杀
     *
     * @param seckillId
     * @return
     */
    Seckill getById(long seckillId);

    /**
     * 秒杀开启是输出秒杀地址,
     * 还是输出开始结束时间
     *
     * @param seckillId
     * @return
     */
    Exposer exportSeckillUrl(long seckillId);

    /**
     * 执行秒杀
     *
     * @param seckillId
     * @param userPhone
     * @param md5
     * @return
     */
    SeckillExecution executionSeckill(long seckillId, long userPhone, String md5)
            throws SeckillException, SeckillRepeatException, SeckillCloseException;
}

package org.seckill.web;

import org.seckill.dto.Exposer;
import org.seckill.dto.SeckillExecution;
import org.seckill.dto.SeckillResult;
import org.seckill.entity.Seckill;
import org.seckill.enums.SeckillStateEnum;
import org.seckill.exception.SeckillCloseException;
import org.seckill.exception.SeckillRepeatException;
import org.seckill.service.SeckillService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/seckill")
public class SeckillController {
    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    private SeckillService seckillService;

    @RequestMapping(value = "/list", method = RequestMethod.GET)
    public String list(Model model) {
        List<Seckill> seckillList = seckillService.getSeckillList();
        model.addAttribute("list", seckillList);
        //list.jsp + Model => ViewAndModel
        return "list"; //  /WEB-INF/jsp/"list".jsp
    }

    @RequestMapping(value = "/{seckillId}/detail", method = RequestMethod.GET)
    public String detail(@PathVariable("seckillId") Long seckillId, Model model) {
        if (seckillId == null) {
            return "redirect:/seckill/list";
        }
        Seckill seckill = seckillService.getById(seckillId);
        if (seckill == null) {
            return "forword:/seckill/list";
        }
        model.addAttribute("seckill", seckill);
        return "detail";
    }

    @RequestMapping(value = "/{seckillId}/exposer", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public SeckillResult<Exposer> exposer(@PathVariable("seckillId") Long seckillId) {
        SeckillResult<Exposer> result;
        try {
            Exposer exposer = seckillService.exportSeckillUrl(seckillId);
            result = new SeckillResult<Exposer>(true, exposer);
        } catch (Exception e) {
            logger.debug(e.getMessage(), e);
            result = new SeckillResult<Exposer>(false, e.getMessage());
        }
        return result;
    }

    @RequestMapping(value = "/{seckillId}/{md5}/execution", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public SeckillResult<SeckillExecution> execute(
            @CookieValue(value = "killPhone", required = false) Long userPhone,
            @PathVariable("md5") String md5,
            @PathVariable("seckillId") Long seckillId) {
        if (userPhone == null) {
            return new SeckillResult<SeckillExecution>(false, "未注册");
        }


        try {
            SeckillExecution seckillExecution = seckillService.executionSeckill(seckillId, userPhone, md5);
            return new SeckillResult<SeckillExecution>(true, seckillExecution);
        } catch (SeckillRepeatException src) {
            SeckillExecution seckillExecution = new SeckillExecution(SeckillStateEnum.REPEAT_KILL, seckillId);
            return new SeckillResult<SeckillExecution>(false, seckillExecution);
        } catch (SeckillCloseException sce) {
            SeckillExecution seckillExecution = new SeckillExecution(SeckillStateEnum.END, seckillId);
            return new SeckillResult<SeckillExecution>(false, seckillExecution);
        } catch (Exception e) {
            logger.error("ex:"+e.getMessage()+",seckillService:"+seckillService,e);
            SeckillExecution seckillExecution = new SeckillExecution(SeckillStateEnum.INNER_ERROR, seckillId);
            return new SeckillResult<SeckillExecution>(false, seckillExecution);
        }
    }

    @RequestMapping(value = "/time/now", method = RequestMethod.GET)
    @ResponseBody
    public SeckillResult<Long> time() {
        SeckillResult<Long> result;
        Date now = new Date();
        result = new SeckillResult<Long>(true, now.getTime());
        return result;
    }
}

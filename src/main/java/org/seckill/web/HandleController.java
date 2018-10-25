package org.seckill.web;

import org.seckill.entity.*;
import org.seckill.service.BaseService;
import org.seckill.service.ContractService;
import org.seckill.service.HandleService;
import org.seckill.utils.CONST;
import org.seckill.utils.CommUtil;
import org.seckill.utils.NumberToCN;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import javax.servlet.http.HttpServletRequest;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Calendar;
import java.util.Date;
import java.util.List;


@Controller
@RequestMapping("/seckill")
public class HandleController {
    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    BaseService baseService;

    @Autowired
    HandleService handleService;

    @Autowired
    ContractService contractService;

    @RequestMapping(value = "/handle_pay/{userId}/{page}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String handlePay(Model model, HttpServletRequest request, @PathVariable("userId") int userId, @PathVariable("page") int page) {
        String flag1 = "@@";
        String flag2 = "=";
        String role4 = baseService.getRole(userId, "role4");
        String is_admin = CommUtil.showIsAdminCookie(request);

        model.addAttribute("role4", role4);
        model.addAttribute("is_admin", is_admin);
        int total = handleService.gainTableMAllListTotal("", "");

        List<TableM> tableMList = handleService.gainTableMAllList("", "", page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);

//        for(int i=0;i<tableMList.size();i++){
//            tableMList.get(i).setTableMList(handleService.gainTableMList(tableMList.get(i).getCodeAuto(),tableMList.get(i).getRemark()));
//        }

        model.addAttribute("tableMList", tableMList);
        model.addAttribute("page", page);
        model.addAttribute("total", total);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        return "handle_pay";
    }

    @RequestMapping(value = "/handle_pay/{userId}/{page}/{code}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String handlePay(Model model, HttpServletRequest request, @PathVariable("userId") int userId, @PathVariable("page") int page, @PathVariable("code") String code) {
        String flag1 = "@@";
        String flag2 = "=";
        String role4 = baseService.getRole(userId, "role4");
        String is_admin = CommUtil.showIsAdminCookie(request);
        if (code.equals("fantasy")) {
            code = "";
        }
        model.addAttribute("role4", role4);
        model.addAttribute("is_admin", is_admin);
        int total = handleService.gainTableMAllListTotalQuery(code, "", "");

        List<TableM> tableMList = handleService.gainTableMAllListQuery(code, "", "", page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);

//        for(int i=0;i<tableMList.size();i++){
//            tableMList.get(i).setTableMList(handleService.gainTableMList(tableMList.get(i).getCodeAuto(),tableMList.get(i).getRemark()));
//        }

        model.addAttribute("tableMList", tableMList);
        model.addAttribute("page", page);
        model.addAttribute("total", total);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        model.addAttribute("query", "query");
        model.addAttribute("code", code);
        return "handle_pay";
    }


    @RequestMapping(value = "/handle_pay_detail/{codeAuto}/{remark}/{userId}/{contractId}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String handlePayDetail(Model model, HttpServletRequest request, @PathVariable("codeAuto") String codeAuto, @PathVariable("remark") String remark, @PathVariable("userId") int userId, @PathVariable("contractId") int contractId) {
        String flag1 = "@@";
        String flag2 = "=";
        String role4 = baseService.getRole(userId, "role4");
        String is_admin = CommUtil.showIsAdminCookie(request);
        if ("fantasy".equals(remark)) {
            remark = "";
        }

        model.addAttribute("role4", role4);
        model.addAttribute("is_admin", is_admin);
        int total = handleService.gainTableMAllListTotal("", "");

        List<TableM> tableMList = handleService.gainTableMList(contractId, codeAuto, remark);

//        for(int i=0;i<tableMList.size();i++){
//            tableMList.get(i).setTableMList(handleService.gainTableMList(tableMList.get(i).getCodeAuto(),tableMList.get(i).getRemark()));
//        }

        model.addAttribute("tableMList", tableMList);
        model.addAttribute("codeAuto", codeAuto);
        model.addAttribute("remark", remark);


        return "handle_pay_detail";
    }

    @RequestMapping(value = "/scan", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String scan(Model model, HttpServletRequest request) {


        return "scan";
    }

    @RequestMapping(value = "/handle_finish/{userId}/{page}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String handleFinish(Model model, HttpServletRequest request, @PathVariable("userId") int userId, @PathVariable("page") int page) {
        String flag1 = "@@";
        String flag2 = "=";
        String role4 = baseService.getRole(userId, "role4");
        String is_admin = CommUtil.showIsAdminCookie(request);

        model.addAttribute("role4", role4);
        model.addAttribute("is_admin", is_admin);

        List<Contract> contractList = handleService.gainContractFinishList(page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = handleService.gainContractFinishListTotal();
        for (int i = 0; i < contractList.size(); i++) {

            //获取支付日期
            String table = contractList.get(i).getTable1();
            String[] tables = table.split(flag2, -1);
            int size = tables[0].split(flag1, -1).length;

            for (int j = 0; j < size; j++) {
                try {
                    String date = tables[2].split(flag1, size)[j];
                    if (!"".equals(date)) {
                        contractList.get(i).setPayDate(date);
                        break;
                    }
                } catch (Exception e) {
                }
            }


            //获取所有支付的金额
            double payTotal = 0;
            List<Contract> temp = new ArrayList<Contract>();
            temp.add(contractList.get(i));
            List<Contract> innerContractList = temp;
            for (int j = 0; j < innerContractList.size(); j++) {
                //2 2H 6   5   11 2H 1  1     1   1
//                if ("house".equals(innerContractList.get(j).getStyle())) {
//
//                    table = innerContractList.get(j).getTable2();
//                    tables = table.split(flag2, -1);
//                    size = tables[0].split(flag1, -1).length;
//                    for (int m = 0; m < size; m++) {
//                        if (!"".equals(tables[6].split(flag1, size)[m])) {
//                            payTotal += Double.parseDouble(tables[6].split(flag1, size)[m]);
//                        }
//                    }
//
//                    table = innerContractList.get(j).getTable2H();
//                    tables = table.split(flag2, -1);
//                    size = tables[0].split(flag1, -1).length;
//                    for (int m = 0; m < size; m++) {
//                        if (!"".equals(tables[5].split(flag1, size)[m])) {
//                            payTotal += Double.parseDouble(tables[5].split(flag1, size)[m]);
//                        }
//                    }
//
//                } else if ("ad".equals(innerContractList.get(j).getStyle())) {
//                    table = innerContractList.get(j).getTable11();
//                    tables = table.split(flag2, -1);
//                    size = tables[0].split(flag1, -1).length;
//                    for (int m = 0; m < size; m++) {
//                        if (!"".equals(tables[2].split(flag1, size)[m])) {
//                            payTotal += Double.parseDouble(tables[2].split(flag1, size)[m]);
//                        }
//                    }
//
//                    table = innerContractList.get(j).getTable2H();
//                    tables = table.split(flag2, -1);
//                    size = tables[0].split(flag1, -1).length;
//                    for (int m = 0; m < size; m++) {
//                        if (!"".equals(tables[1].split(flag1, size)[m])) {
//                            payTotal += Double.parseDouble(tables[1].split(flag1, size)[m]);
//                        }
//                    }
//                } else if ("car".equals(innerContractList.get(j).getStyle())) {
//                    table = innerContractList.get(j).getTable11();
//                    tables = table.split(flag2, -1);
//                    size = tables[0].split(flag1, -1).length;
//                    for (int m = 0; m < size; m++) {
//                        if (!"".equals(tables[2].split(flag1, size)[m])) {
//                            payTotal += Double.parseDouble(tables[2].split(flag1, size)[m]);
//                        }
//                    }
//
//                    table = innerContractList.get(j).getTable2H();
//                    tables = table.split(flag2, -1);
//                    size = tables[0].split(flag1, -1).length;
//                    for (int m = 0; m < size; m++) {
//                        if (!"".equals(tables[1].split(flag1, size)[m])) {
//                            payTotal += Double.parseDouble(tables[1].split(flag1, size)[m]);
//                        }
//                    }
//                }
                payTotal = NumberToCN.parseDouble(innerContractList.get(j).getTotal());
                contractList.get(i).setPayTotal(payTotal);
            }
        }


        model.addAttribute("contractList", contractList);
        model.addAttribute("page", page);
        model.addAttribute("total", total);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        return "handle_finish";
    }

    @RequestMapping(value = "/handle_finish/{userId}/{page}/{code}/{startDate}/{endDate}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String handleFinishQuery(Model model, HttpServletRequest request, @PathVariable("userId") int userId, @PathVariable("page") int page, @PathVariable("code") String code,
                                    @PathVariable("startDate") String startDate, @PathVariable("endDate") String endDate) {
        String flag1 = "@@";
        String flag2 = "=";
        String role4 = baseService.getRole(userId, "role4");
        String is_admin = CommUtil.showIsAdminCookie(request);

        model.addAttribute("role4", role4);
        model.addAttribute("is_admin", is_admin);
        String fantasy = "fantasy";
        if (code.equals(fantasy)) {
            code = "";
        }
        if (startDate.equals(fantasy)) {
            startDate = "";
        }
        if (endDate.equals(fantasy)) {
            endDate = "";
        }

        List<Contract> contractList = handleService.gainContractFinishListQuery(code, startDate, endDate, page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = handleService.gainContractFinishListTotalQuery(code, startDate, endDate);
        int customId = 0;
        for (int i = 0; i < contractList.size(); i++) {
            customId = contractList.get(i).getCustomId();
            //获取支付日期
            String table = contractList.get(i).getTable1();
            String[] tables = table.split(flag2, -1);
            int size = tables[0].split(flag1, -1).length;

            for (int j = 0; j < size; j++) {
                try {
                    String date = tables[2].split(flag1, size)[j];
                    if (!"".equals(date)) {
                        contractList.get(i).setPayDate(date);
                        break;
                    }
                } catch (Exception e) {
                }
            }


            //获取所有支付的金额
            double payTotal = 0;
            List<Contract> temp = new ArrayList<Contract>();
            temp.add(contractList.get(i));
            List<Contract> innerContractList = temp;
            for (int j = 0; j < innerContractList.size(); j++) {
                //2 2H 6   5   11 2H 1  1     1   1
                if ("house".equals(innerContractList.get(j).getStyle())) {
                    table = innerContractList.get(j).getTable2();
                    tables = table.split(flag2, -1);
                    size = tables[0].split(flag1, -1).length;
                    for (int m = 0; m < size; m++) {
                        if (!"".equals(tables[6].split(flag1, size)[m])) {
                            payTotal += Double.parseDouble(tables[6].split(flag1, size)[m]);
                        }
                    }

                    table = innerContractList.get(j).getTable2H();
                    tables = table.split(flag2, -1);
                    size = tables[0].split(flag1, -1).length;
                    for (int m = 0; m < size; m++) {
                        if (!"".equals(tables[5].split(flag1, size)[m])) {
                            payTotal += Double.parseDouble(tables[5].split(flag1, size)[m]);
                        }
                    }

                } else if ("ad".equals(innerContractList.get(j).getStyle())) {
                    table = innerContractList.get(j).getTable11();
                    tables = table.split(flag2, -1);
                    size = tables[0].split(flag1, -1).length;
                    for (int m = 0; m < size; m++) {
                        if (!"".equals(tables[2].split(flag1, size)[m])) {
                            payTotal += Double.parseDouble(tables[2].split(flag1, size)[m]);
                        }
                    }

                    table = innerContractList.get(j).getTable2H();
                    tables = table.split(flag2, -1);
                    size = tables[0].split(flag1, -1).length;
                    for (int m = 0; m < size; m++) {
                        if (!"".equals(tables[1].split(flag1, size)[m])) {
                            payTotal += Double.parseDouble(tables[1].split(flag1, size)[m]);
                        }
                    }
                } else if ("car".equals(innerContractList.get(j).getStyle())) {
                    table = innerContractList.get(j).getTable11();
                    tables = table.split(flag2, -1);
                    size = tables[0].split(flag1, -1).length;
                    for (int m = 0; m < size; m++) {
                        if (!"".equals(tables[2].split(flag1, size)[m])) {
                            payTotal += Double.parseDouble(tables[2].split(flag1, size)[m]);
                        }
                    }

                    table = innerContractList.get(j).getTable2H();
                    tables = table.split(flag2, -1);
                    size = tables[0].split(flag1, -1).length;
                    for (int m = 0; m < size; m++) {
                        if (!"".equals(tables[1].split(flag1, size)[m])) {
                            payTotal += Double.parseDouble(tables[1].split(flag1, size)[m]);
                        }
                    }
                }
                List<ContractFree> contractFreeList = handleService.gainContractFreeList(customId);
                for (ContractFree contractFree : contractFreeList) {
                    payTotal += contractFree.getMoney();
                }
                payTotal = NumberToCN.parseDouble(payTotal);
                contractList.get(i).setPayTotal(payTotal);
            }
        }


        model.addAttribute("contractList", contractList);
        model.addAttribute("page", page);
        model.addAttribute("total", total);
        model.addAttribute("query", "query");
        model.addAttribute("code", code);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        return "handle_finish";
    }

    @RequestMapping(value = "/handle_receivable_pay/{userId}/{page}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String handleReceivablePay(Model model, HttpServletRequest request, @PathVariable("userId") int userId, @PathVariable("page") int page) {
        String flag1 = "@@";
        String flag2 = "=";
        String role4 = baseService.getRole(userId, "role4");
        String is_admin = CommUtil.showIsAdminCookie(request);

        model.addAttribute("role4", role4);
        model.addAttribute("is_admin", is_admin);

        List<Contract> contractList = handleService.gainContractPayList(page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = handleService.gainContractPayListTotal();
        double payTotal = 0;
        for (int i = 0; i < contractList.size(); i++) {
            double t = Double.parseDouble(contractList.get(i).getPayIn());// - Double.parseDouble(contractList.get(i).getPayIn());
            payTotal += t;
        }
        model.addAttribute("contractList", contractList);
        model.addAttribute("page", page);
        model.addAttribute("total", total);
        payTotal = NumberToCN.parseDouble(payTotal);
        model.addAttribute("payTotal", payTotal);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        return "handle_receivable_pay";
    }

    @RequestMapping(value = "/handle_receivable_pay/{userId}/{page}/{code}/{startDate}/{endDate}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String handleReceivablePayQuery(Model model, HttpServletRequest request, @PathVariable("userId") int userId, @PathVariable("page") int page,
                                           @PathVariable("code") String code, @PathVariable("startDate") String startDate,
                                           @PathVariable("endDate") String endDate) {
        String flag1 = "@@";
        String flag2 = "=";
        String role4 = baseService.getRole(userId, "role4");
        String is_admin = CommUtil.showIsAdminCookie(request);
        String fantasy = "fantasy";
        if (code.equals(fantasy)) {
            code = "";
        }
        if (startDate.equals(fantasy)) {
            startDate = "";
        }
        if (endDate.equals(fantasy)) {
            endDate = "";
        }

        model.addAttribute("role4", role4);
        model.addAttribute("is_admin", is_admin);

        List<Contract> contractList = handleService.gainContractPayListQuery(code, startDate, endDate, page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = handleService.gainContractPayListTotalQuery(code, startDate, endDate);
        double payTotal = 0;
        for (int i = 0; i < contractList.size(); i++) {
            double t = Double.parseDouble(contractList.get(i).getPayOut());// - Double.parseDouble(contractList.get(i).getPayIn());
            payTotal += t;
        }
        model.addAttribute("contractList", contractList);
        model.addAttribute("page", page);
        model.addAttribute("total", total);
        payTotal = NumberToCN.parseDouble(payTotal);
        model.addAttribute("payTotal", payTotal);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        model.addAttribute("code", code);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        model.addAttribute("query", "query");
        return "handle_receivable_pay";
    }


    @RequestMapping(value = "/handle_receivable_detail_after/{codeAuto}/{remark}/{userId}/{customId}/{contractId}/update", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String handleReceivableDetailAfter(Model model, HttpServletRequest request, @PathVariable("codeAuto") String codeAuto, @PathVariable("remark") String remark, @PathVariable("userId") int userId, @PathVariable("customId") int customId, @PathVariable("contractId") int contractId) {
        String flag1 = "@@";
        String flag2 = "=";
        String table;
        String[] tables;
        if ("fantasy".equals(remark)) {
            remark = "";
        }
        int size;
        double payTotal = 0;
        String date = "";
        String loc = "";
        double allTotal = 0;
        double debt = 0;
        List<TableM> tableMList = new ArrayList<TableM>();
        List<Contract> contractList = handleService.gainContractByCustomId(customId);

        String tableU = handleService.gainTableMId(contractList.size() > 0 ? contractList.get(0).getId() : 0);
        if (tableU != null) {
            String[] tableUList = tableU.split(flag1);
            model.addAttribute("tableUList", tableUList);

        } else {
            model.addAttribute("tableUList", new ArrayList<String>());
        }

        for (int i = 0; i < contractList.size(); i++) {


            if (i == 0) {
                tableMList = handleService.gainTableMList(customId, contractList.get(i).getCodeAuto(), contractList.get(i).getRemark());
                //tableU = handleService.updateTableM()
            }

            if (contractId != contractList.get(i).getId()) {
                continue;
            }

            String style = contractList.get(i).getStyle();
            debt = contractList.get(i).getDebt();
            if ("house".equals(style)) {

                Contract contract = contractList.get(i);
                house(contract);

                double waterPrice = 0;
                double powerPirce = 0;
                double airPrice = 0;
                double freePrice = 0;

                for (int m = 0; m < contract.getTableList3().size(); m++) {
                    Table t = contract.getTableList3().get(m);
                    if (t.getTable0().contains("物业")) {
                        model.addAttribute("free", t.getTable1());
                        freePrice = Double.parseDouble(t.getTable1());

                    }
                    if (t.getTable0().contains("水")) {
                        model.addAttribute("water", t.getTable1());
                        freePrice = Double.parseDouble(t.getTable1());

                    }
                    if (t.getTable0().contains("电")) {
                        model.addAttribute("power", t.getTable1());
                        freePrice = Double.parseDouble(t.getTable1());

                    }
                    if (t.getTable0().contains("空调")) {
                        model.addAttribute("air", t.getTable1());
                        freePrice = Double.parseDouble(t.getTable1());

                    }
                }


                String buildArea = "";
                String price = "";
                List<AdTemp> adTempList = new ArrayList<AdTemp>();

                //折扣房租,保证金,物业费    房间的单价   水电费
                // tableList11 table2 table3(建筑面积)  tableList22 table3  tableList77 table3   tableList1 table6  tableList3 table0 table1
                double totalBuild = 0;
                long day = 0;
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                try {
                    day = ((sdf.parse(contract.getEndDate()).getTime() - sdf.parse(contract.getStartDate()).getTime()) / (1000 * 60 * 60 * 24)) + 1;
                } catch (ParseException e) {
                    e.printStackTrace();
                }

                //租金
                for (int m = 0; m < contract.getTableList11().size(); m++) {
                    Table t = contract.getTableList11().get(m);
                    price = contract.getTableList1().get(m).getTable6();
                    totalBuild += Double.parseDouble(t.getTable0());
                    buildArea = t.getTable0();
                    loc = contract.getTableList1().get(m).getTable1();


                    try {
                        payTotal = Double.parseDouble(t.getTable3());
                        payTotal = NumberToCN.parseDouble(payTotal);
                        allTotal += payTotal;

                    } catch (Exception e) {

                    }
                    adTempList.add(new AdTemp("房源-租金", payTotal, loc, date, price, buildArea, day));

                }

                //保证金
                for (int m = 0; m < contract.getTableList22().size(); m++) {
                    Table t = contract.getTableList22().get(m);

                    loc = t.getTable1();

                    double discount = 0;
                    try {
                        discount = Double.parseDouble(t.getTable3());
                    } catch (Exception e) {

                    }

                    try {
                        payTotal = Double.parseDouble(t.getTable2()) - Double.parseDouble(t.getTable2()) * discount / 100;
                        payTotal = NumberToCN.parseDouble(payTotal);
                        allTotal += payTotal;

                    } catch (Exception e) {

                    }
                    adTempList.add(new AdTemp("房源-物业保证金", payTotal, loc, date, "", "", day));
                }

                //折扣房租,保证金,物业费    房间的单价   水电费
                // tableList11 table2 table3(建筑面积)  tableList22 table3  tableList77 table3   tableList1 table6  tableList3 table0 table1

                //物业费
                for (int m = 0; m < contract.getTableList77().size(); m++) {
                    Table t = contract.getTableList77().get(m);


                    try {
                        payTotal = Double.parseDouble(t.getTable4());
                        payTotal = NumberToCN.parseDouble(payTotal);
                        allTotal += payTotal;

                    } catch (Exception e) {

                    }
                    adTempList.add(new AdTemp("房源-物业费", payTotal, "", "", freePrice + "", totalBuild + "", day));

                }


//        for (int m = 0; m < size; m++) {
//            if (!"".equals(tables[6].split(flag1, size)[m])) {
//                payTotal = Double.parseDouble(tables[6].split(flag1, size)[m]);
//
//                if ("租金".equals(tables[1].split(flag1, size)[m])) {
//
//                } else if ("物业保证金".equals(tables[1].split(flag1, size)[m])) {
//
//                } else {
//                    allTotal += payTotal;
//                    allTotalAll += payTotal;
//                }
//
//
//            }
//        }


                table = contract.getTable2H();
                tables = table.split(flag2, -1);
                size = tables[0].split(flag1, -1).length;
                payTotal = 0;
                //List<AdTemp> adTempList = new ArrayList<AdTemp>();
                for (int m = 0; m < size; m++) {
                    if (!"".equals(tables[0].split(flag1, size)[m]) && !"".equals(tables[5].split(flag1, size)[m])) {

                        payTotal = Double.parseDouble(tables[5].split(flag1, size)[m]);
                        allTotal += payTotal;


                        adTempList.add(new AdTemp("房源-" + tables[0].split(flag1, size)[m], payTotal, "", "", "", "", day));
                    }
                }


                //house(contractList.get(i));

                //物业水电费
                if (contract.getIsWater() == 1 || contract.getIsPower() == 1 || contract.getIsAir() == 1) {


                    if (contract.getIsWater() == 1) {
                        List<Table> tableList44 = contract.getTableList44();
                        for (int m = 0; m < tableList44.size(); m++) {
                            Table t = tableList44.get(m);

                            FreeExport freeExport = new FreeExport();
                            List<FreeExport> freeExportList = contractService.gainMaxDegree(t.getTable2(), "water");
                            if (freeExportList.size() == 1) {
                                freeExport = freeExportList.get(0);
                                adTempList.add(new AdTemp("水费", 0, "", ""));
                            } else if (freeExportList.size() == 2) {
                                try {
                                    double useDegree = Double.parseDouble(freeExportList.get(0).getDegree()) - Double.parseDouble(freeExportList.get(1).getDegree());
                                    double total = useDegree * waterPrice;
                                    freeExport.setTotal(total);
                                    freeExport.setUseDegree(useDegree + "");
                                    adTempList.add(new AdTemp("水费", total, "", ""));
                                } catch (Exception e) {
                                    adTempList.add(new AdTemp("水费", 0, "", ""));
                                }
                            }


                            freeExport.setName("水费");
                            freeExport.setPrice(waterPrice + "");

                            contract.getTableList44().get(m).setFreeExport(freeExport);

                        }
                    }
                    if (contract.getIsPower() == 1) {
                        List<Table> tableList55 = contract.getTableList55();
                        for (int m = 0; m < tableList55.size(); m++) {
                            Table t = tableList55.get(m);

                            FreeExport freeExport = new FreeExport();
                            List<FreeExport> freeExportList = contractService.gainMaxDegree(t.getTable2(), "power");
                            if (freeExportList.size() == 1) {
                                freeExport = freeExportList.get(0);
                                adTempList.add(new AdTemp("电费", 0, "", ""));
                            } else if (freeExportList.size() == 2) {
                                try {
                                    double useDegree = Double.parseDouble(freeExportList.get(0).getDegree()) - Double.parseDouble(freeExportList.get(1).getDegree());
                                    double total = useDegree * waterPrice;
                                    freeExport.setTotal(total);
                                    freeExport.setUseDegree(useDegree + "");
                                    adTempList.add(new AdTemp("电费", total, "", ""));
                                } catch (Exception e) {
                                    adTempList.add(new AdTemp("电费", 0, "", ""));
                                }
                            }

                            freeExport.setName("电费");
                            freeExport.setPrice(powerPirce + "");
                            contract.getTableList55().get(m).setFreeExport(freeExport);
                        }
                    }
                    if (contract.getIsAir() == 1) {
                        List<Table> tableList66 = contract.getTableList66();
                        for (int m = 0; m < tableList66.size(); m++) {
                            Table t = tableList66.get(m);
                            FreeExport freeExport = new FreeExport();
                            List<FreeExport> freeExportList = contractService.gainMaxDegree(t.getTable2(), "air");
                            if (freeExportList.size() == 1) {
                                freeExport = freeExportList.get(0);
                                adTempList.add(new AdTemp("空调费", 0, "", ""));
                            } else if (freeExportList.size() == 2) {
                                try {
                                    double useDegree = Double.parseDouble(freeExportList.get(0).getDegree()) - Double.parseDouble(freeExportList.get(1).getDegree());
                                    double total = useDegree * waterPrice;
                                    freeExport.setTotal(total);
                                    freeExport.setUseDegree(useDegree + "");
                                    adTempList.add(new AdTemp("空调费", total, "", ""));
                                } catch (Exception e) {
                                    adTempList.add(new AdTemp("空调费", 0, "", ""));
                                }
                            }
                            freeExport.setName("空调费");
                            freeExport.setPrice(airPrice + "");
                            contract.getTableList66().get(m).setFreeExport(freeExport);
                        }
                    }


                }

                contractList.get(i).setAdTempList(adTempList);
            } else if ("ad".equals(style)) {

                table = contractList.get(i).getTable11();
                tables = table.split(flag2, -1);
                size = tables[0].split(flag1, -1).length;
                payTotal = 0;
                List<AdTemp> adTempList = new ArrayList<AdTemp>();
                for (int m = 0; m < size; m++) {
                    if (!"".equals(tables[2].split(flag1, size)[m])) {
                        payTotal = Double.parseDouble(tables[2].split(flag1, size)[m]);
                        allTotal += payTotal;
                        try {
                            String dates[] = contractList.get(i).getTable1().split(flag2, -1);
                            loc = dates[1].split(flag1, size)[m % 2];
                            date = dates[2].split(flag1, size)[m % 2];
                        } catch (Exception e) {

                        }
                        adTempList.add(new AdTemp("广告-租金", payTotal, loc, date));
                    }
                }


                table = contractList.get(i).getTable2H();
                tables = table.split(flag2, -1);
                size = tables[0].split(flag1, -1).length;
                payTotal = 0;

                for (int m = 0; m < size; m++) {
                    if (!"".equals(tables[1].split(flag1, size)[m])) {

                        payTotal = Double.parseDouble(tables[1].split(flag1, size)[m]);
                        allTotal += payTotal;
                        adTempList.add(new AdTemp("广告-" + tables[0].split(flag1, size)[m], payTotal, "", ""));
                    }
                }

                //终止合同带来的
                if (contractList.get(i).getIsPay() == 1 && contractList.get(i).getIsFree() == 0) {
                    try {
                        adTempList.add(new AdTemp("广告-违约金", Double.parseDouble(contractList.get(i).getPayOut()), "", ""));
                        allTotal += Double.parseDouble(contractList.get(i).getPayOut());
                    } catch (Exception e) {

                    }

                }

                contractList.get(i).setAdTempList(adTempList);


                ad(contractList.get(i));

            } else if ("car".equals(style)) {

                table = contractList.get(i).getTable11();
                tables = table.split(flag2, -1);
                size = tables[0].split(flag1, -1).length;
                payTotal = 0;
                List<AdTemp> adTempList = new ArrayList<AdTemp>();
                for (int m = 0; m < size; m++) {
                    if (!"".equals(tables[2].split(flag1, size)[m])) {
                        payTotal = Double.parseDouble(tables[2].split(flag1, size)[m]);
                        allTotal += payTotal;
                        try {
                            String dates[] = contractList.get(i).getTable1().split(flag2, -1);
                            loc = dates[1].split(flag1, size)[m % 2];
                            date = dates[2].split(flag1, size)[m % 2];
                        } catch (Exception e) {

                        }
                        adTempList.add(new AdTemp("车位-租金", payTotal, loc, date));
                    }
                }


                table = contractList.get(i).getTable2H();
                tables = table.split(flag2, -1);
                size = tables[0].split(flag1, -1).length;
                payTotal = 0;

                for (int m = 0; m < size; m++) {
                    if (!"".equals(tables[1].split(flag1, size)[m])) {

                        payTotal = Double.parseDouble(tables[1].split(flag1, size)[m]);
                        allTotal += payTotal;
                        adTempList.add(new AdTemp("车位-" + tables[0].split(flag1, size)[m], payTotal, "", ""));
                    }
                }
                //终止合同带来的
                if (contractList.get(i).getIsPay() == 1 && contractList.get(i).getIsFree() == 0) {
                    try {
                        adTempList.add(new AdTemp("车位-违约金", Double.parseDouble(contractList.get(i).getPayOut()), "", ""));
                        allTotal += Double.parseDouble(contractList.get(i).getPayOut());
                    } catch (Exception e) {

                    }

                }

                contractList.get(i).setAdTempList(adTempList);

                car(contractList.get(i));
            }
        }
        List<ContractFree> contractFreeList = handleService.gainContractFreeList(customId);


        model.addAttribute("contractList", contractList);
        allTotal = NumberToCN.parseDouble(allTotal);
        model.addAttribute("allTotal", allTotal);
        model.addAttribute("codeAuto", codeAuto);
        model.addAttribute("remark", remark);
        model.addAttribute("debt", debt);
        model.addAttribute("tableMList", tableMList);
        model.addAttribute("tableU", tableU);
        model.addAttribute("customId", customId);
        model.addAttribute("contractFreeList", contractFreeList);

        return "handle_receivable_detail_after";
    }

    @RequestMapping(value = "/handle_receivable/{userId}/{page}/{code}/{startDate}/{endDate}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String handleReceivableQuery(Model model, HttpServletRequest request, @PathVariable("userId") int userId, @PathVariable("page") int page, @PathVariable("code") String code, @PathVariable("startDate") String startDate, @PathVariable("endDate") String endDate) {
        String flag1 = "@@";
        String flag2 = "=";
        String role4 = baseService.getRole(userId, "role4");
        String is_admin = CommUtil.showIsAdminCookie(request);

        model.addAttribute("role4", role4);
        model.addAttribute("is_admin", is_admin);
        String fantasy = "fantasy";
        if (code.equals(fantasy)) {
            code = "";
        }
        if (startDate.equals(fantasy)) {
            startDate = "";
        }
        if (endDate.equals(fantasy)) {
            endDate = "";
        }
        List<Contract> contractList = handleService.gainContractListQuery(code, startDate, endDate, page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = handleService.gainContractListTotalQuery(code, startDate, endDate);
        double payTableMinusTotal = 0;
        for (int i = 0; i < contractList.size(); i++) {

            //获取支付日期
            String table = contractList.get(i).getTable1();
            if (table == null) {
                table = "";
            }
            String[] tables = table.split(flag2, -1);
            int size = tables[0].split(flag1, -1).length;

            for (int j = 0; j < size; j++) {
                try {
                    String date = tables[2].split(flag1, size)[j];
                    if (!"".equals(date)) {
                        contractList.get(i).setPayDate(date);
                        break;
                    }
                } catch (Exception e) {
                }
            }


            //获取所有支付的金额
            double payTotal = 0;
            double waterTotal = 0;
            List<Contract> innerContractList = handleService.gainContractId(contractList.get(i).getCustomId());

            for (int j = 0; j < innerContractList.size(); j++) {
                //payTotal = 0;
                //2 2H 6   5   11 2H 1  1     1   1
//                if ("house".equals(innerContractList.get(j).getStyle())) {
//                    table = innerContractList.get(j).getTable2();
//                    tables = table.split(flag2, -1);
//                    size = tables[0].split(flag1, -1).length;
//                    for (int m = 0; m < size; m++) {
//                        if (!"".equals(tables[6].split(flag1, size)[m])) {
//                            payTotal += Double.parseDouble(tables[6].split(flag1, size)[m]);
//                        }
//                    }
//
//                    table = innerContractList.get(j).getTable2H();
//                    tables = table.split(flag2, -1);
//                    size = tables[0].split(flag1, -1).length;
//                    for (int m = 0; m < size; m++) {
//                        if (!"".equals(tables[5].split(flag1, size)[m])) {
//                            payTotal += Double.parseDouble(tables[5].split(flag1, size)[m]);
//                        }
//                    }
//
//                } else if ("ad".equals(innerContractList.get(j).getStyle())) {
//                    table = innerContractList.get(j).getTable11();
//                    tables = table.split(flag2, -1);
//                    size = tables[0].split(flag1, -1).length;
//                    for (int m = 0; m < size; m++) {
//                        if (!"".equals(tables[2].split(flag1, size)[m])) {
//                            payTotal += Double.parseDouble(tables[2].split(flag1, size)[m]);
//                        }
//                    }
//
//                    table = innerContractList.get(j).getTable2H();
//                    tables = table.split(flag2, -1);
//                    size = tables[0].split(flag1, -1).length;
//                    for (int m = 0; m < size; m++) {
//                        if (!"".equals(tables[1].split(flag1, size)[m])) {
//                            payTotal += Double.parseDouble(tables[1].split(flag1, size)[m]);
//                        }
//                    }
//                    //终止合同带来的
//                    if (contractList.get(i).getIsPay() == 1 && contractList.get(i).getIsFree() == 0) {
//                        try {
//
//                            payTotal += Double.parseDouble(contractList.get(i).getPayOut());
//                        } catch (Exception e) {
//
//                        }
//
//                    }
//                } else if ("car".equals(innerContractList.get(j).getStyle())) {
//                    table = innerContractList.get(j).getTable11();
//                    tables = table.split(flag2, -1);
//                    size = tables[0].split(flag1, -1).length;
//                    for (int m = 0; m < size; m++) {
//                        if (!"".equals(tables[2].split(flag1, size)[m])) {
//                            payTotal += Double.parseDouble(tables[2].split(flag1, size)[m]);
//                        }
//                    }
//
//                    table = innerContractList.get(j).getTable2H();
//                    tables = table.split(flag2, -1);
//                    size = tables[0].split(flag1, -1).length;
//                    for (int m = 0; m < size; m++) {
//                        if (!"".equals(tables[1].split(flag1, size)[m])) {
//                            payTotal += Double.parseDouble(tables[1].split(flag1, size)[m]);
//                        }
//                    }
//
//                    //终止合同带来的
//                    if (contractList.get(i).getIsPay() == 1 && contractList.get(i).getIsFree() == 0) {
//                        try {
//
//                            payTotal += Double.parseDouble(contractList.get(i).getPayOut());
//                        } catch (Exception e) {
//
//                        }
//
//                    }
//                }

                //物业水电费
                if (innerContractList.get(j).getIsWater() == 1 || innerContractList.get(j).getIsPower() == 1 || innerContractList.get(j).getIsAir() == 1) {

                    double waterPrice = 0;
                    double powerPirce = 0;
                    double airPrice = 0;
                    double freePrice = 0;

                    house(innerContractList.get(j));
                    for (int m = 0; m < innerContractList.get(j).getTableList3().size(); m++) {
                        Table t = innerContractList.get(j).getTableList3().get(m);
                        if (t.getTable0().contains("物业")) {
                            model.addAttribute("free", t.getTable1());
                            freePrice = Double.parseDouble(t.getTable1());

                        }
                        if (t.getTable0().contains("水")) {
                            model.addAttribute("water", t.getTable1());
                            waterPrice = Double.parseDouble(t.getTable1());

                        }
                        if (t.getTable0().contains("电")) {
                            model.addAttribute("power", t.getTable1());
                            powerPirce = Double.parseDouble(t.getTable1());

                        }
                        if (t.getTable0().contains("空调")) {
                            model.addAttribute("air", t.getTable1());
                            airPrice = Double.parseDouble(t.getTable1());

                        }
                    }

                    if (innerContractList.get(j).getIsWater() == 1) {
                        List<Table> tableList44 = innerContractList.get(j).getTableList44();
                        for (int m = 0; m < tableList44.size(); m++) {
                            Table t = tableList44.get(m);

                            FreeExport freeExport = new FreeExport();
                            List<FreeExport> freeExportList = contractService.gainMaxDegree(t.getTable2(), "water");
                            if (freeExportList.size() == 1) {
                                freeExport = freeExportList.get(0);
                                // adTempList.add(new AdTemp("水费", 0, "", ""));
                            } else if (freeExportList.size() == 2) {
                                try {
                                    double useDegree = Double.parseDouble(freeExportList.get(0).getDegree()) - Double.parseDouble(freeExportList.get(1).getDegree());
                                    double water = useDegree * waterPrice;
                                    waterTotal += water;
                                    freeExport.setTotal(total);
                                    freeExport.setUseDegree(useDegree + "");
                                    //adTempList.add(new AdTemp("水费", total, "", ""));
                                } catch (Exception e) {
                                    // adTempList.add(new AdTemp("水费", 0, "", ""));
                                }
                            }


                            freeExport.setName("水费");
                            freeExport.setPrice(waterPrice + "");

                            //contract.getTableList44().get(m).setFreeExport(freeExport);

                        }
                    }

                    if (innerContractList.get(j).getIsPower() == 1) {

                        List<Table> tableList55 = innerContractList.get(j).getTableList55();
                        for (int m = 0; m < tableList55.size(); m++) {
                            Table t = tableList55.get(m);

                            FreeExport freeExport = new FreeExport();
                            List<FreeExport> freeExportList = contractService.gainMaxDegree(t.getTable2(), "power");
                            if (freeExportList.size() == 1) {
                                freeExport = freeExportList.get(0);
                                //adTempList.add(new AdTemp("电费", 0, "", ""));
                            } else if (freeExportList.size() == 2) {
                                try {
                                    double useDegree = Double.parseDouble(freeExportList.get(0).getDegree()) - Double.parseDouble(freeExportList.get(1).getDegree());
                                    double water = useDegree * waterPrice;
                                    waterTotal += water;
                                    freeExport.setTotal(total);
                                    freeExport.setUseDegree(useDegree + "");
                                    // adTempList.add(new AdTemp("电费", total, "", ""));
                                } catch (Exception e) {
                                    //adTempList.add(new AdTemp("电费", 0, "", ""));
                                }
                            }

                            freeExport.setName("电费");
                            freeExport.setPrice(powerPirce + "");
                            //contract.getTableList55().get(m).setFreeExport(freeExport);
                        }
                    }
                    if (innerContractList.get(j).getIsAir() == 1) {
                        List<Table> tableList66 = innerContractList.get(j).getTableList66();
                        for (int m = 0; m < tableList66.size(); m++) {
                            Table t = tableList66.get(m);
                            FreeExport freeExport = new FreeExport();
                            List<FreeExport> freeExportList = contractService.gainMaxDegree(t.getTable2(), "air");
                            if (freeExportList.size() == 1) {
                                freeExport = freeExportList.get(0);
                                //adTempList.add(new AdTemp("空调费", 0, "", ""));
                            } else if (freeExportList.size() == 2) {
                                try {
                                    double useDegree = Double.parseDouble(freeExportList.get(0).getDegree()) - Double.parseDouble(freeExportList.get(1).getDegree());
                                    double water = useDegree * waterPrice;
                                    freeExport.setTotal(total);
                                    waterTotal += water;
                                    freeExport.setUseDegree(useDegree + "");
                                    //adTempList.add(new AdTemp("空调费", total, "", ""));
                                } catch (Exception e) {
                                    //adTempList.add(new AdTemp("空调费", 0, "", ""));
                                }
                            }
                            freeExport.setName("空调费");
                            freeExport.setPrice(airPrice + "");
                            //contract.getTableList66().get(m).setFreeExport(freeExport);
                        }
                    }

                }


                payTotal += innerContractList.get(j).getTotal();
                double payTableMinus = 0;


                double tableMTotal = 0;
                //获取应收 实收
                List<TableM> tableMList = handleService.gainTableMList(contractList.get(i).getCustomId(), "", "");
                for (int m = 0; m < tableMList.size(); m++) {
                    tableMTotal += Double.parseDouble(tableMList.get(m).getMoneyM());

                }
                payTableMinus = payTotal - tableMTotal + waterTotal;

                tableMTotal = NumberToCN.parseDouble(tableMTotal);
                payTotal = NumberToCN.parseDouble(payTotal);
                payTableMinus = NumberToCN.parseDouble(payTableMinus);

                contractList.get(i).setPayTableMMinus(payTableMinus);
                contractList.get(i).setTableMTotal(tableMTotal);
                contractList.get(i).setPayTotal(payTotal);
                //设置金额,加上水电费的

            }


            //////////////////// 打印部分


            String date = "";
            String loc = "";
            double debt;
            int customId = contractList.get(i).getCustomId();

            List<TableM> tableMList = new ArrayList<TableM>();
            List<Contract> contractListDetail = handleService.gainContractByCustomId(customId);

            String tableU = handleService.gainTableMId(contractListDetail.size() > 0 ? contractListDetail.get(0).getId() : 0);
            if (tableU != null) {
                String[] tableUList = tableU.split(flag1);
                model.addAttribute("tableUList", tableUList);

            } else {
                model.addAttribute("tableUList", new ArrayList<String>());
            }

            for (int d = 0; d < contractListDetail.size(); d++) {

                long dayTempTotal = 0;
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    dayTempTotal = ((sdf.parse(contractListDetail.get(d).getEndDate()).getTime() - sdf.parse(contractListDetail.get(d).getStartDate()).getTime()) / (1000 * 60 * 60 * 24)) + 1;
                    contractListDetail.get(d).setDay(dayTempTotal);
                } catch (ParseException e) {
                    e.printStackTrace();
                }
                if (d == 0) {
                    tableMList = handleService.gainTableMList(customId, contractListDetail.get(d).getCodeAuto(), contractListDetail.get(d).getRemark());

                }

                String style = contractListDetail.get(d).getStyle();
                debt = contractListDetail.get(d).getDebt();
                if ("house".equals(style)) {

                    Contract contract = contractListDetail.get(d);
                    house(contract);

                    double waterPrice = 0;
                    double powerPirce = 0;
                    double airPrice = 0;
                    double freePrice = 0;

                    for (int m = 0; m < contract.getTableList3().size(); m++) {
                        Table t = contract.getTableList3().get(m);
                        if (t.getTable0().contains("物业")) {
                            model.addAttribute("free", t.getTable1());
                            freePrice = Double.parseDouble(t.getTable1());

                        }
                        if (t.getTable0().contains("水")) {
                            model.addAttribute("water", t.getTable1());
                            waterPrice = Double.parseDouble(t.getTable1());

                        }
                        if (t.getTable0().contains("电")) {
                            model.addAttribute("power", t.getTable1());
                            powerPirce = Double.parseDouble(t.getTable1());

                        }
                        if (t.getTable0().contains("空调")) {
                            model.addAttribute("air", t.getTable1());
                            airPrice = Double.parseDouble(t.getTable1());

                        }
                    }


                    String buildArea = "";
                    String price = "";
                    List<AdTemp> adTempList = new ArrayList<AdTemp>();

                    //折扣房租,保证金,物业费    房间的单价   水电费
                    // tableList11 table2 table3(建筑面积)  tableList22 table3  tableList77 table3   tableList1 table6  tableList3 table0 table1
                    double totalBuild = 0;
                    long day = 0;
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    try {
                        day = ((sdf.parse(contract.getEndDate()).getTime() - sdf.parse(contract.getStartDate()).getTime()) / (1000 * 60 * 60 * 24)) + 1;
                    } catch (ParseException e) {
                        e.printStackTrace();
                    }

                    //租金
                    for (int m = 0; m < contract.getTableList11().size(); m++) {
                        Table t = contract.getTableList11().get(m);
                        price = contract.getTableList1().get(m).getTable6();
                        totalBuild += Double.parseDouble(t.getTable0());
                        buildArea = t.getTable0();
                        loc = contract.getTableList1().get(m).getTable1();


                        try {
                            payTotal = Double.parseDouble(t.getTable3());
                            payTotal = NumberToCN.parseDouble(payTotal);


                        } catch (Exception e) {

                        }
                        adTempList.add(new AdTemp("房源-租金", payTotal, loc, date, price, buildArea, day));

                    }

                    //保证金
                    for (int m = 0; m < contract.getTableList22().size(); m++) {
                        Table t = contract.getTableList22().get(m);

                        loc = t.getTable1();

                        double discount = 0;
                        try {
                            discount = Double.parseDouble(t.getTable3());
                        } catch (Exception e) {

                        }

                        try {
                            payTotal = Double.parseDouble(t.getTable2()) - Double.parseDouble(t.getTable2()) * discount / 100;
                            payTotal = NumberToCN.parseDouble(payTotal);


                        } catch (Exception e) {

                        }
                        adTempList.add(new AdTemp("房源-物业保证金", payTotal, loc, date, "", "", day));
                    }

                    //折扣房租,保证金,物业费    房间的单价   水电费
                    // tableList11 table2 table3(建筑面积)  tableList22 table3  tableList77 table3   tableList1 table6  tableList3 table0 table1

                    //物业费
                    for (int m = 0; m < contract.getTableList77().size(); m++) {
                        Table t = contract.getTableList77().get(m);


                        try {
                            payTotal = Double.parseDouble(t.getTable4());
                            payTotal = NumberToCN.parseDouble(payTotal);


                        } catch (Exception e) {

                        }
                        adTempList.add(new AdTemp("房源-物业费", payTotal, "", "", freePrice + "", totalBuild + "", day));
                        contractListDetail.get(d).getTableList77().get(m).setTable10(freePrice + "");
                    }


                    table = contract.getTable2H();
                    tables = table.split(flag2, -1);
                    size = tables[0].split(flag1, -1).length;
                    payTotal = 0;
                    //List<AdTemp> adTempList = new ArrayList<AdTemp>();
                    for (int m = 0; m < size; m++) {
                        if (!"".equals(tables[0].split(flag1, size)[m]) && !"".equals(tables[5].split(flag1, size)[m])) {

                            payTotal = Double.parseDouble(tables[5].split(flag1, size)[m]);


                            adTempList.add(new AdTemp("房源-" + tables[0].split(flag1, size)[m], payTotal, "", "", "", "", day));
                        }
                    }


                    //house(contractListDetail.get(i));

                    //物业水电费
                    if (contract.getIsWater() == 1 || contract.getIsPower() == 1 || contract.getIsAir() == 1) {


                        if (contract.getIsWater() == 1) {
                            List<Table> tableList44 = contract.getTableList44();
                            for (int m = 0; m < tableList44.size(); m++) {
                                Table t = tableList44.get(m);

                                FreeExport freeExport = new FreeExport();
                                List<FreeExport> freeExportList = contractService.gainMaxDegree(t.getTable2(), "water");
                                if (freeExportList.size() == 1) {
                                    freeExport = freeExportList.get(0);
                                    adTempList.add(new AdTemp("水费", 0, freeExport.getLoc(), freeExport.getDate(), "0", freeExport.getDegree(), waterPrice + "", freeExport.getNo(), 0));
                                } else if (freeExportList.size() == 2) {
                                    try {
                                        String lastDegree = freeExportList.get(1).getDegree();
                                        String degree = freeExportList.get(0).getDegree();

                                        double useDegree = Double.parseDouble(degree) - Double.parseDouble(lastDegree);
                                        double totalTemp = useDegree * waterPrice;

                                        freeExport.setTotal(totalTemp);
                                        freeExport.setUseDegree(useDegree + "");
                                        adTempList.add(new AdTemp("水费", totalTemp, freeExportList.get(0).getLoc(), freeExportList.get(0).getDate(), lastDegree, degree, waterPrice + "", freeExportList.get(0).getNo(), useDegree));
                                    } catch (Exception e) {
                                        adTempList.add(new AdTemp("水费", 0, freeExportList.get(0).getLoc(), freeExportList.get(0).getDate(), "0", freeExportList.get(0).getDegree(), waterPrice + "", freeExportList.get(0).getNo(), 0));
                                    }
                                }


                                freeExport.setName("水费");
                                freeExport.setPrice(waterPrice + "");

                                contract.getTableList44().get(m).setFreeExport(freeExport);

                            }
                        }

                        if (contract.getIsPower() == 1) {
                            List<Table> tableList55 = contract.getTableList55();
                            for (int m = 0; m < tableList55.size(); m++) {
                                Table t = tableList55.get(m);

                                FreeExport freeExport = new FreeExport();
                                List<FreeExport> freeExportList = contractService.gainMaxDegree(t.getTable2(), "power");
                                if (freeExportList.size() == 1) {
                                    freeExport = freeExportList.get(0);
                                    adTempList.add(new AdTemp("电费", 0, freeExport.getLoc(), freeExport.getDate(), "0", freeExport.getDegree(), powerPirce + "", freeExport.getNo(), 0));
                                } else if (freeExportList.size() == 2) {
                                    try {
                                        String lastDegree = freeExportList.get(1).getDegree();
                                        String degree = freeExportList.get(0).getDegree();
                                        double useDegree = Double.parseDouble(degree) - Double.parseDouble(lastDegree);
                                        double totalTemp = useDegree * waterPrice;
                                        freeExport.setTotal(totalTemp);

                                        freeExport.setUseDegree(useDegree + "");
                                        adTempList.add(new AdTemp("电费", totalTemp, freeExportList.get(0).getLoc(), freeExportList.get(0).getDate(), lastDegree, degree, powerPirce + "", freeExportList.get(0).getNo(), useDegree));
                                    } catch (Exception e) {
                                        adTempList.add(new AdTemp("电费", 0, freeExportList.get(0).getLoc(), freeExportList.get(0).getDate(), "0", freeExportList.get(0).getDegree(), powerPirce + "", freeExportList.get(0).getNo(), 0));
                                    }
                                }

                                freeExport.setName("电费");
                                freeExport.setPrice(powerPirce + "");
                                contract.getTableList55().get(m).setFreeExport(freeExport);
                            }
                        }
                        if (contract.getIsAir() == 1) {
                            List<Table> tableList66 = contract.getTableList66();
                            for (int m = 0; m < tableList66.size(); m++) {
                                Table t = tableList66.get(m);
                                FreeExport freeExport = new FreeExport();
                                List<FreeExport> freeExportList = contractService.gainMaxDegree(t.getTable2(), "air");
                                if (freeExportList.size() == 1) {
                                    freeExport = freeExportList.get(0);
                                    adTempList.add(new AdTemp("空调费", 0, freeExport.getLoc(), freeExport.getDate(), "0", freeExport.getDegree(), airPrice + "", freeExport.getNo(), 0));
                                } else if (freeExportList.size() == 2) {
                                    try {
                                        String lastDegree = freeExportList.get(1).getDegree();
                                        String degree = freeExportList.get(0).getDegree();
                                        double useDegree = Double.parseDouble(degree) - Double.parseDouble(lastDegree);
                                        double totalTemp = useDegree * waterPrice;

                                        freeExport.setTotal(totalTemp);
                                        freeExport.setUseDegree(useDegree + "");
                                        adTempList.add(new AdTemp("空调费", totalTemp, freeExportList.get(0).getLoc(), freeExportList.get(0).getDate(), lastDegree, degree, airPrice + "", freeExportList.get(0).getNo(), useDegree));
                                    } catch (Exception e) {
                                        adTempList.add(new AdTemp("空调费", 0, freeExportList.get(0).getLoc(), freeExportList.get(0).getDate(), "0", freeExportList.get(0).getDegree(), airPrice + "", freeExportList.get(0).getNo(), 0));
                                    }
                                }
                                freeExport.setName("空调费");
                                freeExport.setPrice(airPrice + "");
                                contract.getTableList66().get(m).setFreeExport(freeExport);
                            }
                        }


                        for (int ad = 0; ad < contractListDetail.size(); ad++) {
                            int listId = contractListDetail.get(ad).getId();
                            int pLoopIndex = ad;
                            for (int adDetail = adTempList.size() - 1; adDetail >= 0; adDetail--) {
                                int loopIndex = adDetail;
                                String adLoc = adTempList.get(adDetail).getLoc();
                                String adNo = listId + "" + pLoopIndex + "" + loopIndex + "" + adLoc + "fantasy";
                                if (tableU.contains(adNo)) {
                                    adTempList.remove(adDetail);
                                }
                            }
                        }

                        contractListDetail.get(d).setAdTempList(adTempList);
                    }


                } else if ("ad".equals(style)) {

                    table = contractListDetail.get(d).getTable11();
                    tables = table.split(flag2, -1);
                    size = tables[0].split(flag1, -1).length;
                    payTotal = 0;
                    List<AdTemp> adTempList = new ArrayList<AdTemp>();
                    for (int m = 0; m < size; m++) {
                        if (!"".equals(tables[2].split(flag1, size)[m])) {
                            payTotal = Double.parseDouble(tables[2].split(flag1, size)[m]);

                            try {
                                String dates[] = contractListDetail.get(i).getTable1().split(flag2, -1);
                                loc = dates[1].split(flag1, size)[m % 2];
                                date = dates[2].split(flag1, size)[m % 2];
                            } catch (Exception e) {

                            }
                            adTempList.add(new AdTemp("广告-租金", payTotal, loc, date));
                        }
                    }


                    table = contractListDetail.get(d).getTable2H();
                    tables = table.split(flag2, -1);
                    size = tables[0].split(flag1, -1).length;
                    payTotal = 0;

                    for (int m = 0; m < size; m++) {
                        if (!"".equals(tables[1].split(flag1, size)[m])) {

                            payTotal = Double.parseDouble(tables[1].split(flag1, size)[m]);

                            adTempList.add(new AdTemp("广告-" + tables[0].split(flag1, size)[m], payTotal, "", ""));
                        }
                    }

                    //终止合同带来的
                    if (contractListDetail.get(d).getIsPay() == 1 && contractListDetail.get(d).getIsFree() == 0) {
                        try {
                            adTempList.add(new AdTemp("广告-违约金", Double.parseDouble(contractListDetail.get(i).getPayOut()), "", ""));

                        } catch (Exception e) {

                        }

                    }

                    for (int ad = 0; ad < contractListDetail.size(); ad++) {

                        for (int adDetail = adTempList.size() - 1; adDetail >= 0; adDetail--) {
                            int listId = contractListDetail.get(ad).getId();
                            int pLoopIndex = ad;
                            int loopIndex = adDetail;
                            String adLoc = adTempList.get(adDetail).getLoc();
                            String adNo = listId + "" + pLoopIndex + "" + loopIndex + "" + adLoc + "fantasy";
                            logger.error("adListDetail:" + adNo + "," + listId + "," + pLoopIndex);
                            if (tableU.contains(adNo)) {
                                adTempList.remove(adDetail);
                            }
                        }
                    }

                    contractListDetail.get(d).setAdTempList(adTempList);


                    ad(contractListDetail.get(d));

                } else if ("car".equals(style)) {

                    table = contractListDetail.get(d).getTable11();
                    tables = table.split(flag2, -1);
                    size = tables[0].split(flag1, -1).length;
                    payTotal = 0;
                    List<AdTemp> adTempList = new ArrayList<AdTemp>();
                    for (int m = 0; m < size; m++) {
                        if (!"".equals(tables[2].split(flag1, size)[m])) {
                            payTotal = Double.parseDouble(tables[2].split(flag1, size)[m]);

                            try {
                                String dates[] = contractListDetail.get(i).getTable1().split(flag2, -1);
                                loc = dates[1].split(flag1, size)[m % 2];
                                date = dates[2].split(flag1, size)[m % 2];
                            } catch (Exception e) {

                            }
                            adTempList.add(new AdTemp("车位-租金", payTotal, loc, date));
                        }
                    }


                    table = contractListDetail.get(d).getTable2H();
                    tables = table.split(flag2, -1);
                    size = tables[0].split(flag1, -1).length;
                    payTotal = 0;

                    for (int m = 0; m < size; m++) {
                        if (!"".equals(tables[1].split(flag1, size)[m])) {

                            payTotal = Double.parseDouble(tables[1].split(flag1, size)[m]);

                            adTempList.add(new AdTemp("车位-" + tables[0].split(flag1, size)[m], payTotal, "", ""));
                        }
                    }
                    //终止合同带来的
                    if (contractListDetail.get(d).getIsPay() == 1 && contractListDetail.get(d).getIsFree() == 0) {
                        try {
                            adTempList.add(new AdTemp("车位-违约金", Double.parseDouble(contractListDetail.get(i).getPayOut()), "", ""));

                        } catch (Exception e) {

                        }

                    }

                    for (int ad = 0; ad < contractListDetail.size(); ad++) {
                        int listId = contractListDetail.get(ad).getId();
                        int pLoopIndex = ad;
                        for (int adDetail = adTempList.size() - 1; adDetail >= 0; adDetail--) {
                            int loopIndex = adDetail;
                            String adLoc = adTempList.get(adDetail).getLoc();
                            String adNo = listId + "" + pLoopIndex + "" + loopIndex + "" + adLoc + "fantasy";
                            if (tableU.contains(adNo)) {
                                adTempList.remove(adDetail);
                            }
                        }
                    }

                    contractListDetail.get(d).setAdTempList(adTempList);

                    car(contractListDetail.get(d));
                }
            }

            contractList.get(i).setContractDetailList(contractListDetail);
            contractList.get(i).setTableU(tableU);

            //////////////////// 打印部分
        }


        model.addAttribute("contractList", contractList);
        model.addAttribute("page", page);
        model.addAttribute("total", total);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        model.addAttribute("code", code);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        model.addAttribute("query", "query");
        model.addAttribute("payTableMinusTotal", NumberToCN.parseDouble(payTableMinusTotal));
        return "handle_receivable";
    }

    @RequestMapping(value = "/handle_receivable/{userId}/{page}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String handleReceivable(Model model, HttpServletRequest request, @PathVariable("userId") int userId, @PathVariable("page") int page) {
        String flag1 = "@@";
        String flag2 = "=";
        String role4 = baseService.getRole(userId, "role4");
        String is_admin = CommUtil.showIsAdminCookie(request);

        model.addAttribute("role4", role4);
        model.addAttribute("is_admin", is_admin);

        List<Contract> contractList = handleService.gainContractList(page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = handleService.gainContractListTotal();
        double payTableMinusTotal = 0;
        for (int i = 0; i < contractList.size(); i++) {

            //获取支付日期
            String table = contractList.get(i).getTable1();
            if (table == null) {
                table = "";
            }
            String[] tables = table.split(flag2, -1);
            int size = tables[0].split(flag1, -1).length;

            for (int j = 0; j < size; j++) {
                try {
                    String date = tables[2].split(flag1, size)[j];
                    if (!"".equals(date)) {
                        contractList.get(i).setPayDate(date);
                        break;
                    }
                } catch (Exception e) {
                }
            }


            //获取所有支付的金额
            double payTotal = 0;
            double waterTotal = 0;
            List<Contract> innerContractList = handleService.gainContractId(contractList.get(i).getCustomId());

            for (int j = 0; j < innerContractList.size(); j++) {


                //物业水电费
                if (innerContractList.get(j).getIsWater() == 1 || innerContractList.get(j).getIsPower() == 1 || innerContractList.get(j).getIsAir() == 1) {

                    double waterPrice = 0;
                    double powerPirce = 0;
                    double airPrice = 0;
                    double freePrice = 0;

                    house(innerContractList.get(j));
                    for (int m = 0; m < innerContractList.get(j).getTableList3().size(); m++) {
                        Table t = innerContractList.get(j).getTableList3().get(m);
                        if (t.getTable0().contains("物业")) {
                            model.addAttribute("free", t.getTable1());
                            freePrice = Double.parseDouble(t.getTable1());

                        }
                        if (t.getTable0().contains("水")) {
                            model.addAttribute("water", t.getTable1());
                            waterPrice = Double.parseDouble(t.getTable1());

                        }
                        if (t.getTable0().contains("电")) {
                            model.addAttribute("power", t.getTable1());
                            powerPirce = Double.parseDouble(t.getTable1());

                        }
                        if (t.getTable0().contains("空调")) {
                            model.addAttribute("air", t.getTable1());
                            airPrice = Double.parseDouble(t.getTable1());

                        }
                    }

                    if (innerContractList.get(j).getIsWater() == 1) {
                        List<Table> tableList44 = innerContractList.get(j).getTableList44();
                        for (int m = 0; m < tableList44.size(); m++) {
                            Table t = tableList44.get(m);

                            FreeExport freeExport = new FreeExport();
                            List<FreeExport> freeExportList = contractService.gainMaxDegree(t.getTable2(), "water");
                            if (freeExportList.size() == 1) {
                                freeExport = freeExportList.get(0);
                                // adTempList.add(new AdTemp("水费", 0, "", ""));
                            } else if (freeExportList.size() == 2) {
                                try {
                                    double useDegree = Double.parseDouble(freeExportList.get(0).getDegree()) - Double.parseDouble(freeExportList.get(1).getDegree());
                                    double water = useDegree * waterPrice;
                                    waterTotal += water;
                                    freeExport.setTotal(total);
                                    freeExport.setUseDegree(useDegree + "");
                                    //adTempList.add(new AdTemp("水费", total, "", ""));
                                } catch (Exception e) {
                                    // adTempList.add(new AdTemp("水费", 0, "", ""));
                                }
                            }


                            freeExport.setName("水费");
                            freeExport.setPrice(waterPrice + "");

                            //contract.getTableList44().get(m).setFreeExport(freeExport);

                        }
                    }

                    if (innerContractList.get(j).getIsPower() == 1) {
                        List<Table> tableList55 = innerContractList.get(j).getTableList55();
                        for (int m = 0; m < tableList55.size(); m++) {
                            Table t = tableList55.get(m);

                            FreeExport freeExport = new FreeExport();
                            List<FreeExport> freeExportList = contractService.gainMaxDegree(t.getTable2(), "power");
                            if (freeExportList.size() == 1) {
                                freeExport = freeExportList.get(0);
                                //adTempList.add(new AdTemp("电费", 0, "", ""));
                            } else if (freeExportList.size() == 2) {
                                try {
                                    double useDegree = Double.parseDouble(freeExportList.get(0).getDegree()) - Double.parseDouble(freeExportList.get(1).getDegree());
                                    double water = useDegree * waterPrice;
                                    waterTotal += water;
                                    freeExport.setTotal(total);
                                    freeExport.setUseDegree(useDegree + "");
                                    // adTempList.add(new AdTemp("电费", total, "", ""));
                                } catch (Exception e) {
                                    //adTempList.add(new AdTemp("电费", 0, "", ""));
                                }
                            }

                            freeExport.setName("电费");
                            freeExport.setPrice(powerPirce + "");
                            //contract.getTableList55().get(m).setFreeExport(freeExport);
                        }
                    }

                    if (innerContractList.get(j).getIsAir() == 1) {
                        List<Table> tableList66 = innerContractList.get(j).getTableList66();
                        for (int m = 0; m < tableList66.size(); m++) {
                            Table t = tableList66.get(m);
                            FreeExport freeExport = new FreeExport();
                            List<FreeExport> freeExportList = contractService.gainMaxDegree(t.getTable2(), "air");
                            if (freeExportList.size() == 1) {
                                freeExport = freeExportList.get(0);
                                //adTempList.add(new AdTemp("空调费", 0, "", ""));
                            } else if (freeExportList.size() == 2) {
                                try {
                                    double useDegree = Double.parseDouble(freeExportList.get(0).getDegree()) - Double.parseDouble(freeExportList.get(1).getDegree());
                                    double water = useDegree * waterPrice;
                                    freeExport.setTotal(total);
                                    waterTotal += water;
                                    freeExport.setUseDegree(useDegree + "");
                                    //adTempList.add(new AdTemp("空调费", total, "", ""));
                                } catch (Exception e) {
                                    //adTempList.add(new AdTemp("空调费", 0, "", ""));
                                }
                            }
                            freeExport.setName("空调费");
                            freeExport.setPrice(airPrice + "");
                            //contract.getTableList66().get(m).setFreeExport(freeExport);
                        }
                    }

                }


                payTotal += innerContractList.get(j).getTotal();
                double payTableMinus = 0;


                double tableMTotal = 0;
                //获取应收 实收
                List<TableM> tableMList = handleService.gainTableMList(contractList.get(i).getCustomId(), "", "");
                for (int m = 0; m < tableMList.size(); m++) {
                    tableMTotal += Double.parseDouble(tableMList.get(m).getMoneyM());
                }
                //已核销的水电费
                List<ContractFree> contractFreeList = handleService.gainContractFreeList(innerContractList.get(j).getCustomId());
                double contractFreeTotal = 0;
                for (ContractFree contractFree : contractFreeList) {
                    contractFreeTotal += contractFree.getMoney();
                }

                payTableMinus = payTotal - tableMTotal + waterTotal + contractFreeTotal;

                tableMTotal = NumberToCN.parseDouble(tableMTotal);
                payTotal = NumberToCN.parseDouble(payTotal);
                payTableMinus = NumberToCN.parseDouble(payTableMinus);

                contractList.get(i).setPayTableMMinus(payTableMinus);
                contractList.get(i).setTableMTotal(tableMTotal);
                contractList.get(i).setPayTotal(payTotal);
                //设置金额,加上水电费的

            }

            //////////////////// 打印部分


            String date = "";
            String loc = "";
            double debt;
            int customId = contractList.get(i).getCustomId();

            List<TableM> tableMList = new ArrayList<TableM>();
            List<Contract> contractListDetail = handleService.gainContractByCustomId(customId);


            String tableU = handleService.gainTableMId(contractListDetail.size() > 0 ? contractListDetail.get(0).getId() : 0);

            if (tableU != null) {
                String[] tableUList = tableU.split(flag1);
                model.addAttribute("tableUList", tableUList);

            } else {
                model.addAttribute("tableUList", new ArrayList<String>());
            }

            for (int d = 0; d < contractListDetail.size(); d++) {


                if (d == 0) {
                    tableMList = handleService.gainTableMList(customId, contractListDetail.get(d).getCodeAuto(), contractListDetail.get(d).getRemark());

                }

                long dayTempTotal = 0;
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    dayTempTotal = ((sdf.parse(contractListDetail.get(d).getEndDate()).getTime() - sdf.parse(contractListDetail.get(d).getStartDate()).getTime()) / (1000 * 60 * 60 * 24)) + 1;
                    contractListDetail.get(d).setDay(dayTempTotal);
                } catch (ParseException e) {
                    e.printStackTrace();
                }

                String style = contractListDetail.get(d).getStyle();
                debt = contractListDetail.get(d).getDebt();
                if ("house".equals(style)) {

                    Contract contract = contractListDetail.get(d);
                    house(contract);

                    double waterPrice = 0;
                    double powerPirce = 0;
                    double airPrice = 0;
                    double freePrice = 0;

                    for (int m = 0; m < contract.getTableList3().size(); m++) {
                        Table t = contract.getTableList3().get(m);
                        if (t.getTable0().contains("物业")) {
                            model.addAttribute("free", t.getTable1());
                            freePrice = Double.parseDouble(t.getTable1());

                        }
                        if (t.getTable0().contains("水")) {
                            model.addAttribute("water", t.getTable1());
                            waterPrice = Double.parseDouble(t.getTable1());

                        }
                        if (t.getTable0().contains("电")) {
                            model.addAttribute("power", t.getTable1());
                            powerPirce = Double.parseDouble(t.getTable1());

                        }
                        if (t.getTable0().contains("空调")) {
                            model.addAttribute("air", t.getTable1());
                            airPrice = Double.parseDouble(t.getTable1());

                        }
                    }


                    String buildArea = "";
                    String price = "";
                    List<AdTemp> adTempList = new ArrayList<AdTemp>();

                    //折扣房租,保证金,物业费    房间的单价   水电费
                    // tableList11 table2 table3(建筑面积)  tableList22 table3  tableList77 table3   tableList1 table6  tableList3 table0 table1
                    double totalBuild = 0;
                    long day = 0;
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    try {
                        day = ((sdf.parse(contract.getEndDate()).getTime() - sdf.parse(contract.getStartDate()).getTime()) / (1000 * 60 * 60 * 24)) + 1;
                    } catch (ParseException e) {
                        e.printStackTrace();
                    }

                    //租金
                    for (int m = 0; m < contract.getTableList11().size(); m++) {
                        Table t = contract.getTableList11().get(m);
                        price = contract.getTableList1().get(m).getTable6();
                        totalBuild += Double.parseDouble(t.getTable0());
                        buildArea = t.getTable0();
                        loc = contract.getTableList1().get(m).getTable1();


                        try {
                            payTotal = Double.parseDouble(t.getTable3());
                            payTotal = NumberToCN.parseDouble(payTotal);


                        } catch (Exception e) {

                        }
                        adTempList.add(new AdTemp("房源-租金", payTotal, loc, date, price, buildArea, day));

                    }

                    //保证金
                    for (int m = 0; m < contract.getTableList22().size(); m++) {
                        Table t = contract.getTableList22().get(m);

                        loc = t.getTable1();

                        double discount = 0;
                        try {
                            discount = Double.parseDouble(t.getTable3());
                        } catch (Exception e) {

                        }

                        try {
                            payTotal = Double.parseDouble(t.getTable2()) - Double.parseDouble(t.getTable2()) * discount / 100;
                            payTotal = NumberToCN.parseDouble(payTotal);


                        } catch (Exception e) {

                        }
                        adTempList.add(new AdTemp("房源-物业保证金", payTotal, loc, date, "", "", day));
                    }

                    //折扣房租,保证金,物业费    房间的单价   水电费
                    // tableList11 table2 table3(建筑面积)  tableList22 table3  tableList77 table3   tableList1 table6  tableList3 table0 table1

                    //物业费
                    for (int m = 0; m < contract.getTableList77().size(); m++) {
                        Table t = contract.getTableList77().get(m);


                        try {
                            payTotal = Double.parseDouble(t.getTable4());
                            payTotal = NumberToCN.parseDouble(payTotal);


                        } catch (Exception e) {

                        }
                        adTempList.add(new AdTemp("房源-物业费", payTotal, "", "", freePrice + "", totalBuild + "", day));
                        contractListDetail.get(d).getTableList77().get(m).setTable10(freePrice + "");
                    }


                    table = contract.getTable2H();
                    tables = table.split(flag2, -1);
                    size = tables[0].split(flag1, -1).length;
                    payTotal = 0;
                    //List<AdTemp> adTempList = new ArrayList<AdTemp>();
                    for (int m = 0; m < size; m++) {
                        if (!"".equals(tables[0].split(flag1, size)[m]) && !"".equals(tables[5].split(flag1, size)[m])) {

                            payTotal = Double.parseDouble(tables[5].split(flag1, size)[m]);


                            adTempList.add(new AdTemp("房源-" + tables[0].split(flag1, size)[m], payTotal, "", "", "", "", day));
                        }
                    }


                    //house(contractListDetail.get(i));

                    //物业水电费
                    if (contract.getIsWater() == 1 || contract.getIsPower() == 1 || contract.getIsAir() == 1) {


                        if (contract.getIsWater() == 1) {
                            List<Table> tableList44 = contract.getTableList44();
                            for (int m = 0; m < tableList44.size(); m++) {
                                Table t = tableList44.get(m);

                                FreeExport freeExport = new FreeExport();
                                List<FreeExport> freeExportList = contractService.gainMaxDegree(t.getTable2(), "water");
                                if (freeExportList.size() == 1) {
                                    freeExport = freeExportList.get(0);
                                    adTempList.add(new AdTemp("水费", 0, freeExport.getLoc(), freeExport.getDate(), "0", freeExport.getDegree(), waterPrice + "", freeExport.getNo(), 0));
                                } else if (freeExportList.size() == 2) {
                                    try {
                                        String lastDegree = freeExportList.get(1).getDegree();
                                        String degree = freeExportList.get(0).getDegree();

                                        double useDegree = Double.parseDouble(degree) - Double.parseDouble(lastDegree);
                                        double totalTemp = useDegree * waterPrice;

                                        freeExport.setTotal(totalTemp);
                                        freeExport.setUseDegree(useDegree + "");
                                        adTempList.add(new AdTemp("水费", totalTemp, freeExportList.get(0).getLoc(), freeExportList.get(0).getDate(), lastDegree, degree, waterPrice + "", freeExportList.get(0).getNo(), useDegree));
                                    } catch (Exception e) {
                                        adTempList.add(new AdTemp("水费", 0, freeExportList.get(0).getLoc(), freeExport.getDate(), "0", freeExportList.get(0).getDegree(), waterPrice + "", freeExportList.get(0).getNo(), 0));
                                    }
                                }


                                freeExport.setName("水费");
                                freeExport.setPrice(waterPrice + "");

                                contract.getTableList44().get(m).setFreeExport(freeExport);

                            }
                        }
                        if (contract.getIsPower() == 1) {
                            List<Table> tableList55 = contract.getTableList55();
                            for (int m = 0; m < tableList55.size(); m++) {
                                Table t = tableList55.get(m);

                                FreeExport freeExport = new FreeExport();
                                List<FreeExport> freeExportList = contractService.gainMaxDegree(t.getTable2(), "power");
                                if (freeExportList.size() == 1) {
                                    freeExport = freeExportList.get(0);
                                    adTempList.add(new AdTemp("电费", 0, freeExport.getLoc(), freeExport.getDate(), "0", freeExport.getDegree(), powerPirce + "", freeExport.getNo(), 0));
                                } else if (freeExportList.size() == 2) {
                                    try {
                                        String lastDegree = freeExportList.get(1).getDegree();
                                        String degree = freeExportList.get(0).getDegree();
                                        double useDegree = Double.parseDouble(degree) - Double.parseDouble(lastDegree);
                                        double totalTemp = useDegree * waterPrice;
                                        freeExport.setTotal(totalTemp);

                                        freeExport.setUseDegree(useDegree + "");
                                        adTempList.add(new AdTemp("电费", totalTemp, freeExportList.get(0).getLoc(), freeExportList.get(0).getDate(), lastDegree, degree, powerPirce + "", freeExportList.get(0).getNo(), useDegree));
                                    } catch (Exception e) {
                                        adTempList.add(new AdTemp("电费", 0, freeExportList.get(0).getLoc(), freeExportList.get(0).getDate(), "0", freeExportList.get(0).getDegree(), powerPirce + "", freeExportList.get(0).getNo(), 0));
                                    }
                                }

                                freeExport.setName("电费");
                                freeExport.setPrice(powerPirce + "");
                                contract.getTableList55().get(m).setFreeExport(freeExport);
                            }
                        }

                        if (contract.getIsAir() == 1) {
                            List<Table> tableList66 = contract.getTableList66();
                            for (int m = 0; m < tableList66.size(); m++) {
                                Table t = tableList66.get(m);
                                FreeExport freeExport = new FreeExport();
                                List<FreeExport> freeExportList = contractService.gainMaxDegree(t.getTable2(), "air");
                                if (freeExportList.size() == 1) {
                                    freeExport = freeExportList.get(0);
                                    adTempList.add(new AdTemp("空调费", 0, freeExport.getLoc(), freeExport.getDate(), "0", freeExport.getDegree(), airPrice + "", freeExport.getNo(), 0));
                                } else if (freeExportList.size() == 2) {
                                    try {
                                        String lastDegree = freeExportList.get(1).getDegree();
                                        String degree = freeExportList.get(0).getDegree();
                                        double useDegree = Double.parseDouble(degree) - Double.parseDouble(lastDegree);
                                        double totalTemp = useDegree * waterPrice;

                                        freeExport.setTotal(totalTemp);
                                        freeExport.setUseDegree(useDegree + "");
                                        adTempList.add(new AdTemp("空调费", totalTemp, freeExportList.get(0).getLoc(), freeExportList.get(0).getDate(), lastDegree, degree, airPrice + "", freeExportList.get(0).getNo(), useDegree));
                                    } catch (Exception e) {
                                        adTempList.add(new AdTemp("空调费", 0, freeExportList.get(0).getLoc(), freeExportList.get(0).getDate(), "0", freeExportList.get(0).getDegree(), airPrice + "", freeExportList.get(0).getNo(), 0));
                                    }
                                }
                                freeExport.setName("空调费");
                                freeExport.setPrice(airPrice + "");
                                contract.getTableList66().get(m).setFreeExport(freeExport);
                            }

                        }
                        for (int ad = 0; ad < contractListDetail.size(); ad++) {
                            int listId = contractListDetail.get(ad).getId();
                            int pLoopIndex = ad;
                            for (int adDetail = adTempList.size() - 1; adDetail >= 0; adDetail--) {
                                int loopIndex = adDetail;
                                String adLoc = adTempList.get(adDetail).getLoc();
                                String adNo = listId + "" + pLoopIndex + "" + loopIndex + "" + adLoc + "fantasy";
                                if (tableU.contains(adNo)) {
                                    adTempList.remove(adDetail);
                                }
                            }
                        }

                        contractListDetail.get(d).setAdTempList(adTempList);
                    }


                } else if ("ad".equals(style)) {

                    table = contractListDetail.get(d).getTable11();
                    tables = table.split(flag2, -1);
                    size = tables[0].split(flag1, -1).length;
                    payTotal = 0;
                    List<AdTemp> adTempList = new ArrayList<AdTemp>();
                    for (int m = 0; m < size; m++) {
                        if (!"".equals(tables[2].split(flag1, size)[m])) {
                            payTotal = Double.parseDouble(tables[2].split(flag1, size)[m]);

                            try {
                                String dates[] = contractListDetail.get(i).getTable1().split(flag2, -1);
                                loc = dates[1].split(flag1, size)[m % 2];
                                date = dates[2].split(flag1, size)[m % 2];
                            } catch (Exception e) {

                            }
                            adTempList.add(new AdTemp("广告-租金", payTotal, loc, date));
                        }
                    }


                    table = contractListDetail.get(d).getTable2H();
                    tables = table.split(flag2, -1);
                    size = tables[0].split(flag1, -1).length;
                    payTotal = 0;

                    for (int m = 0; m < size; m++) {
                        if (!"".equals(tables[1].split(flag1, size)[m])) {

                            payTotal = Double.parseDouble(tables[1].split(flag1, size)[m]);

                            adTempList.add(new AdTemp("广告-" + tables[0].split(flag1, size)[m], payTotal, "", ""));
                        }
                    }

                    //终止合同带来的
                    if (contractListDetail.get(d).getIsPay() == 1 && contractListDetail.get(d).getIsFree() == 0) {
                        try {
                            adTempList.add(new AdTemp("广告-违约金", Double.parseDouble(contractListDetail.get(i).getPayOut()), "", ""));

                        } catch (Exception e) {

                        }

                    }

                    for (int ad = 0; ad < contractListDetail.size(); ad++) {

                        for (int adDetail = adTempList.size() - 1; adDetail >= 0; adDetail--) {
                            int listId = contractListDetail.get(ad).getId();
                            int pLoopIndex = ad;
                            int loopIndex = adDetail;
                            String adLoc = adTempList.get(adDetail).getLoc();
                            String adNo = listId + "" + pLoopIndex + "" + loopIndex + "" + adLoc + "fantasy";
                            logger.error("adListDetail:" + adNo + "," + listId + "," + pLoopIndex);
                            if (tableU.contains(adNo)) {
                                adTempList.remove(adDetail);
                            }
                        }
                    }

                    contractListDetail.get(d).setAdTempList(adTempList);


                    ad(contractListDetail.get(d));

                } else if ("car".equals(style)) {

                    table = contractListDetail.get(d).getTable11();
                    tables = table.split(flag2, -1);
                    size = tables[0].split(flag1, -1).length;
                    payTotal = 0;
                    List<AdTemp> adTempList = new ArrayList<AdTemp>();
                    for (int m = 0; m < size; m++) {
                        if (!"".equals(tables[2].split(flag1, size)[m])) {
                            payTotal = Double.parseDouble(tables[2].split(flag1, size)[m]);

                            try {
                                String dates[] = contractListDetail.get(i).getTable1().split(flag2, -1);
                                loc = dates[1].split(flag1, size)[m % 2];
                                date = dates[2].split(flag1, size)[m % 2];
                            } catch (Exception e) {

                            }
                            adTempList.add(new AdTemp("车位-租金", payTotal, loc, date));
                        }
                    }


                    table = contractListDetail.get(d).getTable2H();
                    tables = table.split(flag2, -1);
                    size = tables[0].split(flag1, -1).length;
                    payTotal = 0;

                    for (int m = 0; m < size; m++) {
                        if (!"".equals(tables[1].split(flag1, size)[m])) {

                            payTotal = Double.parseDouble(tables[1].split(flag1, size)[m]);

                            adTempList.add(new AdTemp("车位-" + tables[0].split(flag1, size)[m], payTotal, "", ""));
                        }
                    }
                    //终止合同带来的
                    if (contractListDetail.get(d).getIsPay() == 1 && contractListDetail.get(d).getIsFree() == 0) {
                        try {
                            adTempList.add(new AdTemp("车位-违约金", Double.parseDouble(contractListDetail.get(i).getPayOut()), "", ""));

                        } catch (Exception e) {

                        }

                    }

                    for (int ad = 0; ad < contractListDetail.size(); ad++) {
                        int listId = contractListDetail.get(ad).getId();
                        int pLoopIndex = ad;
                        for (int adDetail = adTempList.size() - 1; adDetail >= 0; adDetail--) {
                            int loopIndex = adDetail;
                            String adLoc = adTempList.get(adDetail).getLoc();
                            String adNo = listId + "" + pLoopIndex + "" + loopIndex + "" + adLoc + "fantasy";
                            if (tableU.contains(adNo)) {
                                adTempList.remove(adDetail);
                            }
                        }
                    }

                    contractListDetail.get(d).setAdTempList(adTempList);

                    car(contractListDetail.get(d));
                }
            }


            contractList.get(i).setContractDetailList(contractListDetail);
            contractList.get(i).setTableU(tableU);

            //////////////////// 打印部分

            payTableMinusTotal += contractList.get(i).getPayTableMMinus();
        }


        model.addAttribute("contractList", contractList);
        model.addAttribute("page", page);
        model.addAttribute("total", total);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        model.addAttribute("payTableMinusTotal", NumberToCN.parseDouble(payTableMinusTotal));
        return "handle_receivable";
    }

    //    房源租金，物业保证金，物业费，广告租金，车位租金，水费，电费，空调费 all 排序 code loc 其他
    @RequestMapping(value = "/handle_receivable_all/{userId}/{page}/{houseCheck}/{cashCheck}/{propertyCheck}/{adCheck}/{carCheck}/{waterCheck}/{powerCheck}/{airCheck}/{allCheck}/{codeCheck}/{locCheck}/{otherCheck}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String handleReceivableAll(Model model, HttpServletRequest request, @PathVariable("userId") int userId, @PathVariable("page") int page,
                                      @PathVariable("houseCheck") String houseCheck, @PathVariable("cashCheck") String cashCheck, @PathVariable("allCheck") String allCheck,
                                      @PathVariable("propertyCheck") String propertyCheck, @PathVariable("adCheck") String adCheck, @PathVariable("carCheck") String carCheck,
                                      @PathVariable("waterCheck") String waterCheck, @PathVariable("powerCheck") String powerCheck, @PathVariable("airCheck") String airCheck,
                                      @PathVariable("codeCheck") String codeCheck, @PathVariable("locCheck") String locCheck, @PathVariable("otherCheck") String otherCheck) {
        String flag1 = "@@";
        String flag2 = "=";
        String role4 = baseService.getRole(userId, "role4");
        String is_admin = CommUtil.showIsAdminCookie(request);

        model.addAttribute("role4", role4);
        model.addAttribute("is_admin", is_admin);

        List<Contract> contractList = handleService.gainContractListAll(codeCheck, locCheck);
        int total = handleService.gainContractListTotalAll();
        double payTableMinusTotal = 0;
        int customId = 0;
        for (int i = 0; i < contractList.size(); i++) {
            customId = contractList.get(i).getCustomId();
            //获取支付日期
            String table = contractList.get(i).getTable1();
            if (table == null) {
                table = "";
            }
            String[] tables = table.split(flag2, -1);
            int size = tables[0].split(flag1, -1).length;

            for (int j = 0; j < size; j++) {
                try {
                    String date = tables[2].split(flag1, size)[j];
                    if (!"".equals(date)) {
                        contractList.get(i).setPayDate(date);
                        break;
                    }
                } catch (Exception e) {
                }
            }


            //获取所有支付的金额
            double payTotal = 0;
            double waterTotal = 0;

            List<Contract> innerContractList = handleService.gainContractId(contractList.get(i).getCustomId());
            for (int j = 0; j < innerContractList.size(); j++) {


                //物业水电费
                if (innerContractList.get(j).getIsWater() == 1 || innerContractList.get(j).getIsPower() == 1 || innerContractList.get(j).getIsAir() == 1) {

                    double waterPrice = 0;
                    double powerPirce = 0;
                    double airPrice = 0;
                    double freePrice = 0;

                    house(innerContractList.get(j));
                    for (int m = 0; m < innerContractList.get(j).getTableList3().size(); m++) {
                        Table t = innerContractList.get(j).getTableList3().get(m);
                        if (t.getTable0().contains("物业")) {
                            model.addAttribute("free", t.getTable1());
                            freePrice = Double.parseDouble(t.getTable1());

                        }
                        if (t.getTable0().contains("水")) {
                            model.addAttribute("water", t.getTable1());
                            waterPrice = Double.parseDouble(t.getTable1());

                        }
                        if (t.getTable0().contains("电")) {
                            model.addAttribute("power", t.getTable1());
                            powerPirce = Double.parseDouble(t.getTable1());

                        }
                        if (t.getTable0().contains("空调")) {
                            model.addAttribute("air", t.getTable1());
                            airPrice = Double.parseDouble(t.getTable1());

                        }
                    }

                    if (innerContractList.get(j).getIsWater() == 1) {
                        List<Table> tableList44 = innerContractList.get(j).getTableList44();
                        for (int m = 0; m < tableList44.size(); m++) {
                            Table t = tableList44.get(m);

                            FreeExport freeExport = new FreeExport();
                            List<FreeExport> freeExportList = contractService.gainMaxDegree(t.getTable2(), "water");
                            if (freeExportList.size() == 1) {
                                freeExport = freeExportList.get(0);
                                // adTempList.add(new AdTemp("水费", 0, "", ""));
                            } else if (freeExportList.size() == 2) {
                                try {
                                    double useDegree = Double.parseDouble(freeExportList.get(0).getDegree()) - Double.parseDouble(freeExportList.get(1).getDegree());
                                    double water = useDegree * waterPrice;
                                    waterTotal += water;
                                    freeExport.setTotal(total);
                                    freeExport.setUseDegree(useDegree + "");
                                    //adTempList.add(new AdTemp("水费", total, "", ""));
                                } catch (Exception e) {
                                    // adTempList.add(new AdTemp("水费", 0, "", ""));
                                }
                            }


                            freeExport.setName("水费");
                            freeExport.setPrice(waterPrice + "");

                            //contract.getTableList44().get(m).setFreeExport(freeExport);

                        }
                    }
                    if (innerContractList.get(j).getIsPower() == 1) {
                        List<Table> tableList55 = innerContractList.get(j).getTableList55();
                        for (int m = 0; m < tableList55.size(); m++) {
                            Table t = tableList55.get(m);

                            FreeExport freeExport = new FreeExport();
                            List<FreeExport> freeExportList = contractService.gainMaxDegree(t.getTable2(), "power");
                            if (freeExportList.size() == 1) {
                                freeExport = freeExportList.get(0);
                                //adTempList.add(new AdTemp("电费", 0, "", ""));
                            } else if (freeExportList.size() == 2) {
                                try {
                                    double useDegree = Double.parseDouble(freeExportList.get(0).getDegree()) - Double.parseDouble(freeExportList.get(1).getDegree());
                                    double water = useDegree * waterPrice;
                                    waterTotal += water;
                                    freeExport.setTotal(total);
                                    freeExport.setUseDegree(useDegree + "");
                                    // adTempList.add(new AdTemp("电费", total, "", ""));
                                } catch (Exception e) {
                                    //adTempList.add(new AdTemp("电费", 0, "", ""));
                                }
                            }

                            freeExport.setName("电费");
                            freeExport.setPrice(powerPirce + "");
                            //contract.getTableList55().get(m).setFreeExport(freeExport);
                        }
                    }

                    if (innerContractList.get(j).getIsAir() == 1) {
                        List<Table> tableList66 = innerContractList.get(j).getTableList66();
                        for (int m = 0; m < tableList66.size(); m++) {
                            Table t = tableList66.get(m);
                            FreeExport freeExport = new FreeExport();
                            List<FreeExport> freeExportList = contractService.gainMaxDegree(t.getTable2(), "air");
                            if (freeExportList.size() == 1) {
                                freeExport = freeExportList.get(0);
                                //adTempList.add(new AdTemp("空调费", 0, "", ""));
                            } else if (freeExportList.size() == 2) {
                                try {
                                    double useDegree = Double.parseDouble(freeExportList.get(0).getDegree()) - Double.parseDouble(freeExportList.get(1).getDegree());
                                    double water = useDegree * waterPrice;
                                    freeExport.setTotal(total);
                                    waterTotal += water;
                                    freeExport.setUseDegree(useDegree + "");
                                    //adTempList.add(new AdTemp("空调费", total, "", ""));
                                } catch (Exception e) {
                                    //adTempList.add(new AdTemp("空调费", 0, "", ""));
                                }
                            }
                            freeExport.setName("空调费");
                            freeExport.setPrice(airPrice + "");
                            //contract.getTableList66().get(m).setFreeExport(freeExport);
                        }
                    }

                }


                payTotal += innerContractList.get(j).getTotal();
                double payTableMinus = 0;


                double tableMTotal = 0;
                //获取应收 实收
                List<TableM> tableMList = handleService.gainTableMList(contractList.get(i).getCustomId(), "", "");
                for (int m = 0; m < tableMList.size(); m++) {
                    tableMTotal += Double.parseDouble(tableMList.get(m).getMoneyM());

                }
                //已核销的水电费
                List<ContractFree> contractFreeList = handleService.gainContractFreeList(innerContractList.get(j).getCustomId());
                double contractFreeTotal = 0;
                for (ContractFree contractFree : contractFreeList) {
                    contractFreeTotal += contractFree.getMoney();
                }
                payTableMinus = payTotal - tableMTotal + waterTotal + contractFreeTotal;

                tableMTotal = NumberToCN.parseDouble(tableMTotal);
                payTotal = NumberToCN.parseDouble(payTotal);
                payTableMinus = NumberToCN.parseDouble(payTableMinus);

                contractList.get(i).setPayTableMMinus(payTableMinus);
                contractList.get(i).setTableMTotal(tableMTotal);
                contractList.get(i).setPayTotal(payTotal);
                //设置金额,加上水电费的

            }

            //////////////////// 打印部分


            String date = "";
            String loc = "";
            double debt;
            customId = contractList.get(i).getCustomId();

            List<TableM> tableMList = new ArrayList<TableM>();
            List<Contract> contractListDetail = handleService.gainContractByCustomId(customId);

            String tableU = handleService.gainTableMId(contractListDetail.size() > 0 ? contractListDetail.get(0).getId() : 0);
            if (tableU != null) {
                String[] tableUList = tableU.split(flag1);
                model.addAttribute("tableUList", tableUList);

            } else {
                model.addAttribute("tableUList", new ArrayList<String>());
            }

            for (int d = 0; d < contractListDetail.size(); d++) {

                long dayTempTotal = 0;
                try {
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    dayTempTotal = ((sdf.parse(contractListDetail.get(d).getEndDate()).getTime() - sdf.parse(contractListDetail.get(d).getStartDate()).getTime()) / (1000 * 60 * 60 * 24)) + 1;
                    contractListDetail.get(d).setDay(dayTempTotal);
                } catch (ParseException e) {
                    e.printStackTrace();
                }

                if (d == 0) {
                    tableMList = handleService.gainTableMList(customId, contractListDetail.get(d).getCodeAuto(), contractListDetail.get(d).getRemark());

                }

                String style = contractListDetail.get(d).getStyle();
                debt = contractListDetail.get(d).getDebt();
                if ("house".equals(style)) {

                    Contract contract = contractListDetail.get(d);
                    house(contract);

                    double waterPrice = 0;
                    double powerPirce = 0;
                    double airPrice = 0;
                    double freePrice = 0;

                    for (int m = 0; m < contract.getTableList3().size(); m++) {
                        Table t = contract.getTableList3().get(m);
                        if (t.getTable0().contains("物业")) {
                            model.addAttribute("free", t.getTable1());
                            freePrice = Double.parseDouble(t.getTable1());

                        }
                        if (t.getTable0().contains("水")) {
                            model.addAttribute("water", t.getTable1());
                            waterPrice = Double.parseDouble(t.getTable1());

                        }
                        if (t.getTable0().contains("电")) {
                            model.addAttribute("power", t.getTable1());
                            powerPirce = Double.parseDouble(t.getTable1());

                        }
                        if (t.getTable0().contains("空调")) {
                            model.addAttribute("air", t.getTable1());
                            airPrice = Double.parseDouble(t.getTable1());

                        }
                    }


                    String buildArea = "";
                    String price = "";
                    List<AdTemp> adTempList = new ArrayList<AdTemp>();

                    //折扣房租,保证金,物业费    房间的单价   水电费
                    // tableList11 table2 table3(建筑面积)  tableList22 table3  tableList77 table3   tableList1 table6  tableList3 table0 table1
                    double totalBuild = 0;
                    long day = 0;
                    SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                    try {
                        day = ((sdf.parse(contract.getEndDate()).getTime() - sdf.parse(contract.getStartDate()).getTime()) / (1000 * 60 * 60 * 24)) + 1;
                    } catch (ParseException e) {
                        e.printStackTrace();
                    }

                    //租金
                    for (int m = 0; m < contract.getTableList11().size(); m++) {
                        Table t = contract.getTableList11().get(m);
                        price = contract.getTableList1().get(m).getTable6();
                        totalBuild += Double.parseDouble(t.getTable0());
                        buildArea = t.getTable0();
                        loc = contract.getTableList1().get(m).getTable1();


                        try {
                            payTotal = Double.parseDouble(t.getTable3());
                            payTotal = NumberToCN.parseDouble(payTotal);


                        } catch (Exception e) {

                        }
                        adTempList.add(new AdTemp("房源-租金", payTotal, loc, date, price, buildArea, day));

                    }

                    //保证金
                    for (int m = 0; m < contract.getTableList22().size(); m++) {
                        Table t = contract.getTableList22().get(m);

                        loc = t.getTable1();

                        double discount = 0;
                        try {
                            discount = Double.parseDouble(t.getTable3());
                        } catch (Exception e) {

                        }

                        try {
                            payTotal = Double.parseDouble(t.getTable2()) - Double.parseDouble(t.getTable2()) * discount / 100;
                            payTotal = NumberToCN.parseDouble(payTotal);


                        } catch (Exception e) {

                        }
                        adTempList.add(new AdTemp("房源-物业保证金", payTotal, loc, date, "", "", day));
                    }

                    //折扣房租,保证金,物业费    房间的单价   水电费
                    // tableList11 table2 table3(建筑面积)  tableList22 table3  tableList77 table3   tableList1 table6  tableList3 table0 table1

                    //物业费
                    for (int m = 0; m < contract.getTableList77().size(); m++) {
                        Table t = contract.getTableList77().get(m);


                        try {
                            payTotal = Double.parseDouble(t.getTable4());
                            payTotal = NumberToCN.parseDouble(payTotal);


                        } catch (Exception e) {

                        }
                        adTempList.add(new AdTemp("房源-物业费", payTotal, "", "", freePrice + "", totalBuild + "", day));
                        contractListDetail.get(d).getTableList77().get(m).setTable10(freePrice + "");
                    }


                    table = contract.getTable2H();
                    tables = table.split(flag2, -1);
                    size = tables[0].split(flag1, -1).length;
                    payTotal = 0;
                    //List<AdTemp> adTempList = new ArrayList<AdTemp>();
                    for (int m = 0; m < size; m++) {
                        if (!"".equals(tables[0].split(flag1, size)[m]) && !"".equals(tables[5].split(flag1, size)[m])) {

                            payTotal = Double.parseDouble(tables[5].split(flag1, size)[m]);


                            adTempList.add(new AdTemp("房源-" + tables[0].split(flag1, size)[m], payTotal, "", "", "", "", day));
                        }
                    }


                    //house(contractListDetail.get(i));

                    //物业水电费
                    if (contract.getIsWater() == 1 || contract.getIsPower() == 1 || contract.getIsAir() == 1) {


                        if (contract.getIsWater() == 1) {
                            List<Table> tableList44 = contract.getTableList44();
                            for (int m = 0; m < tableList44.size(); m++) {
                                Table t = tableList44.get(m);

                                FreeExport freeExport = new FreeExport();
                                List<FreeExport> freeExportList = contractService.gainMaxDegree(t.getTable2(), "water");
                                if (freeExportList.size() == 1) {
                                    freeExport = freeExportList.get(0);
                                    adTempList.add(new AdTemp("水费", 0, freeExport.getLoc(), freeExport.getDate(), "0", freeExport.getDegree(), waterPrice + "", freeExport.getNo(), 0));
                                } else if (freeExportList.size() == 2) {
                                    try {
                                        String lastDegree = freeExportList.get(1).getDegree();
                                        String degree = freeExportList.get(0).getDegree();

                                        double useDegree = Double.parseDouble(degree) - Double.parseDouble(lastDegree);
                                        double totalTemp = useDegree * waterPrice;

                                        freeExport.setTotal(totalTemp);
                                        freeExport.setUseDegree(useDegree + "");
                                        adTempList.add(new AdTemp("水费", totalTemp, freeExportList.get(0).getLoc(), freeExportList.get(0).getDate(), lastDegree, degree, waterPrice + "", freeExportList.get(0).getNo(), useDegree));
                                    } catch (Exception e) {
                                        adTempList.add(new AdTemp("水费", 0, freeExportList.get(0).getLoc(), freeExportList.get(0).getDate(), "0", freeExportList.get(0).getDegree(), waterPrice + "", freeExportList.get(0).getNo(), 0));
                                    }
                                }


                                freeExport.setName("水费");
                                freeExport.setPrice(waterPrice + "");

                                contract.getTableList44().get(m).setFreeExport(freeExport);

                            }
                        }

                        if (contract.getIsPower() == 1) {

                            List<Table> tableList55 = contract.getTableList55();
                            for (int m = 0; m < tableList55.size(); m++) {
                                Table t = tableList55.get(m);

                                FreeExport freeExport = new FreeExport();
                                List<FreeExport> freeExportList = contractService.gainMaxDegree(t.getTable2(), "power");
                                if (freeExportList.size() == 1) {
                                    freeExport = freeExportList.get(0);
                                    adTempList.add(new AdTemp("电费", 0, freeExport.getLoc(), freeExport.getDate(), "0", freeExport.getDegree(), powerPirce + "", freeExport.getNo(), 0));
                                } else if (freeExportList.size() == 2) {
                                    try {
                                        String lastDegree = freeExportList.get(1).getDegree();
                                        String degree = freeExportList.get(0).getDegree();
                                        double useDegree = Double.parseDouble(degree) - Double.parseDouble(lastDegree);
                                        double totalTemp = useDegree * waterPrice;
                                        freeExport.setTotal(totalTemp);

                                        freeExport.setUseDegree(useDegree + "");
                                        adTempList.add(new AdTemp("电费", totalTemp, freeExportList.get(0).getLoc(), freeExportList.get(0).getDate(), lastDegree, degree, powerPirce + "", freeExportList.get(0).getNo(), useDegree));
                                    } catch (Exception e) {
                                        adTempList.add(new AdTemp("电费", 0, freeExportList.get(0).getLoc(), freeExportList.get(0).getDate(), "0", freeExportList.get(0).getDegree(), powerPirce + "", freeExportList.get(0).getNo(), 0));
                                    }
                                }

                                freeExport.setName("电费");
                                freeExport.setPrice(powerPirce + "");
                                contract.getTableList55().get(m).setFreeExport(freeExport);
                            }
                        }

                        if (contract.getIsAir() == 1) {
                            List<Table> tableList66 = contract.getTableList66();
                            for (int m = 0; m < tableList66.size(); m++) {
                                Table t = tableList66.get(m);
                                FreeExport freeExport = new FreeExport();
                                List<FreeExport> freeExportList = contractService.gainMaxDegree(t.getTable2(), "air");
                                if (freeExportList.size() == 1) {
                                    freeExport = freeExportList.get(0);
                                    adTempList.add(new AdTemp("空调费", 0, freeExport.getLoc(), freeExport.getDate(), "0", freeExport.getDegree(), airPrice + "", freeExport.getNo(), 0));
                                } else if (freeExportList.size() == 2) {
                                    try {
                                        String lastDegree = freeExportList.get(1).getDegree();
                                        String degree = freeExportList.get(0).getDegree();
                                        double useDegree = Double.parseDouble(degree) - Double.parseDouble(lastDegree);
                                        double totalTemp = useDegree * waterPrice;

                                        freeExport.setTotal(totalTemp);
                                        freeExport.setUseDegree(useDegree + "");
                                        adTempList.add(new AdTemp("空调费", totalTemp, freeExportList.get(0).getLoc(), freeExportList.get(0).getDate(), lastDegree, degree, airPrice + "", freeExportList.get(0).getNo(), useDegree));
                                    } catch (Exception e) {
                                        adTempList.add(new AdTemp("空调费", 0, freeExportList.get(0).getLoc(), freeExportList.get(0).getDate(), "0", freeExportList.get(0).getDegree(), airPrice + "", freeExportList.get(0).getNo(), 0));
                                    }
                                }
                                freeExport.setName("空调费");
                                freeExport.setPrice(airPrice + "");
                                contract.getTableList66().get(m).setFreeExport(freeExport);
                            }
                        }

                        for (int ad = 0; ad < contractListDetail.size(); ad++) {
                            int listId = contractListDetail.get(ad).getId();
                            int pLoopIndex = ad;
                            for (int adDetail = adTempList.size() - 1; adDetail >= 0; adDetail--) {
                                int loopIndex = adDetail;
                                String adLoc = adTempList.get(adDetail).getLoc();
                                String adNo = listId + "" + pLoopIndex + "" + loopIndex + "" + adLoc + "fantasy";
                                if (tableU.contains(adNo)) {
                                    adTempList.remove(adDetail);
                                }
                            }
                        }

                        contractListDetail.get(d).setAdTempList(adTempList);
                    }


                } else if ("ad".equals(style)) {

                    table = contractListDetail.get(d).getTable11();
                    tables = table.split(flag2, -1);
                    size = tables[0].split(flag1, -1).length;
                    payTotal = 0;
                    List<AdTemp> adTempList = new ArrayList<AdTemp>();
                    for (int m = 0; m < size; m++) {
                        if (!"".equals(tables[2].split(flag1, size)[m])) {
                            payTotal = Double.parseDouble(tables[2].split(flag1, size)[m]);

                            try {
                                String dates[] = contractListDetail.get(i).getTable1().split(flag2, -1);
                                loc = dates[1].split(flag1, size)[m % 2];
                                date = dates[2].split(flag1, size)[m % 2];
                            } catch (Exception e) {

                            }
                            adTempList.add(new AdTemp("广告-租金", payTotal, loc, date));
                        }
                    }


                    table = contractListDetail.get(d).getTable2H();
                    tables = table.split(flag2, -1);
                    size = tables[0].split(flag1, -1).length;
                    payTotal = 0;

                    for (int m = 0; m < size; m++) {
                        if (!"".equals(tables[1].split(flag1, size)[m])) {

                            payTotal = Double.parseDouble(tables[1].split(flag1, size)[m]);

                            adTempList.add(new AdTemp("广告-" + tables[0].split(flag1, size)[m], payTotal, "", ""));
                        }
                    }

                    //终止合同带来的
                    if (contractListDetail.get(d).getIsPay() == 1 && contractListDetail.get(d).getIsFree() == 0) {
                        try {
                            adTempList.add(new AdTemp("广告-违约金", Double.parseDouble(contractListDetail.get(i).getPayOut()), "", ""));

                        } catch (Exception e) {

                        }

                    }

                    for (int ad = 0; ad < contractListDetail.size(); ad++) {

                        for (int adDetail = adTempList.size() - 1; adDetail >= 0; adDetail--) {
                            int listId = contractListDetail.get(ad).getId();
                            int pLoopIndex = ad;
                            int loopIndex = adDetail;
                            String adLoc = adTempList.get(adDetail).getLoc();
                            String adNo = listId + "" + pLoopIndex + "" + loopIndex + "" + adLoc + "fantasy";
                            logger.error("adListDetail:" + adNo + "," + listId + "," + pLoopIndex);
                            if (tableU.contains(adNo)) {
                                adTempList.remove(adDetail);
                            }
                        }
                    }

                    contractListDetail.get(d).setAdTempList(adTempList);


                    ad(contractListDetail.get(d));

                } else if ("car".equals(style)) {

                    table = contractListDetail.get(d).getTable11();
                    tables = table.split(flag2, -1);
                    size = tables[0].split(flag1, -1).length;
                    payTotal = 0;
                    List<AdTemp> adTempList = new ArrayList<AdTemp>();
                    for (int m = 0; m < size; m++) {
                        if (!"".equals(tables[2].split(flag1, size)[m])) {
                            payTotal = Double.parseDouble(tables[2].split(flag1, size)[m]);

                            try {
                                String dates[] = contractListDetail.get(i).getTable1().split(flag2, -1);
                                loc = dates[1].split(flag1, size)[m % 2];
                                date = dates[2].split(flag1, size)[m % 2];
                            } catch (Exception e) {

                            }
                            adTempList.add(new AdTemp("车位-租金", payTotal, loc, date));
                        }
                    }


                    table = contractListDetail.get(d).getTable2H();
                    tables = table.split(flag2, -1);
                    size = tables[0].split(flag1, -1).length;
                    payTotal = 0;

                    for (int m = 0; m < size; m++) {
                        if (!"".equals(tables[1].split(flag1, size)[m])) {

                            payTotal = Double.parseDouble(tables[1].split(flag1, size)[m]);

                            adTempList.add(new AdTemp("车位-" + tables[0].split(flag1, size)[m], payTotal, "", ""));
                        }
                    }
                    //终止合同带来的
                    if (contractListDetail.get(d).getIsPay() == 1 && contractListDetail.get(d).getIsFree() == 0) {
                        try {
                            adTempList.add(new AdTemp("车位-违约金", Double.parseDouble(contractListDetail.get(i).getPayOut()), "", ""));

                        } catch (Exception e) {

                        }

                    }

                    for (int ad = 0; ad < contractListDetail.size(); ad++) {
                        int listId = contractListDetail.get(ad).getId();
                        int pLoopIndex = ad;
                        for (int adDetail = adTempList.size() - 1; adDetail >= 0; adDetail--) {
                            int loopIndex = adDetail;
                            String adLoc = adTempList.get(adDetail).getLoc();
                            String adNo = listId + "" + pLoopIndex + "" + loopIndex + "" + adLoc + "fantasy";
                            if (tableU.contains(adNo)) {
                                adTempList.remove(adDetail);
                            }
                        }
                    }

                    contractListDetail.get(d).setAdTempList(adTempList);

                    car(contractListDetail.get(d));
                }
            }

            contractList.get(i).setContractDetailList(contractListDetail);
            contractList.get(i).setTableU(tableU);

            //////////////////// 打印部分
            payTableMinusTotal += contractList.get(i).getPayTableMMinus();
        }


        model.addAttribute("contractList", contractList);
        model.addAttribute("page", page);
        model.addAttribute("total", total);
        model.addAttribute("pageSize", total);


        model.addAttribute("houseCheck", houseCheck);
        model.addAttribute("cashCheck", cashCheck);
        model.addAttribute("propertyCheck", propertyCheck);
        model.addAttribute("adCheck", adCheck);
        model.addAttribute("carCheck", carCheck);
        model.addAttribute("waterCheck", waterCheck);
        model.addAttribute("powerCheck", powerCheck);
        model.addAttribute("airCheck", airCheck);
        model.addAttribute("allCheck", allCheck);
        model.addAttribute("carCheck", carCheck);
        model.addAttribute("codeCheck", codeCheck);
        model.addAttribute("locCheck", locCheck);
        model.addAttribute("otherCheck", otherCheck);
        model.addAttribute("payTableMinusTotal", NumberToCN.parseDouble(payTableMinusTotal));

        return "handle_receivable_all";
    }

    @RequestMapping(value = "/handle_receivable_detail/{codeAuto}/{remark}/{userId}/{customId}/update", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String handleReceivableDetail(Model model, HttpServletRequest request, @PathVariable("codeAuto") String codeAuto, @PathVariable("remark") String remark, @PathVariable("userId") int userId, @PathVariable("customId") int customId) {


        String flag1 = "@@";
        String flag2 = "=";
        String table;
        String[] tables;
        if ("fantasy".equals(remark)) {
            remark = "";
        }
        int size;
        double payTotal = 0;
        String date = "";
        String loc = "";
        double allTotal = 0;
        double debt = 0;
        List<TableM> tableMList = new ArrayList<TableM>();
        List<Contract> contractListDetail = handleService.gainContractByCustomId(customId);

        String tableU = handleService.gainTableMId(contractListDetail.size() > 0 ? contractListDetail.get(0).getId() : 0);
        if (tableU != null) {
            String[] tableUList = tableU.split(flag1);
            model.addAttribute("tableUList", tableUList);

        } else {
            model.addAttribute("tableUList", new ArrayList<String>());
        }

        for (int i = 0; i < contractListDetail.size(); i++) {


            if (i == 0) {
                tableMList = handleService.gainTableMList(customId, contractListDetail.get(i).getCodeAuto(), contractListDetail.get(i).getRemark());
                //tableU = handleService.updateTableM()
            }

            String style = contractListDetail.get(i).getStyle();
            debt = contractListDetail.get(i).getDebt();
            if ("house".equals(style)) {

                Contract contract = contractListDetail.get(i);
                house(contract);

                double waterPrice = 0;
                double powerPirce = 0;
                double airPrice = 0;
                double freePrice = 0;

                for (int m = 0; m < contract.getTableList3().size(); m++) {
                    Table t = contract.getTableList3().get(m);
                    if (t.getTable0().contains("物业")) {
                        model.addAttribute("free", t.getTable1());
                        freePrice = Double.parseDouble(t.getTable1());

                    }
                    if (t.getTable0().contains("水")) {
                        model.addAttribute("water", t.getTable1());
                        waterPrice = Double.parseDouble(t.getTable1());

                    }
                    if (t.getTable0().contains("电")) {
                        model.addAttribute("power", t.getTable1());
                        powerPirce = Double.parseDouble(t.getTable1());

                    }
                    if (t.getTable0().contains("空调")) {
                        model.addAttribute("air", t.getTable1());
                        airPrice = Double.parseDouble(t.getTable1());

                    }
                }


                String buildArea = "";
                String price = "";
                List<AdTemp> adTempList = new ArrayList<AdTemp>();

                //折扣房租,保证金,物业费    房间的单价   水电费
                // tableList11 table2 table3(建筑面积)  tableList22 table3  tableList77 table3   tableList1 table6  tableList3 table0 table1
                double totalBuild = 0;
                long day = 0;
                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
                try {
                    day = ((sdf.parse(contract.getEndDate()).getTime() - sdf.parse(contract.getStartDate()).getTime()) / (1000 * 60 * 60 * 24)) + 1;
                } catch (ParseException e) {
                    e.printStackTrace();
                }

                //租金
                for (int m = 0; m < contract.getTableList11().size(); m++) {
                    Table t = contract.getTableList11().get(m);
                    price = contract.getTableList1().get(m).getTable6();
                    totalBuild += Double.parseDouble(t.getTable0());
                    buildArea = t.getTable0();
                    loc = contract.getTableList1().get(m).getTable1();


                    try {
                        payTotal = Double.parseDouble(t.getTable3());
                        payTotal = NumberToCN.parseDouble(payTotal);
                        allTotal += payTotal;

                    } catch (Exception e) {

                    }
                    adTempList.add(new AdTemp("房源-租金", payTotal, loc, date, price, buildArea, day));

                }

                //保证金
                for (int m = 0; m < contract.getTableList22().size(); m++) {
                    Table t = contract.getTableList22().get(m);

                    loc = t.getTable1();

                    double discount = 0;
                    try {
                        discount = Double.parseDouble(t.getTable3());
                    } catch (Exception e) {

                    }

                    try {
                        payTotal = Double.parseDouble(t.getTable2()) - Double.parseDouble(t.getTable2()) * discount / 100;
                        payTotal = NumberToCN.parseDouble(payTotal);
                        allTotal += payTotal;

                    } catch (Exception e) {

                    }
                    adTempList.add(new AdTemp("房源-物业保证金", payTotal, loc, date, "", "", day));
                }

                //折扣房租,保证金,物业费    房间的单价   水电费
                // tableList11 table2 table3(建筑面积)  tableList22 table3  tableList77 table3   tableList1 table6  tableList3 table0 table1

                //物业费
                for (int m = 0; m < contract.getTableList77().size(); m++) {
                    Table t = contract.getTableList77().get(m);


                    try {
                        payTotal = Double.parseDouble(t.getTable4());
                        payTotal = NumberToCN.parseDouble(payTotal);
                        allTotal += payTotal;

                    } catch (Exception e) {

                    }
                    adTempList.add(new AdTemp("房源-物业费", payTotal, "", "", freePrice + "", totalBuild + "", day));

                }


                table = contract.getTable2H();
                tables = table.split(flag2, -1);
                size = tables[0].split(flag1, -1).length;
                payTotal = 0;
                //List<AdTemp> adTempList = new ArrayList<AdTemp>();
                for (int m = 0; m < size; m++) {
                    if (!"".equals(tables[0].split(flag1, size)[m]) && !"".equals(tables[5].split(flag1, size)[m])) {

                        payTotal = Double.parseDouble(tables[5].split(flag1, size)[m]);
                        allTotal += payTotal;


                        adTempList.add(new AdTemp("房源-" + tables[0].split(flag1, size)[m], payTotal, "", "", "", "", day));
                    }
                }


                //house(contractListDetail.get(i));

                //物业水电费
                if (contract.getIsWater() == 1 || contract.getIsPower() == 1 || contract.getIsAir() == 1) {

                    if (contract.getIsWater() == 1) {
                        List<Table> tableList44 = contract.getTableList44();
                        for (int m = 0; m < tableList44.size(); m++) {
                            Table t = tableList44.get(m);

                            FreeExport freeExport = new FreeExport();
                            List<FreeExport> freeExportList = contractService.gainMaxDegree(t.getTable2(), "water");
                            if (freeExportList.size() == 1) {
                                freeExport = freeExportList.get(0);
                                adTempList.add(new AdTemp("水费", 0, freeExportList.get(0).getLoc(), ""));
                            } else if (freeExportList.size() == 2) {
                                try {
                                    double useDegree = Double.parseDouble(freeExportList.get(0).getDegree()) - Double.parseDouble(freeExportList.get(1).getDegree());
                                    double total = useDegree * waterPrice;
                                    allTotal += total;
                                    freeExport.setTotal(total);
                                    freeExport.setUseDegree(useDegree + "");
                                    adTempList.add(new AdTemp("水费", total, freeExportList.get(0).getLoc(), ""));
                                } catch (Exception e) {
                                    adTempList.add(new AdTemp("水费", 0, freeExportList.get(0).getLoc(), ""));
                                }
                            }


                            freeExport.setName("水费");
                            freeExport.setPrice(waterPrice + "");

                            contract.getTableList44().get(m).setFreeExport(freeExport);

                        }
                    }
                    if (contract.getIsPower() == 1) {
                        List<Table> tableList55 = contract.getTableList55();
                        for (int m = 0; m < tableList55.size(); m++) {
                            Table t = tableList55.get(m);

                            FreeExport freeExport = new FreeExport();
                            List<FreeExport> freeExportList = contractService.gainMaxDegree(t.getTable2(), "power");
                            if (freeExportList.size() == 1) {
                                freeExport = freeExportList.get(0);
                                adTempList.add(new AdTemp("电费", 0, freeExportList.get(0).getLoc(), ""));
                            } else if (freeExportList.size() == 2) {
                                try {
                                    double useDegree = Double.parseDouble(freeExportList.get(0).getDegree()) - Double.parseDouble(freeExportList.get(1).getDegree());
                                    double total = useDegree * waterPrice;
                                    freeExport.setTotal(total);
                                    allTotal += total;
                                    freeExport.setUseDegree(useDegree + "");
                                    adTempList.add(new AdTemp("电费", total, freeExportList.get(0).getLoc(), ""));
                                } catch (Exception e) {
                                    adTempList.add(new AdTemp("电费", 0, freeExportList.get(0).getLoc(), ""));
                                }
                            }

                            freeExport.setName("电费");
                            freeExport.setPrice(powerPirce + "");
                            contract.getTableList55().get(m).setFreeExport(freeExport);
                        }
                    }

                    if (contract.getIsAir() == 1) {
                        List<Table> tableList66 = contract.getTableList66();
                        for (int m = 0; m < tableList66.size(); m++) {
                            Table t = tableList66.get(m);
                            FreeExport freeExport = new FreeExport();
                            List<FreeExport> freeExportList = contractService.gainMaxDegree(t.getTable2(), "air");
                            if (freeExportList.size() == 1) {
                                freeExport = freeExportList.get(0);
                                adTempList.add(new AdTemp("空调费", 0, freeExportList.get(0).getLoc(), ""));
                            } else if (freeExportList.size() == 2) {
                                try {
                                    double useDegree = Double.parseDouble(freeExportList.get(0).getDegree()) - Double.parseDouble(freeExportList.get(1).getDegree());
                                    double total = useDegree * waterPrice;
                                    allTotal += total;
                                    freeExport.setTotal(total);
                                    freeExport.setUseDegree(useDegree + "");
                                    adTempList.add(new AdTemp("空调费", total, freeExportList.get(0).getLoc(), ""));
                                } catch (Exception e) {
                                    adTempList.add(new AdTemp("空调费", 0, freeExportList.get(0).getLoc(), ""));
                                }
                            }
                            freeExport.setName("空调费");
                            freeExport.setPrice(airPrice + "");
                            contract.getTableList66().get(m).setFreeExport(freeExport);
                        }


                    }
                }

                contractListDetail.get(i).setAdTempList(adTempList);
            } else if ("ad".equals(style)) {

                table = contractListDetail.get(i).getTable11();
                tables = table.split(flag2, -1);
                size = tables[0].split(flag1, -1).length;
                payTotal = 0;
                List<AdTemp> adTempList = new ArrayList<AdTemp>();
                for (int m = 0; m < size; m++) {
                    if (!"".equals(tables[2].split(flag1, size)[m])) {
                        payTotal = Double.parseDouble(tables[2].split(flag1, size)[m]);
                        allTotal += payTotal;
                        try {
                            String dates[] = contractListDetail.get(i).getTable1().split(flag2, -1);
                            loc = dates[1].split(flag1, size)[m % 2];
                            date = dates[2].split(flag1, size)[m % 2];
                        } catch (Exception e) {

                        }
                        adTempList.add(new AdTemp("广告-租金", payTotal, loc, date));
                    }
                }


                table = contractListDetail.get(i).getTable2H();
                tables = table.split(flag2, -1);
                size = tables[0].split(flag1, -1).length;
                payTotal = 0;

                for (int m = 0; m < size; m++) {
                    if (!"".equals(tables[1].split(flag1, size)[m])) {

                        payTotal = Double.parseDouble(tables[1].split(flag1, size)[m]);
                        allTotal += payTotal;
                        adTempList.add(new AdTemp("广告-" + tables[0].split(flag1, size)[m], payTotal, "", ""));
                    }
                }

                //终止合同带来的
                if (contractListDetail.get(i).getIsPay() == 1 && contractListDetail.get(i).getIsFree() == 0) {
                    try {
                        adTempList.add(new AdTemp("广告-违约金", Double.parseDouble(contractListDetail.get(i).getPayOut()), "", ""));
                        allTotal += Double.parseDouble(contractListDetail.get(i).getPayOut());
                    } catch (Exception e) {

                    }

                }

                contractListDetail.get(i).setAdTempList(adTempList);


                ad(contractListDetail.get(i));

            } else if ("car".equals(style)) {

                table = contractListDetail.get(i).getTable11();
                tables = table.split(flag2, -1);
                size = tables[0].split(flag1, -1).length;
                payTotal = 0;
                List<AdTemp> adTempList = new ArrayList<AdTemp>();
                for (int m = 0; m < size; m++) {
                    if (!"".equals(tables[2].split(flag1, size)[m])) {
                        payTotal = Double.parseDouble(tables[2].split(flag1, size)[m]);
                        allTotal += payTotal;
                        try {
                            String dates[] = contractListDetail.get(i).getTable1().split(flag2, -1);
                            loc = dates[1].split(flag1, size)[m % 2];
                            date = dates[2].split(flag1, size)[m % 2];
                        } catch (Exception e) {

                        }
                        adTempList.add(new AdTemp("车位-租金", payTotal, loc, date));
                    }
                }


                table = contractListDetail.get(i).getTable2H();
                tables = table.split(flag2, -1);
                size = tables[0].split(flag1, -1).length;
                payTotal = 0;

                for (int m = 0; m < size; m++) {
                    if (!"".equals(tables[1].split(flag1, size)[m])) {

                        payTotal = Double.parseDouble(tables[1].split(flag1, size)[m]);
                        allTotal += payTotal;
                        adTempList.add(new AdTemp("车位-" + tables[0].split(flag1, size)[m], payTotal, "", ""));
                    }
                }
                //终止合同带来的
                if (contractListDetail.get(i).getIsPay() == 1 && contractListDetail.get(i).getIsFree() == 0) {
                    try {
                        adTempList.add(new AdTemp("车位-违约金", Double.parseDouble(contractListDetail.get(i).getPayOut()), "", ""));
                        allTotal += Double.parseDouble(contractListDetail.get(i).getPayOut());
                    } catch (Exception e) {

                    }

                }

                contractListDetail.get(i).setAdTempList(adTempList);

                car(contractListDetail.get(i));
            }
        }

        List<ContractFree> contractFreeList = handleService.gainContractFreeList(customId);
        for (ContractFree contractFree : contractFreeList) {
            allTotal += contractFree.getMoney();
        }

        model.addAttribute("contractList", contractListDetail);
        allTotal = NumberToCN.parseDouble(allTotal);
        model.addAttribute("allTotal", allTotal);
        model.addAttribute("codeAuto", codeAuto);
        model.addAttribute("remark", remark);
        model.addAttribute("debt", debt);
        model.addAttribute("tableMList", tableMList);
        model.addAttribute("tableU", tableU);
        model.addAttribute("customId", customId);
        model.addAttribute("contractFreeList", contractFreeList);

        return "handle_receivable_detail";
    }

    @RequestMapping(value = "/handle_receivable_detail/{codeAuto}/{remark}/{debt}/{contractId}/debt", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int handleReceivableDebt(Model model, HttpServletRequest request, @PathVariable("codeAuto") String codeAuto, @PathVariable("remark") String remark, @PathVariable("debt") double debt, @PathVariable("contractId") int contractId) {
        if ("fantasy".equals(remark)) {
            remark = "";
        }
        int isOk = handleService.updateDebt(codeAuto, remark, debt, contractId);
        return isOk;
    }

    @RequestMapping(value = "/handle_receivable_detail/{uuid}/tableM", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int handleReceivabledelTableM(Model model, HttpServletRequest request, @PathVariable("uuid") String uuid) {
        int isOk = handleService.delTableM(uuid);
        return isOk;
    }

    @RequestMapping(value = "/handle_receivable_detail/{codeAuto}/{remark}/{isConfirm}/{id}/{frees}/isConfirm", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int handleReceivabledelIsConfirm(Model model, HttpServletRequest request
            , @PathVariable("codeAuto") String codeAuto, @PathVariable("remark") String remark,
                                            @PathVariable("isConfirm") int isConfirm, @PathVariable("id") int id, @PathVariable("frees") String frees) {
        String flag1 = "@@";
        String flag2 = "=";
        if ("fantasy".equals(remark)) {
            remark = "";
        }
        logger.error("isConfirm:" + id + "," + isConfirm);
        int isOk = handleService.updateIsConfirmId(id, isConfirm);
        List<String> tableMList = handleService.gainTableMCustomId(id);
        String tableM = "";
        if (tableMList != null && tableMList.size() > 0) {
            tableM = tableMList.get(0);
        }
        tableM = tableM.replace("@@", "fantasy@@");
        handleService.updateTableMCustomId(tableM, id);
        handleService.updateisWaterCustomId(0, id);

        try {
            int size = frees.split(flag2)[0].split(flag1).length;
            for (int i = 0; i < size; i++) {
                String name = frees.split(flag2)[0].split(flag1)[i];
                String loc = frees.split(flag2)[1].split(flag1)[i];
                String no = frees.split(flag2)[2].split(flag1)[i];
                String money = frees.split(flag2)[3].split(flag1)[i];
                String all = name + loc + no + money;
                if (!"".equals(all)) {
                    if ("".equals(money)) {
                        money = "0";
                    }
                    handleService.insertContractFree(id, name, loc, no, Double.parseDouble(money));
                }
            }


        } catch (Exception e) {
            logger.error("contractFree:" + e.getMessage());
        }

        return isOk;
    }

    @RequestMapping(value = "/handle_receivable_detail/{codeAuto}/{remark}/{tableM}/{customId}/tableU", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int handleReceivableTableU(Model model, HttpServletRequest request, @PathVariable("codeAuto") String codeAuto, @PathVariable("remark") String remark, @PathVariable("tableM") String tableM, @PathVariable("customId") int customId) {
        if ("fantasy".equals(remark)) {
            remark = "";
        }

        int isOk = handleService.updateTableM(codeAuto, remark, tableM, customId);
        return isOk;
    }


    @RequestMapping(value = "/handle_receivable_detail/{codeAuto}/{remark}/{tableM}/{customId}/tableM", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int handleReceivableTableM(Model model, HttpServletRequest request, @PathVariable("codeAuto") String codeAuto, @PathVariable("remark") String remark, @PathVariable("tableM") String tableM, @PathVariable("customId") int customId) {
        String flag1 = "@@";
        String tableMs[] = tableM.split(flag1);
        String dateM = tableMs[0];
        String moneyM = tableMs[1];
        String contentM = tableMs[2];
        String remarkM = tableMs[3];
        String pay1 = tableMs[4];
        String pay2 = tableMs[5];
        String pay3 = tableMs[6];
        String pay4 = tableMs[7];
        String pay5 = tableMs[8];
        if ("fantasy".equals(remark)) {
            remark = "";
        }
        String uuid = CommUtil.getUUID32();

        int isOk = handleService.insertTableM(uuid, codeAuto, remark, dateM, moneyM, contentM, remarkM, pay1, pay2, pay3, pay4, customId, pay5, "");
        return isOk;
    }

    @RequestMapping(value = "/handle_table_m/{codeAuto}/{remark}/{tableM}/{contractId}/tableM", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int handleReceivableTableMPay(Model model, HttpServletRequest request, @PathVariable("codeAuto") String codeAuto, @PathVariable("remark") String remark, @PathVariable("tableM") String tableM, @PathVariable("contractId") int contractId) {
        String flag1 = "@@";
        String tableMs[] = tableM.split(flag1, -1);
        String dateM = tableMs[0];
        String moneyM = tableMs[1];
        String pay = tableMs[2];
        String payOut = tableMs[3];
        if ("fantasy".equals(remark)) {
            remark = "";
        }
        String uuid = CommUtil.getUUID32();
        handleService.delTableMContractId(contractId);
        //判断是否已经插入了,插入了更新
        TableM tableMClass = handleService.gainTableMContractId(contractId);
        if (tableMClass == null) {
            int isOk = handleService.insertTableMPay(uuid, codeAuto, remark, dateM, moneyM, contractId, pay, payOut);
        } else {
            int isOk = handleService.updateTableMPay(tableMClass.getUuid(), codeAuto, remark, dateM, moneyM, contractId, pay, payOut);
        }

        handleService.updatePayFinish(contractId, 1);
        return 1;
    }

    /**
     * @param contract tableList1
     *                 table0
     *                 table1  位置编号
     *                 table2
     *                 table3 建筑面积
     *                 table4
     *                 table5
     *                 table6 单价
     *                 table7
     *                 table8
     *                 <p>
     *                 table33  租金时间  1 0 2
     *                 table88  物业金 和 电费  (只有房源有) 0  1 2
     *                 <p>
     *                 table44 1 2 3 0
     */
    public static void house(Contract contract) {
        String flag1 = "@@";
        String flag2 = "=";
        //1,8  2, 7  2h,6   3,3  11,7 22,4 333  444 554 664  775 883
        if (contract.getTable1() != null && contract.getTable1().length() != 8) {
            String table = contract.getTable1();
            String[] tables = table.split(flag2, -1);
            int size = tables[0].split(flag1, -1).length;
            List<Table> list = new ArrayList<Table>();
            for (int i = 0; i < size; i++) {
                Table t = new Table();
                try {
                    t.setTable0(tables[0].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable1(tables[1].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable2(tables[2].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable3(tables[3].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable4(tables[4].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable5(tables[5].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable6(tables[6].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable7(tables[7].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable8(tables[8].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                String str = t.getTable0() + t.getTable1() + t.getTable2() + t.getTable3() + t.getTable4() + t.getTable5() + t.getTable6() + t.getTable7();
                if (!"".equals(str)) {
                    list.add(t);
                }

            }
            contract.setTableList1(list);
        }

        if (contract.getTable2() != null && contract.getTable2().length() != 7) {
            String table = contract.getTable2();
            String[] tables = table.split(flag2, -1);
            int size = tables[0].split(flag1, -1).length;
            List<Table> list = new ArrayList<Table>();
            for (int i = 0; i < size; i++) {
                Table t = new Table();
                try {
                    t.setTable0(tables[0].split(flag1, size)[i].split("m2")[0]);
                } catch (Exception e) {
                }
                try {
                    t.setTable1(tables[1].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable2(tables[2].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable3(tables[3].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable4(tables[4].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable5(tables[5].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable6(tables[6].split(flag1, size)[i]);
                } catch (Exception e) {
                }

                String str = t.getTable0() + t.getTable1() + t.getTable2() + t.getTable3() + t.getTable4() + t.getTable5() + t.getTable6();
                if (!"".equals(str)) {
                    list.add(t);
                }

            }
            contract.setTableList2(list);
        }
        if (contract.getTable2H() != null && contract.getTable2H().length() != 6) {
            String table = contract.getTable2H();
            String[] tables = table.split(flag2, -1);
            int size = tables[0].split(flag1, -1).length;
            List<Table> list = new ArrayList<Table>();
            for (int i = 0; i < size; i++) {
                Table t = new Table();
                try {
                    t.setTable0(tables[0].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable1(tables[1].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable2(tables[2].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable3(tables[3].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable4(tables[4].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable5(tables[5].split(flag1, size)[i]);
                } catch (Exception e) {
                }


                String str = t.getTable0() + t.getTable1() + t.getTable2() + t.getTable3() + t.getTable4() + t.getTable5();
                if (!"".equals(str)) {
                    list.add(t);
                }

            }
            contract.setTableList2H(list);
        }

        if (contract.getTable3() != null && contract.getTable3().length() != 3) {
            String table = contract.getTable3();
            String[] tables = table.split(flag2, -1);
            int size = tables[0].split(flag1, -1).length;
            List<Table> list = new ArrayList<Table>();
            for (int i = 0; i < size; i++) {
                Table t = new Table();
                try {
                    t.setTable0(tables[0].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable1(tables[1].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable2(tables[2].split(flag1, size)[i]);
                } catch (Exception e) {
                }


                String str = t.getTable0() + t.getTable1() + t.getTable2();
                if (!"".equals(str)) {
                    list.add(t);
                }

            }
            contract.setTableList3(list);
        }
        if (contract.getTable11() != null && contract.getTable11().length() != 7) {
            String table = contract.getTable11();
            String[] tables = table.split(flag2, -1);
            int size = tables[0].split(flag1, -1).length;
            List<Table> list = new ArrayList<Table>();
            for (int i = 0; i < size; i++) {
                Table t = new Table();
                try {
                    t.setTable0(tables[0].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable1(tables[1].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable2(tables[2].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable3(tables[3].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable4(tables[4].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable5(tables[5].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable6(tables[6].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable7(contract.getTableList1().get(i).getTable0());
                } catch (Exception e) {

                }
                String str = t.getTable0() + t.getTable1() + t.getTable2() + t.getTable3() + t.getTable4() + t.getTable5() + t.getTable6();
                if (!"".equals(str)) {
                    list.add(t);
                }

            }
            contract.setTableList11(list);
        }
        if (contract.getTable22() != null && contract.getTable22() != null && contract.getTable22().length() != 4) {
            String table = contract.getTable22();
            String[] tables = table.split(flag2, -1);
            int size = tables[0].split(flag1, -1).length;
            List<Table> list = new ArrayList<Table>();
            for (int i = 0; i < size; i++) {
                Table t = new Table();
                try {
                    t.setTable0(tables[0].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable1(tables[1].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable2(tables[2].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable3(tables[3].split(flag1, size)[i]);
                } catch (Exception e) {
                }

                try {
                    t.setTable4(contract.getTableList1().get(i).getTable0());
                } catch (Exception e) {

                }
                try {
                    String moneyStr = tables[2].split(flag1, size)[i];
                    String discountStr = tables[3].split(flag1, size)[i];
                    if ("".equals(moneyStr)) {
                        moneyStr = "0";
                    }
                    if ("".equals(discountStr)) {
                        discountStr = "0";
                    }
                    double md = Double.parseDouble(moneyStr) - Double.parseDouble(moneyStr) * Double.parseDouble(discountStr) / 100;
                    t.setTable5(md + "");
                } catch (Exception e) {
                }
                String str = t.getTable0() + t.getTable1() + t.getTable2() + t.getTable3();
                if (!"".equals(str)) {
                    list.add(t);
                }

            }
            contract.setTableList22(list);
        }
        if (contract.getTable33() != null && contract.getTable33().length() != 3) {
            String table = contract.getTable33();
            String[] tables = table.split(flag2, -1);
            int size = tables[0].split(flag1, -1).length;
            List<Table> list = new ArrayList<Table>();
            for (int i = 0; i < size; i++) {
                Table t = new Table();
                try {
                    t.setTable0(tables[0].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable1(tables[1].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable2(tables[2].split(flag1, size)[i]);
                } catch (Exception e) {
                }


                String str = t.getTable0() + t.getTable1() + t.getTable2();
                if (!"".equals(str)) {
                    list.add(t);
                }

            }
            contract.setTableList33(list);
        }

        if (contract.getTable44() != null && contract.getTable44().length() != 4) {
            String table = contract.getTable44();
            String[] tables = table.split(flag2, -1);
            int size = tables[0].split(flag1, -1).length;
            List<Table> list = new ArrayList<Table>();
            for (int i = 0; i < size; i++) {
                Table t = new Table();
                try {
                    t.setTable0(tables[0].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable1(tables[1].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable2(tables[2].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable3(tables[3].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable5(contract.getTableList1().get(i).getTable0());
                } catch (Exception e) {

                }

                String str = t.getTable0() + t.getTable1() + t.getTable2() + t.getTable3();
                if (!"".equals(str)) {
                    list.add(t);
                }

            }
            contract.setTableList44(list);
        }
        if (contract.getTable55() != null && contract.getTable55().length() != 4) {
            String table = contract.getTable55();
            String[] tables = table.split(flag2, -1);
            int size = tables[0].split(flag1, -1).length;
            List<Table> list = new ArrayList<Table>();
            for (int i = 0; i < size; i++) {
                Table t = new Table();
                try {
                    t.setTable0(tables[0].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable1(tables[1].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable2(tables[2].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable3(tables[3].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable5(contract.getTableList1().get(i).getTable0());
                } catch (Exception e) {

                }

                String str = t.getTable0() + t.getTable1() + t.getTable2() + t.getTable3();
                if (!"".equals(str)) {
                    list.add(t);
                }

            }
            contract.setTableList55(list);
        }
        if (contract.getTable66() != null && contract.getTable66().length() != 4) {
            String table = contract.getTable66();
            String[] tables = table.split(flag2, -1);
            int size = tables[0].split(flag1, -1).length;
            List<Table> list = new ArrayList<Table>();
            for (int i = 0; i < size; i++) {
                Table t = new Table();
                try {
                    t.setTable0(tables[0].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable1(tables[1].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable2(tables[2].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable3(tables[3].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable5(contract.getTableList1().get(i).getTable0());
                } catch (Exception e) {

                }

                String str = t.getTable0() + t.getTable1() + t.getTable2() + t.getTable3();
                if (!"".equals(str)) {
                    list.add(t);
                }

            }
            contract.setTableList66(list);
        }

        if (contract.getTable77() != null && contract.getTable77().length() != 5) {
            String table = contract.getTable77();
            String[] tables = table.split(flag2, -1);
            int size = tables[0].split(flag1, -1).length;
            List<Table> list = new ArrayList<Table>();
            for (int i = 0; i < size; i++) {
                Table t = new Table();
                try {
                    t.setTable0(tables[0].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable1(tables[1].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable2(tables[2].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable3(tables[3].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable4(tables[4].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable5(contract.getTableList1().get(i).getTable0());
                } catch (Exception e) {

                }

                String str = t.getTable0() + t.getTable1() + t.getTable2() + t.getTable3() + t.getTable4();
                if (!"".equals(str)) {
                    list.add(t);
                }

            }
            contract.setTableList77(list);
        }

        if (contract.getTable88() != null && contract.getTable88().length() != 3) {
            String table = contract.getTable88();
            String[] tables = table.split(flag2, -1);
            int size = tables[0].split(flag1, -1).length;
            List<Table> list = new ArrayList<Table>();
            for (int i = 0; i < size; i++) {
                Table t = new Table();
                try {
                    t.setTable0(tables[0].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable1(tables[1].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable2(tables[2].split(flag1, size)[i]);
                } catch (Exception e) {
                }


                String str = t.getTable0() + t.getTable1() + t.getTable2();
                if (!"".equals(str)) {
                    list.add(t);
                }

            }
            contract.setTableList88(list);
        }
    }

    public static void ad(Contract contract) {
        String flag1 = "@@";
        String flag2 = "=";
        //1,8  2, 7  2h,6   3,3  11,7 22,4 333  444 554 664  775 883
        if (contract.getTable1() != null && contract.getTable1().length() != 8) {
            String table = contract.getTable1();
            String[] tables = table.split(flag2, -1);
            int size = tables[0].split(flag1, -1).length;
            List<Table> list = new ArrayList<Table>();
            for (int i = 0; i < size; i++) {
                Table t = new Table();
                try {
                    t.setTable0(tables[0].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable1(tables[1].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable2(tables[2].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable3(tables[3].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable4(tables[4].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable5(tables[5].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable6(tables[6].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable7(tables[7].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                String str = t.getTable0() + t.getTable1() + t.getTable2() + t.getTable3() + t.getTable4() + t.getTable5() + t.getTable6() + t.getTable7();
                if (!"".equals(str)) {
                    list.add(t);
                }

            }
            contract.setTableList1(list);
        }

        if (contract.getTable2() != null && contract.getTable2().length() != 1) {
            String table = contract.getTable2();
            String[] tables = table.split(flag2, -1);
            int size = tables[0].split(flag1, -1).length;
            List<Table> list = new ArrayList<Table>();
            for (int i = 0; i < size; i++) {
                Table t = new Table();

                try {
                    t.setTable1(tables[0].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable2(tables[1].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable2(contract.getTableList1().get(i).getTable0());
                } catch (Exception e) {

                }

                String str = t.getTable0() + t.getTable1() + t.getTable2() + t.getTable3() + t.getTable4() + t.getTable5() + t.getTable6();
                if (!"".equals(str)) {
                    list.add(t);
                }

            }
            contract.setTableList2(list);
        }
        if (contract.getTable2H() != null && contract.getTable2H().length() != 2) {
            String table = contract.getTable2H();
            String[] tables = table.split(flag2, -1);
            int size = tables[0].split(flag1, -1).length;
            List<Table> list = new ArrayList<Table>();
            for (int i = 0; i < size; i++) {
                Table t = new Table();
                try {
                    t.setTable0(tables[0].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable1(tables[1].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable2(tables[2].split(flag1, size)[i]);
                } catch (Exception e) {
                }


                String str = t.getTable0() + t.getTable1() + t.getTable2() + t.getTable3() + t.getTable4() + t.getTable5();
                if (!"".equals(str)) {
                    list.add(t);
                }

            }
            contract.setTableList2H(list);
        }


        if (contract.getTable11() != null && contract.getTable11().length() != 3) {
            String table = contract.getTable11();
            String[] tables = table.split(flag2, -1);
            int size = tables[0].split(flag1, -1).length;
            List<Table> list = new ArrayList<Table>();
            for (int i = 0; i < size; i++) {
                Table t = new Table();
                try {
                    t.setTable0(tables[0].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable1(tables[1].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable2(tables[2].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable3(tables[3].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable4(contract.getTableList1().get(i).getTable0());
                } catch (Exception e) {

                }
                String str = t.getTable0() + t.getTable1() + t.getTable2() + t.getTable3() + t.getTable4() + t.getTable5() + t.getTable6();
                if (!"".equals(str)) {
                    list.add(t);
                }

            }
            contract.setTableList11(list);
        }

        if (contract.getTable33() != null && contract.getTable33().length() != 2) {
            String table = contract.getTable33();
            String[] tables = table.split(flag2, -1);
            int size = tables[0].split(flag1, -1).length;
            List<Table> list = new ArrayList<Table>();
            for (int i = 0; i < size; i++) {
                Table t = new Table();
                try {
                    t.setTable0(tables[0].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable1(tables[1].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable2(tables[2].split(flag1, size)[i]);
                } catch (Exception e) {
                }


                String str = t.getTable0() + t.getTable1() + t.getTable2();
                if (!"".equals(str)) {
                    list.add(t);
                }

            }
            contract.setTableList33(list);
        }

    }

    /**
     * table1
     * 1 loc
     * 11 no
     * 8  person
     * 9  phone
     *
     * @param contract
     */
    public static void car(Contract contract) {
        String flag1 = "@@";
        String flag2 = "=";
        //1,8  2, 7  2h,6   3,3  11,7 22,4 333  444 554 664  775 883
        if (contract.getTable1() != null && contract.getTable1().length() != 8) {
            String table = contract.getTable1();
            String[] tables = table.split(flag2, -1);
            int size = tables[0].split(flag1, -1).length;
            List<Table> list = new ArrayList<Table>();
            for (int i = 0; i < size; i++) {
                Table t = new Table();
                try {
                    t.setTable0(tables[0].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable1(tables[1].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable2(tables[2].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable3(tables[3].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable4(tables[4].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable5(tables[5].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable6(tables[6].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable7(tables[7].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable8(tables[8].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable9(tables[9].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable10(tables[10].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable11(tables[11].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                String str = t.getTable0() + t.getTable1() + t.getTable2() + t.getTable3() + t.getTable4() + t.getTable5() + t.getTable6() + t.getTable7();
                if (!"".equals(str)) {
                    list.add(t);
                }

            }
            contract.setTableList1(list);
        }

        if (contract.getTable2() != null && contract.getTable2().length() != 1) {
            String table = contract.getTable2();
            String[] tables = table.split(flag2, -1);
            int size = tables[0].split(flag1, -1).length;
            List<Table> list = new ArrayList<Table>();
            for (int i = 0; i < size; i++) {
                Table t = new Table();

                try {
                    t.setTable1(tables[0].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable2(tables[1].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable2(contract.getTableList1().get(i).getTable0());
                } catch (Exception e) {

                }

                String str = t.getTable0() + t.getTable1() + t.getTable2() + t.getTable3() + t.getTable4() + t.getTable5() + t.getTable6();
                if (!"".equals(str)) {
                    list.add(t);
                }

            }
            contract.setTableList2(list);
        }
        if (contract.getTable2H() != null && contract.getTable2H().length() != 2) {
            String table = contract.getTable2H();
            String[] tables = table.split(flag2, -1);
            int size = tables[0].split(flag1, -1).length;
            List<Table> list = new ArrayList<Table>();
            for (int i = 0; i < size; i++) {
                Table t = new Table();
                try {
                    t.setTable0(tables[0].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable1(tables[1].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable2(tables[2].split(flag1, size)[i]);
                } catch (Exception e) {
                }


                String str = t.getTable0() + t.getTable1() + t.getTable2() + t.getTable3() + t.getTable4() + t.getTable5();
                if (!"".equals(str)) {
                    list.add(t);
                }

            }
            contract.setTableList2H(list);
        }


        if (contract.getTable11() != null && contract.getTable11().length() != 3) {
            String table = contract.getTable11();
            String[] tables = table.split(flag2, -1);
            int size = tables[0].split(flag1, -1).length;
            List<Table> list = new ArrayList<Table>();
            for (int i = 0; i < size; i++) {
                Table t = new Table();
                try {
                    t.setTable0(tables[0].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable1(tables[1].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable2(tables[2].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable3(tables[3].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable4(tables[4].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable5(tables[5].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable6(contract.getTableList1().get(i).getTable0());
                } catch (Exception e) {

                }
                String str = t.getTable0() + t.getTable1() + t.getTable2() + t.getTable3() + t.getTable4() + t.getTable5() + t.getTable6();
                if (!"".equals(str)) {
                    list.add(t);
                }

            }
            contract.setTableList11(list);
        }

        if (contract.getTable33() != null && contract.getTable33().length() != 2) {
            String table = contract.getTable33();
            String[] tables = table.split(flag2, -1);
            int size = tables[0].split(flag1, -1).length;
            List<Table> list = new ArrayList<Table>();
            for (int i = 0; i < size; i++) {
                Table t = new Table();
                try {
                    t.setTable0(tables[0].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable1(tables[1].split(flag1, size)[i]);
                } catch (Exception e) {
                }
                try {
                    t.setTable2(tables[2].split(flag1, size)[i]);
                } catch (Exception e) {
                }


                String str = t.getTable0() + t.getTable1() + t.getTable2();
                if (!"".equals(str)) {
                    list.add(t);
                }

            }
            contract.setTableList33(list);
        }
    }
}

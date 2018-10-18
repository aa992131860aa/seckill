package org.seckill.web;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.seckill.entity.*;
import org.seckill.service.BaseService;
import org.seckill.service.ContractService;
import org.seckill.service.HandleService;
import org.seckill.service.StorageService;
import org.seckill.utils.*;
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
import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.math.BigDecimal;
import java.net.URLEncoder;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Controller
@RequestMapping("/seckill")
public class ContractController {
    private final Logger logger = LoggerFactory.getLogger(this.getClass());
    @Autowired
    ContractService contractService;

    @Autowired
    BaseService baseService;
    @Autowired
    HandleService handleService;
    @Autowired
    StorageService storageService;

    /**
     * 客户资源
     */

    @RequestMapping(value = "/contract_house_confirm/{userId}/{page}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String contractConfirm(Model model, HttpServletRequest request, @PathVariable("userId") int userId, @PathVariable("page") int page) {
        String role4 = baseService.getRole(userId, "role4");
        String is_admin = CommUtil.showIsAdminCookie(request);

        model.addAttribute("role4", role4);
        model.addAttribute("is_admin", is_admin);
        List<Contract> contractList = contractService.gainContractListConfirm(page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = contractService.gainContractListConfirmTotal();
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        model.addAttribute("contractList", contractList);
        model.addAttribute("total", total);
        model.addAttribute("approval", "approval");
        return "contract_house_confirm";
    }

    @RequestMapping(value = "/contract_house_cancel/{userId}/{page}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String contractCancel(Model model, HttpServletRequest request, @PathVariable("userId") int userId, @PathVariable("page") int page) {
        String role4 = baseService.getRole(userId, "role4");
        String is_admin = CommUtil.showIsAdminCookie(request);

        model.addAttribute("role4", role4);
        model.addAttribute("is_admin", is_admin);
        List<Contract> contractList = contractService.gainContractListCancel(page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = contractService.gainContractListCancelTotal();
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        model.addAttribute("contractList", contractList);
        model.addAttribute("total", total);
        model.addAttribute("approval", "approval");
        return "contract_house_cancel";
    }

    /**
     * 文件下载功能
     *
     * @param request
     * @param response
     * @throws Exception
     */
    @RequestMapping("/down")
    public void down(HttpServletRequest request, HttpServletResponse response) throws Exception {
        //模拟文件，myfile.txt为需要下载的文件
        String fileName = request.getSession().getServletContext().getRealPath("upload") + "/myfile.txt";
        //获取输入流
        InputStream bis = new BufferedInputStream(new FileInputStream(new File(fileName)));
        //假如以中文名下载的话
        String filename = "下载文件.txt";
        //转码，免得文件名中文乱码
        filename = URLEncoder.encode(filename, "UTF-8");
        //设置文件下载头
        response.addHeader("Content-Disposition", "attachment;filename=" + "bb.doc");
        //1.设置文件ContentType类型，这样设置，会自动判断下载文件类型
        response.setContentType("multipart/form-data");
        BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());
        int len = 0;
        while ((len = bis.read()) != -1) {
            out.write(len);
            out.flush();
        }
        out.close();
    }

    @RequestMapping(value = "/download/{no}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int download(Model model, HttpServletRequest request, HttpServletResponse response, @PathVariable("no") String no) throws IOException {
        String noName = no + ".doc";
        String downloadName = this.getClass().getClassLoader().getResource("/download").getPath() + noName;


        //模拟文件，myfile.txt为需要下载的文件
        //String fileName = request.getSession().getServletContext().getRealPath("upload")+"/myfile.txt";
        //获取输入流
        InputStream bis = new BufferedInputStream(new FileInputStream(new File(downloadName)));
        //假如以中文名下载的话
        String filename = "下载文件.txt";
        //转码，免得文件名中文乱码
        filename = URLEncoder.encode(downloadName, "UTF-8");
        //设置文件下载头
        response.addHeader("Content-Disposition", "attachment;filename=" + noName);
        //1.设置文件ContentType类型，这样设置，会自动判断下载文件类型
        response.setContentType("multipart/form-data");
        BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());
        int len = 0;
        while ((len = bis.read()) != -1) {
            out.write(len);
            out.flush();
        }
        out.close();

        return 1;
    }

    @RequestMapping(value = "/display", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String display(Model model, HttpServletRequest request, HttpServletResponse response) throws IOException {
        String fileName = this.getClass().getClassLoader().getResource("/download/contract.doc").getPath();
        String downloadName = this.getClass().getClassLoader().getResource("/download").getPath() + "bb.doc";
        Map<String, String> map = new HashMap<String, String>();
        map.put("${year}", "2018");
        map.put("${month}", "11");
        map.put("${day}", "21");

        WordUtil.readwriteWord(fileName, downloadName, map);


        //模拟文件，myfile.txt为需要下载的文件
        //String fileName = request.getSession().getServletContext().getRealPath("upload")+"/myfile.txt";
        //获取输入流
        InputStream bis = new BufferedInputStream(new FileInputStream(new File(downloadName)));
        //假如以中文名下载的话
        String filename = "下载文件.txt";
        //转码，免得文件名中文乱码
        filename = URLEncoder.encode(downloadName, "UTF-8");
        //设置文件下载头
        response.addHeader("Content-Disposition", "attachment;filename=" + "bb.doc");
        //1.设置文件ContentType类型，这样设置，会自动判断下载文件类型
        response.setContentType("multipart/form-data");
        BufferedOutputStream out = new BufferedOutputStream(response.getOutputStream());
        int len = 0;
        while ((len = bis.read()) != -1) {
            out.write(len);
            out.flush();
        }
        out.close();

        return "display";
    }

    @RequestMapping(value = "/contract_house_confirm/{uuid}/{isOk}/{explain}/{approval}", method = RequestMethod.POST)
    @ResponseBody
    public int customUpdateIsOk(Model model, HttpServletRequest request, @PathVariable("uuid") String uuid, @PathVariable("isOk") int isOk, @PathVariable("explain") String explain, @PathVariable("approval") String approval) {
        if ("fantasy".equals(explain)) {
            explain = "";
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String approvalDate = sdf.format(new Date());
        return contractService.updateIsOk(uuid, isOk, explain, approval, approvalDate);
    }

    @RequestMapping(value = "/contract_house/updateWater/{isWater}/{contractUuid}/{loc}/{type}", method = RequestMethod.POST)
    @ResponseBody
    public int updateContractWater(Model model, HttpServletRequest request, @PathVariable("type")String type,@PathVariable("contractUuid") String contractUuid, @PathVariable("isWater") int isWater, @PathVariable("loc") String loc) {
        if (contractUuid.equals("fantasy")) {
            contractUuid = "";
        }
        contractService.updateWaterLoc(loc,type);
        return contractService.updateContractWater(isWater, contractUuid, loc,type);

    }


    /**
     * 客户资源
     */
    @RequestMapping(value = "/contract_warn/{userId}/{page}/query", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String contractWarn(Model model, HttpServletRequest request, @PathVariable("userId") int userId, @PathVariable("page") int page) {
        String role4 = baseService.getRole(userId, "role4");
        String is_admin = CommUtil.showIsAdminCookie(request);

        model.addAttribute("role4", role4);
        model.addAttribute("is_admin", is_admin);
        List<Contract> contractList = contractService.gainCustomWarn(page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = contractService.gainCustomWarnTotal();
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        model.addAttribute("contractList", contractList);
        model.addAttribute("total", total);
        return "contract_house_warn";
    }

    /**
     * 客户资源
     */
    @RequestMapping(value = "/contract_contract_warn/{userId}/{page}/query", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String contractContractWarn(Model model, HttpServletRequest request, @PathVariable("userId") int userId, @PathVariable("page") int page) {
        String role4 = baseService.getRole(userId, "role4");
        String is_admin = CommUtil.showIsAdminCookie(request);

        model.addAttribute("role4", role4);
        model.addAttribute("is_admin", is_admin);
        List<Contract> contractList = contractService.gainContractWarn(page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = contractService.gainContractWarnTotal();
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        model.addAttribute("contractList", contractList);
        model.addAttribute("total", total);
        return "contract_warn";
    }

    /**
     * 客户资源
     */
    @RequestMapping(value = "/contract_cancel/{userId}/{page}/{export}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String contractCancel(Model model, HttpServletRequest request, @PathVariable("userId") int userId, @PathVariable("page") int page, @PathVariable("export") String export, HttpServletResponse response) {
        String role4 = baseService.getRole(userId, "role4");
        String is_admin = CommUtil.showIsAdminCookie(request);

        model.addAttribute("role4", role4);
        model.addAttribute("is_admin", is_admin);
        List<Contract> contractList = contractService.gainContractListDel("", page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = contractService.gainContractListDelTotal("");
        //获取所有支付的金额
        double payTotal = 0;
        double payTotalAll = 0;
//        for (int j = 0; j < contractList.size(); j++) {
//            payTotal = 0;
//            String flag1 = "@@";
//            String flag2 = "=";
//            String table = contractList.get(j).getTable2();
//            String[] tables = table.split(flag2, -1);
//            int size = tables[0].split(flag1, -1).length;
//            for (int m = 0; m < size; m++) {
//                if (!"".equals(tables[6].split(flag1, size)[m])) {
//                    payTotal += Double.parseDouble(tables[6].split(flag1, size)[m]);
//                }
//            }
//
//            table = contractList.get(j).getTable2H();
//            tables = table.split(flag2, -1);
//            size = tables[0].split(flag1, -1).length;
//            for (int m = 0; m < size; m++) {
//                if (!"".equals(tables[5].split(flag1, size)[m])) {
//                    payTotal += Double.parseDouble(tables[5].split(flag1, size)[m]);
//                }
//            }
//            payTotalAll += payTotal;
//            contractList.get(j).setPayTotal(payTotal);
//        }
        for (int i = 0; i < contractList.size(); i++) {
            payTotalAll += contractList.get(i).getTotal();
        }
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        model.addAttribute("contractList", contractList);
        model.addAttribute("total", total);
        model.addAttribute("payTotalAll", payTotalAll);
        if ("export".equals(export)) {
            //获取数据

            String content[][] = new String[contractList.size() + 1][];

            //excel标题
            String[] title = {"序号", "审批时间", "客户名称", "联系人", "联系电话", "合同号", "类型", "数量", "金额", "经办人"};
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
            //excel文件名
            String fileName = "终止合同报表" + sdf.format(new Date()) + ".xls";

            //sheet名
            String sheetName = "终止合同报表";

            for (int i = 0; i < contractList.size(); i++) {
                content[i] = new String[title.length];

                content[i][0] = contractList.get(i).getId() + "";
                content[i][1] = contractList.get(i).getApprovalDate();
                content[i][2] = contractList.get(i).getCodeAuto();
                content[i][3] = contractList.get(i).getLinkMan();
                content[i][4] = contractList.get(i).getPhone();
                content[i][5] = contractList.get(i).getNo();

                String style = contractList.get(i).getStyle();
                if ("house".equals(style)) {
                    content[i][6] = "房源合同";
                }
                if ("ad".equals(style)) {
                    content[i][6] = "广告合同";
                }
                if ("car".equals(style)) {
                    content[i][6] = "车位合同";
                }

                content[i][7] = 1 + "";
                content[i][8] = contractList.get(i).getPayTotal() + "";
                content[i][9] = contractList.get(i).getApproval();


            }
            content[contractList.size()] = new String[title.length];
            content[contractList.size()][0] = "合计" + "";
            content[contractList.size()][7] = contractList.size() + "";
            content[contractList.size()][8] = payTotalAll + "";

            //创建HSSFWorkbook
            HSSFWorkbook wb = ExcelUtil.getHSSFWorkbook(sheetName, title, content, null);

            //响应到客户端
            try {
                this.setResponseHeader(response, fileName);
                OutputStream os = response.getOutputStream();
                wb.write(os);
                os.flush();
                os.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return "contract_cancel";
    }


    /**
     * 客户资源
     */
    @RequestMapping(value = "/contract_house/{userId}/{page}/{export}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String contract(Model model, HttpServletRequest request, @PathVariable("userId") int userId, @PathVariable("page") int page, @PathVariable("export") String export, HttpServletResponse response) {
        String role4 = baseService.getRole(userId, "role4");
        String is_admin = CommUtil.showIsAdminCookie(request);

        model.addAttribute("role4", role4);
        model.addAttribute("is_admin", is_admin);
        List<Contract> contractList = contractService.gainContractList("house", page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = contractService.gainContractListTotal("house");
        //获取所有支付的金额
        double payTotal = 0;
        double payTotalAll = 0;
        for (int j = 0; j < contractList.size(); j++) {
            payTotal = 0;
//            String flag1 = "@@";
//            String flag2 = "=";
//            String table = contractList.get(j).getTable2();
//            String[] tables = table.split(flag2, -1);
//            int size = tables[0].split(flag1, -1).length;
//            for (int m = 0; m < size; m++) {
//                if (!"".equals(tables[6].split(flag1, size)[m])) {
//                    payTotal += Double.parseDouble(tables[6].split(flag1, size)[m]);
//                }
//            }
//
//            table = contractList.get(j).getTable2H();
//            tables = table.split(flag2, -1);
//            size = tables[0].split(flag1, -1).length;
//            for (int m = 0; m < size; m++) {
//                if (!"".equals(tables[5].split(flag1, size)[m])) {
//                    payTotal += Double.parseDouble(tables[5].split(flag1, size)[m]);
//                }
//            }

            payTotal = contractList.get(j).getTotal();
            payTotalAll += payTotal;

            contractList.get(j).setPayTotal(payTotal);
        }
        payTotalAll = NumberToCN.parseDouble(payTotalAll);
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        model.addAttribute("contractList", contractList);
        model.addAttribute("total", total);
        model.addAttribute("payTotalAll", payTotalAll);
        if ("export".equals(export)) {
            //获取数据

            String content[][] = new String[contractList.size() + 1][];

            //excel标题
            String[] title = {"序号", "审批时间", "客户名称", "联系人", "联系电话", "合同号", "审批状态", "数量", "金额", "经办人"};
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
            //excel文件名
            String fileName = "房子租赁合同报表" + sdf.format(new Date()) + ".xls";

            //sheet名
            String sheetName = "房子租赁合同报表";

            for (int i = 0; i < contractList.size(); i++) {
                content[i] = new String[title.length];

                content[i][0] = contractList.get(i).getId() + "";
                content[i][1] = contractList.get(i).getApprovalDate();
                content[i][2] = contractList.get(i).getCodeAuto();
                content[i][3] = contractList.get(i).getLinkMan();
                content[i][4] = contractList.get(i).getPhone();
                content[i][5] = contractList.get(i).getNo();

                int isOk = contractList.get(i).getIsOk();
                if (isOk == 0) {
                    content[i][6] = "审批中";
                }
                if (isOk == 1) {
                    content[i][6] = "已审批";
                }
                if (isOk == -1) {
                    content[i][6] = "已驳回";
                }

                content[i][7] = 1 + "";
                content[i][8] = contractList.get(i).getPayTotal() + "";
                content[i][9] = contractList.get(i).getApproval();


            }
            content[contractList.size()] = new String[title.length];
            content[contractList.size()][0] = "合计" + "";
            content[contractList.size()][7] = contractList.size() + "";
            content[contractList.size()][8] = payTotalAll + "";

            //创建HSSFWorkbook
            HSSFWorkbook wb = ExcelUtil.getHSSFWorkbook(sheetName, title, content, null);

            //响应到客户端
            try {
                this.setResponseHeader(response, fileName);
                OutputStream os = response.getOutputStream();
                wb.write(os);
                os.flush();
                os.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return "contract_house";
    }

    /**
     * 客户资源
     */
    @RequestMapping(value = "/contract_ad/{userId}/{page}/{export}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String contractAd(Model model, HttpServletRequest request, @PathVariable("userId") int userId, @PathVariable("page") int page, @PathVariable("export") String export, HttpServletResponse response) {
        String role4 = baseService.getRole(userId, "role4");
        String is_admin = CommUtil.showIsAdminCookie(request);

        model.addAttribute("role4", role4);
        model.addAttribute("is_admin", is_admin);
        List<Contract> contractList = contractService.gainContractList("ad", page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = contractService.gainContractListTotal("ad");
        double payTotal = 0;
        double payTotalAll = 0;
        for (int j = 0; j < contractList.size(); j++) {
            payTotal = 0;
            String flag1 = "@@";
            String flag2 = "=";
            String table = contractList.get(j).getTable11();
            String[] tables = table.split(flag2, -1);
            int size = tables[0].split(flag1, -1).length;
            for (int m = 0; m < size; m++) {
                if (!"".equals(tables[2].split(flag1, size)[m])) {
                    payTotal += Double.parseDouble(tables[2].split(flag1, size)[m]);
                }
            }

            table = contractList.get(j).getTable2H();
            tables = table.split(flag2, -1);
            size = tables[0].split(flag1, -1).length;
            for (int m = 0; m < size; m++) {
                if (!"".equals(tables[1].split(flag1, size)[m])) {
                    payTotal += Double.parseDouble(tables[1].split(flag1, size)[m]);
                }
            }
            payTotal = NumberToCN.parseDouble(payTotal);
            payTotalAll += payTotal;
            contractList.get(j).setPayTotal(payTotal);
        }
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        model.addAttribute("contractList", contractList);
        model.addAttribute("total", total);
        model.addAttribute("payTotalAll", payTotalAll);
        if ("export".equals(export)) {
            //获取数据

            String content[][] = new String[contractList.size() + 1][];

            //excel标题
            String[] title = {"序号", "审批时间", "客户名称", "联系人", "联系电话", "合同号", "审批状态", "数量", "金额", "经办人"};
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
            //excel文件名
            String fileName = "广告位合同报表" + sdf.format(new Date()) + ".xls";

            //sheet名
            String sheetName = "广告位合同报表";

            for (int i = 0; i < contractList.size(); i++) {
                content[i] = new String[title.length];

                content[i][0] = contractList.get(i).getId() + "";
                content[i][1] = contractList.get(i).getApprovalDate();
                content[i][2] = contractList.get(i).getCodeAuto();
                content[i][3] = contractList.get(i).getLinkMan();
                content[i][4] = contractList.get(i).getPhone();
                content[i][5] = contractList.get(i).getNo();

                int isOk = contractList.get(i).getIsOk();
                if (isOk == 0) {
                    content[i][6] = "审批中";
                }
                if (isOk == 1) {
                    content[i][6] = "已审批";
                }
                if (isOk == -1) {
                    content[i][6] = "已驳回";
                }

                content[i][7] = 1 + "";
                content[i][8] = contractList.get(i).getPayTotal() + "";
                content[i][9] = contractList.get(i).getApproval();


            }
            content[contractList.size()] = new String[title.length];
            content[contractList.size()][0] = "合计" + "";
            content[contractList.size()][7] = contractList.size() + "";
            content[contractList.size()][8] = payTotalAll + "";

            //创建HSSFWorkbook
            HSSFWorkbook wb = ExcelUtil.getHSSFWorkbook(sheetName, title, content, null);

            //响应到客户端
            try {
                this.setResponseHeader(response, fileName);
                OutputStream os = response.getOutputStream();
                wb.write(os);
                os.flush();
                os.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return "contract_ad";
    }

    /**
     * 客户资源
     */
    @RequestMapping(value = "/contract_car/{userId}/{page}/{export}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String contractCar(Model model, HttpServletRequest request, @PathVariable("userId") int userId, @PathVariable("page") int page, @PathVariable("export") String export, HttpServletResponse response) {
        String role4 = baseService.getRole(userId, "role4");
        String is_admin = CommUtil.showIsAdminCookie(request);

        model.addAttribute("role4", role4);
        model.addAttribute("is_admin", is_admin);
        List<Contract> contractList = contractService.gainContractList("car", page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = contractService.gainContractListTotal("car");
        double payTotal = 0;
        double payTotalAll = 0;
        for (int j = 0; j < contractList.size(); j++) {
            payTotal = 0;
            String flag1 = "@@";
            String flag2 = "=";
            String table = contractList.get(j).getTable11();
            String[] tables = table.split(flag2, -1);
            int size = tables[0].split(flag1, -1).length;
            for (int m = 0; m < size; m++) {
                if (!"".equals(tables[2].split(flag1, size)[m])) {
                    payTotal += Double.parseDouble(tables[2].split(flag1, size)[m]);
                }
            }

            table = contractList.get(j).getTable2H();
            tables = table.split(flag2, -1);
            size = tables[0].split(flag1, -1).length;
            for (int m = 0; m < size; m++) {
                if (!"".equals(tables[1].split(flag1, size)[m])) {
                    payTotal += Double.parseDouble(tables[1].split(flag1, size)[m]);
                }
            }
            payTotalAll += payTotal;
            contractList.get(j).setPayTotal(payTotal);
        }

        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        model.addAttribute("contractList", contractList);
        model.addAttribute("total", total);
        model.addAttribute("payTotalAll", payTotalAll);
        if ("export".equals(export)) {
            //获取数据

            String content[][] = new String[contractList.size() + 1][];

            //excel标题
            String[] title = {"序号", "审批时间", "客户名称", "联系人", "联系电话", "合同号", "审批状态", "数量", "金额", "经办人"};
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
            //excel文件名
            String fileName = "车位合同报表" + sdf.format(new Date()) + ".xls";

            //sheet名
            String sheetName = "车位合同报表";

            for (int i = 0; i < contractList.size(); i++) {
                content[i] = new String[title.length];

                content[i][0] = contractList.get(i).getId() + "";
                content[i][1] = contractList.get(i).getApprovalDate();
                content[i][2] = contractList.get(i).getCodeAuto();
                content[i][3] = contractList.get(i).getLinkMan();
                content[i][4] = contractList.get(i).getPhone();
                content[i][5] = contractList.get(i).getNo();

                int isOk = contractList.get(i).getIsOk();
                if (isOk == 0) {
                    content[i][6] = "审批中";
                }
                if (isOk == 1) {
                    content[i][6] = "已审批";
                }
                if (isOk == -1) {
                    content[i][6] = "已驳回";
                }

                content[i][7] = 1 + "";
                content[i][8] = contractList.get(i).getPayTotal() + "";
                content[i][9] = contractList.get(i).getApproval();


            }
            content[contractList.size()] = new String[title.length];
            content[contractList.size()][0] = "合计" + "";
            content[contractList.size()][7] = contractList.size() + "";
            content[contractList.size()][8] = payTotalAll + "";

            //创建HSSFWorkbook
            HSSFWorkbook wb = ExcelUtil.getHSSFWorkbook(sheetName, title, content, null);

            //响应到客户端
            try {
                this.setResponseHeader(response, fileName);
                OutputStream os = response.getOutputStream();
                wb.write(os);
                os.flush();
                os.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return "contract_car";
    }

    @RequestMapping(value = "/contract_house/{uuid}/del", method = RequestMethod.POST)
    @ResponseBody
    public int contractDel(Model model, HttpServletRequest request, @PathVariable("uuid") String uuid) {
        //恢复资源的闲置状态
        Contract contract = contractService.gainContract(uuid);
        HandleController.house(contract);
        if (contract != null) {
            List<Table> table1List = contract.getTableList1();
            for (int i = 0; i < table1List.size(); i++) {
                Table table = table1List.get(i);
                //contractService.updateHouse(8, table.getTable1());
            }
        }

        contractService.del(uuid);
        contractService.delTable1(uuid);
        contractService.delTable38(uuid);
        contractService.delTable77(uuid);

        return 1;
    }

    @RequestMapping(value = "/contract_house/{uuid}/update", method = RequestMethod.GET)
    public String contractUpdate(Model model, HttpServletRequest request, @PathVariable("uuid") String uuid) {

        Contract contract = contractService.gainContract(uuid);
        String flag1 = "@@";
        String flag2 = "=";
        //1,8  2, 7  2h,6   3,3  11,7 22,4 333  444 554 664  775 883
        if (contract.getTable1().length() != 8) {
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

        if (contract.getTable2().length() != 7) {
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
        if (contract.getTable2H().length() != 6) {
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

        if (contract.getTable3().length() != 3) {
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
        if (contract.getTable11().length() != 7) {
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
        if (contract.getTable22().length() != 4) {
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
                String str = t.getTable0() + t.getTable1() + t.getTable2() + t.getTable3();
                if (!"".equals(str)) {
                    list.add(t);
                }

            }
            contract.setTableList22(list);
        }
        if (contract.getTable33().length() != 3) {
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

        if (contract.getTable44().length() != 4) {
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
        if (contract.getTable55().length() != 4) {
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
        if (contract.getTable66().length() != 4) {
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

        if (contract.getTable77().length() != 5) {
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

        if (contract.getTable88().length() != 3) {
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
        List<Free> freeList = contractService.gainFree();
        for (int i = 0; i < freeList.size(); i++) {
            if (freeList.get(i).getName().contains("物业")) {
                model.addAttribute("free", freeList.get(i).getPrice());
                break;
            }
        }

        model.addAttribute("contract", contract);
        model.addAttribute("contractId", contract.getType());
        List<GoodsStatus> goodsStatusList = contractService.gainGoodsStatus();
        List<Contact> contactList = contractService.gainContact();
        Collections.reverse(goodsStatusList);
        model.addAttribute("goodsStatusList", goodsStatusList);
        model.addAttribute("contactList", contactList);
        model.addAttribute("type", "update");
        return "contract_house_add";
    }

    @RequestMapping(value = "/contract_house/{uuid}/{approval}/detail", method = RequestMethod.GET)
    public String contractDetail(Model model, HttpServletRequest request, @PathVariable("uuid") String uuid, @PathVariable("approval") String approval) throws ParseException {

        Contract contract = contractService.gainContract(uuid);
        HandleController.house(contract);
        double free = 0;
        String water = "";
        String power = "";
        String air = "";

        List<Free> freeList = contractService.gainFree();
        for (int i = 0; i < freeList.size(); i++) {
            if (freeList.get(i).getName().contains("物业")) {
                model.addAttribute("free", freeList.get(i).getPrice());
                free = Double.parseDouble(freeList.get(i).getPrice());

            }
            if (freeList.get(i).getName().contains("水")) {
                water = freeList.get(i).getPrice();
            }
            if (freeList.get(i).getName().contains("电")) {
                power = freeList.get(i).getPrice();
            }
            if (freeList.get(i).getName().contains("空调")) {
                air = freeList.get(i).getPrice();
            }

        }

        model.addAttribute("contract", contract);
        model.addAttribute("contractId", contract.getType());
        List<GoodsStatus> goodsStatusList = contractService.gainGoodsStatus();
        List<Contact> contactList = contractService.gainContact();
        model.addAttribute("goodsStatusList", goodsStatusList);
        model.addAttribute("contactList", contactList);
        model.addAttribute("type", "update");
        model.addAttribute("approval", approval);
        //写入合同
        String fileName = this.getClass().getClassLoader().getResource("/download/contract.doc").getPath();
        String downloadName = this.getClass().getClassLoader().getResource("/download").getPath() + contract.getNo() + ".doc";
        Map<String, String> map = new HashMap<String, String>();


        String startDate = contract.getStartDate();
        String endDate = contract.getEndDate();


        BigDecimal freeMoney = new BigDecimal(free);

        map.put("${year}", startDate.split("-")[0]);
        map.put("${month}", startDate.split("-")[1]);
        map.put("${day}", startDate.split("-")[2]);
        map.put("${name}", contract.getCodeAuto());

        Table table1 = contract.getTableList1().get(0);
        String loc = table1.getTable1();
        map.put("${floor}", loc.split("-")[0]);
        if (loc.split("-").length > 1)
            map.put("${floorNo}", loc.split("-")[1]);

        map.put("${buildArea}", table1.getTable3());
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        long dayTotal = (sdf.parse(endDate).getTime() - sdf.parse(startDate).getTime()) / (1000 * 60 * 60 * 24) + 1;
        map.put("${dayTotal}", dayTotal + "");
        map.put("${startYear}", startDate.split("-")[0]);
        map.put("${startMonth}", startDate.split("-")[1]);
        map.put("${startDay}", startDate.split("-")[2]);
        map.put("${endYear}", endDate.split("-")[0]);
        map.put("${endMonth}", endDate.split("-")[1]);
        map.put("${endDay}", endDate.split("-")[2]);

        double money = 0; //总的金额
        double cash = 0;      //物业保证金
        for (int i = 0; i < contract.getTableList2().size(); i++) {
            Table table2 = contract.getTableList2().get(i);
            String name = table2.getTable1();
            if ("物业保证金".equals(name)) {
                cash = Double.parseDouble(table2.getTable6());
            }
            money += Double.parseDouble(table2.getTable6());

        }
        for (int i = 0; i < contract.getTableList2H().size(); i++) {
            Table table2H = contract.getTableList2H().get(i);
            money += Double.parseDouble(table2H.getTable5());
        }
        money = NumberToCN.parseDouble(money);
        map.put("${unit}", table1.getTable6());
        map.put("${money}", money + "");
        map.put("${moneyBig}", NumberToCN.number2CNMontrayUnit(new BigDecimal(money)));
        map.put("${water}", water);
        map.put("${power}", power);
        map.put("${air}", air);
        map.put("${free}", free + "");
        map.put("${freeBig}", NumberToCN.number2CNMontrayUnit(freeMoney));
        //保证金
        map.put("${cash}", cash + "");
        map.put("${cashBig}", NumberToCN.number2CNMontrayUnit(new BigDecimal(cash)));
        map.put("${carNo}", "        ");

        WordUtil.readwriteWord(fileName, downloadName, map);
        return "contract_house_detail";
    }


    @RequestMapping(value = "/contract_house/{uuid}/{isPay}/del/{date}/{dateCount}", method = RequestMethod.GET)
    public String contractUpdateDel(Model model, HttpServletRequest request, @PathVariable("dateCount") int dateCount, @PathVariable("date") String contractEndDate, @PathVariable("uuid") String uuid, @PathVariable("isPay") int isPay) {

        //折扣房租,保证金,物业费    房间的单价   水电费
        // tableList11 table2  tableList22 table3  tableList77 table3   tableList1 table6  tableList3 table0 table1

        Contract contract = contractService.gainContract(uuid);
        HandleController.house(contract);

        String flag1 = "@@";
        String flag2 = "=";
        long day = 0;
        double allTotalOut = 0;
        long allDay = 0;
        double allTotalAll = 0;
        //1,8  2, 7  2h,6   3,3  11,7 22,4 333  444 554 664  775 883
        String endDate = contract.getEndDate();
        String startDate = contract.getStartDate();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        String nowDate = "";
        if (isPay == 0) {
            if (dateCount == 0 && (contract.getContractEnd() != null && !"".equals(contract.getContractEnd()))) {
                nowDate = contract.getContractEnd();
            } else {
                nowDate = contractEndDate;
            }

        } else {
            nowDate = contract.getContractEnd();
            contractEndDate = contract.getContractEnd();
        }
        //判断nowDate是否小于startDate

        String temp = "";
        try {
            if (sdf.parse(nowDate).getTime() < sdf.parse(startDate).getTime()) {
                nowDate = startDate;
            }
            day = (sdf.parse(endDate).getTime() - sdf.parse(nowDate).getTime()) / (1000 * 60 * 60 * 24);
            allDay = (sdf.parse(endDate).getTime() - sdf.parse(startDate).getTime()) / (1000 * 60 * 60 * 24);

        } catch (ParseException e) {
            e.printStackTrace();
        }
        //List<Free> freeList = contractService.gainFree();
        double waterPrice = 0;
        double powerPirce = 0;
        double airPrice = 0;
        double freePrice = 0;

        for (int i = 0; i < contract.getTableList3().size(); i++) {
            Table t = contract.getTableList3().get(i);
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

        List<Table> tableList44 = contract.getTableList44();

        tableList44 = contract.getTableList44();
        for (int i = 0; i < tableList44.size(); i++) {
            Table table = tableList44.get(i);
            FreeExport freeExport = new FreeExport();
            List<FreeExport> freeExportList = contractService.gainMaxDegree(table.getTable2(), "water");
            if (freeExportList.size() == 1) {
                freeExport = freeExportList.get(0);

            } else if (freeExportList.size() == 2) {
                try {
                    double useDegree = Double.parseDouble(freeExportList.get(0).getDegree()) - Double.parseDouble(freeExportList.get(1).getDegree());
                    double total = useDegree * waterPrice;
                    freeExport.setTotal(total);
                    freeExport.setUseDegree(useDegree + "");
                    allTotalOut += total;
                } catch (Exception e) {

                }
            }

            freeExport.setName("水费");
            freeExport.setPrice(waterPrice + "");

            contract.getTableList44().get(i).setFreeExport(freeExport);

        }

        List<Table> tableList55 = contract.getTableList55();
        for (int i = 0; i < tableList55.size(); i++) {
            Table table = tableList55.get(i);
            FreeExport freeExport = new FreeExport();
            List<FreeExport> freeExportList = contractService.gainMaxDegree(table.getTable2(), "power");
            if (freeExportList.size() == 1) {
                freeExport = freeExportList.get(0);

            } else if (freeExportList.size() == 2) {
                try {
                    double useDegree = Double.parseDouble(freeExportList.get(0).getDegree()) - Double.parseDouble(freeExportList.get(1).getDegree());
                    double total = useDegree * waterPrice;
                    freeExport.setTotal(total);
                    freeExport.setUseDegree(useDegree + "");
                    allTotalOut += total;
                } catch (Exception e) {

                }
            }
            freeExport.setName("电费");
            freeExport.setPrice(powerPirce + "");
            contract.getTableList55().get(i).setFreeExport(freeExport);
        }
        List<Table> tableList66 = contract.getTableList66();
        for (int i = 0; i < tableList66.size(); i++) {
            Table table = tableList66.get(i);
            FreeExport freeExport = new FreeExport();
            List<FreeExport> freeExportList = contractService.gainMaxDegree(table.getTable2(), "air");
            if (freeExportList.size() == 1) {
                freeExport = freeExportList.get(0);

            } else if (freeExportList.size() == 2) {
                try {
                    double useDegree = Double.parseDouble(freeExportList.get(0).getDegree()) - Double.parseDouble(freeExportList.get(1).getDegree());
                    double total = useDegree * waterPrice;
                    freeExport.setTotal(total);
                    freeExport.setUseDegree(useDegree + "");
                    allTotalOut += total;
                } catch (Exception e) {

                }
            }
            freeExport.setName("空调费");
            freeExport.setPrice(airPrice + "");
            contract.getTableList66().get(i).setFreeExport(freeExport);
        }

        String table = contract.getTable2();
        String[] tables = table.split(flag2, -1);
        int size = tables[0].split(flag1, -1).length;
        double payTotal = 0;
        double allTotal = 0;
        String loc = "";
        String date = "";
        String buildArea = "";
        String price = "";
        List<AdTemp> adTempList = new ArrayList<AdTemp>();

        //折扣房租,保证金,物业费    房间的单价   水电费
        // tableList11 table2 table3(建筑面积)  tableList22 table3  tableList77 table3   tableList1 table6  tableList3 table0 table1
        double totalBuild = 0;


        //租金
        for (int m = 0; m < contract.getTableList11().size(); m++) {
            Table t = contract.getTableList11().get(m);
            price = contract.getTableList1().get(m).getTable6();
            totalBuild += Double.parseDouble(t.getTable0());
            buildArea = t.getTable0();
            loc = contract.getTableList1().get(m).getTable1();

            double discount = 0;
            try {
                discount = Double.parseDouble(t.getTable2());
            } catch (Exception e) {

            }

            try {
                payTotal = day * Double.parseDouble(buildArea) * Double.parseDouble(price) - day * Double.parseDouble(buildArea) * Double.parseDouble(price) * discount / 100;
                payTotal = NumberToCN.parseDouble(payTotal);
                allTotal += payTotal;
                allTotalAll += allDay * Double.parseDouble(buildArea) * Double.parseDouble(price) - allDay * Double.parseDouble(buildArea) * Double.parseDouble(price) * discount / 100;
                allTotalAll = NumberToCN.parseDouble(allTotalAll);
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
                allTotalAll += Double.parseDouble(t.getTable2()) - Double.parseDouble(t.getTable2()) * discount / 100;
                allTotalAll = NumberToCN.parseDouble(allTotalAll);
            } catch (Exception e) {

            }
            adTempList.add(new AdTemp("房源-物业保证金", payTotal, loc, date, "", "", day));
        }

        //折扣房租,保证金,物业费    房间的单价   水电费
        // tableList11 table2 table3(建筑面积)  tableList22 table3  tableList77 table3   tableList1 table6  tableList3 table0 table1

        //物业费
        for (int m = 0; m < contract.getTableList77().size(); m++) {
            Table t = contract.getTableList77().get(m);


            double discount = 0;
            try {
                discount = Double.parseDouble(t.getTable3());
            } catch (Exception e) {

            }

            try {
                payTotal = day * totalBuild * freePrice - day * totalBuild * freePrice * discount / 100;
                payTotal = NumberToCN.parseDouble(payTotal);
                allTotal += payTotal;
                allTotalAll += allDay * totalBuild * freePrice - allDay * totalBuild * freePrice * discount / 100;
                allTotalAll = NumberToCN.parseDouble(allTotalAll);
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
                allTotalAll += payTotal;

                adTempList.add(new AdTemp("房源-" + tables[0].split(flag1, size)[m], payTotal, "", "", "", "", day));
            }
        }

        contract.setAdTempList(adTempList);
        allTotalAll = NumberToCN.parseDouble(allTotalAll);
        allTotal = NumberToCN.parseDouble(allTotal);
        allTotalOut = NumberToCN.parseDouble(allTotalOut);
        //HandleController.house(contract);
        model.addAttribute("allTotalAll", allTotalAll);
        model.addAttribute("allTotal", allTotal);
        model.addAttribute("allTotalOut", allTotalOut);
        model.addAttribute("contract", contract);
        model.addAttribute("contractId", contract.getType());
        List<GoodsStatus> goodsStatusList = contractService.gainGoodsStatus();
        List<Contact> contactList = contractService.gainContact();
        model.addAttribute("goodsStatusList", goodsStatusList);
        model.addAttribute("contactList", contactList);
        model.addAttribute("type", "del");
        model.addAttribute("isPay", isPay);
        model.addAttribute("uuid", uuid);
        model.addAttribute("contractEndDate", contractEndDate);
        dateCount++;
        model.addAttribute("dateCount", dateCount);
        return "contract_house_del";
    }

    @RequestMapping(value = "/contract_house_pay/{uuid}/del", method = RequestMethod.GET)
    public String contractUpdateDelPay(Model model, HttpServletRequest request, @PathVariable("uuid") String uuid) {

        //折扣房租,保证金,物业费    房间的单价   水电费
        // tableList11 table2  tableList22 table3  tableList77 table3   tableList1 table6  tableList3 table0 table1

        Contract contract = contractService.gainContract(uuid);
        HandleController.house(contract);

        String flag1 = "@@";
        String flag2 = "=";
        long day = 0;
        double allTotalOut = 0;
        long allDay = 0;
        double allTotalAll = 0;
        //1,8  2, 7  2h,6   3,3  11,7 22,4 333  444 554 664  775 883
        String endDate = contract.getEndDate();
        String startDate = contract.getStartDate();
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");

        String nowDate = contract.getContractEnd();

        //判断nowDate是否小于startDate

        String temp = "";
        try {
            if (sdf.parse(nowDate).getTime() < sdf.parse(startDate).getTime()) {
                nowDate = startDate;
            }
            day = (sdf.parse(endDate).getTime() - sdf.parse(nowDate).getTime()) / (1000 * 60 * 60 * 24);
            allDay = (sdf.parse(endDate).getTime() - sdf.parse(startDate).getTime()) / (1000 * 60 * 60 * 24);

        } catch (ParseException e) {
            e.printStackTrace();
        }
        //List<Free> freeList = contractService.gainFree();
        double waterPrice = 0;
        double powerPirce = 0;
        double airPrice = 0;
        double freePrice = 0;

        for (int i = 0; i < contract.getTableList3().size(); i++) {
            Table t = contract.getTableList3().get(i);
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

        List<Table> tableList44 = contract.getTableList44();

        tableList44 = contract.getTableList44();
        for (int i = 0; i < tableList44.size(); i++) {
            Table table = tableList44.get(i);
            FreeExport freeExport = new FreeExport();
            List<FreeExport> freeExportList = contractService.gainMaxDegree(table.getTable2(), "water");
            if (freeExportList.size() == 1) {
                freeExport = freeExportList.get(0);

            } else if (freeExportList.size() == 2) {
                try {
                    double useDegree = Double.parseDouble(freeExportList.get(0).getDegree()) - Double.parseDouble(freeExportList.get(1).getDegree());
                    double total = useDegree * waterPrice;
                    freeExport.setTotal(total);
                    freeExport.setUseDegree(useDegree + "");
                    allTotalOut += total;
                } catch (Exception e) {

                }
            }

            freeExport.setName("水费");
            freeExport.setPrice(waterPrice + "");

            contract.getTableList44().get(i).setFreeExport(freeExport);

        }

        List<Table> tableList55 = contract.getTableList55();
        for (int i = 0; i < tableList55.size(); i++) {
            Table table = tableList55.get(i);
            FreeExport freeExport = new FreeExport();
            List<FreeExport> freeExportList = contractService.gainMaxDegree(table.getTable2(), "power");
            if (freeExportList.size() == 1) {
                freeExport = freeExportList.get(0);

            } else if (freeExportList.size() == 2) {
                try {
                    double useDegree = Double.parseDouble(freeExportList.get(0).getDegree()) - Double.parseDouble(freeExportList.get(1).getDegree());
                    double total = useDegree * waterPrice;
                    freeExport.setTotal(total);
                    freeExport.setUseDegree(useDegree + "");
                    allTotalOut += total;
                } catch (Exception e) {

                }
            }
            freeExport.setName("电费");
            freeExport.setPrice(powerPirce + "");
            contract.getTableList55().get(i).setFreeExport(freeExport);
        }
        List<Table> tableList66 = contract.getTableList66();
        for (int i = 0; i < tableList66.size(); i++) {
            Table table = tableList66.get(i);
            FreeExport freeExport = new FreeExport();
            List<FreeExport> freeExportList = contractService.gainMaxDegree(table.getTable2(), "air");
            if (freeExportList.size() == 1) {
                freeExport = freeExportList.get(0);

            } else if (freeExportList.size() == 2) {
                try {
                    double useDegree = Double.parseDouble(freeExportList.get(0).getDegree()) - Double.parseDouble(freeExportList.get(1).getDegree());
                    double total = useDegree * waterPrice;
                    freeExport.setTotal(total);
                    freeExport.setUseDegree(useDegree + "");
                    allTotalOut += total;
                } catch (Exception e) {

                }
            }
            freeExport.setName("空调费");
            freeExport.setPrice(airPrice + "");
            contract.getTableList66().get(i).setFreeExport(freeExport);
        }

        String table = contract.getTable2();
        String[] tables = table.split(flag2, -1);
        int size = tables[0].split(flag1, -1).length;
        double payTotal = 0;
        double allTotal = 0;
        String loc = "";
        String date = "";
        String buildArea = "";
        String price = "";
        List<AdTemp> adTempList = new ArrayList<AdTemp>();

        //折扣房租,保证金,物业费    房间的单价   水电费
        // tableList11 table2 table3(建筑面积)  tableList22 table3  tableList77 table3   tableList1 table6  tableList3 table0 table1
        double totalBuild = 0;


        //租金
        for (int m = 0; m < contract.getTableList11().size(); m++) {
            Table t = contract.getTableList11().get(m);
            price = contract.getTableList1().get(m).getTable6();
            totalBuild += Double.parseDouble(t.getTable0());
            buildArea = t.getTable0();
            loc = contract.getTableList1().get(m).getTable1();

            double discount = 0;
            try {
                discount = Double.parseDouble(t.getTable2());
            } catch (Exception e) {

            }

            try {
                payTotal = day * Double.parseDouble(buildArea) * Double.parseDouble(price) - day * Double.parseDouble(buildArea) * Double.parseDouble(price) * discount / 100;
                payTotal = NumberToCN.parseDouble(payTotal);
                allTotal += payTotal;
                allTotalAll += allDay * Double.parseDouble(buildArea) * Double.parseDouble(price) - allDay * Double.parseDouble(buildArea) * Double.parseDouble(price) * discount / 100;
                allTotalAll = NumberToCN.parseDouble(allTotalAll);
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
                allTotalAll += Double.parseDouble(t.getTable2()) - Double.parseDouble(t.getTable2()) * discount / 100;
                allTotalAll = NumberToCN.parseDouble(allTotalAll);
            } catch (Exception e) {

            }
            adTempList.add(new AdTemp("房源-物业保证金", payTotal, loc, date, "", "", day));
        }

        //折扣房租,保证金,物业费    房间的单价   水电费
        // tableList11 table2 table3(建筑面积)  tableList22 table3  tableList77 table3   tableList1 table6  tableList3 table0 table1

        //物业费
        for (int m = 0; m < contract.getTableList77().size(); m++) {
            Table t = contract.getTableList77().get(m);


            double discount = 0;
            try {
                discount = Double.parseDouble(t.getTable3());
            } catch (Exception e) {

            }

            try {
                payTotal = day * totalBuild * freePrice - day * totalBuild * freePrice * discount / 100;
                payTotal = NumberToCN.parseDouble(payTotal);
                allTotal += payTotal;
                allTotalAll += allDay * totalBuild * freePrice - allDay * totalBuild * freePrice * discount / 100;
                allTotalAll = NumberToCN.parseDouble(allTotalAll);
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
                allTotalAll += payTotal;

                adTempList.add(new AdTemp("房源-" + tables[0].split(flag1, size)[m], payTotal, "", "", "", "", day));
            }
        }

        contract.setAdTempList(adTempList);
        allTotalAll = NumberToCN.parseDouble(allTotalAll);
        allTotal = NumberToCN.parseDouble(allTotal);
        allTotalOut = NumberToCN.parseDouble(allTotalOut);
        //HandleController.house(contract);
        model.addAttribute("allTotalAll", allTotalAll);
        model.addAttribute("allTotal", allTotal);
        model.addAttribute("allTotalOut", allTotalOut);
        model.addAttribute("contract", contract);
        model.addAttribute("contractId", contract.getType());
        List<GoodsStatus> goodsStatusList = contractService.gainGoodsStatus();
        List<Contact> contactList = contractService.gainContact();
        model.addAttribute("goodsStatusList", goodsStatusList);
        model.addAttribute("contactList", contactList);
        model.addAttribute("type", "del");

        model.addAttribute("uuid", uuid);


        TableM tableM = handleService.gainTableMContractId(contract.getId());
        model.addAttribute("tableM", tableM);
        return "contract_house_del_pay";
    }

    @RequestMapping(value = "/contract_ad/{uuid}/{isPay}/del/{date}/{dateCount}", method = RequestMethod.GET)
    public String contractAdUpdateDel(Model model, HttpServletRequest request, @PathVariable("date") String contractEndDate, @PathVariable("dateCount") int dateCount, @PathVariable("uuid") String uuid, @PathVariable("isPay") int isPay) {

        Contract contract = contractService.gainContract(uuid);
        String flag1 = "@@";
        String flag2 = "=";
        //1,8  2, 7  2h,6   3,3  11,7 22,4 333  444 554 664  775 883
        String nowDate = "";
        if (isPay == 0) {
            if (dateCount == 0 && (contract.getContractEnd() != null && !"".equals(contract.getContractEnd()))) {
                nowDate = contract.getContractEnd();
            } else {
                nowDate = contractEndDate;
            }

        } else {
            nowDate = contract.getContractEnd();

        }

        String table = contract.getTable11();
        String[] tables = table.split(flag2, -1);
        int size = tables[0].split(flag1, -1).length;
        double payTotal = 0;
        double allTotal = 0;
        String loc = "";
        String date = "";
        List<AdTemp> adTempList = new ArrayList<AdTemp>();
        for (int m = 0; m < size; m++) {
            if (!"".equals(tables[2].split(flag1, size)[m])) {
                payTotal = Double.parseDouble(tables[2].split(flag1, size)[m]);
                allTotal += payTotal;
                try {
                    String dates[] = contract.getTable1().split(flag2, -1);
                    loc = dates[1].split(flag1, size)[m % 2];
                    date = dates[2].split(flag1, size)[m % 2];
                } catch (Exception e) {

                }
                adTempList.add(new AdTemp("广告-租金", payTotal, loc, date));
            }
        }


        table = contract.getTable2H();
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

        contract.setAdTempList(adTempList);

        HandleController.ad(contract);

        model.addAttribute("allTotal", allTotal);
        model.addAttribute("contract", contract);
        model.addAttribute("contractId", contract.getType());
        List<GoodsStatus> goodsStatusList = contractService.gainGoodsStatus();
        List<Contact> contactList = contractService.gainContact();
        model.addAttribute("goodsStatusList", goodsStatusList);
        model.addAttribute("contactList", contactList);
        model.addAttribute("type", "del");
        model.addAttribute("isPay", isPay);
        dateCount++;
        model.addAttribute("dateCount", dateCount);
        model.addAttribute("contractEndDate", nowDate);
        return "contract_ad_del";
    }

    @RequestMapping(value = "/contract_ad_pay/{uuid}/del", method = RequestMethod.GET)
    public String contractAdUpdateDelPay(Model model, HttpServletRequest request, @PathVariable("uuid") String uuid) {

        Contract contract = contractService.gainContract(uuid);
        String flag1 = "@@";
        String flag2 = "=";
        //1,8  2, 7  2h,6   3,3  11,7 22,4 333  444 554 664  775 883


        String table = contract.getTable11();
        String[] tables = table.split(flag2, -1);
        int size = tables[0].split(flag1, -1).length;
        double payTotal = 0;
        double allTotal = 0;
        String loc = "";
        String date = "";
        List<AdTemp> adTempList = new ArrayList<AdTemp>();
        for (int m = 0; m < size; m++) {
            if (!"".equals(tables[2].split(flag1, size)[m])) {
                payTotal = Double.parseDouble(tables[2].split(flag1, size)[m]);
                allTotal += payTotal;
                try {
                    String dates[] = contract.getTable1().split(flag2, -1);
                    loc = dates[1].split(flag1, size)[m % 2];
                    date = dates[2].split(flag1, size)[m % 2];
                } catch (Exception e) {

                }
                adTempList.add(new AdTemp("广告-租金", payTotal, loc, date));
            }
        }


        table = contract.getTable2H();
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

        contract.setAdTempList(adTempList);

        HandleController.ad(contract);
        List<TableM> tableMList = handleService.gainTableMList(contract.getId(), "", "");
        if (tableMList.size() > 0) {
            model.addAttribute("tableM", tableMList.get(tableMList.size() - 1));
        } else {
            model.addAttribute("tableM", new TableM());
        }
        model.addAttribute("allTotal", allTotal);
        model.addAttribute("contract", contract);
        model.addAttribute("contractId", contract.getType());
        List<GoodsStatus> goodsStatusList = contractService.gainGoodsStatus();
        List<Contact> contactList = contractService.gainContact();
        model.addAttribute("goodsStatusList", goodsStatusList);
        model.addAttribute("contactList", contactList);
        model.addAttribute("type", "del");
        return "contract_ad_del_pay";
    }

    @RequestMapping(value = "/contract_car/{uuid}/{isPay}/del/{date}/{dateCount}", method = RequestMethod.GET)
    public String contractCarUpdateDel(Model model, HttpServletRequest request, @PathVariable("date") String contractEndDate, @PathVariable("dateCount") int dateCount, @PathVariable("uuid") String uuid, @PathVariable("isPay") int isPay) {

        Contract contract = contractService.gainContract(uuid);
        String flag1 = "@@";
        String flag2 = "=";
        //1,8  2, 7  2h,6   3,3  11,7 22,4 333  444 554 664  775 883
        String nowDate = "";
        if (isPay == 0) {
            if (dateCount == 0 && (contract.getContractEnd() != null && !"".equals(contract.getContractEnd()))) {
                nowDate = contract.getContractEnd();
            } else {
                nowDate = contractEndDate;
            }

        } else {
            nowDate = contract.getContractEnd();

        }

        String table = contract.getTable11();
        String[] tables = table.split(flag2, -1);
        int size = tables[0].split(flag1, -1).length;
        double payTotal = 0;
        double allTotal = 0;
        String loc = "";
        String date = "";
        List<AdTemp> adTempList = new ArrayList<AdTemp>();
        for (int m = 0; m < size; m++) {
            if (!"".equals(tables[2].split(flag1, size)[m])) {
                payTotal = Double.parseDouble(tables[2].split(flag1, size)[m]);
                allTotal += payTotal;
                try {
                    String dates[] = contract.getTable1().split(flag2, -1);
                    loc = dates[1].split(flag1, size)[m % 2];
                    date = dates[2].split(flag1, size)[m % 2];
                } catch (Exception e) {

                }
                adTempList.add(new AdTemp("车位-租金", payTotal, loc, date));
            }
        }


        table = contract.getTable2H();
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


        contract.setAdTempList(adTempList);

        HandleController.car(contract);

        model.addAttribute("allTotal", allTotal);
        model.addAttribute("contract", contract);
        model.addAttribute("contractId", contract.getType());
        List<GoodsStatus> goodsStatusList = contractService.gainGoodsStatus();
        List<Contact> contactList = contractService.gainContact();
        model.addAttribute("goodsStatusList", goodsStatusList);
        model.addAttribute("contactList", contactList);
        model.addAttribute("type", "del");
        model.addAttribute("isPay", isPay);
        dateCount++;
        model.addAttribute("dateCount", dateCount);
        model.addAttribute("contractEndDate", nowDate);
        return "contract_car_del";
    }

    @RequestMapping(value = "/contract_car_pay/{uuid}/del", method = RequestMethod.GET)
    public String contractCarUpdateDelPay(Model model, HttpServletRequest request, @PathVariable("uuid") String uuid) {

        Contract contract = contractService.gainContract(uuid);
        String flag1 = "@@";
        String flag2 = "=";
        //1,8  2, 7  2h,6   3,3  11,7 22,4 333  444 554 664  775 883


        String table = contract.getTable11();
        String[] tables = table.split(flag2, -1);
        int size = tables[0].split(flag1, -1).length;
        double payTotal = 0;
        double allTotal = 0;
        String loc = "";
        String date = "";
        List<AdTemp> adTempList = new ArrayList<AdTemp>();
        for (int m = 0; m < size; m++) {
            if (!"".equals(tables[2].split(flag1, size)[m])) {
                payTotal = Double.parseDouble(tables[2].split(flag1, size)[m]);
                allTotal += payTotal;
                try {
                    String dates[] = contract.getTable1().split(flag2, -1);
                    loc = dates[1].split(flag1, size)[m % 2];
                    date = dates[2].split(flag1, size)[m % 2];
                } catch (Exception e) {

                }
                adTempList.add(new AdTemp("车位-租金", payTotal, loc, date));
            }
        }


        table = contract.getTable2H();
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


        contract.setAdTempList(adTempList);

        HandleController.car(contract);
        List<TableM> tableMList = handleService.gainTableMList(contract.getId(), "", "");
        if (tableMList.size() > 0) {
            model.addAttribute("tableM", tableMList.get(tableMList.size() - 1));
        } else {
            model.addAttribute("tableM", new TableM());
        }
        model.addAttribute("allTotal", allTotal);
        model.addAttribute("contract", contract);
        model.addAttribute("contractId", contract.getType());
        List<GoodsStatus> goodsStatusList = contractService.gainGoodsStatus();
        List<Contact> contactList = contractService.gainContact();
        model.addAttribute("goodsStatusList", goodsStatusList);
        model.addAttribute("contactList", contactList);
        model.addAttribute("type", "del");
        return "contract_car_del_pay";
    }

    @RequestMapping(value = "/contract_ad/{uuid}/update", method = RequestMethod.GET)
    public String contractAdUpdate(Model model, HttpServletRequest request, @PathVariable("uuid") String uuid) {

        Contract contract = contractService.gainContract(uuid);
        HandleController.house(contract);


        List<Free> freeList = contractService.gainFree();
        for (int i = 0; i < freeList.size(); i++) {
            if (freeList.get(i).getName().contains("物业")) {
                model.addAttribute("free", freeList.get(i).getPrice());
                break;
            }
        }

        model.addAttribute("contract", contract);
        model.addAttribute("contractId", contract.getType());
        List<GoodsStatus> goodsStatusList = contractService.gainGoodsStatus();
        List<Contact> contactList = contractService.gainContact();
        Collections.reverse(goodsStatusList);
        model.addAttribute("goodsStatusList", goodsStatusList);
        model.addAttribute("contactList", contactList);
        model.addAttribute("type", "update");
        return "contract_ad_add";
    }

    @RequestMapping(value = "/contract_ad/{uuid}/{approval}/detail", method = RequestMethod.GET)
    public String contractAdDetail(Model model, HttpServletRequest request, @PathVariable("uuid") String uuid, @PathVariable("approval") String approval) {

        Contract contract = contractService.gainContract(uuid);
        HandleController.ad(contract);


        List<Free> freeList = contractService.gainFree();
        for (int i = 0; i < freeList.size(); i++) {
            if (freeList.get(i).getName().contains("物业")) {
                model.addAttribute("free", freeList.get(i).getPrice());
                break;
            }
        }

        model.addAttribute("contract", contract);
        model.addAttribute("contractId", contract.getType());
        List<GoodsStatus> goodsStatusList = contractService.gainGoodsStatus();
        List<Contact> contactList = contractService.gainContact();
        model.addAttribute("goodsStatusList", goodsStatusList);
        model.addAttribute("contactList", contactList);
        model.addAttribute("type", "update");
        model.addAttribute("approval", approval);
        return "contract_ad_detail";
    }

    @RequestMapping(value = "/contract_car/{uuid}/update", method = RequestMethod.GET)
    public String contractCarUpdate(Model model, HttpServletRequest request, @PathVariable("uuid") String uuid) {

        Contract contract = contractService.gainContract(uuid);
        HandleController.car(contract);
        List<CarReg> carRegList = null;
        List<Custom> customList = storageService.gainCustomById(contract.getCustomId());
        for (int i = 0; i < customList.size(); i++) {
            carRegList = storageService.gainCarReg(customList.get(i).getUuid());
            customList.get(i).setCarRegList(carRegList);
        }
        if (carRegList == null) {
            carRegList = new ArrayList<CarReg>();
        }
        carRegList.add(0, new CarReg());


        model.addAttribute("contract", contract);
        model.addAttribute("contractId", contract.getType());
        List<GoodsStatus> goodsStatusList = contractService.gainGoodsStatus();
        List<Contact> contactList = contractService.gainContact();
        Collections.reverse(goodsStatusList);
        model.addAttribute("goodsStatusList", goodsStatusList);
        model.addAttribute("contactList", contactList);
        model.addAttribute("type", "update");
        model.addAttribute("customList", customList);
        model.addAttribute("carRegList", carRegList);
        model.addAttribute("custom", customList.get(0));
        return "contract_car_add";
    }

    @RequestMapping(value = "/contract_car/{uuid}/{approval}/detail", method = RequestMethod.GET)
    public String contractCarDetail(Model model, HttpServletRequest request, @PathVariable("uuid") String uuid, @PathVariable("approval") String approval) {

        Contract contract = contractService.gainContract(uuid);
        HandleController.car(contract);


        model.addAttribute("contract", contract);
        model.addAttribute("contractId", contract.getType());
        List<GoodsStatus> goodsStatusList = contractService.gainGoodsStatus();
        List<Contact> contactList = contractService.gainContact();
        model.addAttribute("goodsStatusList", goodsStatusList);
        model.addAttribute("contactList", contactList);
        model.addAttribute("type", "update");
        model.addAttribute("approval", approval);
        return "contract_car_detail";
    }

    @RequestMapping(value = "/contract_house/{uuid}/{approval}/energy", method = RequestMethod.GET)
    public String contractCarEnergy(Model model, HttpServletRequest request, @PathVariable("uuid") String uuid, @PathVariable("approval") String approval) {

        Contract contract = contractService.gainContract(uuid);
        HandleController.house(contract);
        List<Free> freeList = contractService.gainFree();
        double waterPrice = 0;
        double powerPirce = 0;
        double airPrice = 0;
        for (int i = 0; i < freeList.size(); i++) {
            if (freeList.get(i).getName().contains("物业")) {
                model.addAttribute("free", freeList.get(i).getPrice());


            }
            if (freeList.get(i).getName().contains("水")) {
                model.addAttribute("water", freeList.get(i).getPrice());
                waterPrice = Double.parseDouble(freeList.get(i).getPrice());


            }
            if (freeList.get(i).getName().contains("电")) {
                model.addAttribute("power", freeList.get(i).getPrice());
                powerPirce = Double.parseDouble(freeList.get(i).getPrice());


            }
            if (freeList.get(i).getName().contains("空调")) {
                model.addAttribute("air", freeList.get(i).getPrice());
                airPrice = Double.parseDouble(freeList.get(i).getPrice());
            }

        }
        List<Table> tableList44 = contract.getTableList44();
        for (int i = 0; i < tableList44.size(); i++) {
            Table table = tableList44.get(i);
            FreeExport freeExport = new FreeExport();
            List<FreeExport> freeExportList = contractService.gainMaxDegree(table.getTable2(), "water");
            if (freeExportList.size() == 1) {
                freeExport = freeExportList.get(0);

            } else if (freeExportList.size() == 2) {
                try {
                    double useDegree = Double.parseDouble(freeExportList.get(0).getDegree()) - Double.parseDouble(freeExportList.get(1).getDegree());
                    double total = useDegree * waterPrice;
                    freeExport.setTotal(total);
                    freeExport.setUseDegree(useDegree + "");

                } catch (Exception e) {

                }
            }
            contract.getTableList44().get(i).setFreeExport(freeExport);
        }
        List<Table> tableList55 = contract.getTableList55();
        for (int i = 0; i < tableList55.size(); i++) {
            Table table = tableList55.get(i);
            FreeExport freeExport = new FreeExport();
            List<FreeExport> freeExportList = contractService.gainMaxDegree(table.getTable2(), "power");
            if (freeExportList.size() == 1) {
                freeExport = freeExportList.get(0);

            } else if (freeExportList.size() == 2) {
                try {
                    double useDegree = Double.parseDouble(freeExportList.get(0).getDegree()) - Double.parseDouble(freeExportList.get(1).getDegree());
                    double total = useDegree * waterPrice;
                    freeExport.setTotal(total);
                    freeExport.setUseDegree(useDegree + "");

                } catch (Exception e) {

                }
            }
            contract.getTableList55().get(i).setFreeExport(freeExport);
        }
        List<Table> tableList66 = contract.getTableList66();
        for (int i = 0; i < tableList66.size(); i++) {
            Table table = tableList66.get(i);
            FreeExport freeExport = new FreeExport();
            List<FreeExport> freeExportList = contractService.gainMaxDegree(table.getTable2(), "air");
            if (freeExportList.size() == 1) {
                freeExport = freeExportList.get(0);

            } else if (freeExportList.size() == 2) {
                try {
                    double useDegree = Double.parseDouble(freeExportList.get(0).getDegree()) - Double.parseDouble(freeExportList.get(1).getDegree());
                    double total = useDegree * waterPrice;
                    freeExport.setTotal(total);
                    freeExport.setUseDegree(useDegree + "");

                } catch (Exception e) {

                }
            }
            contract.getTableList66().get(i).setFreeExport(freeExport);
        }


        model.addAttribute("contract", contract);
        model.addAttribute("contractId", contract.getType());
        List<GoodsStatus> goodsStatusList = contractService.gainGoodsStatus();
        List<Contact> contactList = contractService.gainContact();
        model.addAttribute("goodsStatusList", goodsStatusList);
        model.addAttribute("contactList", contactList);
        model.addAttribute("type", "update");
        model.addAttribute("approval", approval);

        return "contract_house_energy";
    }

    /**
     * 客户资源
     */
    @RequestMapping(value = "/contract_house_cancel/{userId}/{page}/{code}/{startDate}/{endDate}/query", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String contractQueryCancel(Model model, HttpServletRequest request,
                                      @PathVariable("userId") int userId, @PathVariable("page") int page,
                                      @PathVariable("code") String code, @PathVariable("startDate") String startDate,
                                      @PathVariable("endDate") String endDate) {
        String role4 = baseService.getRole(userId, "role4");
        String is_admin = CommUtil.showIsAdminCookie(request);
        if (CONST.RS.equals(code)) {
            code = "";
        }
        if (CONST.RS.equals(startDate)) {
            startDate = "";
        }
        if (CONST.RS.equals(endDate)) {
            endDate = "";
        }
        model.addAttribute("role4", role4);
        model.addAttribute("is_admin", is_admin);
        List<Contract> contractList = contractService.queryCancel(code, startDate, endDate, page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = contractService.queryCancelTotal(code, startDate, endDate);
        model.addAttribute("code", code);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        model.addAttribute("query", "query");
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        model.addAttribute("contractList", contractList);
        model.addAttribute("total", total);
        return "contract_house_cancel";
    }


    @RequestMapping(value = "/contract_cancel/{userId}/{page}/{code}/{linkMan}/{no}/{startDate}/{endDate}/query/{export}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String contractQueryCancel(Model model, HttpServletRequest request,
                                      @PathVariable("userId") int userId, @PathVariable("page") int page,
                                      @PathVariable("code") String code, @PathVariable("linkMan") String linkMan,
                                      @PathVariable("no") String no, @PathVariable("startDate") String startDate,
                                      @PathVariable("endDate") String endDate, @PathVariable("export") String export, HttpServletResponse response) {
        String role4 = baseService.getRole(userId, "role4");
        String is_admin = CommUtil.showIsAdminCookie(request);
        if (CONST.RS.equals(code)) {
            code = "";
        }
        if (CONST.RS.equals(linkMan)) {
            linkMan = "";
        }
        if (CONST.RS.equals(no)) {
            no = "";
        }
        if (CONST.RS.equals(startDate)) {
            startDate = "";
        }
        if (CONST.RS.equals(endDate)) {
            endDate = "";
        }
        model.addAttribute("role4", role4);
        model.addAttribute("is_admin", is_admin);
        List<Contract> contractList = contractService.queryDel("", code, linkMan, no, "", startDate, endDate, page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = contractService.queryDelTotal("house", code, linkMan, no, "", startDate, endDate);
        //获取所有支付的金额
        double payTotal = 0;
        double payTotalAll = 0;
        for (int j = 0; j < contractList.size(); j++) {
            payTotal = 0;
            String flag1 = "@@";
            String flag2 = "=";
            String table = contractList.get(j).getTable2();
            String[] tables = table.split(flag2, -1);
            int size = tables[0].split(flag1, -1).length;
            for (int m = 0; m < size; m++) {
                if (!"".equals(tables[6].split(flag1, size)[m])) {
                    payTotal += Double.parseDouble(tables[6].split(flag1, size)[m]);
                }
            }

            table = contractList.get(j).getTable2H();
            tables = table.split(flag2, -1);
            size = tables[0].split(flag1, -1).length;
            for (int m = 0; m < size; m++) {
                if (!"".equals(tables[5].split(flag1, size)[m])) {
                    payTotal += Double.parseDouble(tables[5].split(flag1, size)[m]);
                }
            }
            payTotalAll += payTotal;
            contractList.get(j).setPayTotal(payTotal);
        }

        model.addAttribute("code", code);
        model.addAttribute("linkMan", linkMan);
        model.addAttribute("no", no);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        model.addAttribute("query", "query");
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        model.addAttribute("contractList", contractList);
        model.addAttribute("total", total);
        model.addAttribute("payTotalAll", payTotalAll);

        if ("export".equals(export)) {
            //获取数据

            String content[][] = new String[contractList.size() + 1][];

            //excel标题
            String[] title = {"序号", "审批时间", "客户名称", "联系人", "联系电话", "合同号", "类型", "数量", "金额", "经办人"};
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
            //excel文件名
            String fileName = "终止合同报表" + sdf.format(new Date()) + ".xls";

            //sheet名
            String sheetName = "终止合同报表";

            for (int i = 0; i < contractList.size(); i++) {
                content[i] = new String[title.length];

                content[i][0] = contractList.get(i).getId() + "";
                content[i][1] = contractList.get(i).getApprovalDate();
                content[i][2] = contractList.get(i).getCodeAuto();
                content[i][3] = contractList.get(i).getLinkMan();
                content[i][4] = contractList.get(i).getPhone();
                content[i][5] = contractList.get(i).getNo();

                String style = contractList.get(i).getStyle();
                if ("house".equals(style)) {
                    content[i][6] = "房源合同";
                }
                if ("ad".equals(style)) {
                    content[i][6] = "广告合同";
                }
                if ("car".equals(style)) {
                    content[i][6] = "车位合同";
                }

                content[i][7] = 1 + "";
                content[i][8] = contractList.get(i).getPayTotal() + "";
                content[i][9] = contractList.get(i).getApproval();


            }
            content[contractList.size()] = new String[title.length];
            content[contractList.size()][0] = "合计" + "";
            content[contractList.size()][7] = contractList.size() + "";
            content[contractList.size()][8] = payTotalAll + "";

            //创建HSSFWorkbook
            HSSFWorkbook wb = ExcelUtil.getHSSFWorkbook(sheetName, title, content, null);

            //响应到客户端
            try {
                this.setResponseHeader(response, fileName);
                OutputStream os = response.getOutputStream();
                wb.write(os);
                os.flush();
                os.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return "contract_cancel";
    }

    @RequestMapping(value = "/contract_house/{userId}/{page}/{code}/{linkMan}/{no}/{startDate}/{endDate}/query/{export}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String contractQuery(Model model, HttpServletRequest request,
                                @PathVariable("userId") int userId, @PathVariable("page") int page,
                                @PathVariable("code") String code, @PathVariable("linkMan") String linkMan,
                                @PathVariable("no") String no, @PathVariable("startDate") String startDate,
                                @PathVariable("endDate") String endDate, @PathVariable("export") String export, HttpServletResponse response) {
        String role4 = baseService.getRole(userId, "role4");
        String is_admin = CommUtil.showIsAdminCookie(request);
        if (CONST.RS.equals(code)) {
            code = "";
        }
        if (CONST.RS.equals(linkMan)) {
            linkMan = "";
        }
        if (CONST.RS.equals(no)) {
            no = "";
        }
        if (CONST.RS.equals(startDate)) {
            startDate = "";
        }
        if (CONST.RS.equals(endDate)) {
            endDate = "";
        }
        model.addAttribute("role4", role4);
        model.addAttribute("is_admin", is_admin);
        List<Contract> contractList = contractService.query("house", code, linkMan, no, "", startDate, endDate, page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = contractService.queryTotal("house", code, linkMan, no, "", startDate, endDate);
        //获取所有支付的金额
        double payTotal = 0;
        double payTotalAll = 0;
        for (int j = 0; j < contractList.size(); j++) {
            payTotal = 0;
//            String flag1 = "@@";
//            String flag2 = "=";
//            String table = contractList.get(j).getTable2();
//            String[] tables = table.split(flag2, -1);
//            int size = tables[0].split(flag1, -1).length;
//            for (int m = 0; m < size; m++) {
//                if (!"".equals(tables[6].split(flag1, size)[m])) {
//                    payTotal += Double.parseDouble(tables[6].split(flag1, size)[m]);
//                }
//            }
//
//            table = contractList.get(j).getTable2H();
//            tables = table.split(flag2, -1);
//            size = tables[0].split(flag1, -1).length;
//            for (int m = 0; m < size; m++) {
//                if (!"".equals(tables[5].split(flag1, size)[m])) {
//                    payTotal += Double.parseDouble(tables[5].split(flag1, size)[m]);
//                }
//            }
            payTotal = contractList.get(j).getTotal();
            payTotalAll += payTotal;
            payTotalAll = NumberToCN.parseDouble(payTotalAll);
            contractList.get(j).setPayTotal(payTotal);
        }

        model.addAttribute("code", code);
        model.addAttribute("linkMan", linkMan);
        model.addAttribute("no", no);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        model.addAttribute("query", "query");
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        model.addAttribute("contractList", contractList);
        model.addAttribute("total", total);
        model.addAttribute("payTotalAll", payTotalAll);

        if ("export".equals(export)) {
            //获取数据

            String content[][] = new String[contractList.size() + 1][];

            //excel标题
            String[] title = {"序号", "审批时间", "客户名称", "联系人", "联系电话", "合同号", "审批状态", "数量", "金额", "经办人"};
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
            //excel文件名
            String fileName = "房子租赁合同报表" + sdf.format(new Date()) + ".xls";

            //sheet名
            String sheetName = "房子租赁合同报表";

            for (int i = 0; i < contractList.size(); i++) {
                content[i] = new String[title.length];

                content[i][0] = contractList.get(i).getId() + "";
                content[i][1] = contractList.get(i).getApprovalDate();
                content[i][2] = contractList.get(i).getCodeAuto();
                content[i][3] = contractList.get(i).getLinkMan();
                content[i][4] = contractList.get(i).getPhone();
                content[i][5] = contractList.get(i).getNo();

                int isOk = contractList.get(i).getIsOk();
                if (isOk == 0) {
                    content[i][6] = "审批中";
                }
                if (isOk == 1) {
                    content[i][6] = "已审批";
                }
                if (isOk == -1) {
                    content[i][6] = "已驳回";
                }

                content[i][7] = 1 + "";
                content[i][8] = contractList.get(i).getPayTotal() + "";
                content[i][9] = contractList.get(i).getApproval();


            }
            content[contractList.size()] = new String[title.length];
            content[contractList.size()][0] = "合计" + "";
            content[contractList.size()][7] = contractList.size() + "";
            content[contractList.size()][8] = payTotalAll + "";

            //创建HSSFWorkbook
            HSSFWorkbook wb = ExcelUtil.getHSSFWorkbook(sheetName, title, content, null);

            //响应到客户端
            try {
                this.setResponseHeader(response, fileName);
                OutputStream os = response.getOutputStream();
                wb.write(os);
                os.flush();
                os.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }

        return "contract_house";
    }

    //发送响应流方法
    public void setResponseHeader(HttpServletResponse response, String fileName) {
        try {
            try {
                fileName = new String(fileName.getBytes(), "ISO8859-1");
            } catch (UnsupportedEncodingException e) {
                // TODO Auto-generated catch block
                e.printStackTrace();
            }
            response.setContentType("application/octet-stream;charset=ISO8859-1");
            response.setHeader("Content-Disposition", "attachment;filename=" + fileName);
            response.addHeader("Pargam", "no-cache");
            response.addHeader("Cache-Control", "no-cache");
        } catch (Exception ex) {
            ex.printStackTrace();
        }
    }

    /**
     * 客户资源
     */
    @RequestMapping(value = "/contract_ad/{userId}/{page}/{code}/{linkMan}/{no}/{startDate}/{endDate}/query/{export}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String contractQueryAd(Model model, HttpServletRequest request,
                                  @PathVariable("userId") int userId, @PathVariable("page") int page,
                                  @PathVariable("code") String code, @PathVariable("linkMan") String linkMan,
                                  @PathVariable("no") String no, @PathVariable("startDate") String startDate, @PathVariable("endDate") String endDate, @PathVariable("export") String export, HttpServletResponse response) {
        String role4 = baseService.getRole(userId, "role4");
        String is_admin = CommUtil.showIsAdminCookie(request);
        if (CONST.RS.equals(code)) {
            code = "";
        }
        if (CONST.RS.equals(linkMan)) {
            linkMan = "";
        }
        if (CONST.RS.equals(no)) {
            no = "";
        }
        if (CONST.RS.equals(startDate)) {
            startDate = "";
        }
        if (CONST.RS.equals(endDate)) {
            endDate = "";
        }
        model.addAttribute("role4", role4);
        model.addAttribute("is_admin", is_admin);
        List<Contract> contractList = contractService.query("ad", code, linkMan, no, "", startDate, endDate, page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = contractService.queryTotal("ad", code, linkMan, no, "", startDate, endDate);
        double payTotal = 0;
        double payTotalAll = 0;
        for (int j = 0; j < contractList.size(); j++) {
            payTotal = 0;
            String flag1 = "@@";
            String flag2 = "=";
            String table = contractList.get(j).getTable11();
            String[] tables = table.split(flag2, -1);
            int size = tables[0].split(flag1, -1).length;
            for (int m = 0; m < size; m++) {
                if (!"".equals(tables[2].split(flag1, size)[m])) {
                    payTotal += Double.parseDouble(tables[2].split(flag1, size)[m]);
                }
            }

            table = contractList.get(j).getTable2H();
            tables = table.split(flag2, -1);
            size = tables[0].split(flag1, -1).length;
            for (int m = 0; m < size; m++) {
                if (!"".equals(tables[1].split(flag1, size)[m])) {
                    payTotal += Double.parseDouble(tables[1].split(flag1, size)[m]);
                }
            }
            payTotalAll += payTotal;
            contractList.get(j).setPayTotal(payTotal);
        }
        model.addAttribute("code", code);
        model.addAttribute("linkMan", linkMan);
        model.addAttribute("no", no);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        model.addAttribute("query", "query");
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        model.addAttribute("contractList", contractList);
        model.addAttribute("total", total);
        model.addAttribute("payTotalAll", payTotalAll);
        if ("export".equals(export)) {
            //获取数据

            String content[][] = new String[contractList.size() + 1][];

            //excel标题
            String[] title = {"序号", "审批时间", "客户名称", "联系人", "联系电话", "合同号", "审批状态", "数量", "金额", "经办人"};
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
            //excel文件名
            String fileName = "广告位合同报表" + sdf.format(new Date()) + ".xls";

            //sheet名
            String sheetName = "广告位合同报表";

            for (int i = 0; i < contractList.size(); i++) {
                content[i] = new String[title.length];

                content[i][0] = contractList.get(i).getId() + "";
                content[i][1] = contractList.get(i).getApprovalDate();
                content[i][2] = contractList.get(i).getCodeAuto();
                content[i][3] = contractList.get(i).getLinkMan();
                content[i][4] = contractList.get(i).getPhone();
                content[i][5] = contractList.get(i).getNo();

                int isOk = contractList.get(i).getIsOk();
                if (isOk == 0) {
                    content[i][6] = "审批中";
                }
                if (isOk == 1) {
                    content[i][6] = "已审批";
                }
                if (isOk == -1) {
                    content[i][6] = "已驳回";
                }

                content[i][7] = 1 + "";
                content[i][8] = contractList.get(i).getPayTotal() + "";
                content[i][9] = contractList.get(i).getApproval();


            }
            content[contractList.size()] = new String[title.length];
            content[contractList.size()][0] = "合计" + "";
            content[contractList.size()][7] = contractList.size() + "";
            content[contractList.size()][8] = payTotalAll + "";

            //创建HSSFWorkbook
            HSSFWorkbook wb = ExcelUtil.getHSSFWorkbook(sheetName, title, content, null);

            //响应到客户端
            try {
                this.setResponseHeader(response, fileName);
                OutputStream os = response.getOutputStream();
                wb.write(os);
                os.flush();
                os.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return "contract_ad";
    }

    /**
     * 客户资源
     */
    @RequestMapping(value = "/contract_car/{userId}/{page}/{code}/{linkMan}/{no}/{startDate}/{endDate}/{number}/query/{export}", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    public String contractQueryCar(Model model, HttpServletRequest request,
                                   @PathVariable("userId") int userId, @PathVariable("page") int page,
                                   @PathVariable("code") String code, @PathVariable("linkMan") String linkMan,
                                   @PathVariable("no") String no,
                                   @PathVariable("number") String number, @PathVariable("startDate") String startDate, @PathVariable("endDate") String endDate, @PathVariable("export") String export, HttpServletResponse response) {
        String role4 = baseService.getRole(userId, "role4");
        String is_admin = CommUtil.showIsAdminCookie(request);
        if (CONST.RS.equals(code)) {
            code = "";
        }
        if (CONST.RS.equals(linkMan)) {
            linkMan = "";
        }
        if (CONST.RS.equals(no)) {
            no = "";
        }
        if (CONST.RS.equals(number)) {
            number = "";
        }
        if (CONST.RS.equals(startDate)) {
            startDate = "";
        }
        if (CONST.RS.equals(endDate)) {
            endDate = "";
        }
        model.addAttribute("role4", role4);
        model.addAttribute("is_admin", is_admin);
        List<Contract> contractList = contractService.query("car", code, linkMan, no, number, startDate, endDate, page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = contractService.queryTotal("car", code, linkMan, no, number, startDate, endDate);
        double payTotal = 0;
        double payTotalAll = 0;
        for (int j = 0; j < contractList.size(); j++) {
            payTotal = 0;
            String flag1 = "@@";
            String flag2 = "=";
            String table = contractList.get(j).getTable11();
            String[] tables = table.split(flag2, -1);
            int size = tables[0].split(flag1, -1).length;
            for (int m = 0; m < size; m++) {
                if (!"".equals(tables[2].split(flag1, size)[m])) {
                    payTotal += Double.parseDouble(tables[2].split(flag1, size)[m]);
                }
            }

            table = contractList.get(j).getTable2H();
            tables = table.split(flag2, -1);
            size = tables[0].split(flag1, -1).length;
            for (int m = 0; m < size; m++) {
                if (!"".equals(tables[1].split(flag1, size)[m])) {
                    payTotal += Double.parseDouble(tables[1].split(flag1, size)[m]);
                }
            }
            payTotalAll += payTotal;
            contractList.get(j).setPayTotal(payTotal);
        }
        model.addAttribute("code", code);
        model.addAttribute("linkMan", linkMan);
        model.addAttribute("no", no);
        model.addAttribute("number", number);
        model.addAttribute("startDate", startDate);
        model.addAttribute("endDate", endDate);
        model.addAttribute("query", "query");
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        model.addAttribute("contractList", contractList);
        model.addAttribute("total", total);
        model.addAttribute("payTotalAll", payTotalAll);
        if ("export".equals(export)) {
            //获取数据

            String content[][] = new String[contractList.size() + 1][];

            //excel标题
            String[] title = {"序号", "审批时间", "客户名称", "联系人", "联系电话", "合同号", "审批状态", "数量", "金额", "经办人"};
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
            //excel文件名
            String fileName = "车位合同报表" + sdf.format(new Date()) + ".xls";

            //sheet名
            String sheetName = "车位合同报表";

            for (int i = 0; i < contractList.size(); i++) {
                content[i] = new String[title.length];

                content[i][0] = contractList.get(i).getId() + "";
                content[i][1] = contractList.get(i).getApprovalDate();
                content[i][2] = contractList.get(i).getCodeAuto();
                content[i][3] = contractList.get(i).getLinkMan();
                content[i][4] = contractList.get(i).getPhone();
                content[i][5] = contractList.get(i).getNo();

                int isOk = contractList.get(i).getIsOk();
                if (isOk == 0) {
                    content[i][6] = "审批中";
                }
                if (isOk == 1) {
                    content[i][6] = "已审批";
                }
                if (isOk == -1) {
                    content[i][6] = "已驳回";
                }

                content[i][7] = 1 + "";
                content[i][8] = contractList.get(i).getPayTotal() + "";
                content[i][9] = contractList.get(i).getApproval();


            }
            content[contractList.size()] = new String[title.length];
            content[contractList.size()][0] = "合计" + "";
            content[contractList.size()][7] = contractList.size() + "";
            content[contractList.size()][8] = payTotalAll + "";

            //创建HSSFWorkbook
            HSSFWorkbook wb = ExcelUtil.getHSSFWorkbook(sheetName, title, content, null);

            //响应到客户端
            try {
                this.setResponseHeader(response, fileName);
                OutputStream os = response.getOutputStream();
                wb.write(os);
                os.flush();
                os.close();
            } catch (Exception e) {
                e.printStackTrace();
            }
        }
        return "contract_car";
    }

    public String parse(List<String> list, int index) {
        if (list.size() <= index) {
            return "";
        }
        return list.get(index);
    }

    public int maxIndex(int... lists) {
        int len = lists.length;
        int max = 0;
        for (int i = 0; i < len; i++) {
            if (lists[i] > max) {
                max = lists[i];
            }
        }
        return max;
    }

    @RequestMapping(value = "/contract_house/{main}/{table1}/{table2}/{table2H}/{table3}/{table11}/{table22}/{table33}/{table44}/{table55}/{table66}/{table77}/{table88}/insert", method = RequestMethod.POST)
    @ResponseBody
    public int contractInsert(Model model, HttpServletRequest request, @PathVariable("main") String main
            , @PathVariable("table1") String table1, @PathVariable("table2") String table2
            , @PathVariable("table2H") String table2H, @PathVariable("table3") String table3
            , @PathVariable("table11") String table11, @PathVariable("table22") String table22
            , @PathVariable("table33") String table33, @PathVariable("table44") String table44
            , @PathVariable("table55") String table55, @PathVariable("table66") String table66
            , @PathVariable("table77") String table77, @PathVariable("table88") String table88) {
        if (table2.contains("fantasy")) {
            table2 = table2.replace("fantasy", "/");
        }
        if (table3.contains("fantasy")) {
            table3 = table3.replace("fantasy", "/");
        }
        String flag1 = "@@";
        String flag2 = "=";
        String undefined = "undefined";
        logger.error(main);


        String[] mains = main.split(flag2, -1);
        String code_auto = mains[0];
        String remark = mains[1];
        String linkMan = mains[2];
        String phone = mains[3];
        String startDate = mains[4];
        String endDate = mains[5];
        String warnDay = mains[6];
        String code = mains[7];
        String type = mains[8];
        String house1 = mains[9];
        String house2 = mains[10];
        String house3 = mains[11];
        String userName = mains[12];
        String explain = mains[13];
        String customId = mains[14];
        String cashM = mains[15];


        String uuid = CommUtil.getUUID32();
        //SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
        SimpleDateFormat sdfSort = new SimpleDateFormat("yyMMdd");
        String date = sdfSort.format(new Date());
        int t = contractService.dateTotal(date) + 1;
        String sort = contractService.gainContactSort(Integer.parseInt(type));
        String no = sort + t;

        int isOk = contractService.insertContract(userName, house1, house2, house3, code, no, uuid, code_auto, remark, linkMan, phone, startDate, endDate, warnDay, type,
                "house", table1, table2, table2H, table3, table11, table22, table33, table44, table55, table66,
                table77, table88, explain, Integer.parseInt(customId), Double.parseDouble(cashM));
        Contract contract = contractService.gainContract(uuid);
        HandleController.house(contract);

        if (contract != null) {
            List<Table> table1List = contract.getTableList1();
            for (int i = 0; i < table1List.size(); i++) {
                Table table = table1List.get(i);
                contractService.insertTable1(uuid, "house", table.getTable1(), table.getTable2(), Integer.parseInt(table.getTable7()));
            }

            List<Table> table33List = contract.getTableList33();
            for (int i = 0; i < table33List.size(); i++) {
                Table table = table33List.get(i);
                contractService.insertTable38(uuid, "house", table.getTable1(), table.getTable0(), table.getTable2(), "", "", "");
            }

            List<Table> table88List = contract.getTableList88();
            for (int i = 0; i < table88List.size(); i++) {
                Table table = table88List.get(i);
                contractService.insertTable38(uuid, "house", "", "", "", table.getTable0(), table.getTable1(), table.getTable2());
            }

            List<Table> table77List = contract.getTableList77();
            for (int i = 0; i < table77List.size(); i++) {
                Table table = table77List.get(i);
                contractService.insertTable77(uuid, table.getTable0(), table.getTable1(), table.getTable2(), table.getTable3(), table.getTable4());
            }


            List<Table> table44List = contract.getTableList44();

            for (int i = 0; i < table44List.size(); i++) {
                Table table = table44List.get(i);
                String noT = table.getTable1();
                String loc = table.getTable2();
                String contractDegree = table.getTable3();
                String dateT = table.getTable0();
                int count = contractService.gainFreeExportByLocAndDate(loc, dateT);

                if (!dateT.contains("-")) {
                    SimpleDateFormat sdfT = new SimpleDateFormat("yyyy-MM-dd");
                    dateT = sdfT.format(new Date());
                }
                storageService.insertFreeExport(loc, noT, dateT, contractDegree, "water", "contract", dateT, contractDegree, uuid);

            }
            table44List = contract.getTableList55();
            for (int i = 0; i < table44List.size(); i++) {
                Table table = table44List.get(i);
                String noT = table.getTable1();
                String loc = table.getTable2();
                String contractDegree = table.getTable3();
                String dateT = table.getTable0();
                int count = contractService.gainFreeExportByLocAndDate(loc, dateT);

                if (!dateT.contains("-")) {
                    SimpleDateFormat sdfT = new SimpleDateFormat("yyyy-MM-dd");
                    dateT = sdfT.format(new Date());
                }
                storageService.insertFreeExport(loc, noT, dateT, contractDegree, "power", "contract", dateT, contractDegree, uuid);

            }

            table44List = contract.getTableList66();
            for (int i = 0; i < table44List.size(); i++) {
                Table table = table44List.get(i);
                String noT = table.getTable1();
                String loc = table.getTable2();
                String contractDegree = table.getTable3();
                String dateT = table.getTable0();
                int count = contractService.gainFreeExportByLocAndDate(loc, dateT);
                if (!dateT.contains("-")) {
                    SimpleDateFormat sdfT = new SimpleDateFormat("yyyy-MM-dd");
                    dateT = sdfT.format(new Date());
                }

                storageService.insertFreeExport(loc, noT, dateT, contractDegree, "air", "contract", dateT, contractDegree, uuid);

            }
        }

        return isOk;
    }

    @RequestMapping(value = "/contract_house/{uuid}/{main}/{table1}/{table2}/{table2H}/{table3}/{table11}/{table22}/{table33}/{table44}/{table55}/{table66}/{table77}/{table88}/update", method = RequestMethod.POST)
    @ResponseBody
    public int contractUpdate(Model model, HttpServletRequest request, @PathVariable("uuid") String uuid, @PathVariable("main") String main
            , @PathVariable("table1") String table1, @PathVariable("table2") String table2
            , @PathVariable("table2H") String table2H, @PathVariable("table3") String table3
            , @PathVariable("table11") String table11, @PathVariable("table22") String table22
            , @PathVariable("table33") String table33, @PathVariable("table44") String table44
            , @PathVariable("table55") String table55, @PathVariable("table66") String table66
            , @PathVariable("table77") String table77, @PathVariable("table88") String table88) {
        if (table2.contains("fantasy")) {
            table2 = table2.replace("fantasy", "/");
        }
        if (table3.contains("fantasy")) {
            table3 = table3.replace("fantasy", "/");
        }
        String flag1 = "@@";
        String flag2 = "=";
        String undefined = "undefined";
        logger.error(main);


        String[] mains = main.split(flag2, -1);
        String code_auto = mains[0];
        String remark = mains[1];
        String linkMan = mains[2];
        String phone = mains[3];
        String startDate = mains[4];
        String endDate = mains[5];
        String warnDay = mains[6];
        String code = mains[7];
        String type = mains[8];
        String house1 = mains[9];
        String house2 = mains[10];
        String house3 = mains[11];
        String userName = mains[12];
        String explain = mains[13];
        String customId = mains[14];
        String cashM = mains[15];
        //String uuid = CommUtil.getUUID32();
//        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//        String date = sdf.format(new Date());
//        sdf = new SimpleDateFormat("yyMMdd");
//        int t = contractService.dateTotal(date) + 1;
//        String sort = contractService.gainContactSort(Integer.parseInt(type));
//        String no;
//        if (t < 10) {
//            no = sort + sdf.format(new Date()) + "0" + t;
//        } else {
//            no = sort + sdf.format(new Date()) + t;
//        }
        int isOk = contractService.modifyContract(userName, house1, house2, house3, code, uuid, code_auto, remark, linkMan, phone, startDate, endDate, warnDay, type,
                "house", table1, table2, table2H, table3, table11, table22, table33, table44, table55, table66,
                table77, table88, explain, Integer.parseInt(customId), Double.parseDouble(cashM));
        logger.error(userName, house1, house2, house3, code, uuid, code_auto, remark, linkMan, phone, startDate, endDate, warnDay, type,
                "house", table1, table2, table2H, table3, table11, table22, table33, table44, table55, table66,
                table77, table88);


        contractService.delTable38(uuid);
        contractService.delTable1(uuid);
        contractService.delTable77(uuid);
        Contract contract = contractService.gainContract(uuid);
        HandleController.house(contract);
        if (contract != null) {

            List<Table> table1List = contract.getTableList1();
            for (int i = 0; i < table1List.size(); i++) {
                Table table = table1List.get(i);
                contractService.insertTable1(uuid, "house", table.getTable1(), table.getTable2(), Integer.parseInt(table.getTable7()));
            }

            List<Table> table33List = contract.getTableList33();
            for (int i = 0; i < table33List.size(); i++) {
                Table table = table33List.get(i);
                contractService.insertTable38(uuid, "house", table.getTable1(), table.getTable0(), table.getTable2(), "", "", "");
            }
            List<Table> table88List = contract.getTableList88();
            for (int i = 0; i < table88List.size(); i++) {
                Table table = table88List.get(i);
                contractService.insertTable38(uuid, "house", "", "", "", table.getTable0(), table.getTable1(), table.getTable2());
            }
            List<Table> table77List = contract.getTableList77();
            for (int i = 0; i < table77List.size(); i++) {
                Table table = table77List.get(i);
                contractService.insertTable77(uuid, table.getTable0(), table.getTable1(), table.getTable2(), table.getTable3(), table.getTable4());
            }
            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
            String date = sdf.format(new Date());
            List<Table> table44List = contract.getTableList44();

            for (int i = 0; i < table44List.size(); i++) {
                Table table = table44List.get(i);
                String noT = table.getTable1();
                String loc = table.getTable2();
                String contractDegree = table.getTable3();
                String dateT = table.getTable0();
                int count = contractService.gainFreeExportByLocAndDate(loc, dateT);

                if (!dateT.contains("-")) {
                    SimpleDateFormat sdfT = new SimpleDateFormat("yyyy-MM-dd");
                    dateT = sdfT.format(new Date());
                }
                storageService.updateFreeExport(loc, noT, dateT, contractDegree, "water", "contract", dateT, contractDegree, uuid);

            }
            table44List = contract.getTableList55();

            for (int i = 0; i < table44List.size(); i++) {
                Table table = table44List.get(i);
                String noT = table.getTable1();
                String loc = table.getTable2();
                String contractDegree = table.getTable3();
                String dateT = table.getTable0();
                int count = contractService.gainFreeExportByLocAndDate(loc, dateT);

                if (!dateT.contains("-")) {
                    SimpleDateFormat sdfT = new SimpleDateFormat("yyyy-MM-dd");
                    dateT = sdfT.format(new Date());
                }
                storageService.updateFreeExport(loc, noT, dateT, contractDegree, "power", "contract", dateT, contractDegree, uuid);

            }

            table44List = contract.getTableList66();
            for (int i = 0; i < table44List.size(); i++) {
                Table table = table44List.get(i);
                String noT = table.getTable1();
                String loc = table.getTable2();
                String contractDegree = table.getTable3();
                String dateT = table.getTable0();
                int count = contractService.gainFreeExportByLocAndDate(loc, dateT);

                if (!dateT.contains("-")) {
                    SimpleDateFormat sdfT = new SimpleDateFormat("yyyy-MM-dd");
                    dateT = sdfT.format(new Date());
                }
                storageService.updateFreeExport(loc, noT, dateT, contractDegree, "air", "contract", dateT, contractDegree, uuid);

            }
        }
        return isOk;
    }


    @RequestMapping(value = "/contract_ad/{main}/{table1}/{table2}/{table2H}/{table3}/{table11}/{table33}/insert", method = RequestMethod.POST)
    @ResponseBody
    public int contractAdInsert(Model model, HttpServletRequest request, @PathVariable("main") String main
            , @PathVariable("table1") String table1, @PathVariable("table2") String table2
            , @PathVariable("table2H") String table2H, @PathVariable("table3") String table3
            , @PathVariable("table11") String table11
            , @PathVariable("table33") String table33) {
        if (table2.contains("fantasy")) {
            table2 = table2.replace("fantasy", "/");
        }
        if (table3.contains("fantasy")) {
            table3 = table3.replace("fantasy", "/");
        }
        String flag1 = "@@";
        String flag2 = "=";
        String undefined = "undefined";
        logger.error(main);


        String[] mains = main.split(flag2, -1);
        String code_auto = mains[0];
        String remark = mains[1];
        String linkMan = mains[2];
        String phone = mains[3];
        String startDate = mains[4];
        String endDate = mains[5];
        String warnDay = mains[6];
        String code = mains[7];
        String type = mains[8];

        String userName = mains[9];
        String explain = mains[10];
        String customId = mains[11];
        String cashM = mains[12];
        String uuid = CommUtil.getUUID32();

        SimpleDateFormat sdfSort = new SimpleDateFormat("yyMMdd");
        String date = sdfSort.format(new Date());
        int t = contractService.dateTotal(date) + 1;
        String sort = contractService.gainContactSort(Integer.parseInt(type));
        String no = sort + t;

        int isOk = contractService.insertAdContract(userName, code, no, uuid, code_auto, remark, linkMan, phone, startDate, endDate, warnDay, type,
                "ad", table1, table2, table2H, table3, table11, table33, explain, Integer.parseInt(customId), Double.parseDouble(cashM));

        Contract contract = contractService.gainContract(uuid);
        HandleController.ad(contract);
        if (contract != null) {
            List<Table> table1List = contract.getTableList1();
            for (int i = 0; i < table1List.size(); i++) {
                Table table = table1List.get(i);
                contractService.insertTable1(uuid, "ad", table.getTable1(), table.getTable2(), Integer.parseInt(table.getTable7()));
            }

            List<Table> table33List = contract.getTableList33();
            for (int i = 0; i < table33List.size(); i++) {
                Table table = table33List.get(i);
                contractService.insertTable38(uuid, "ad", table.getTable1(), table.getTable0(), table.getTable2(), "", "", "");
            }
        }
        return isOk;
    }

    @RequestMapping(value = "/contract_car/{main}/{table1}/{table2}/{table2H}/{table3}/{table11}/{table33}/insert", method = RequestMethod.POST)
    @ResponseBody
    public int contractCarInsert(Model model, HttpServletRequest request, @PathVariable("main") String main
            , @PathVariable("table1") String table1, @PathVariable("table2") String table2
            , @PathVariable("table2H") String table2H, @PathVariable("table3") String table3
            , @PathVariable("table11") String table11
            , @PathVariable("table33") String table33) {
        if (table2.contains("fantasy")) {
            table2 = table2.replace("fantasy", "/");
        }
        if (table3.contains("fantasy")) {
            table3 = table3.replace("fantasy", "/");
        }
        String flag1 = "@@";
        String flag2 = "=";
        String undefined = "undefined";
        logger.error(main);


        String[] mains = main.split(flag2, -1);
        String code_auto = mains[0];
        String remark = mains[1];
        String linkMan = mains[2];
        String phone = mains[3];
        String startDate = mains[4];
        String endDate = mains[5];
        String warnDay = mains[6];
        String code = mains[7];
        String type = mains[8];

        String userName = mains[9];
        String explain = mains[10];
        String customId = mains[11];
        String cashM = mains[12];

        String uuid = CommUtil.getUUID32();

        SimpleDateFormat sdfSort = new SimpleDateFormat("yyMMdd");
        String date = sdfSort.format(new Date());
        int t = contractService.dateTotal(date) + 1;
        String sort = contractService.gainContactSort(Integer.parseInt(type));
        String no = sort + t;

        int isOk = contractService.insertCarContract(userName, code, no, uuid, code_auto, remark, linkMan, phone, startDate, endDate, warnDay, type,
                "car", table1, table2, table2H, table3, table11, table33, explain, Integer.parseInt(customId), Double.parseDouble(cashM));

        Contract contract = contractService.gainContract(uuid);
        HandleController.car(contract);

        List<Table> table1List = contract.getTableList1();
        for (int i = 0; i < table1List.size(); i++) {
            Table table = table1List.get(i);
            contractService.insertTable1(uuid, "car", table.getTable1(), table.getTable2(), Integer.parseInt(table.getTable7()));

            //车位回写
            contractService.updateCustomCarReg(table.getTable11(), table.getTable8(), table.getTable9(), table.getTable1(), Integer.parseInt(customId));

        }

        List<Table> table33List = contract.getTableList33();
        for (int i = 0; i < table33List.size(); i++) {
            Table table = table33List.get(i);
            contractService.insertTable38(uuid, "car", table.getTable1(), table.getTable0(), table.getTable2(), "", "", "");
        }


        return isOk;
    }

    @RequestMapping(value = "/contract_ad/{uuid}/{main}/{table1}/{table2}/{table2H}/{table3}/{table11}/{table33}/update", method = RequestMethod.POST)
    @ResponseBody
    public int contractAdUpdate(Model model, HttpServletRequest request, @PathVariable("uuid") String uuid, @PathVariable("main") String main
            , @PathVariable("table1") String table1, @PathVariable("table2") String table2
            , @PathVariable("table2H") String table2H, @PathVariable("table3") String table3
            , @PathVariable("table11") String table11
            , @PathVariable("table33") String table33) {
        if (table2.contains("fantasy")) {
            table2 = table2.replace("fantasy", "/");
        }
        if (table3.contains("fantasy")) {
            table3 = table3.replace("fantasy", "/");
        }
        String flag1 = "@@";
        String flag2 = "=";
        String undefined = "undefined";
        logger.error(main);


        String[] mains = main.split(flag2, -1);
        String code_auto = mains[0];
        String remark = mains[1];
        String linkMan = mains[2];
        String phone = mains[3];
        String startDate = mains[4];
        String endDate = mains[5];
        String warnDay = mains[6];
        String code = mains[7];
        String type = mains[8];

        String userName = mains[9];
        String explain = mains[10];
        String customId = mains[11];
        String cashM = mains[12];

        int isOk = contractService.modifyAdContract(userName, code, uuid, code_auto, remark, linkMan, phone, startDate, endDate, warnDay, type,
                "ad", table1, table2, table2H, table3, table11, table33, explain, Integer.parseInt(customId), Double.parseDouble(cashM));

        contractService.delTable38(uuid);
        contractService.delTable1(uuid);
        contractService.delTable77(uuid);
        Contract contract = contractService.gainContract(uuid);
        HandleController.ad(contract);
        if (contract != null) {
            List<Table> table1List = contract.getTableList1();
            for (int i = 0; i < table1List.size(); i++) {
                Table table = table1List.get(i);
                contractService.insertTable1(uuid, "ad", table.getTable1(), table.getTable2(), Integer.parseInt(table.getTable7()));
            }

            List<Table> table33List = contract.getTableList33();
            for (int i = 0; i < table33List.size(); i++) {
                Table table = table33List.get(i);
                contractService.insertTable38(uuid, "ad", table.getTable1(), table.getTable0(), table.getTable2(), "", "", "");
            }
        }

        return isOk;
    }

    @RequestMapping(value = "/contract_car/{uuid}/{main}/{table1}/{table2}/{table2H}/{table3}/{table11}/{table33}/update", method = RequestMethod.POST)
    @ResponseBody
    public int contractCarUpdate(Model model, HttpServletRequest request, @PathVariable("uuid") String uuid, @PathVariable("main") String main
            , @PathVariable("table1") String table1, @PathVariable("table2") String table2
            , @PathVariable("table2H") String table2H, @PathVariable("table3") String table3
            , @PathVariable("table11") String table11
            , @PathVariable("table33") String table33) {
        if (table2.contains("fantasy")) {
            table2 = table2.replace("fantasy", "/");
        }
        if (table3.contains("fantasy")) {
            table3 = table3.replace("fantasy", "/");
        }
        String flag1 = "@@";
        String flag2 = "=";
        String undefined = "undefined";
        logger.error(main);


        String[] mains = main.split(flag2, -1);
        String code_auto = mains[0];
        String remark = mains[1];
        String linkMan = mains[2];
        String phone = mains[3];
        String startDate = mains[4];
        String endDate = mains[5];
        String warnDay = mains[6];
        String code = mains[7];
        String type = mains[8];

        String userName = mains[9];
        String explain = mains[10];
        String customId = mains[11];
        String cashM = mains[12];

        int isOk = contractService.modifyCarContract(userName, code, uuid, code_auto, remark, linkMan, phone, startDate, endDate, warnDay, type,
                "car", table1, table2, table2H, table3, table11, table33, explain, Integer.parseInt(customId), Double.parseDouble(cashM));

        contractService.delTable38(uuid);
        contractService.delTable1(uuid);
        contractService.delTable77(uuid);
        Contract contract = contractService.gainContract(uuid);
        HandleController.car(contract);
        if (contract != null) {
            List<Table> table1List = contract.getTableList1();
            for (int i = 0; i < table1List.size(); i++) {
                Table table = table1List.get(i);
                contractService.insertTable1(uuid, "car", table.getTable1(), table.getTable2(), Integer.parseInt(table.getTable7()));
                //车位回写
                contractService.updateCustomCarReg(table.getTable11(), table.getTable8(), table.getTable9(), table.getTable1(), Integer.parseInt(customId));
            }

            List<Table> table33List = contract.getTableList33();
            for (int i = 0; i < table33List.size(); i++) {
                Table table = table33List.get(i);
                contractService.insertTable38(uuid, "car", table.getTable1(), table.getTable0(), table.getTable2(), "", "", "");
            }

        }
        return isOk;
    }


    @RequestMapping(value = "/contract_house/insert", method = RequestMethod.GET)
    public String customInsert(Model model, HttpServletRequest request) {

        List<GoodsStatus> goodsStatusList = contractService.gainGoodsStatus();
        List<Contact> contactList = contractService.gainContact();
        int contactId = -1;
        for (int i = 0; i < contactList.size(); i++) {
            if (contactList.get(i).getName().contains("房")) {

                contactId = contactList.get(i).getId();

                break;
            }
        }
        List<Free> freeList = contractService.gainFree();
        for (int i = 0; i < freeList.size(); i++) {
            if (freeList.get(i).getName().contains("物业")) {
                model.addAttribute("free", freeList.get(i).getPrice());
                break;
            }
        }

        Collections.reverse(goodsStatusList);
        model.addAttribute("freeList", freeList);
        model.addAttribute("goodsStatusList", goodsStatusList);
        model.addAttribute("contactList", contactList);
        model.addAttribute("contractId", contactId);
        model.addAttribute("type", "insert");


        return "contract_house_add";
    }

    @RequestMapping(value = "/contract_ad/insert", method = RequestMethod.GET)
    public String customAdInsert(Model model, HttpServletRequest request) {

        List<GoodsStatus> goodsStatusList = contractService.gainGoodsStatus();
        List<Contact> contactList = contractService.gainContact();
        int contactId = -1;
        for (int i = 0; i < contactList.size(); i++) {
            if (contactList.get(i).getName().contains("广告")) {

                contactId = contactList.get(i).getId();

                break;
            }
        }


        Collections.reverse(goodsStatusList);

        model.addAttribute("goodsStatusList", goodsStatusList);
        model.addAttribute("contactList", contactList);
        model.addAttribute("contractId", contactId);
        model.addAttribute("type", "insert");


        return "contract_ad_add";
    }


    @RequestMapping(value = "/contract_car/insert", method = RequestMethod.GET)
    public String customCarInsert(Model model, HttpServletRequest request) {

        List<GoodsStatus> goodsStatusList = contractService.gainGoodsStatus();
        List<Contact> contactList = contractService.gainContact();
        int contactId = -1;
        for (int i = 0; i < contactList.size(); i++) {
            if (contactList.get(i).getName().contains("车位")) {

                contactId = contactList.get(i).getId();

                break;
            }
        }


        Collections.reverse(goodsStatusList);

        model.addAttribute("goodsStatusList", goodsStatusList);
        model.addAttribute("contactList", contactList);
        model.addAttribute("contractId", contactId);
        model.addAttribute("type", "insert");


        return "contract_car_add";
    }

    @RequestMapping(value = "/contract_house/{code}/code", method = RequestMethod.GET)
    @ResponseBody
    public List<Custom> customCode(Model model, HttpServletRequest request, @PathVariable("code") String code) {
        List<Custom> customList = storageService.gainCustomByCode(code);

        for (int i = 0; i < customList.size(); i++) {
            List<Worker> workerList = storageService.gainWorker(customList.get(i).getUuid());
            List<CarReg> carRegList = storageService.gainCarReg(customList.get(i).getUuid());
            customList.get(i).setWorkerList(workerList);
            customList.get(i).setCarRegList(carRegList);
        }

        return customList;
    }

    @RequestMapping(value = "/contract_house/{loc}/loc", method = RequestMethod.GET)
    @ResponseBody
    public List<House> customLoc(Model model, HttpServletRequest request, @PathVariable("loc") String loc) {
        List<House> houseList = contractService.gainHouse(loc);
        return houseList;
    }

    @RequestMapping(value = "/contract_house/{uuid}/update/del", method = RequestMethod.POST)
    @ResponseBody
    public int customUpdateDel(Model model, HttpServletRequest request, @PathVariable("uuid") String uuid) {
        int isOk = contractService.updateDel(uuid);
        return isOk;
    }

    @RequestMapping(value = "/contract_house/{isFree}/{freeReason}/{otherIn}/{otherOut}/{reason}/{uuid}/{payTotal}/{isOver}/{payIn}/{payOut}/{payFree}/{contractEndDate}/delPay", method = RequestMethod.POST)
    @ResponseBody
    public int customUpdateDelPay(Model model, HttpServletRequest request, @PathVariable("uuid") String uuid
            , @PathVariable("isFree") int isFree, @PathVariable("freeReason") String freeReason, @PathVariable("otherIn") String otherIn
            , @PathVariable("otherOut") String otherOut
            , @PathVariable("reason") String reason, @PathVariable("payTotal") String payTotal, @PathVariable("isOver") int isOver, @PathVariable("payIn") String payIn, @PathVariable("payOut") String payOut, @PathVariable("payFree") double payFree, @PathVariable("contractEndDate") String contractEndDate) {
        int isOk = contractService.updateDel(uuid);
        String ri = "fantasy";
        if (freeReason.equals(ri)) {
            freeReason = "";
        }
        if (otherIn.equals(ri)) {
            otherIn = "";
        }
        if (otherOut.equals(ri)) {
            otherOut = "";
        }
        if (reason.equals(ri)) {
            reason = "";
        }
//        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//        String contractEnd = sdf.format(new Date());

        int isOk2 = handleService.updatePay(1, isFree, freeReason, otherIn, otherOut, reason, uuid, payTotal, isOver, payIn, payOut, contractEndDate, payFree);

        return isOk;
    }

    @RequestMapping(value = "/contract_ad/{loc}/loc", method = RequestMethod.GET)
    @ResponseBody
    public List<House> customAdLoc(Model model, HttpServletRequest request, @PathVariable("loc") String loc) {
        List<House> houseList = contractService.gainAd(loc);
        return houseList;
    }

    @RequestMapping(value = "/contract_car/{loc}/{codeAuto}/{remark}/{customId}/loc", method = RequestMethod.GET)
    @ResponseBody
    public List<House> customCarLoc(Model model, HttpServletRequest request, @PathVariable("loc") String loc, @PathVariable("codeAuto") String codeAuto, @PathVariable("remark") String remark, @PathVariable("customId") int customId) {
        if ("fantasy".equals(remark)) {
            remark = "";
        }
        List<House> houseList = contractService.gainCar(loc);
        List<Custom> customList = storageService.gainCustomById(customId);
        String person = "";
        String phone = "";
        String number = "";
        if (customList != null && customList.size() > 0) {
            List<CarReg> carRegList = storageService.gainCarReg(customList.get(0).getUuid());
            customList.get(0).setCarRegList(carRegList);
//            if (carRegList.size() > 0) {
//                person = carRegList.get(0).getName();
//                phone = carRegList.get(0).getPhone();
//                number = carRegList.get(0).getNo();
//            }
//            for (int j = 0; j < houseList.size(); j++) {
//                houseList.get(j).setPerson(person);
//                houseList.get(j).setPhone(phone);
//                houseList.get(j).setNumber(number);
//            }

            for (int j = 0; j < houseList.size(); j++) {
                houseList.get(j).setCustom(customList.get(0));

            }

        }
        return houseList;
    }
}

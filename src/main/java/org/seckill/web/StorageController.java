package org.seckill.web;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.seckill.entity.*;
import org.seckill.service.BaseService;
import org.seckill.service.ContractService;
import org.seckill.service.HandleService;
import org.seckill.service.StorageService;
import org.seckill.utils.CONST;
import org.seckill.utils.CommUtil;
import org.seckill.utils.ExcelUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.MultipartHttpServletRequest;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import java.io.OutputStream;
import java.io.UnsupportedEncodingException;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;

@Controller
@RequestMapping("/seckill")
public class StorageController {
    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    StorageService storageService;

    @Autowired
    BaseService baseService;

    @Autowired
    HandleService handleService;

    @Autowired
    ContractService contractService;


    /**
     * 导出报表
     *
     * @return
     */
    @RequestMapping(value = "/export_storage")
    @ResponseBody
    public void export(HttpServletRequest request, HttpServletResponse response) throws Exception {
        //获取数据

        String content[][] = new String[3][];

        //excel标题
        String[] title = {"名称", "性别", "年龄", "学校", "班级"};

        //excel文件名
        String fileName = "学生信息表" + System.currentTimeMillis() + ".xls";

        //sheet名
        String sheetName = "学生信息表";

        for (int i = 0; i < 3; i++) {
            content[i] = new String[title.length];

            content[i][0] = "a" + i;
            content[i][1] = "b" + i;
            content[i][2] = "c" + i;
            content[i][3] = "d" + i;
            content[i][4] = "e" + i;

        }

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

    @RequestMapping(value = "/free_report_detail/{loc}/{style}", method = RequestMethod.POST)
    @ResponseBody
    public List<FreeExport> freeLocDetail(Model model, HttpServletRequest request, HttpServletResponse response, @PathVariable("loc") String loc, @PathVariable("style") String style) {
        List<FreeExport> freeExportList = storageService.gainFreeExportBy(loc, style);
//        double firstDegree = 0;
//        double firstContractDegree = 0;
//        double twoDegree = 0;
//        double twoContractDegree = 0;
        double free = 0;
        double water = 0;
        double power = 0;
        double air = 0;
        List<Free> freeList = contractService.gainFree();
        for (int i = 0; i < freeList.size(); i++) {

            if (freeList.get(i).getName().contains("水")) {
                water = Double.parseDouble(freeList.get(i).getPrice());
            }
            if (freeList.get(i).getName().contains("电")) {
                power = Double.parseDouble(freeList.get(i).getPrice());
            }
            if (freeList.get(i).getName().contains("空调")) {
                air = Double.parseDouble(freeList.get(i).getPrice());
            }

        }

        double lastDegree = 0;
        double lastContractDegree = 0;
        String lastType = "";
        double degree0 = 0;
        double total = 0;
        for (int i = 0; i < freeExportList.size(); i++) {

//            FreeExport freeExport = freeExportList.get(i);
//            double degree = 0;
//            try {
//                degree = Double.parseDouble(freeExport.getDegree());
//            } catch (Exception e) {
//
//            }
//            double contractDegree = 0;
//            try {
//                contractDegree = Double.parseDouble(freeExport.getContractDegree());
//            } catch (Exception e) {
//
//            }
            //第一次记录
//            if (i == 0) {
//                lastDegree = degree;
//                lastContractDegree = contractDegree;
//                lastType = freeExport.getSource();
//            } else {
//                if ("contract".equals(lastType)) {
//                    freeExportList.get(i).setUseDegree((lastContractDegree - lastDegree) + "");
//                } else {
//                    freeExportList.get(i).setUseDegree((lastDegree - degree) + "");
//                }
//                lastDegree = degree;
//                lastContractDegree = contractDegree;
//                lastType = freeExport.getSource();
//            }


            FreeExport freeExport = freeExportList.get(i);
            double degree = 0;
            double price = 0;
            try {
                degree = Double.parseDouble(freeExport.getDegree());
            } catch (Exception e) {

            }
            if ("water".equals(style)) {
                price = water;
            } else if ("power".equals(style)) {
                price = power;
            } else if ("air".equals(style)) {
                price = air;
            }

            freeExportList.get(i).setTotal(0);
            freeExportList.get(i).setPrice(price + "");
            if (freeExportList.size() == 1) {
                freeExportList.get(i).setTotal(0);
                freeExportList.get(i).setUseDegree(0 + "");
            }

            if (freeExportList.size() > 1) {
                if (i == 0) {
                    try {
                        degree0 = Double.parseDouble(freeExport.getDegree());
                    } catch (Exception e) {

                    }
                }
//                else if (i == 1) {
//                    try {
//                        double degreeNow = Double.parseDouble(freeExport.getDegree());
//                        freeExportList.get(0).setTotal((degree0 - degreeNow) * price);
//                        freeExportList.get(0).setUseDegree((degree0 - degreeNow) + "");
//                        degree0 = Double.parseDouble(freeExport.getDegree());
//                    } catch (Exception e) {
//
//                    }
//
//                }
                else {
                    try {
                        double degreeNow = Double.parseDouble(freeExport.getDegree());
                        freeExportList.get(i - 1).setTotal((degree0 - degreeNow) * price);
                        freeExportList.get(i - 1).setUseDegree((degree0 - degreeNow) + "");
                        degree0 = Double.parseDouble(freeExport.getDegree());
                    } catch (Exception e) {

                    }
                }

            }

        }

        return freeExportList;
    }

    /**
     * 客户资源
     */
    @RequestMapping(value = "/custom_detail/{userId}/{page}/{export}", method = RequestMethod.GET)
    public String customDetail(Model model, HttpServletRequest request, @PathVariable("userId") int userId, @PathVariable("page") int page, @PathVariable("export") String export, HttpServletResponse response) {
        String role4 = baseService.getRole(userId, "role4");
        String is_admin = CommUtil.showIsAdminCookie(request);

        model.addAttribute("role4", role4);
        model.addAttribute("is_admin", is_admin);
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);

        List<Custom> customList = storageService.gainCustom(page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int totalNum = 0;
        for (int i = 0; i < customList.size(); i++) {
            customList.get(i).setC(0);
            String uuid = customList.get(i).getUuid();
            List<Worker> workerList = storageService.gainWorker(uuid);

            customList.get(i).setWorkerList(workerList);

            int count = storageService.gainRentCustom(customList.get(i).getId());
            if (count > 0) {
                customList.get(i).setIsRent("是");
            } else {
                customList.get(i).setIsRent("否");
            }
            int num = storageService.gainRentCustomNum(customList.get(i).getId());
            customList.get(i).setNum(num);

            totalNum += num;


        }

        int total = storageService.gainCustomTotal();

        model.addAttribute("customList", customList);
        model.addAttribute("total", total);
        model.addAttribute("totalNum", totalNum);

        if ("export".equals(export)) {
            //获取数据

            String content[][] = new String[customList.size() + 1][];

            //excel标题
            String[] title = {"序号", "客户名称", "备注", "法人", "法人电话", "主要财务", "财务电话", "联系人", "联系电话", "企业注册信息", "是否在租", "数量"};
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
            //excel文件名
            String fileName = "客户报表" + sdf.format(new Date()) + ".xls";

            //sheet名
            String sheetName = "客户报表";

            for (int i = 0; i < customList.size(); i++) {
                content[i] = new String[title.length];

                content[i][0] = customList.get(i).getId() + "";
                content[i][1] = customList.get(i).getName();
                content[i][2] = customList.get(i).getRemark();
                List<Worker> workerList = customList.get(i).getWorkerList();
                for (int w = 0; w < workerList.size(); w++) {
                    if ("法人".equals(workerList.get(w).getDuty())) {
                        content[i][3] = workerList.get(w).getName();
                        content[i][4] = workerList.get(w).getPhone();
                        break;
                    }
                }
                for (int w = 0; w < workerList.size(); w++) {
                    if ("主要财务".equals(workerList.get(w).getDuty())) {
                        content[i][5] = workerList.get(w).getName();
                        content[i][6] = workerList.get(w).getPhone();
                        break;
                    }
                }
                for (int w = 0; w < workerList.size(); w++) {
                    if (!"法人".equals(workerList.get(w).getDuty())) {
                        if (!"主要财务".equals(workerList.get(w).getDuty())) {
                            content[i][7] = workerList.get(w).getName();
                            content[i][8] = workerList.get(w).getPhone();
                            break;
                        }
                    }
                }
                content[i][9] = customList.get(i).getRegisterInfo();
                content[i][10] = customList.get(i).getIsRent();
                content[i][11] = customList.get(i).getNum() + "";

            }
            content[customList.size()] = new String[title.length];
            content[customList.size()][0] = "合计" + "";
            content[customList.size()][11] = totalNum + "";

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

        return "custom_detail";
    }

    @RequestMapping(value = "/custom/{userId}/{page}/{export}", method = RequestMethod.GET)
    public String custom(Model model, HttpServletRequest request, @PathVariable("userId") int userId, @PathVariable("page") int page
            , @PathVariable("export") String export, HttpServletResponse response) {
        String role4 = baseService.getRole(userId, "role4");
        String is_admin = CommUtil.showIsAdminCookie(request);

        model.addAttribute("role4", role4);
        model.addAttribute("is_admin", is_admin);
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);

        List<Custom> customList = storageService.gainCustom(page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);

        for (int i = 0; i < customList.size(); i++) {
            customList.get(i).setC(0);
            String uuid = customList.get(i).getUuid();
            List<Worker> workerList = storageService.gainWorker(uuid);

            customList.get(i).setWorkerList(workerList);

        }

        int total = storageService.gainCustomTotal();

        model.addAttribute("customList", customList);
        model.addAttribute("total", total);

        if ("export".equals(export)) {
            //获取数据

            String content[][] = new String[customList.size()][];

            //excel标题
            String[] title = {"序号", "客户名称", "备注", "联系人", "联系电话"};
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
            //excel文件名
            String fileName = "客户汇总表" + sdf.format(new Date()) + ".xls";

            //sheet名
            String sheetName = "客户汇总表";

            for (int i = 0; i < customList.size(); i++) {
                content[i] = new String[title.length];

                content[i][0] = customList.get(i).getId() + "";
                content[i][1] = customList.get(i).getName();
                content[i][2] = customList.get(i).getRemark();
                List<Worker> workerList = customList.get(i).getWorkerList();
                if (workerList.size() > 0) {
                    content[i][3] = workerList.get(0).getName();
                    content[i][4] = workerList.get(0).getPhone();
                } else {
                    content[i][3] = "";
                    content[i][4] = "";
                }


            }

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


        return "custom";
    }

    @RequestMapping(value = "/custom/{userId}/{page}/{code}/{linkMan}/query/{export}", method = RequestMethod.GET)
    public String customQuery(Model model, HttpServletRequest request, @PathVariable("userId") int userId,
                              @PathVariable("page") int page, @PathVariable("code") String code,
                              @PathVariable("linkMan") String linkMan, @PathVariable("export") String export, HttpServletResponse response) {
        String role4 = baseService.getRole(userId, "role4");
        String is_admin = CommUtil.showIsAdminCookie(request);

        model.addAttribute("role4", role4);
        model.addAttribute("is_admin", is_admin);
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        model.addAttribute("query", "query");
        if (CONST.RS.equals(code)) {
            code = "";
        }
        if (CONST.RS.equals(linkMan)) {
            linkMan = "";
        }
        model.addAttribute("code", code);
        model.addAttribute("linkMan", linkMan);
        List<Custom> customList = storageService.gainCustomQuery(code, linkMan, page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        for (int i = 0; i < customList.size(); i++) {
            String uuid = customList.get(i).getUuid();
            List<Worker> workerList = storageService.gainWorker(uuid);

            customList.get(i).setWorkerList(workerList);

        }
        int total = storageService.gainCustomQueryTotal(code, linkMan).size();

        model.addAttribute("customList", customList);
        model.addAttribute("total", total);
        if ("export".equals(export)) {
            //获取数据

            String content[][] = new String[customList.size()][];

            //excel标题
            String[] title = {"序号", "客户名称", "备注", "联系人", "联系电话"};
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
            //excel文件名
            String fileName = "客户汇总表" + sdf.format(new Date()) + ".xls";

            //sheet名
            String sheetName = "客户汇总表";

            for (int i = 0; i < customList.size(); i++) {
                content[i] = new String[title.length];

                content[i][0] = customList.get(i).getId() + "";
                content[i][1] = customList.get(i).getName();
                content[i][2] = customList.get(i).getRemark();
                List<Worker> workerList = customList.get(i).getWorkerList();
                if (workerList.size() > 0) {
                    content[i][3] = workerList.get(0).getName();
                    content[i][4] = workerList.get(0).getPhone();
                } else {
                    content[i][3] = "";
                    content[i][4] = "";
                }


            }

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

        return "custom";
    }

    @RequestMapping(value = "/custom_detail/{userId}/{page}/{code}/{linkMan}/query/{export}", method = RequestMethod.GET)
    public String customDetailQuery(Model model, HttpServletRequest request, @PathVariable("userId") int userId,
                                    @PathVariable("page") int page, @PathVariable("code") String code,
                                    @PathVariable("linkMan") String linkMan, @PathVariable("export") String export, HttpServletResponse response) {
        String role4 = baseService.getRole(userId, "role4");
        String is_admin = CommUtil.showIsAdminCookie(request);

        model.addAttribute("role4", role4);
        model.addAttribute("is_admin", is_admin);
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        model.addAttribute("query", "query");
        if (CONST.RS.equals(code)) {
            code = "";
        }
        if (CONST.RS.equals(linkMan)) {
            linkMan = "";
        }
        model.addAttribute("code", code);
        model.addAttribute("linkMan", linkMan);
        List<Custom> customList = storageService.gainCustomQuery(code, linkMan, page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int totalNum = 0;
        for (int i = 0; i < customList.size(); i++) {
            String uuid = customList.get(i).getUuid();
            List<Worker> workerList = storageService.gainWorker(uuid);

            customList.get(i).setWorkerList(workerList);

            int count = storageService.gainRentCustom(customList.get(i).getId());
            if (count > 0) {
                customList.get(i).setIsRent("是");
            } else {
                customList.get(i).setIsRent("是");
            }
            int num = storageService.gainRentCustomNum(customList.get(i).getId());
            customList.get(i).setNum(num);

            totalNum += num;


        }
        int total = storageService.gainCustomQueryTotal(code, linkMan).size();

        model.addAttribute("customList", customList);
        model.addAttribute("total", total);
        model.addAttribute("totalNum", totalNum);

        if ("export".equals(export)) {
            //获取数据

            String content[][] = new String[customList.size() + 1][];

            //excel标题
            String[] title = {"序号", "客户名称", "备注", "法人", "法人电话", "主要财务", "财务电话", "联系人", "联系电话", "企业注册信息", "是否在租", "数量"};
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
            //excel文件名
            String fileName = "客户报表" + sdf.format(new Date()) + ".xls";

            //sheet名
            String sheetName = "客户报表";

            for (int i = 0; i < customList.size(); i++) {
                content[i] = new String[title.length];

                content[i][0] = customList.get(i).getId() + "";
                content[i][1] = customList.get(i).getName();
                content[i][2] = customList.get(i).getRemark();
                List<Worker> workerList = customList.get(i).getWorkerList();
                for (int w = 0; w < workerList.size(); w++) {
                    if ("法人".equals(workerList.get(w).getDuty())) {
                        content[i][3] = workerList.get(w).getName();
                        content[i][4] = workerList.get(w).getPhone();
                        break;
                    }
                }
                for (int w = 0; w < workerList.size(); w++) {
                    if ("主要财务".equals(workerList.get(w).getDuty())) {
                        content[i][5] = workerList.get(w).getName();
                        content[i][6] = workerList.get(w).getPhone();
                        break;
                    }
                }
                for (int w = 0; w < workerList.size(); w++) {
                    if (!"法人".equals(workerList.get(w).getDuty())) {
                        if (!"主要财务".equals(workerList.get(w).getDuty())) {
                            content[i][7] = workerList.get(w).getName();
                            content[i][8] = workerList.get(w).getPhone();
                            break;
                        }
                    }
                }
                content[i][9] = customList.get(i).getRegisterInfo();
                content[i][10] = customList.get(i).getIsRent();
                content[i][11] = customList.get(i).getNum() + "";

            }
            content[customList.size()] = new String[title.length];
            content[customList.size()][0] = "合计" + "";
            content[customList.size()][11] = totalNum + "";

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

        return "custom_detail";
    }


    @RequestMapping(value = "/custom/{custom}/{worker}/{company}/{carReg}/{bad}/{registerInfo}/insert", method = RequestMethod.POST)
    @ResponseBody
    public int customAdd(Model model, HttpServletRequest request, @PathVariable("custom") String custom
            , @PathVariable("worker") String worker, @PathVariable("company") String company
            , @PathVariable("carReg") String carReg, @PathVariable("bad") String bad, @PathVariable("registerInfo") String registerInfo) {
        if (custom.contains("fantasy")) {
            custom = custom.split("fantasy")[0] + "/" + custom.split("fantasy")[1];
        }
        if (registerInfo.contains("fantasy")) {
            registerInfo = "";
        }
        String flag1 = ",";
        String flag2 = "=";
        String undefined = "undefined";

        custom = custom.replace(undefined, "");
        String[] customs = custom.split(flag2);

        worker = worker.replace(undefined, "");
        String[] workers = worker.split(flag2);
        List<String> nameW = new ArrayList<String>();
        List<String> phoneW = new ArrayList<String>();
        List<String> dutyW = new ArrayList<String>();
        List<String> linkW = new ArrayList<String>();
        for (int i = 0; i < workers.length; i++) {
            String w[] = workers[i].split(flag1);
            List<String> ws = new ArrayList<String>();
            for (String s : w) {
                ws.add(s);
            }
            if (i == 0) {
                nameW = ws;
            } else if (i == 1) {
                phoneW = ws;
            } else if (i == 2) {
                dutyW = ws;
            } else if (i == 3) {
                linkW = ws;
            }
        }

        company = company.replace(undefined, "");
        String[] compnays = company.split(flag2);
        List<String> noC = new ArrayList<String>();
        List<String> nameC = new ArrayList<String>();

        for (int i = 0; i < compnays.length; i++) {
            String w[] = compnays[i].split(flag1);
            List<String> ws = new ArrayList<String>();
            for (String s : w) {
                ws.add(s);
            }
            if (i == 0) {
                noC = ws;
            } else if (i == 1) {
                nameC = ws;
            }
        }

        carReg = carReg.replace(undefined, "");
        String[] carRegs = carReg.split(flag2);
        List<String> noR = new ArrayList<String>();
        List<String> nameR = new ArrayList<String>();
        List<String> phoneR = new ArrayList<String>();

        for (int i = 0; i < carRegs.length; i++) {
            String w[] = carRegs[i].split(flag1);
            List<String> ws = new ArrayList<String>();
            for (String s : w) {
                ws.add(s);
            }
            if (i == 0) {
                noR = ws;
            } else if (i == 1) {
                nameR = ws;
            } else if (i == 2) {
                phoneR = ws;
            }
        }

        bad = bad.replace(undefined, "");
        String[] bads = bad.split(flag2);
        List<String> dateB = new ArrayList<String>();
        List<String> placeB = new ArrayList<String>();
        List<String> contentB = new ArrayList<String>();

        for (int i = 0; i < bads.length; i++) {
            String w[] = bads[i].split(flag1);
            List<String> ws = new ArrayList<String>();
            for (String s : w) {
                ws.add(s);
            }
            if (i == 0) {
                dateB = ws;
            } else if (i == 1) {
                placeB = ws;
            } else if (i == 2) {
                contentB = ws;
            }
        }
        String uuid = CommUtil.getUUID32();
        storageService.addCustom(customs[0], customs.length > 1 ? customs[1] : "", customs.length > 2 ? customs[2] : "", uuid, registerInfo);
        int wMax = maxIndex(nameW.size(), phoneW.size(), dutyW.size(), linkW.size());
        for (int i = 0; i < wMax; i++) {
            String t = parse(nameW, i) + parse(phoneW, i) + parse(dutyW, i) + parse(linkW, i);
            if (!"".equals(t)) {
                storageService.addWorker(parse(nameW, i), parse(phoneW, i), parse(dutyW, i), parse(linkW, i), uuid);
            }
        }
        int cMax = maxIndex(noC.size(), nameC.size());
        for (int i = 0; i < cMax; i++) {
            String t = parse(noC, i) + parse(nameC, i);
            if (!"".equals(t)) {
                storageService.addCompany(parse(nameC, i), parse(noC, i), uuid);
            }
        }
        int rMax = maxIndex(nameR.size(), phoneR.size(), noR.size());
        for (int i = 0; i < rMax; i++) {
            String t = parse(nameR, i) + parse(phoneR, i) + parse(noR, i);
            if (!"".equals(t)) {
                storageService.addCarReg(parse(nameR, i), parse(phoneR, i), parse(noR, i), uuid);
            }
        }
        int bMax = maxIndex(dateB.size(), placeB.size(), contentB.size());
        for (int i = 0; i < bMax; i++) {
            String t = parse(dateB, i) + parse(placeB, i) + parse(contentB, i);
            if (!"".equals(t)) {
                storageService.addBad(parse(dateB, i), parse(placeB, i), parse(contentB, i), uuid);
            }
        }

        return 1;
    }


    @RequestMapping(value = "/custom/{custom}/{worker}/{company}/{carReg}/{bad}/{uuid}/{customId}/{registerInfo}/update", method = RequestMethod.POST)
    @ResponseBody
    public int customUpdate(Model model, HttpServletRequest request, @PathVariable("custom") String custom
            , @PathVariable("worker") String worker, @PathVariable("company") String company
            , @PathVariable("carReg") String carReg, @PathVariable("bad") String bad, @PathVariable("uuid") String pUuid, @PathVariable("customId") int customId, @PathVariable("registerInfo") String registerInfo) {
        if (custom.contains("fantasy")) {
            custom = custom.split("fantasy")[0] + "/" + custom.split("fantasy")[1];
        }
        if (registerInfo.contains("fantasy")) {
            registerInfo = "";
        }
        String flag1 = ",";
        String flag2 = "=";
        String undefined = "undefined";

        storageService.delCustom(pUuid);
        storageService.delWorker(pUuid);
        storageService.delCarReg(pUuid);
        storageService.delBad(pUuid);

        custom = custom.replace(undefined, "");
        String[] customs = custom.split(flag2);

        worker = worker.replace(undefined, "");
        String[] workers = worker.split(flag2);
        List<String> nameW = new ArrayList<String>();
        List<String> phoneW = new ArrayList<String>();
        List<String> dutyW = new ArrayList<String>();
        List<String> linkW = new ArrayList<String>();
        for (int i = 0; i < workers.length; i++) {
            String w[] = workers[i].split(flag1);
            List<String> ws = new ArrayList<String>();
            for (String s : w) {
                ws.add(s);
            }
            if (i == 0) {
                nameW = ws;
            } else if (i == 1) {
                phoneW = ws;
            } else if (i == 2) {
                dutyW = ws;
            } else if (i == 3) {
                linkW = ws;
            }
        }

        company = company.replace(undefined, "");
        String[] compnays = company.split(flag2);
        List<String> noC = new ArrayList<String>();
        List<String> nameC = new ArrayList<String>();

        for (int i = 0; i < compnays.length; i++) {
            String w[] = compnays[i].split(flag1);
            List<String> ws = new ArrayList<String>();
            for (String s : w) {
                ws.add(s);
            }
            if (i == 0) {
                noC = ws;
            } else if (i == 1) {
                nameC = ws;
            }
        }

        carReg = carReg.replace(undefined, "");
        String[] carRegs = carReg.split(flag2);
        List<String> noR = new ArrayList<String>();
        List<String> nameR = new ArrayList<String>();
        List<String> phoneR = new ArrayList<String>();

        for (int i = 0; i < carRegs.length; i++) {
            String w[] = carRegs[i].split(flag1);
            List<String> ws = new ArrayList<String>();
            for (String s : w) {
                ws.add(s);
            }
            if (i == 0) {
                noR = ws;
            } else if (i == 1) {
                nameR = ws;
            } else if (i == 2) {
                phoneR = ws;
            }
        }

        bad = bad.replace(undefined, "");
        String[] bads = bad.split(flag2);
        List<String> dateB = new ArrayList<String>();
        List<String> placeB = new ArrayList<String>();
        List<String> contentB = new ArrayList<String>();

        for (int i = 0; i < bads.length; i++) {
            String w[] = bads[i].split(flag1);
            List<String> ws = new ArrayList<String>();
            for (String s : w) {
                ws.add(s);
            }
            if (i == 0) {
                dateB = ws;
            } else if (i == 1) {
                placeB = ws;
            } else if (i == 2) {
                contentB = ws;
            }
        }
        String uuid = pUuid;

        storageService.addCustom(customs[0], customs.length > 1 ? customs[1] : "", customs.length > 2 ? customs[2] : "", uuid, registerInfo);
        int wMax = maxIndex(nameW.size(), phoneW.size(), dutyW.size(), linkW.size());
        for (int i = 0; i < wMax; i++) {
            String t = parse(nameW, i) + parse(phoneW, i) + parse(dutyW, i) + parse(linkW, i);
            if (!"".equals(t)) {
                storageService.addWorker(parse(nameW, i), parse(phoneW, i), parse(dutyW, i), parse(linkW, i), uuid);
            }
        }
        int cMax = maxIndex(noC.size(), nameC.size());
        for (int i = 0; i < cMax; i++) {
            String t = parse(noC, i) + parse(nameC, i);
            if (!"".equals(t)) {
                storageService.addCompany(parse(nameC, i), parse(noC, i), uuid);
            }
        }
        int rMax = maxIndex(nameR.size(), phoneR.size(), noR.size());
        for (int i = 0; i < rMax; i++) {
            String t = parse(nameR, i) + parse(phoneR, i) + parse(noR, i);
            if (!"".equals(t)) {
                storageService.addCarReg(parse(nameR, i), parse(phoneR, i), parse(noR, i), uuid);
            }
        }
        int bMax = maxIndex(dateB.size(), placeB.size(), contentB.size());
        for (int i = 0; i < bMax; i++) {
            String t = parse(dateB, i) + parse(placeB, i) + parse(contentB, i);
            if (!"".equals(t)) {
                storageService.addBad(parse(dateB, i), parse(placeB, i), parse(contentB, i), uuid);
            }
        }

        storageService.updateCustomIdByUuid(uuid, customId);

        return 1;
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

    @RequestMapping(value = "/custom/{uuid}/{name}/del", method = RequestMethod.POST)
    @ResponseBody
    public int customDel(Model model, HttpServletRequest request, @PathVariable("uuid") String uuid, @PathVariable("name") String name) {

//        List<Custom> customList = storageService.gainCustomNameList(name);
//        for (int i = 0; i < customList.size(); i++) {
//            storageService.delCustom(customList.get(i).getUuid());
//            storageService.delWorker(customList.get(i).getUuid());
//            storageService.delCarReg(customList.get(i).getUuid());
//            storageService.delBad(customList.get(i).getUuid());
//        }
//        storageService.delCustomByName(name);
        storageService.delCustom(uuid);
        storageService.delWorker(uuid);
        storageService.delCompany(uuid);
        storageService.delCarReg(uuid);
        storageService.delBad(uuid);


        return 1;
    }

    @RequestMapping(value = "/custom/insert", method = RequestMethod.GET)
    public String customInsert(Model model, HttpServletRequest request) {
        model.addAttribute("count", 0);
        return "custom_add";
    }


    @RequestMapping(value = "/custom/{uuid}/{name}/update", method = RequestMethod.GET)

    public String customUpdate(Model model, HttpServletRequest request, @PathVariable("uuid") String uuid, @PathVariable("name") String name) {
//        Custom mCustom = null;
//        List<Custom> mCustomList = new ArrayList<Custom>();
        Custom mCustom = storageService.gainCustomOne(uuid);
        List<Worker> workerList = storageService.gainWorker(uuid);
        List<Company> companyList = storageService.gainCompany(uuid);
        List<CarReg> carRegList = storageService.gainCarReg(uuid);
        List<Bad> badList = storageService.gainBad(uuid);
        mCustom.setWorkerList(workerList);
        mCustom.setCompanyList(companyList);
        mCustom.setCarRegList(carRegList);
        mCustom.setBadList(badList);
        String selectUuid = "";
        //获取以前租的合同
        List<Contract> contractList = contractService.gainCustomByLinkManAndRemark(name, mCustom.getRemark());
        for (int i = 0; i < contractList.size(); i++) {
            HandleController.house(contractList.get(i));
        }
        mCustom.setContractList(contractList);
        logger.error("contractList:" + contractList.toString());

//        for (int i = 0; i < customList.size(); i++) {
//            if (i == 0) {
//                Custom custom = storageService.gainCustomOne(customList.get(i).getUuid());
//                List<Worker> workerList = storageService.gainWorker(customList.get(i).getUuid());
//                List<Company> companyList = storageService.gainCompany(customList.get(i).getUuid());
//                List<CarReg> carRegList = storageService.gainCarReg(customList.get(i).getUuid());
//                List<Bad> badList = storageService.gainBad(customList.get(i).getUuid());
//
//                custom.setWorkerList(workerList);
//                custom.setCompanyList(companyList);
//                custom.setCarRegList(carRegList);
//                custom.setBadList(badList);
//                mCustom = custom;
//
//
//            }
//            logger.error("customUUID:" + customList.get(i).getUuid());
//            Custom custom = storageService.gainCustomOne(customList.get(i).getUuid());
//            List<Worker> workerList = storageService.gainWorker(customList.get(i).getUuid());
//            List<Company> companyList = storageService.gainCompany(customList.get(i).getUuid());
//            List<CarReg> carRegList = storageService.gainCarReg(customList.get(i).getUuid());
//            List<Bad> badList = storageService.gainBad(customList.get(i).getUuid());
//            custom.setWorkerList(workerList);
//            custom.setCompanyList(companyList);
//            custom.setCarRegList(carRegList);
//            custom.setBadList(badList);
//            if (custom.getRemark() == null || "".equals(custom.getRemark())) {
//                custom.setRemark("暂无");
//            }
//
//            selectUuid += custom.getUuid();
//
//            mCustomList.add(custom);
//
//
//        }
//
//        mCustom.setCustomList(mCustomList);
//        mCustom.setC(customList.size());
//        mCustom.setSelectUuid(selectUuid);

        model.addAttribute("count", 1);
        model.addAttribute("id", 1);
        model.addAttribute("custom", mCustom);
        return "custom_add";
    }

    /**
     * 房子,车位,广告
     *
     * @return
     */

    @RequestMapping(value = "/house/{userId}/{page}/{house}/{export}", method = RequestMethod.GET)
    public String list(Model model, HttpServletRequest request, HttpServletResponse response, @PathVariable("userId") int userId, @PathVariable("page") int page, @PathVariable("house") String house, @PathVariable("export") String export) {
        String role4 = baseService.getRole(userId, "role4");
        String is_admin = CommUtil.showIsAdminCookie(request);

        model.addAttribute("role4", role4);
        model.addAttribute("is_admin", is_admin);
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        String fileNameSort = "";
        int type = 0;
        if ("house".equals(house)) {
            fileNameSort = "房源";
            type = 0;
        } else if ("house_ad".equals(house)) {
            fileNameSort = "广告位";
            type = 1;
        } else if ("house_car".equals(house)) {
            fileNameSort = "车位";
            type = 2;
        }
        List<House> houseList = storageService.gainHouse(page * CONST.PAGE_SIZE, CONST.PAGE_SIZE, type);
        int total = storageService.gainHouseTotal(type);
        int totalNum = storageService.totalNum(page * CONST.PAGE_SIZE, CONST.PAGE_SIZE, type);
        model.addAttribute("total", total);
        model.addAttribute("houseList", houseList);
        model.addAttribute("totalNum", totalNum);
        logger.error("houseList:" + houseList);

        if ("export".equals(export) && "house".equals(house)) {
            //获取数据

            String content[][] = new String[houseList.size() + 1][];

            //excel标题
            String[] title = {"序号", "商品名称", "位置编号", "楼层", "建筑面积", "是否带窗", "状态", "数量"};
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
            //excel文件名
            String fileName = fileNameSort + "资源报表" + sdf.format(new Date()) + ".xls";

            //sheet名
            String sheetName = fileNameSort + "资源报表";

            for (int i = 0; i < houseList.size(); i++) {
                content[i] = new String[title.length];

                content[i][0] = houseList.get(i).getId() + "";
                content[i][1] = houseList.get(i).getName();
                content[i][2] = houseList.get(i).getLocation();
                content[i][3] = houseList.get(i).getFloor() + "";
                content[i][4] = houseList.get(i).getBuildArea() + "";
                content[i][5] = houseList.get(i).getIsWindow() == 1 ? "是" : "否";
                content[i][6] = houseList.get(i).getGoodsStatusName() + "";
                content[i][7] = houseList.get(i).getNum() + "";
            }
            content[houseList.size()] = new String[title.length];
            content[houseList.size()][0] = "合计" + "";
            content[houseList.size()][7] = totalNum + "";

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
        if ("export".equals(export) && "house_ad".equals(house)) {
            //获取数据

            String content[][] = new String[houseList.size() + 1][];

            //excel标题
            String[] title = {"序号", "商品名称", "位置编号", "楼层", "类型", "状态", "数量"};
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
            //excel文件名
            String fileName = fileNameSort + "资源报表" + sdf.format(new Date()) + ".xls";

            //sheet名
            String sheetName = fileNameSort + "资源报表";

            for (int i = 0; i < houseList.size(); i++) {
                content[i] = new String[title.length];

                content[i][0] = houseList.get(i).getId() + "";
                content[i][1] = houseList.get(i).getName();
                content[i][2] = houseList.get(i).getLocation();
                content[i][3] = houseList.get(i).getFloor() + "";
                content[i][4] = houseList.get(i).getAdName() + "";
                content[i][5] = houseList.get(i).getGoodsStatusName() + "";
                content[i][6] = houseList.get(i).getNum() + "";
            }
            content[houseList.size()] = new String[title.length];
            content[houseList.size()][0] = "合计" + "";
            content[houseList.size()][6] = totalNum + "";

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
        if ("export".equals(export) && "house_car".equals(house)) {
            //获取数据

            String content[][] = new String[houseList.size() + 1][];

            //excel标题
            String[] title = {"序号", "商品名称", "位置编号", "类型", "状态", "数量"};
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
            //excel文件名
            String fileName = fileNameSort + "资源报表" + sdf.format(new Date()) + ".xls";

            //sheet名
            String sheetName = fileNameSort + "资源报表";

            for (int i = 0; i < houseList.size(); i++) {
                content[i] = new String[title.length];

                content[i][0] = houseList.get(i).getId() + "";
                content[i][1] = houseList.get(i).getName();
                content[i][2] = houseList.get(i).getLocation();
                content[i][3] = houseList.get(i).getAdName();
                content[i][4] = houseList.get(i).getGoodsStatusName() + "";
                content[i][5] = houseList.get(i).getNum() + "";
            }
            content[houseList.size()] = new String[title.length];
            content[houseList.size()][0] = "合计" + "";
            content[houseList.size()][5] = totalNum + "";

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
        return house;
    }

    @RequestMapping(value = "/house/freeExport/{type}", method = RequestMethod.GET)
    public String freeReport(Model model, HttpServletRequest request, HttpServletResponse response, @PathVariable("type") String type) {
        model.addAttribute("type", type);

        List<FreeExport> freeExportList = storageService.gainFreeExportGroup(type);
        model.addAttribute("freeExportList", freeExportList);
        return "free_report";
    }

    @RequestMapping(value = "/house/freeExport/list/{userId}/{type}/{page}", method = RequestMethod.GET)

    public String freeReportList(Model model, HttpServletRequest request, HttpServletResponse response, @PathVariable("type") String type, @PathVariable("page") int page, @PathVariable("userId") int userId) {
        model.addAttribute("type", type);
        double free = 0;
        double water = 0;
        double power = 0;
        double air = 0;
        List<Free> freeList = contractService.gainFree();
        for (int i = 0; i < freeList.size(); i++) {

            if (freeList.get(i).getName().contains("水")) {
                water = Double.parseDouble(freeList.get(i).getPrice());
            }
            if (freeList.get(i).getName().contains("电")) {
                power = Double.parseDouble(freeList.get(i).getPrice());
            }
            if (freeList.get(i).getName().contains("空调")) {
                air = Double.parseDouble(freeList.get(i).getPrice());
            }

        }
        double degree0 = 0;
        List<FreeExport> freeExportList = storageService.gainFreeExportDateAndLoc(type, page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        for (int i = 0; i < freeExportList.size(); i++) {
            FreeExport freeExport = freeExportList.get(i);
            List<FreeExport> freeExportNewList = storageService.gainFreeExportBy(freeExport.getLoc(), freeExport.getType());


            double degree = 0;
            double price = 0;

            if ("water".equals(type)) {
                price = water;
            } else if ("power".equals(type)) {
                price = power;
            } else if ("air".equals(type)) {
                price = air;
            }


            freeExportList.get(i).setTotal(0);
            freeExportList.get(i).setPrice(price + "");
            for (int j = 0; j < freeExportNewList.size(); j++) {
                freeExportNewList.get(0).setPrice(price + "");
                if (freeExportNewList.size() == 1) {
                    freeExportNewList.get(j).setTotal(0);
                    freeExportNewList.get(j).setUseDegree(0 + "");
                }

                if (freeExportNewList.size() > 1) {
                    if (j == 0) {

                        try {
                            degree0 = Double.parseDouble(freeExportNewList.get(j).getDegree());
                        } catch (Exception e) {

                        }
                    } else if (j == 1) {
                        try {
                            double degreeNow = Double.parseDouble(freeExportNewList.get(j).getDegree());
                            if ((degree0 - degreeNow) <= 0) {
                                freeExportNewList.get(0).setTotal(0);
                                freeExportNewList.get(0).setUseDegree(0 + "");
                            } else {
                                freeExportNewList.get(0).setTotal((degree0 - degreeNow) * price);
                                freeExportNewList.get(0).setUseDegree((degree0 - degreeNow) + "");

                            }
                        } catch (Exception e) {

                        }
                    } else {
                        // break;
                    }

                }
            }
            if (freeExportNewList.size() > 0) {
                freeExportList.remove(i);
                freeExportList.add(i, freeExportNewList.get(0));
            }

        }
        model.addAttribute("freeExportList", freeExportList);
        model.addAttribute("page",page);
        model.addAttribute("pageSize",CONST.PAGE_SIZE);
        model.addAttribute("total",freeExportList.size());
        return "money_water";
    }

    @RequestMapping(value = "/house/freeExport/{id}/del", method = RequestMethod.POST)
    @ResponseBody
    public Integer freeReportList(Model model, HttpServletRequest request, HttpServletResponse response, @PathVariable("id") int id) {

        storageService.delFreeExport(id);
        return 1;
    }


    @RequestMapping(value = "/house/freeExport/handle/{type}", method = RequestMethod.GET)
    public String freeReportHandle(Model model, HttpServletRequest request, HttpServletResponse response, @PathVariable("type") String type) {
        model.addAttribute("type", type);

        return "free_handle";
    }

    @RequestMapping(value = "/house/freeExport/handle/add/{data}", method = RequestMethod.POST)
    @ResponseBody
    public int freeReportHandleAdd(Model model, HttpServletRequest request, HttpServletResponse response, @PathVariable("data") String data) {
        String flag1 = "@@";
        String datas[] = data.split(flag1);
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        String log = datas[0] + datas[1] + datas[2] + datas[3] + datas[4];
        if (!"".equals(log)) {
            storageService.insertFreeExport(datas[0], datas[1], datas[2], datas[3], datas[4], "handle", sdf.format(new Date()), "", "");

        }
        return 1;
    }

    @RequestMapping(value = "/house/freeExport/update/{date}/{degree}/{id}", method = RequestMethod.POST)
    @ResponseBody
    public int freeReportUpdate(Model model, HttpServletRequest request, HttpServletResponse response,
                                @PathVariable("date") String date, @PathVariable("degree") String degree,
                                @PathVariable("id") int id) {
        if (date.equals("fantasy")) {
            date = "";
        }
        storageService.updateFreeExportDateAndDegree(id, date, degree);
        return 1;
    }


    @RequestMapping(value = "/house/freeExport/add/{type}", method = RequestMethod.POST)
    public String freeReportAdd(Model model, HttpServletRequest request,
                                @PathVariable("type") String type) throws ParseException {
        try {

            int count = 0;//导入总条数
            MultipartHttpServletRequest multipartHttpServletRequest = (MultipartHttpServletRequest) request;
            MultipartFile file = multipartHttpServletRequest.getFile("uploadXls");
            List<List<Object>> list = ExcelUtil.getExcelList(file.getInputStream(), file.getOriginalFilename());
            count = list.size();
            SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
            String createTime = simpleDateFormat.format(new Date());
            //title,content,author,createtime,category_id,pic
            for (int i = 0; i < list.size(); i++) {
                List<Object> lo = list.get(i);
                FreeExport freeExport = new FreeExport();
                freeExport.setLoc(lo.get(0).toString());
                freeExport.setNo(lo.get(1).toString());
                freeExport.setDate(lo.get(2).toString());
                freeExport.setDegree(lo.get(3).toString());
//                SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//                String strTime = sdf.format(sdf.parse(lo.get(2).toString()));
//                freeExport.setDegree(strTime);
                String date = lo.get(2).toString();
                try {
                    if (date.contains("/")) {
                        String dates[] = date.split("/");
                        String deteTemp = dates[0] + "-" + dates[1] + "-" + dates[2];
                        freeExport.setDate(deteTemp);
                    }
                } catch (Exception e) {

                }
                storageService.insertFreeExport(freeExport.getLoc(), freeExport.getNo(), freeExport.getDate(), freeExport.getDegree(), type, "auto", createTime, "", "");
                System.out.println(freeExport.toString());

            }
        } catch (Exception e) {
            e.printStackTrace();
            return "free_report_success";
        }
        return "free_report_success";
    }


    //type,type_id,goodsNameId, location, goodsStatusId, floor, startTime, endTime, startArea, endArea
    @RequestMapping(value = "/house/{userId}/{page}/{type}/{typeId}/{goodsNameId}/{location}/{goodsStatusId}/{floor}/{startTime}/{endTime}/{startArea}/{endArea}/{isWindow1}/{isWindow2}/{status0}/{status1}/{status2}/{statusVal0}/{statusVal1}/{statusVal2}/{adType0}/{adType1}/{adTypeVal0}/{adTypeVal1}/{carType0}/{carType1}/{carTypeVal0}/{carTypeVal1}/{house1}/{house2}/{house3}/query/{export}", method = RequestMethod.GET)
    public String houseQuery(Model model, HttpServletRequest request, @PathVariable("userId") int userId, @PathVariable("page") int page
            , @PathVariable("type") int type, @PathVariable("typeId") int typeId, @PathVariable("goodsNameId") int goodsNameId, @PathVariable("location") String location
            , @PathVariable("goodsStatusId") int goodsStatusId, @PathVariable("floor") int floor, @PathVariable("startTime") String startTime
            , @PathVariable("endTime") String endTime, @PathVariable("startArea") String startArea, @PathVariable("endArea") String endArea
            , @PathVariable("isWindow1") String isWindow1, @PathVariable("isWindow2") String isWindow2, @PathVariable("status0") String status0
            , @PathVariable("status1") String status1, @PathVariable("status2") String status2, @PathVariable("statusVal0") int statusVal0, @PathVariable("statusVal1") int statusVal1
            , @PathVariable("statusVal2") int statusVal2, @PathVariable("adType0") String adType0, @PathVariable("adType1") String adType1, @PathVariable("adTypeVal0") String adTypeVal0, @PathVariable("adTypeVal1") String adTypeVal1, @PathVariable("carType0") String carType0, @PathVariable("carType1") String carType1, @PathVariable("carTypeVal0") String carTypeVal0, @PathVariable("carTypeVal1") String carTypeVal1, @PathVariable("house1") String house1, @PathVariable("house2") String house2, @PathVariable("house3") String house3, @PathVariable("export") String export, HttpServletResponse response) {
        //{type}/{typeId}/{goodsNameId}/{location}/{goodsStatusId}/{floor}/{startTime}/{endTime}
        // /{startArea}/{endArea}/{isWindow1}/{isWindow2}/{status0}/{status1}/{status2}/{statusVal0}/{statusVal1}
        // /{statusVal2}/{adType0}/{adType1}/{adTypeVal0}/{adTypeVal1}/{carType0}/{carType1}/{carTypeVal0}/{carTypeVal1}/{house1}/{house2}/{house3}
        model.addAttribute("type", type);
        model.addAttribute("typeId", typeId);
        model.addAttribute("goodsNameId", goodsNameId);
        model.addAttribute("locationL", location);
        model.addAttribute("goodsStatusId", goodsStatusId);
        model.addAttribute("floor", floor);
        model.addAttribute("startTime", startTime);
        model.addAttribute("endTime", endTime);
        model.addAttribute("startArea", startArea);
        model.addAttribute("endArea", endArea);
        model.addAttribute("isWindow1", isWindow1);
        model.addAttribute("isWindow2", isWindow2);
        model.addAttribute("status0", status0);
        model.addAttribute("status1", status1);
        model.addAttribute("status2", status2);
        model.addAttribute("statusVal0", statusVal0);
        model.addAttribute("statusVal1", statusVal1);
        model.addAttribute("statusVal2", statusVal2);
        model.addAttribute("adType0", adType0);
        model.addAttribute("adType1", adType1);
        model.addAttribute("adTypeVal0", adTypeVal0);
        model.addAttribute("adTypeVal1", adTypeVal1);
        model.addAttribute("carType0", carType0);
        model.addAttribute("carType1", carType1);
        model.addAttribute("carTypeVal0", carTypeVal0);
        model.addAttribute("carTypeVal1", carTypeVal1);
        model.addAttribute("house1", house1);
        model.addAttribute("house2", house2);
        model.addAttribute("house3", house3);


        String role4 = baseService.getRole(userId, "role4");
        String is_admin = CommUtil.showIsAdminCookie(request);
        String goodsStatusIn;
        String isWindowIn;
        String adTypeIn;
        String carTypeIn;
        if ("false".equals(status0)) {
            statusVal0 = -1;
        }
        if ("false".equals(status1)) {
            statusVal1 = -1;
        }
        if ("false".equals(status2)) {
            statusVal2 = -1;
        }
        goodsStatusIn = "(" + statusVal0 + "," + statusVal1 + "," + statusVal2 + ")";
        int isWindowVal1;
        int isWindowVal2;
        if ("false".equals(isWindow1)) {
            isWindowVal1 = -2;
        } else {
            isWindowVal1 = 1;
        }
        if ("false".equals(isWindow2)) {
            isWindowVal2 = -2;
        } else {
            isWindowVal2 = 0;
        }
        isWindowIn = "(" + isWindowVal1 + "," + isWindowVal2 + ")";

        if ("false".equals(adType0)) {
            adTypeVal0 = "-";
        }
        if ("false".equals(adType1)) {
            adTypeVal1 = "-";
        }
        adTypeIn = "(" + adTypeVal0 + "," + adTypeVal1 + ")";

        if ("false".equals(carType0)) {
            carTypeVal0 = "-";
        }
        if ("false".equals(carType1)) {
            carTypeVal1 = "-";
        }
        carTypeIn = "(" + carTypeVal0 + "," + carTypeVal1 + ")";
        int total = storageService.gainHouseQueryTotal(type, typeId, goodsNameId, location, goodsStatusIn, floor, startTime, endTime, startArea, endArea, isWindowIn, adTypeIn, carTypeIn);
        int totalNum = storageService.gainHouseQueryNum(page * CONST.PAGE_SIZE, CONST.PAGE_SIZE, type, typeId, goodsNameId, location, goodsStatusIn, floor, startTime, endTime, startArea, endArea, isWindowIn, house1, house2, house3, adTypeIn, carTypeIn);
        role4 = "fantasy";
        model.addAttribute("role4", role4);
        model.addAttribute("is_admin", is_admin);
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        model.addAttribute("total", total);
        List<House> houseList = storageService.gainHouseQuery(page * CONST.PAGE_SIZE, CONST.PAGE_SIZE, type, typeId, goodsNameId, location, goodsStatusIn, floor, startTime, endTime, startArea, endArea, isWindowIn, house1, house2, house3, adTypeIn, carTypeIn);
        model.addAttribute("houseList", houseList);
        model.addAttribute("totalNum", totalNum);
        model.addAttribute("query", "query");


        String result = "house";
        logger.error("houseQueryModify:" + type);
        String fileNameSort = "";
        if (type == 0) {
            result = "house";
            fileNameSort = "房源";
        } else if (type == 1) {
            result = "house_ad";
            fileNameSort = "广告位";
        } else if (type == 2) {
            result = "house_car";
            fileNameSort = "车位";
        }

        if ("export".equals(export) && "house".equals(result)) {
            //获取数据

            String content[][] = new String[houseList.size() + 1][];

            //excel标题
            String[] title = {"序号", "商品名称", "位置编号", "楼层", "建筑面积", "是否带窗", "状态", "数量"};
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
            //excel文件名
            String fileName = fileNameSort + "资源报表" + sdf.format(new Date()) + ".xls";

            //sheet名
            String sheetName = fileNameSort + "资源报表";

            for (int i = 0; i < houseList.size(); i++) {
                content[i] = new String[title.length];

                content[i][0] = houseList.get(i).getId() + "";
                content[i][1] = houseList.get(i).getName();
                content[i][2] = houseList.get(i).getLocation();
                content[i][3] = houseList.get(i).getFloor() + "";
                content[i][4] = houseList.get(i).getBuildArea() + "";
                content[i][5] = houseList.get(i).getIsWindow() == 1 ? "是" : "否";
                content[i][6] = houseList.get(i).getGoodsStatusName() + "";
                content[i][7] = houseList.get(i).getNum() + "";
            }
            content[houseList.size()] = new String[title.length];
            content[houseList.size()][0] = "合计" + "";
            content[houseList.size()][7] = totalNum + "";

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
        if ("export".equals(export) && "house_ad".equals(result)) {
            //获取数据

            String content[][] = new String[houseList.size() + 1][];

            //excel标题
            String[] title = {"序号", "商品名称", "位置编号", "楼层", "类型", "状态", "数量"};
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
            //excel文件名
            String fileName = fileNameSort + "资源报表" + sdf.format(new Date()) + ".xls";

            //sheet名
            String sheetName = fileNameSort + "资源报表";

            for (int i = 0; i < houseList.size(); i++) {
                content[i] = new String[title.length];

                content[i][0] = houseList.get(i).getId() + "";
                content[i][1] = houseList.get(i).getName();
                content[i][2] = houseList.get(i).getLocation();
                content[i][3] = houseList.get(i).getFloor() + "";
                content[i][4] = houseList.get(i).getAdName() + "";
                content[i][5] = houseList.get(i).getGoodsStatusName() + "";
                content[i][6] = houseList.get(i).getNum() + "";
            }
            content[houseList.size()] = new String[title.length];
            content[houseList.size()][0] = "合计" + "";
            content[houseList.size()][6] = totalNum + "";

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
        if ("export".equals(export) && "house_car".equals(result)) {
            //获取数据

            String content[][] = new String[houseList.size() + 1][];

            //excel标题
            String[] title = {"序号", "商品名称", "位置编号", "类型", "状态", "数量"};
            SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
            //excel文件名
            String fileName = fileNameSort + "资源报表" + sdf.format(new Date()) + ".xls";

            //sheet名
            String sheetName = fileNameSort + "资源报表";

            for (int i = 0; i < houseList.size(); i++) {
                content[i] = new String[title.length];

                content[i][0] = houseList.get(i).getId() + "";
                content[i][1] = houseList.get(i).getName();
                content[i][2] = houseList.get(i).getLocation();
                content[i][3] = houseList.get(i).getAdName();
                content[i][4] = houseList.get(i).getGoodsStatusName() + "";
                content[i][5] = houseList.get(i).getNum() + "";
            }
            content[houseList.size()] = new String[title.length];
            content[houseList.size()][0] = "合计" + "";
            content[houseList.size()][5] = totalNum + "";

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

        return result;


    }

    @RequestMapping(value = "/house/{userId}/{house}/add", method = RequestMethod.GET)
    public String addHouse(Model model, HttpServletRequest request, @PathVariable("userId") int userId, @PathVariable("house") String house) {
        List<GoodsName> goodsNameList = storageService.gainGoodsName();
        List<GoodsStatus> goodsStatusList = storageService.gainGoodsStatus();
        List<Ad> adList = storageService.gainAd();
        List<Car> carList = storageService.gainCar();

        if ("house_ad_add".equals(house)) {
            for (int i = 0; i < goodsNameList.size(); i++) {
                if (goodsNameList.get(i).getName().contains("广告")) {

                    GoodsName goodsName = goodsNameList.get(i);
                    goodsNameList = new ArrayList<GoodsName>();
                    goodsNameList.add(0, goodsName);
                    break;
                }
            }
        } else if ("house_car_add".equals(house)) {
            for (int i = 0; i < goodsNameList.size(); i++) {
                if (goodsNameList.get(i).getName().contains("停车")) {

                    GoodsName goodsName = goodsNameList.get(i);
                    goodsNameList = new ArrayList<GoodsName>();
                    goodsNameList.add(0, goodsName);
                    break;
                }
            }
        } else if ("house_add".equals(house)) {
            for (int i = 0; i < goodsNameList.size(); i++) {
                if (goodsNameList.get(i).getName().contains("房")) {

                    GoodsName goodsName = goodsNameList.get(i);
                    goodsNameList = new ArrayList<GoodsName>();
                    goodsNameList.add(0, goodsName);
                    break;
                }
            }
        }
        for (int i = 0; i < goodsStatusList.size(); i++) {
            if ("闲置".equals(goodsStatusList.get(i).getName())) {
                GoodsStatus goodsStatus = goodsStatusList.get(i);
                goodsStatusList = new ArrayList<GoodsStatus>();
                goodsStatusList.add(0, goodsStatus);
                break;
            }
        }

        model.addAttribute("goodsNameList", goodsNameList);
        model.addAttribute("goodsStatusList", goodsStatusList);
        model.addAttribute("adList", adList);
        model.addAttribute("carList", carList);
        model.addAttribute("house", new House());

        return house;
    }

    @RequestMapping(value = "/house/{type}/query", method = RequestMethod.GET)
    public String queryHouse(Model model, HttpServletRequest request, @PathVariable("type") int type) {
        List<GoodsName> goodsNameList = storageService.gainGoodsName();
        List<GoodsStatus> goodsStatusList = storageService.gainGoodsStatus();

        if (type == 1) {

            List<Ad> adList = storageService.gainAd();
            model.addAttribute("adList", adList);
            for (int i = 0; i < goodsNameList.size(); i++) {
                if (goodsNameList.get(i).getName().contains("广告")) {

                    GoodsName goodsName = goodsNameList.get(i);
                    goodsNameList = new ArrayList<GoodsName>();
                    goodsNameList.add(goodsName);

                    break;
                }
            }

        } else if (type == 2) {
            List<Car> carList = storageService.gainCar();
            model.addAttribute("carList", carList);
            for (int i = 0; i < goodsNameList.size(); i++) {
                if (goodsNameList.get(i).getName().contains("停车")) {

                    GoodsName goodsName = goodsNameList.get(i);
                    goodsNameList = new ArrayList<GoodsName>();
                    goodsNameList.add(goodsName);
                    break;
                }
            }
        } else {

            for (int i = 0; i < goodsNameList.size(); i++) {
                if (goodsNameList.get(i).getName().contains("房")) {

                    GoodsName goodsName = goodsNameList.get(i);
                    goodsNameList = new ArrayList<GoodsName>();
                    goodsNameList.add(goodsName);
                    break;
                }
            }
        }
        model.addAttribute("goodsNameList", goodsNameList);
        model.addAttribute("goodsStatusList", goodsStatusList);
        model.addAttribute("type", type);
        return "house_query";
    }

    @RequestMapping(value = "/house/{userId}/{goodsNameId}/{location}/{useArea}/{buildArea}/{num}/{linkHouse}/{unit}/{cash}/{waterNo}/{powerNo}/{airNo}/{startTime}/{endTime}/{goodsStatusId}/{floor}/{isWindow}/{remark}/{chartLoc}/add", method = RequestMethod.POST)
    @ResponseBody
    public Integer addHouseImpl(Model model, HttpServletRequest request, @PathVariable("userId") int userId, @PathVariable("goodsNameId") int goodsNameId, @PathVariable("location") String location
            , @PathVariable("useArea") double useArea, @PathVariable("buildArea") double buildArea, @PathVariable("num") int num, @PathVariable("linkHouse") String linkHouse, @PathVariable("unit") double unit
            , @PathVariable("cash") double cash, @PathVariable("waterNo") String waterNo, @PathVariable("powerNo") String powerNo, @PathVariable("airNo") String airNo, @PathVariable("startTime") String startTime, @PathVariable("endTime") String endTime
            , @PathVariable("goodsStatusId") int goodsStatusId, @PathVariable("floor") int floor, @PathVariable("isWindow") int isWindow, @PathVariable("remark") String remark, @PathVariable("chartLoc") String chartLoc) {
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        if ("fantasy".equals(linkHouse)) {
            linkHouse = "";
        }
        if ("fantasy".equals(waterNo)) {
            waterNo = "";
        }
        if ("fantasy".equals(powerNo)) {
            powerNo = "";
        }
        if ("fantasy".equals(airNo)) {
            airNo = "";
        }
        if ("fantasy".equals(remark)) {
            remark = "";
        }
        if (chartLoc.equals("fantasy")) {
            chartLoc = "";
        }
        Integer isOk = storageService.addHouse(userId, goodsNameId, location
                , useArea, buildArea, num, linkHouse, unit
                , cash, waterNo, powerNo, airNo, startTime, endTime, sdf.format(new Date())
                , goodsStatusId, floor, isWindow, remark, chartLoc);
        String userIdStr = CommUtil.showUserIdCookie(request);
        if (isOk > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), "增加房源资源");
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOk;
    }

    @RequestMapping(value = "/house_ad/{userId}/{goodsNameId}/{location}/{useArea}/{num}/{startTime}/{endTime}/{goodsStatusId}/{floor}/{adType}/{chartLoc}/add", method = RequestMethod.POST)
    @ResponseBody
    public Integer addHouseAdImpl(Model model, HttpServletRequest request, @PathVariable("userId") int userId, @PathVariable("goodsNameId") int goodsNameId, @PathVariable("location") String location
            , @PathVariable("useArea") double useArea, @PathVariable("num") int num, @PathVariable("startTime") String startTime, @PathVariable("endTime") String endTime
            , @PathVariable("goodsStatusId") int goodsStatusId, @PathVariable("floor") int floor, @PathVariable("adType") int adType, @PathVariable("chartLoc") String chartLoc) {
        if (chartLoc.contains("fantasy")) {
            chartLoc = "";
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Integer isOk = storageService.addHouseAd(userId, goodsNameId, location
                , useArea, num, startTime, endTime, sdf.format(new Date())
                , goodsStatusId, floor, adType, chartLoc);
        String userIdStr = CommUtil.showUserIdCookie(request);
        if (isOk > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), "增加广告资源");
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOk;
    }

    @RequestMapping(value = "/house_car/{userId}/{goodsNameId}/{location}/{useArea}/{num}/{startTime}/{endTime}/{goodsStatusId}/{floor}/{carType}/{chartLoc}/add", method = RequestMethod.POST)
    @ResponseBody
    public Integer addHouseCarImpl(Model model, HttpServletRequest request, @PathVariable("userId") int userId, @PathVariable("goodsNameId") int goodsNameId, @PathVariable("location") String location
            , @PathVariable("useArea") double useArea, @PathVariable("num") int num, @PathVariable("startTime") String startTime, @PathVariable("endTime") String endTime
            , @PathVariable("goodsStatusId") int goodsStatusId, @PathVariable("floor") int floor, @PathVariable("carType") int carType, @PathVariable("chartLoc") String chartLoc) {
        if (chartLoc.equals("fantasy")) {
            chartLoc = "";
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Integer isOk = storageService.addHouseCar(userId, goodsNameId, location
                , useArea, num, startTime, endTime, sdf.format(new Date())
                , goodsStatusId, floor, carType, chartLoc);
        String userIdStr = CommUtil.showUserIdCookie(request);
        if (isOk > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), "增加车位资源");
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOk;
    }

    @RequestMapping(value = "/house/{id}/{userId}/{goodsNameId}/{location}/{useArea}/{buildArea}/{num}/{linkHouse}/{unit}/{cash}/{waterNo}/{powerNo}/{airNo}/{startTime}/{endTime}/{goodsStatusId}/{floor}/{isWindow}/{remark}/{chartLoc}/modify", method = RequestMethod.POST)
    @ResponseBody
    public Integer modifyHouseImpl(Model model, HttpServletRequest request, @PathVariable("id") int id, @PathVariable("userId") int userId, @PathVariable("goodsNameId") int goodsNameId, @PathVariable("location") String location
            , @PathVariable("useArea") double useArea, @PathVariable("buildArea") double buildArea, @PathVariable("num") int num, @PathVariable("linkHouse") String linkHouse, @PathVariable("unit") double unit
            , @PathVariable("cash") double cash, @PathVariable("waterNo") String waterNo, @PathVariable("powerNo") String powerNo, @PathVariable("airNo") String airNo, @PathVariable("startTime") String startTime, @PathVariable("endTime") String endTime
            , @PathVariable("goodsStatusId") int goodsStatusId, @PathVariable("floor") int floor, @PathVariable("isWindow") int isWindow, @PathVariable("remark") String remark, @PathVariable("chartLoc") String chartLoc) {

        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        logger.error("time:" + sdf.format(new Date()));
        if ("fantasy".equals(linkHouse)) {
            linkHouse = "";
        }

        if ("fantasy".equals(waterNo)) {
            waterNo = "";
        }

        if ("fantasy".equals(powerNo)) {
            powerNo = "";
        }

        if ("fantasy".equals(airNo)) {
            airNo = "";
        }

        if ("fantasy".equals(remark)) {
            remark = "";
        }
        if ("fantasy".equals(chartLoc)) {
            chartLoc = "";
        }

        Integer isOk = storageService.modifyHouse(id, userId, goodsNameId, location
                , useArea, buildArea, num, linkHouse, unit
                , cash, waterNo, powerNo, airNo, startTime, endTime, sdf.format(new Date())
                , goodsStatusId, floor, isWindow, remark, chartLoc);
        logger.error("isoK:" + isOk);
        String userIdStr = CommUtil.showUserIdCookie(request);
        logger.error("userIdStr:" + userIdStr);
        if (isOk > 0) {
            if (userIdStr != null) {
                logger.error("insert:");
                baseService.addLogs(Integer.parseInt(userIdStr), "修改房源资源");
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        logger.error("=============================");
        return isOk;
    }

    @RequestMapping(value = "/house_car/{id}/{userId}/{goodsNameId}/{location}/{useArea}/{num}/{startTime}/{endTime}/{goodsStatusId}/{floor}/{carType}/{chartLoc}/modify", method = RequestMethod.POST)
    @ResponseBody
    public Integer modifyHouseCarImpl(Model model, HttpServletRequest request, @PathVariable("id") int id, @PathVariable("userId") int userId, @PathVariable("goodsNameId") int goodsNameId, @PathVariable("location") String location
            , @PathVariable("useArea") double useArea, @PathVariable("num") int num,
                                      @PathVariable("startTime") String startTime, @PathVariable("endTime") String endTime
            , @PathVariable("goodsStatusId") int goodsStatusId, @PathVariable("floor") int floor, @PathVariable("carType") int carType, @PathVariable("chartLoc") String chartLoc) {

        if (chartLoc.contains("fantasy")) {
            chartLoc = "";
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Integer isOK = storageService.modifyHouseCar(id, userId, goodsNameId, location
                , useArea, num, startTime, endTime, sdf.format(new Date())
                , goodsStatusId, floor, carType, chartLoc);
        String userIdStr = CommUtil.showUserIdCookie(request);
        if (isOK > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), "修改车位资源");
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOK;
    }

    @RequestMapping(value = "/house_ad/{id}/{userId}/{goodsNameId}/{location}/{useArea}/{num}/{startTime}/{endTime}/{goodsStatusId}/{floor}/{adType}/{chartLoc}/modify", method = RequestMethod.POST)
    @ResponseBody
    public Integer modifyHouseAdImpl(Model model, HttpServletRequest request, @PathVariable("id") int id, @PathVariable("userId") int userId, @PathVariable("goodsNameId") int goodsNameId, @PathVariable("location") String location
            , @PathVariable("useArea") double useArea, @PathVariable("num") int num,
                                     @PathVariable("startTime") String startTime, @PathVariable("endTime") String endTime
            , @PathVariable("goodsStatusId") int goodsStatusId, @PathVariable("floor") int floor, @PathVariable("adType") int adType, @PathVariable("chartLoc") String chartLoc) {

        if (chartLoc.contains("fantasy")) {
            chartLoc = "";
        }
        SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
        Integer isOK = storageService.modifyHouseAd(id, userId, goodsNameId, location
                , useArea, num, startTime, endTime, sdf.format(new Date())
                , goodsStatusId, floor, adType, chartLoc);
        String userIdStr = CommUtil.showUserIdCookie(request);
        if (isOK > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), "修改广告资源");
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOK;
    }


    @RequestMapping(value = "/house/{id}/delete", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int houseDeleteImpl(@PathVariable("id") int id, HttpServletRequest request) {

        String userIdStr = CommUtil.showUserIdCookie(request);
        int isOK = storageService.delHouse(id);
        if (isOK > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), "删除资源信息");
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOK;


    }

    @RequestMapping(value = "/house/{id}/{userId}/{goodsNameId}/{locationL}/{useArea}/{buildArea}/{num}/{linkHouse}/{unit}/{cash}/{waterNo}/{powerNo}/{airNo}/{startTime}/{endTime}/{goodsStatusId}/{floor}/{chartLoc}/info", method = RequestMethod.GET)
    public String addHouse(Model model, HttpServletRequest request, @PathVariable("id") int id, @PathVariable("userId") int userId,
                           @PathVariable("goodsNameId") int goodsNameId, @PathVariable("locationL") String locationL
            , @PathVariable("useArea") double useArea, @PathVariable("buildArea") double buildArea, @PathVariable("num") int num,
                           @PathVariable("linkHouse") String linkHouse, @PathVariable("unit") double unit
            , @PathVariable("cash") double cash, @PathVariable("waterNo") String waterNo, @PathVariable("powerNo") String powerNo,
                           @PathVariable("airNo") String airNo, @PathVariable("startTime") String startTime, @PathVariable("endTime") String endTime
            , @PathVariable("goodsStatusId") int goodsStatusId, @PathVariable("floor") int floor, @PathVariable("chartLoc") String chartLoc) {

        if ("fantasy".equals(linkHouse)) {
            linkHouse = "";
        }
        if ("fantasy".equals(waterNo)) {
            waterNo = "";
        }
        if ("fantasy".equals(powerNo)) {
            powerNo = "";
        }
        if ("fantasy".equals(airNo)) {
            airNo = "";
        }
        if ("fantasy".equals(chartLoc)) {
            chartLoc = "";
        }

        model.addAttribute("id", id);
        model.addAttribute("userId", userId);
        model.addAttribute("goodsNameId", goodsNameId);
        model.addAttribute("locationL", locationL);
        model.addAttribute("useArea", CommUtil.zero(useArea + ""));
        model.addAttribute("buildArea", CommUtil.zero(buildArea + ""));
        model.addAttribute("num", num);
        model.addAttribute("linkHouse", linkHouse);
        model.addAttribute("unit", CommUtil.zero(unit + ""));
        model.addAttribute("cash", CommUtil.zero(cash + ""));
        model.addAttribute("waterNo", waterNo);
        model.addAttribute("powerNo", powerNo);
        model.addAttribute("airNo", airNo);
        model.addAttribute("startTime", startTime);
        model.addAttribute("endTime", endTime);
        model.addAttribute("chartLoc", chartLoc);

        model.addAttribute("floor", floor);
        model.addAttribute("house", storageService.gainOneHouse(id));
        List<GoodsName> goodsNameList = storageService.gainGoodsName();
        List<GoodsStatus> goodsStatusList = storageService.gainGoodsStatus();
        //判断是否已有合同在使用房源


        for (int i = 0; i < goodsNameList.size(); i++) {
            if (goodsNameList.get(i).getName().contains("房")) {

                GoodsName goodsName = goodsNameList.get(i);
                goodsNameList = new ArrayList<GoodsName>();
                goodsNameList.add(goodsName);
                break;
            }
        }

        List<Custom> customList = storageService.gainHistoryHouse(locationL);
        List<Contract> contractList = storageService.gainHistoryContract(locationL);
        for (int i = 0; i < customList.size(); i++) {

            List<Worker> workerList = storageService.gainWorker(customList.get(i).getUuid());
            customList.get(i).setWorkerList(workerList);
            customList.get(i).setContract(contractList.get(i));

        }

        //List<Contract> contractList = handleService.gainContractOne(locationL);
        model.addAttribute("customList", customList);
        model.addAttribute("goodsNameList", goodsNameList);
        model.addAttribute("goodsStatusList", goodsStatusList);
        model.addAttribute("goodsStatusId", goodsStatusId);
        return "house_add";
    }

    @RequestMapping(value = "/house_ad/{id}/{userId}/{goodsNameId}/{locationL}/{useArea}/{num}/{startTime}/{endTime}/{goodsStatusId}/{floor}/{adType}/{adName}/{chartLoc}/info", method = RequestMethod.GET)
    public String addHouseAd(Model model, HttpServletRequest request, @PathVariable("id") int id, @PathVariable("userId") int userId,
                             @PathVariable("goodsNameId") int goodsNameId, @PathVariable("locationL") String locationL
            , @PathVariable("useArea") double useArea, @PathVariable("num") int num,
                             @PathVariable("startTime") String startTime, @PathVariable("endTime") String endTime
            , @PathVariable("goodsStatusId") int goodsStatusId, @PathVariable("floor") int floor, @PathVariable("adType") int adType, @PathVariable("adName") String adName, @PathVariable("chartLoc") String chartLoc) {
        if (chartLoc.contains("fantasy")) {
            chartLoc = "";
        }

        model.addAttribute("id", id);
        model.addAttribute("userId", userId);
        model.addAttribute("goodsNameId", goodsNameId);
        model.addAttribute("locationL", locationL);
        model.addAttribute("useArea", CommUtil.zero(useArea + ""));
        model.addAttribute("num", num);
        model.addAttribute("startTime", startTime);
        model.addAttribute("endTime", endTime);

        model.addAttribute("floor", floor);
        model.addAttribute("adType", adType);
        model.addAttribute("adName", adName);
        model.addAttribute("chartLoc", chartLoc);

        List<GoodsName> goodsNameList = storageService.gainGoodsName();
        List<GoodsStatus> goodsStatusList = storageService.gainGoodsStatus();
        List<Ad> adList = storageService.gainAd();

        for (int i = 0; i < goodsNameList.size(); i++) {
            if (goodsNameList.get(i).getName().contains("广告")) {

                GoodsName goodsName = goodsNameList.get(i);
                goodsNameList = new ArrayList<GoodsName>();
                goodsNameList.add(goodsName);
                break;
            }
        }
//        List<Contract> gainStatus = storageService.gainStatus(locationL, "ad");
//
//        if (gainStatus != null && gainStatus.size() > 0) {
//
//            //帅选出当前位置编号的状态
//
//            Contract contract = gainStatus.get(0);
//            HandleController.ad(contract);
//            for (int j = 0; j < contract.getTableList1().size(); j++) {
//                if (locationL.equals(contract.getTableList1().get(j).getTable1())) {
//                    goodsStatusId = Integer.parseInt(contract.getTableList1().get(j).getTable7());
//                    break;
//                }
//            }
//
//
//        } else {
//            for (int i = 0; i < goodsStatusList.size(); i++) {
//                if ("闲置".equals(goodsStatusList.get(i).getName())) {
//                    GoodsStatus goodsStatus = goodsStatusList.get(i);
//                    goodsStatusList = new ArrayList<GoodsStatus>();
//                    goodsStatusList.add(0, goodsStatus);
//                    goodsStatusId = goodsStatus.getId();
//                    break;
//                }
//            }
//        }

        List<Custom> customList = storageService.gainHistoryHouse(locationL);
        List<Contract> contractList = storageService.gainHistoryContract(locationL);
        for (int i = 0; i < customList.size(); i++) {

            List<Worker> workerList = storageService.gainWorker(customList.get(i).getUuid());
            customList.get(i).setWorkerList(workerList);
            customList.get(i).setContract(contractList.get(i));

        }

        model.addAttribute("customList", customList);
        model.addAttribute("goodsStatusId", goodsStatusId);
        model.addAttribute("goodsNameList", goodsNameList);
        model.addAttribute("goodsStatusList", goodsStatusList);
        model.addAttribute("adList", adList);
        logger.error("customList={}", customList);
        return "house_ad_add";
    }

    @RequestMapping(value = "/house_car/{id}/{userId}/{goodsNameId}/{locationL}/{useArea}/{num}/{startTime}/{endTime}/{goodsStatusId}/{floor}/{carType}/{chartLoc}/info", method = RequestMethod.GET)
    public String addHouseCar(Model model, HttpServletRequest request, @PathVariable("id") int id, @PathVariable("userId") int userId,
                              @PathVariable("goodsNameId") int goodsNameId, @PathVariable("locationL") String locationL
            , @PathVariable("useArea") double useArea, @PathVariable("num") int num,
                              @PathVariable("startTime") String startTime, @PathVariable("endTime") String endTime
            , @PathVariable("goodsStatusId") int goodsStatusId, @PathVariable("floor") int floor, @PathVariable("carType") int carType, @PathVariable("chartLoc") String chartLoc) {

        if (chartLoc.contains("fantasy")) {
            chartLoc = "";
        }
        model.addAttribute("id", id);
        model.addAttribute("userId", userId);
        model.addAttribute("goodsNameId", goodsNameId);
        model.addAttribute("locationL", locationL);
        model.addAttribute("useArea", CommUtil.zero(useArea + ""));
        model.addAttribute("num", num);
        model.addAttribute("startTime", startTime);
        model.addAttribute("endTime", endTime);
        model.addAttribute("chartLoc", chartLoc);

        model.addAttribute("floor", floor);
        model.addAttribute("carType", carType);
        List<GoodsName> goodsNameList = storageService.gainGoodsName();
        List<GoodsStatus> goodsStatusList = storageService.gainGoodsStatus();
        for (int i = 0; i < goodsNameList.size(); i++) {
            if (goodsNameList.get(i).getName().contains("车")) {

                GoodsName goodsName = goodsNameList.get(i);
                goodsNameList = new ArrayList<GoodsName>();
                goodsNameList.add(goodsName);
                break;
            }
        }

//        List<Contract> gainStatus = storageService.gainStatus(locationL, "car");
//
//        if (gainStatus != null && gainStatus.size() > 0) {
//
//            //帅选出当前位置编号的状态
//
//            Contract contract = gainStatus.get(0);
//            HandleController.car(contract);
//            for (int j = 0; j < contract.getTableList1().size(); j++) {
//                if (locationL.equals(contract.getTableList1().get(j).getTable1())) {
//                    goodsStatusId = Integer.parseInt(contract.getTableList1().get(j).getTable7());
//                    break;
//                }
//            }
//
//
//        } else {
//            for (int i = 0; i < goodsStatusList.size(); i++) {
//                if ("闲置".equals(goodsStatusList.get(i).getName())) {
//                    GoodsStatus goodsStatus = goodsStatusList.get(i);
//                    goodsStatusList = new ArrayList<GoodsStatus>();
//                    goodsStatusList.add(0, goodsStatus);
//                    goodsStatusId = goodsStatus.getId();
//                    break;
//                }
//            }
//        }
        List<Custom> customList = storageService.gainHistoryHouse(locationL);
        List<Contract> contractList = storageService.gainHistoryContract(locationL);
        for (int i = 0; i < customList.size(); i++) {

            List<Worker> workerList = storageService.gainWorker(customList.get(i).getUuid());
            customList.get(i).setWorkerList(workerList);
            customList.get(i).setContract(contractList.get(i));

        }

        model.addAttribute("customList", customList);
        model.addAttribute("goodsNameList", goodsNameList);
        model.addAttribute("goodsStatusList", goodsStatusList);
        List<Car> carList = storageService.gainCar();
        model.addAttribute("carList", carList);
        model.addAttribute("goodsStatusId", goodsStatusId);
        return "house_car_add";
    }


}

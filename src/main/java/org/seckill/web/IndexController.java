package org.seckill.web;

import org.seckill.entity.*;
import org.seckill.service.BaseService;
import org.seckill.service.ContractService;
import org.seckill.utils.CONST;
import org.seckill.utils.CommUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import javax.servlet.http.HttpServletRequest;
import java.util.ArrayList;
import java.util.List;

@Controller
@RequestMapping("/seckill")
public class IndexController {
    private final Logger logger = LoggerFactory.getLogger(this.getClass());

    @Autowired
    BaseService baseService;

    @Autowired
    ContractService contractService;

    /**
     * 系统日志
     */


    @RequestMapping(value = "/sys_logs/{page}/query", method = RequestMethod.GET)
    public String querySysLogs(Model model, @PathVariable("page") int page) {
        List<SysLogs> sysLogsList = baseService.querySysLogs(page, CONST.PAGE_SIZE);
        int total = baseService.querySysLogsTotal();

        model.addAttribute("sysLogsList", sysLogsList);
        model.addAttribute("total", total);
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);

        return "sys_logs"; //  /WEB-INF/jsp/"list".jsp
    }

    /**
     * 权限分配
     */

    @RequestMapping(value = "/role/{userId}/user", method = RequestMethod.GET)
    public String role(Model model, HttpServletRequest request, @PathVariable("userId") int userId) {
        List<Check> checkList = new ArrayList<Check>();
        List<Role1> role1List = baseService.queryRole1();
        String is_admin = CommUtil.showIsAdminCookie(request);
        String role1 = baseService.getRole(userId, "role1");
        String role2 = baseService.getRole(userId, "role2");
        String role3 = baseService.getRole(userId, "role3");
        String role4 = baseService.getRole(userId, "role4");

        String role1Id = baseService.getRoleId(userId, "role1");
        String role2Id = baseService.getRoleId(userId, "role2");
        String role3Id = baseService.getRoleId(userId, "role3");
        String role4Id = baseService.getRoleId(userId, "role4");

        for (int i = 0; i < role1List.size(); i++) {
            boolean role1Check = false;
            if (role1 != null && role1.contains(role1List.get(i).getName())) {
                role1Check = true;
                checkList.add(new Check(role1List.get(i).getId(), 0, role1List.get(i).getName(), true));
            } else {
                checkList.add(new Check(role1List.get(i).getId(), 0, role1List.get(i).getName(), false));
                role1Check = false;
            }
            List<Role2> role2List = baseService.queryRole2(role1List.get(i).getId());
            role1List.get(i).setRole2(role2List);
            for (int j = 0; j < role2List.size(); j++) {
                boolean role2Check = false;
                if (role2 != null && role2Id != null && role2Id.contains(role2List.get(j).getId() + "") && role2.contains(role2List.get(j).getName()) && role1Check) {
                    role2Check = true;
                    checkList.add(new Check(role2List.get(j).getId(), role2List.get(j).getParentId(), role2List.get(j).getName(), true));
                } else {
                    role2Check = false;
                    checkList.add(new Check(role2List.get(j).getId(), role2List.get(j).getParentId(), role2List.get(j).getName(), false));
                }
                List<Role3> role3List = baseService.queryRole3(role2List.get(j).getId());
                role2List.get(j).setRole3(role3List);
                for (int m = 0; m < role3List.size(); m++) {
                    boolean role3Check = false;
                    if (role3 != null && role3Id != null && role3Id.contains(role3List.get(m).getId() + "") && role3.contains(role3List.get(m).getName()) && role2Check) {
                        role3Check = true;
                        checkList.add(new Check(role3List.get(m).getId(), role3List.get(m).getParentId(), role3List.get(m).getName(), true));
                    } else {
                        role3Check = false;
                        checkList.add(new Check(role3List.get(m).getId(), role3List.get(m).getParentId(), role3List.get(m).getName(), false));
                    }

                    List<Role4> role4List = baseService.queryRole4(role3List.get(m).getId());
                    role3List.get(m).setRole4(role4List);

                    for (int n = 0; n < role4List.size(); n++) {
                        if ("无".equals(role4List.get(n).getName())) {
                            //checkList.add(new Check(role4List.get(n).getId(), role4List.get(n).getParentId(), role4List.get(n).getName(), false));
                        } else if (role4 != null && role4Id != null && role4Id.contains(role4List.get(n).getId() + "") && role4.contains(role4List.get(n).getName()) && role3Check) {
                            checkList.add(new Check(role4List.get(n).getId(), role4List.get(n).getParentId(), role4List.get(n).getName(), true));
                        } else {
                            checkList.add(new Check(role4List.get(n).getId(), role4List.get(n).getParentId(), role4List.get(n).getName(), false));
                        }
                    }
                }
            }
        }
        model.addAttribute("checkList", checkList);
        model.addAttribute("role1List", role1List);
        model.addAttribute("userId", userId);
        return "role"; //  /WEB-INF/jsp/"list".jsp
    }

    @RequestMapping(value = "/role/{userId}/{role1}/{role2}/{role3}/{role4}/modify", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int insertRole(@PathVariable("userId") int userId, @PathVariable("role1") String role1, @PathVariable("role2") String role2, @PathVariable("role3") String role3, @PathVariable("role4") String role4, HttpServletRequest request) {

        String userIdStr = CommUtil.showUserIdCookie(request);
        int isOK = baseService.insertRole(userId, role1, role2, role3, role4);
        if (isOK > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), CONST.DEL_SYSTEM__TYPE);
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOK;


    }

//    @RequestMapping(value = "/role/{userId}/{filed}/modify", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
//    @ResponseBody
//    public int getRole(@PathVariable("userId") int userId,@PathVariable("filed")String filed, HttpServletRequest request) {
//
//        String userIdStr = showUserIdCookie(request);
//        int isOK = baseService.getRole(userId,filed);
//        if (isOK > 0) {
//            if (userIdStr != null) {
//                baseService.addLogs(Integer.parseInt(userIdStr), CONST.DEL_SYSTEM__TYPE);
//            } else {
//                baseService.addLogs(-1, CONST.NO_TYPE);
//            }
//        }
//        return isOK;
//
//
//    }

    @RequestMapping(value = "/index", method = RequestMethod.GET)
    public String index(Model model) {


        return "index"; //  /WEB-INF/jsp/"list".jsp
    }

    @RequestMapping(value = "/node", method = RequestMethod.GET)
    public String node(Model model) {


        return "node"; //  /WEB-INF/jsp/"list".jsp
    }

    @RequestMapping(value = "/login1", method = RequestMethod.GET)
    public String login1(Model model) {


        return "login1"; //  /WEB-INF/jsp/"list".jsp
    }

    @RequestMapping(value = "/login", method = RequestMethod.GET)
    public String login(Model model, HttpServletRequest request) {

//        try {
//            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//            if (MysqlBackup.exportDatabaseTool("116.62.28.28", "root", "admin123", "D:/backupDatabase", sdf.format(new Date())+".sql", "seckill")) {
//                System.out.println("数据库成功备份！！！");
//            } else {
//                System.out.println("数据库备份失败！！！");
//            }
//        } catch (InterruptedException e) {
//            e.printStackTrace();
//        }
        return "login"; //  /WEB-INF/jsp/"list".jsp
    }

    @RequestMapping(value = "/login_ts", method = RequestMethod.GET)
    public String loginTs(Model model, HttpServletRequest request) {

//        try {
//            SimpleDateFormat sdf = new SimpleDateFormat("yyyy-MM-dd");
//            if (MysqlBackup.exportDatabaseTool("116.62.28.28", "root", "admin123", "D:/backupDatabase", sdf.format(new Date())+".sql", "seckill")) {
//                System.out.println("数据库成功备份！！！");
//            } else {
//                System.out.println("数据库备份失败！！！");
//            }
//        } catch (InterruptedException e) {
//            e.printStackTrace();
//        }
        return "login_ts"; //  /WEB-INF/jsp/"list".jsp
    }

    @RequestMapping(value = "/login/{account}/{pwd}/query", method = RequestMethod.GET, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public Users loginImpl(@PathVariable("account") String account, @PathVariable("pwd") String pwd) {


        return baseService.login(account, pwd);

    }

    /**
     * 主页
     */
    @RequestMapping(value = "/desk/{userId}", method = RequestMethod.GET)
    public String desk(HttpServletRequest request, Model model, @PathVariable("userId") int userId) {
        String role1 = baseService.getRole(userId, "role1");
        String is_admin = CommUtil.showIsAdminCookie(request);
        model.addAttribute("role1", role1);
        model.addAttribute("is_admin", is_admin);
        return "desk"; //  /WEB-INF/jsp/"list".jsp
    }

    @RequestMapping(value = "/base/{userId}", method = RequestMethod.GET)
    public String base(HttpServletRequest request, Model model, @PathVariable("userId") int userId) {
        String role2 = baseService.getRole(userId, "role2");
        String role3 = baseService.getRole(userId, "role3");
        model.addAttribute("role3", role3);
        String is_admin = CommUtil.showIsAdminCookie(request);
        model.addAttribute("role2", role2);
        model.addAttribute("is_admin", is_admin);

        return "base"; //  /WEB-INF/jsp/"list".jsp
    }

    /**
     * 功能
     */
    @RequestMapping(value = "/storage/{userId}", method = RequestMethod.GET)
    public String storage(HttpServletRequest request, Model model, @PathVariable("userId") int userId) {
        String role2 = baseService.getRole(userId, "role2");
        String role3 = baseService.getRole(userId, "role3");
        model.addAttribute("role3", role3);
        String is_admin = CommUtil.showIsAdminCookie(request);
        model.addAttribute("role2", role2);
        model.addAttribute("is_admin", is_admin);

        return "storage"; //  /WEB-INF/jsp/"list".jsp
    }

//    @RequestMapping(value = "/contact", method = RequestMethod.GET)
//    public String contact(Model model) {
//
//
//        return "contact"; //  /WEB-INF/jsp/"list".jsp
//    }

    @RequestMapping(value = "/money/{userId}", method = RequestMethod.GET)
    public String money(HttpServletRequest request, Model model, @PathVariable("userId") int userId) {
        String role2 = baseService.getRole(userId, "role2");
        String is_admin = CommUtil.showIsAdminCookie(request);
        String role3 = baseService.getRole(userId, "role3");
        model.addAttribute("role3", role3);
        model.addAttribute("role2", role2);
        model.addAttribute("is_admin", is_admin);

        return "money"; //  /WEB-INF/jsp/"list".jsp
    }

    @RequestMapping(value = "/handle/{userId}", method = RequestMethod.GET)
    public String handle(HttpServletRequest request, Model model, @PathVariable("userId") int userId) {
        String role2 = baseService.getRole(userId, "role2");
        String is_admin = CommUtil.showIsAdminCookie(request);
        String role3 = baseService.getRole(userId, "role3");
        model.addAttribute("role3", role3);
        model.addAttribute("role2", role2);
        model.addAttribute("is_admin", is_admin);


        return "handle"; //  /WEB-INF/jsp/"list".jsp
    }

    @RequestMapping(value = "/contact1/{userId}", method = RequestMethod.GET)
    public String contact(HttpServletRequest request, Model model, @PathVariable("userId") int userId) {
        String role2 = baseService.getRole(userId, "role2");
        String is_admin = CommUtil.showIsAdminCookie(request);
        String role3 = baseService.getRole(userId, "role3");
        model.addAttribute("role3", role3);
        model.addAttribute("role2", role2);
        model.addAttribute("is_admin", is_admin);

        return "contact_manager"; //  /WEB-INF/jsp/"list".jsp
    }

    @RequestMapping(value = "/interact/{userId}", method = RequestMethod.GET)
    public String interact(HttpServletRequest request, Model model, @PathVariable("userId") int userId) {
        String role2 = baseService.getRole(userId, "role2");
        String is_admin = CommUtil.showIsAdminCookie(request);
        String role3 = baseService.getRole(userId, "role3");
        model.addAttribute("role3", role3);
        model.addAttribute("role2", role2);
        model.addAttribute("is_admin", is_admin);


        return "interact"; //  /WEB-INF/jsp/"list".jsp
    }

    @RequestMapping(value = "/my/{userId}", method = RequestMethod.GET)
    public String my(HttpServletRequest request, Model model, @PathVariable("userId") int userId) {
        String role2 = baseService.getRole(userId, "role2");
        String is_admin = CommUtil.showIsAdminCookie(request);
        String role3 = baseService.getRole(userId, "role3");
        model.addAttribute("role3", role3);
        model.addAttribute("role2", role2);
        model.addAttribute("is_admin", is_admin);
        int warnCount = contractService.gainCustomWarnTotal();
        model.addAttribute("warnCount", warnCount);

        int contractWarnCount = contractService.gainContractWarnTotal();
        model.addAttribute("contractWarnCount", contractWarnCount);

        int confirmCount = contractService.gainContractListConfirmTotal();
        model.addAttribute("confirmCount", confirmCount);


//        int cancelCount = contractService.gainContractListCancelTotal();
//        model.addAttribute("cancelCount", cancelCount);

        return "my"; //  /WEB-INF/jsp/"list".jsp
    }


    /**
     * 系统管理员
     */

    @RequestMapping(value = "/system", method = RequestMethod.GET)
    public String system(Model model) {


        return "system"; //  /WEB-INF/jsp/"list".jsp
    }

    @RequestMapping(value = "/system_add", method = RequestMethod.GET)
    public String systemAdd(Model model) {


        return "system_add"; //  /WEB-INF/jsp/"list".jsp
    }


    @RequestMapping(value = "/system/{id}/{account}/{name}/{pwd}/modify", method = RequestMethod.GET)
    public String systemAdd(Model model, @PathVariable("id") int id, @PathVariable("account") String account, @PathVariable("name") String name, @PathVariable("pwd") String pwd) {

        model.addAttribute("id", id);
        model.addAttribute("account", account);
        model.addAttribute("name", name);
        model.addAttribute("pwd", pwd);
        return "system_add"; //  /WEB-INF/jsp/"list".jsp
    }

    @RequestMapping(value = "/system/{account}/{name}/{pwd}/add", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int systemAddImpl(@PathVariable("account") String account, @PathVariable("name") String name, @PathVariable("pwd") String pwd, HttpServletRequest request) {
        String userIdStr = CommUtil.showUserIdCookie(request);
        int isOK = baseService.addSystem(account, name, pwd);
        if (isOK > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), CONST.ADD_SYSTEM__TYPE);
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOK;

    }

    @RequestMapping(value = "/system/{id}/delete", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int systemDeleteImpl(@PathVariable("id") int id, HttpServletRequest request) {

        String userIdStr = CommUtil.showUserIdCookie(request);
        int isOK = baseService.delSystem(id);
        if (isOK > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), CONST.DEL_SYSTEM__TYPE);
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOK;


    }

    @RequestMapping(value = "/system/{id}/{account}/{name}/{pwd}/modify", method = RequestMethod.POST)
    @ResponseBody
    public int systemModifyImpl(@PathVariable("id") int id, @PathVariable("account") String account, @PathVariable("name") String name, @PathVariable("pwd") String pwd, HttpServletRequest request) {
        String userIdStr = CommUtil.showUserIdCookie(request);
        int isOK = baseService.modifySystem(id, account, name, pwd);
        if (isOK > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), CONST.MODIFY_SYSTEM_TYPE);
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOK;


    }

    @RequestMapping(value = "/system/{page}/query", method = RequestMethod.GET)
    public String systemQueryImpl(Model model, @PathVariable("page") int page) {
        List<Users> list = baseService.querySystem(page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = baseService.querySystemTotal();
        model.addAttribute("userList", list);
        model.addAttribute("total", total);
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        return "system";

    }

    /**
     * 部门管理
     */

    @RequestMapping(value = "/department", method = RequestMethod.GET)
    public String department(Model model) {


        return "department"; //  /WEB-INF/jsp/"list".jsp
    }

    @RequestMapping(value = "/department_add", method = RequestMethod.GET)
    public String departmentAdd(Model model) {


        return "department_add"; //  /WEB-INF/jsp/"list".jsp
    }


    @RequestMapping(value = "/department/{id}/{name}/modify", method = RequestMethod.GET)
    public String departmentAdd(Model model, @PathVariable("id") int id, @PathVariable("name") String name) {

        model.addAttribute("id", id);
        model.addAttribute("name", name);
        return "department_add"; //  /WEB-INF/jsp/"list".jsp
    }

    @RequestMapping(value = "/department/{name}/{company}/add", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int departmentAddImpl(@PathVariable("name") String name, @PathVariable("company") String company, HttpServletRequest request) {
        String userIdStr = CommUtil.showUserIdCookie(request);
        int isOK = baseService.addDepartment(name, company);
        if (isOK > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), CONST.ADD_DEPARTMENT_TYPE);
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOK;

    }

    @RequestMapping(value = "/department/{id}/delete", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int departmentDeleteImpl(@PathVariable("id") int id, HttpServletRequest request) {

        String userIdStr = CommUtil.showUserIdCookie(request);
        int isOK = baseService.delDepartment(id);
        if (isOK > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), CONST.DEL_DEPARTMENT_TYPE);
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOK;


    }

    @RequestMapping(value = "/department/{id}/{name}/modify", method = RequestMethod.POST)
    @ResponseBody
    public int departmentModifyImpl(@PathVariable("id") int id, @PathVariable("name") String name, HttpServletRequest request) {
        String userIdStr = CommUtil.showUserIdCookie(request);
        int isOK = baseService.modifyDepartment(id, name);
        if (isOK > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), CONST.MODIFY_DEPARTMENT_TYPE);
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOK;


    }

    @RequestMapping(value = "/department/{page}/query", method = RequestMethod.GET)
    public String departmentQueryImpl(Model model, @PathVariable("page") int page) {
        List<Department> list = baseService.queryDepartment(page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = baseService.queryDepartmentTotal();
        model.addAttribute("departmentList", list);
        model.addAttribute("total", total);
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        return "department";

    }

    /**
     * 合同管理
     */


    @RequestMapping(value = "/contact_add", method = RequestMethod.GET)
    public String contactAdd(Model model) {


        return "contact_add"; //  /WEB-INF/jsp/"list".jsp
    }


    @RequestMapping(value = "/contact/{id}/{name}/{sort}/modify", method = RequestMethod.GET)
    public String contactAdd(Model model, @PathVariable("id") int id, @PathVariable("name") String name, @PathVariable("sort") String sort) {

        model.addAttribute("id", id);
        model.addAttribute("name", name);
        model.addAttribute("sort", sort);
        return "contact_add"; //  /WEB-INF/jsp/"list".jsp
    }

    @RequestMapping(value = "/contact/{name}/{sort}/add", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int contactAddImpl(@PathVariable("name") String name, @PathVariable("sort") String sort, HttpServletRequest request) {
        String userIdStr = CommUtil.showUserIdCookie(request);
        int isOK = baseService.addContact(name, sort);
        if (isOK > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), CONST.ADD_DEPARTMENT_TYPE);
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOK;

    }

    @RequestMapping(value = "/contact/{id}/delete", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int contactDeleteImpl(@PathVariable("id") int id, HttpServletRequest request) {

        String userIdStr = CommUtil.showUserIdCookie(request);
        int isOK = baseService.delContact(id);
        if (isOK > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), CONST.DEL_DEPARTMENT_TYPE);
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOK;


    }

    @RequestMapping(value = "/contact/{id}/{name}/{sort}/modify", method = RequestMethod.POST)
    @ResponseBody
    public int contactModifyImpl(@PathVariable("id") int id, @PathVariable("name") String name, @PathVariable("sort") String sort, HttpServletRequest request) {
        String userIdStr = CommUtil.showUserIdCookie(request);
        int isOK = baseService.modifyContact(id, name, sort);
        if (isOK > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), CONST.MODIFY_DEPARTMENT_TYPE);
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOK;


    }

    @RequestMapping(value = "/contact/{page}/query", method = RequestMethod.GET)
    public String contactQueryImpl(Model model, @PathVariable("page") int page) {
        List<Contact> list = baseService.queryContact(page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = baseService.queryContactTotal();
        model.addAttribute("contactList", list);
        model.addAttribute("total", total);
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        return "contact";

    }

    /**
     * 商品状态
     */

    @RequestMapping(value = "/goods_status", method = RequestMethod.GET)
    public String goods_status(Model model) {


        return "goods_status"; //  /WEB-INF/jsp/"list".jsp
    }

    @RequestMapping(value = "/goods_status_add", method = RequestMethod.GET)
    public String goods_statusAdd(Model model) {


        return "goods_status_add"; //  /WEB-INF/jsp/"list".jsp
    }


    @RequestMapping(value = "/goods_status/{id}/{name}/{status}/modify", method = RequestMethod.GET)
    public String goods_statusAdd(Model model, @PathVariable("id") int id, @PathVariable("name") String name, @PathVariable("status") String status) {

        model.addAttribute("id", id);
        model.addAttribute("name", name);
        model.addAttribute("status", status);
        return "goods_status_add"; //  /WEB-INF/jsp/"list".jsp
    }

    @RequestMapping(value = "/goods_status/{name}/{status}/add", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int goods_statusAddImpl(@PathVariable("name") String name, @PathVariable("status") String status, HttpServletRequest request) {
        String userIdStr = CommUtil.showUserIdCookie(request);
        int isOK = baseService.addGoodsStatus(name, status);
        if (isOK > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), CONST.ADD_DEPARTMENT_TYPE);
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOK;

    }

    @RequestMapping(value = "/goods_status/{id}/delete", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int goods_statusDeleteImpl(@PathVariable("id") int id, HttpServletRequest request) {

        String userIdStr = CommUtil.showUserIdCookie(request);
        int isOK = baseService.delGoodsStatus(id);
        if (isOK > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), CONST.DEL_DEPARTMENT_TYPE);
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOK;


    }

    @RequestMapping(value = "/goods_status/{id}/{name}/{sort}/modify", method = RequestMethod.POST)
    @ResponseBody
    public int goods_statusModifyImpl(@PathVariable("id") int id, @PathVariable("name") String name, @PathVariable("sort") String sort, HttpServletRequest request) {
        String userIdStr = CommUtil.showUserIdCookie(request);
        int isOK = baseService.modifyGoodsStatus(id, name, sort);
        if (isOK > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), CONST.MODIFY_DEPARTMENT_TYPE);
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOK;


    }

    @RequestMapping(value = "/goods_status/{page}/query", method = RequestMethod.GET)
    public String goods_statusQueryImpl(Model model, @PathVariable("page") int page) {
        List<GoodsStatus> list = baseService.queryGoodsStatus(page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = baseService.queryGoodsStatusTotal();
        model.addAttribute("goodsStatusList", list);
        model.addAttribute("total", total);
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        return "goods_status";

    }


    /**
     * 商品名称
     */

    @RequestMapping(value = "/goods_name", method = RequestMethod.GET)
    public String goods_name(Model model) {


        return "goods_name"; //  /WEB-INF/jsp/"list".jsp
    }

    @RequestMapping(value = "/goods_name_add", method = RequestMethod.GET)
    public String goods_nameAdd(Model model) {


        return "goods_name_add"; //  /WEB-INF/jsp/"list".jsp
    }


    @RequestMapping(value = "/goods_name/{id}/{name}/modify", method = RequestMethod.GET)
    public String goods_nameAdd(Model model, @PathVariable("id") int id, @PathVariable("name") String name) {

        model.addAttribute("id", id);
        model.addAttribute("name", name);
        return "goods_name_add"; //  /WEB-INF/jsp/"list".jsp
    }

    @RequestMapping(value = "/goods_name/{name}/add", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int goods_nameAddImpl(@PathVariable("name") String name, HttpServletRequest request) {
        String userIdStr = CommUtil.showUserIdCookie(request);
        int isOK = baseService.addGoodsName(name);
        if (isOK > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), CONST.ADD_DEPARTMENT_TYPE);
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOK;

    }

    @RequestMapping(value = "/goods_name/{id}/delete", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int goods_nameDeleteImpl(@PathVariable("id") int id, HttpServletRequest request) {

        String userIdStr = CommUtil.showUserIdCookie(request);
        int isOK = baseService.delGoodsName(id);
        if (isOK > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), CONST.DEL_DEPARTMENT_TYPE);
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOK;


    }

    @RequestMapping(value = "/goods_name/{id}/{name}/modify", method = RequestMethod.POST)
    @ResponseBody
    public int goods_nameModifyImpl(@PathVariable("id") int id, @PathVariable("name") String name, HttpServletRequest request) {
        String userIdStr = CommUtil.showUserIdCookie(request);
        int isOK = baseService.modifyGoodsName(id, name);
        if (isOK > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), CONST.MODIFY_DEPARTMENT_TYPE);
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOK;


    }

    @RequestMapping(value = "/goods_name/{page}/query", method = RequestMethod.GET)
    public String goods_nameQueryImpl(Model model, @PathVariable("page") int page) {
        List<GoodsName> list = baseService.queryGoodsName(page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = baseService.queryGoodsNameTotal();
        model.addAttribute("goodsNameList", list);
        model.addAttribute("total", total);
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        return "goods_name";

    }

    /**
     * 广告类型
     */

    @RequestMapping(value = "/ad", method = RequestMethod.GET)
    public String ad(Model model) {


        return "ad"; //  /WEB-INF/jsp/"list".jsp
    }

    @RequestMapping(value = "/ad_add", method = RequestMethod.GET)
    public String adAdd(Model model) {


        return "ad_add"; //  /WEB-INF/jsp/"list".jsp
    }


    @RequestMapping(value = "/ad/{id}/{name}/modify", method = RequestMethod.GET)
    public String adAdd(Model model, @PathVariable("id") int id, @PathVariable("name") String name) {

        model.addAttribute("id", id);
        model.addAttribute("name", name);
        return "ad_add"; //  /WEB-INF/jsp/"list".jsp
    }

    @RequestMapping(value = "/ad/{name}/add", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int adAddImpl(@PathVariable("name") String name, HttpServletRequest request) {
        String userIdStr = CommUtil.showUserIdCookie(request);
        int isOK = baseService.addAd(name);
        if (isOK > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), CONST.ADD_DEPARTMENT_TYPE);
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOK;

    }

    @RequestMapping(value = "/ad/{id}/delete", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int adDeleteImpl(@PathVariable("id") int id, HttpServletRequest request) {

        String userIdStr = CommUtil.showUserIdCookie(request);
        int isOK = baseService.delAd(id);
        if (isOK > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), CONST.DEL_DEPARTMENT_TYPE);
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOK;


    }

    @RequestMapping(value = "/ad/{id}/{name}/modify", method = RequestMethod.POST)
    @ResponseBody
    public int adModifyImpl(@PathVariable("id") int id, @PathVariable("name") String name, HttpServletRequest request) {
        String userIdStr = CommUtil.showUserIdCookie(request);
        int isOK = baseService.modifyAd(id, name);
        if (isOK > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), CONST.MODIFY_DEPARTMENT_TYPE);
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOK;


    }

    @RequestMapping(value = "/ad/{page}/query", method = RequestMethod.GET)
    public String adQueryImpl(Model model, @PathVariable("page") int page) {
        List<Ad> list = baseService.queryAd(page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = baseService.queryAdTotal();
        model.addAttribute("adList", list);
        model.addAttribute("total", total);
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        return "ad";

    }


    /**
     * 车位类型
     */

    @RequestMapping(value = "/car", method = RequestMethod.GET)
    public String car(Model model) {


        return "car"; //  /WEB-INF/jsp/"list".jsp
    }

    @RequestMapping(value = "/car_add", method = RequestMethod.GET)
    public String carAdd(Model model) {


        return "car_add"; //  /WEB-INF/jsp/"list".jsp
    }


    @RequestMapping(value = "/car/{id}/{name}/modify", method = RequestMethod.GET)
    public String carAdd(Model model, @PathVariable("id") int id, @PathVariable("name") String name) {

        model.addAttribute("id", id);
        model.addAttribute("name", name);
        return "car_add"; //  /WEB-INF/jsp/"list".jsp
    }

    @RequestMapping(value = "/car/{name}/add", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int carAddImpl(@PathVariable("name") String name, HttpServletRequest request) {
        String userIdStr = CommUtil.showUserIdCookie(request);
        int isOK = baseService.addCar(name);
        if (isOK > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), CONST.ADD_DEPARTMENT_TYPE);
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOK;

    }

    @RequestMapping(value = "/car/{id}/delete", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int carDeleteImpl(@PathVariable("id") int id, HttpServletRequest request) {

        String userIdStr = CommUtil.showUserIdCookie(request);
        int isOK = baseService.delCar(id);
        if (isOK > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), CONST.DEL_DEPARTMENT_TYPE);
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOK;


    }

    @RequestMapping(value = "/car/{id}/{name}/modify", method = RequestMethod.POST)
    @ResponseBody
    public int carModifyImpl(@PathVariable("id") int id, @PathVariable("name") String name, HttpServletRequest request) {
        String userIdStr = CommUtil.showUserIdCookie(request);
        int isOK = baseService.modifyCar(id, name);
        if (isOK > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), CONST.MODIFY_DEPARTMENT_TYPE);
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOK;


    }

    @RequestMapping(value = "/car/{page}/query", method = RequestMethod.GET)
    public String carQueryImpl(Model model, @PathVariable("page") int page) {
        List<Car> list = baseService.queryCar(page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = baseService.queryCarTotal();
        model.addAttribute("carList", list);
        model.addAttribute("total", total);
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        return "car";

    }

    /**
     * 用户管理
     */

    @RequestMapping(value = "/user/{page}/query", method = RequestMethod.GET)
    public String userQueryImpl(Model model, @PathVariable("page") int page) {
        List<Users> list = baseService.queryUser(page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = baseService.queryUserTotal();
        model.addAttribute("userList", list);
        model.addAttribute("total", total);
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        return "user";

    }

    @RequestMapping(value = "/user_role/{page}/query", method = RequestMethod.GET)
    public String userRoleQueryImpl(Model model, @PathVariable("page") int page) {
        List<Users> list = baseService.queryUser(page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = baseService.queryUserTotal();
        model.addAttribute("userList", list);
        model.addAttribute("total", total);
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        return "user_role";

    }

    @RequestMapping(value = "/user/{id}/{account}/{name}/{pwd}/{department_id}/modify", method = RequestMethod.POST)
    @ResponseBody
    public int userModifyImpl(HttpServletRequest request, @PathVariable("id") int id, @PathVariable("account") String account, @PathVariable("name") String name, @PathVariable("pwd")
            String pwd, @PathVariable("department_id") int department_id) {

        String userIdStr = CommUtil.showUserIdCookie(request);
        int isOK = baseService.modifyUser(id, account, name, pwd, department_id);
        if (isOK > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), CONST.MODIFY_USER_TYPE);
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOK;


    }

    @RequestMapping(value = "/user/{id}/delete", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int userDeleteImpl(HttpServletRequest request, @PathVariable("id") int id) {
        String userIdStr = CommUtil.showUserIdCookie(request);
        int isOK = baseService.delUser(id);
        if (isOK > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), CONST.DEL_USER_TYPE);
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOK;


    }

    @RequestMapping(value = "/user/{account}/{name}/{pwd}/{department_id}/add", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int userAddImpl(HttpServletRequest request, @PathVariable("account") String account, @PathVariable("name") String name, @PathVariable("pwd") String pwd, @PathVariable("department_id") int department_id) {

        String userIdStr = CommUtil.showUserIdCookie(request);
        int isOK = baseService.addUser(account, name, pwd, department_id);
        if (isOK > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), CONST.ADD_USER_TYPE);
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOK;


    }

    @RequestMapping(value = "/user/{id}/{account}/{name}/{pwd}/{department_id}/modify", method = RequestMethod.GET)
    public String departmentAddImpl(Model model, @PathVariable("id") int id, @PathVariable("account") String account, @PathVariable("name") String name, @PathVariable("pwd") String pwd, @PathVariable("department_id") int department_id) {

        model.addAttribute("id", id);
        model.addAttribute("account", account);
        model.addAttribute("name", name);
        model.addAttribute("pwd", pwd);
        model.addAttribute("department_id", department_id);
        List<Department> departmentList = baseService.queryDepartmentAll();
        model.addAttribute("department_list", departmentList);
        return "user_add"; //  /WEB-INF/jsp/"list".jsp
    }

    @RequestMapping(value = "/user_add", method = RequestMethod.GET)
    public String userAdd(Model model) {

        List<Department> departmentList = baseService.queryDepartmentAll();
        model.addAttribute("department_list", departmentList);
        return "user_add"; //  /WEB-INF/jsp/"list".jsp
    }


    @RequestMapping(value = "/user/{id}/forbid", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int userForbidImpl(HttpServletRequest request, @PathVariable("id") int id) {
        String userIdStr = CommUtil.showUserIdCookie(request);
        int isOK = baseService.forbidAccount(id);
        if (isOK > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), CONST.FORBID_USER_TYPE);
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOK;


    }

    @RequestMapping(value = "/user/{id}/unForbid", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int userUnForbidImpl(HttpServletRequest request, @PathVariable("id") int id) {

        String userIdStr = CommUtil.showUserIdCookie(request);
        int isOK = baseService.unForbidAccount(id);
        if (isOK > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), CONST.UNFORBID_USER_TYPE);
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOK;


    }

    /**
     * 费用管理
     */

    @RequestMapping(value = "/free", method = RequestMethod.GET)
    public String free(Model model) {


        return "free"; //  /WEB-INF/jsp/"list".jsp
    }

    @RequestMapping(value = "/free_add", method = RequestMethod.GET)
    public String freeAdd(Model model) {


        return "free_add"; //  /WEB-INF/jsp/"list".jsp
    }


    @RequestMapping(value = "/free/{id}/{name}/{price}/{unit}/modify", method = RequestMethod.GET)
    public String freeAdd(Model model, @PathVariable("id") int id, @PathVariable("name") String name, @PathVariable("price") String price, @PathVariable("unit") String unit) {
        if (unit.contains("fantasy")) {
            unit = unit.replace("fantasy", "/");
        }
        model.addAttribute("id", id);
        model.addAttribute("name", name);
        model.addAttribute("price", price);
        model.addAttribute("unit", unit);
        return "free_add"; //  /WEB-INF/jsp/"list".jsp
    }

    @RequestMapping(value = "/free/{name}/{price}/{unit}/add", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int departmentAddImpl(HttpServletRequest request, @PathVariable("name") String name, @PathVariable("price") String price, @PathVariable("unit") String unit) {
        if (unit.contains("fantasy")) {
            unit = unit.replace("fantasy", "/");
        }

        String userIdStr = CommUtil.showUserIdCookie(request);
        int isOK = baseService.addFree(name, price, unit);
        if (isOK > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), CONST.ADD_FREE_TYPE);
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOK;


    }

    @RequestMapping(value = "/free/{id}/delete", method = RequestMethod.POST, produces = "application/json;charset=UTF-8")
    @ResponseBody
    public int freeDeleteImpl(HttpServletRequest request, @PathVariable("id") int id) {
        String userIdStr = CommUtil.showUserIdCookie(request);
        int isOK = baseService.delFree(id);
        if (isOK > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), CONST.DEL_FREE_TYPE);
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOK;


    }

    @RequestMapping(value = "/free/{id}/{name}/{price}/{unit}/modify", method = RequestMethod.POST)
    @ResponseBody
    public int freeModifyImpl(HttpServletRequest request, @PathVariable("id") int id, @PathVariable("name") String name, @PathVariable("price") String price, @PathVariable("unit") String unit) {
        if (unit.contains("fantasy")) {
            unit = unit.replace("fantasy", "/");
        }

        String userIdStr = CommUtil.showUserIdCookie(request);
        int isOK = baseService.modifyFree(id, name, price, unit);
        if (isOK > 0) {
            if (userIdStr != null) {
                baseService.addLogs(Integer.parseInt(userIdStr), CONST.MODIFY_FREE_TYPE);
            } else {
                baseService.addLogs(-1, CONST.NO_TYPE);
            }
        }
        return isOK;


    }

    @RequestMapping(value = "/free/{page}/query", method = RequestMethod.GET)
    public String freeQueryImpl(Model model, @PathVariable("page") int page) {
        List<Free> list = baseService.queryFree(page * CONST.PAGE_SIZE, CONST.PAGE_SIZE);
        int total = baseService.queryFreeTotal();
        model.addAttribute("freeList", list);
        model.addAttribute("total", total);
        model.addAttribute("page", page);
        model.addAttribute("pageSize", CONST.PAGE_SIZE);
        return "free";

    }

}

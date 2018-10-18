package org.seckill.service.impl;

import org.apache.ibatis.annotations.Param;
import org.seckill.dao.BaseDao;
import org.seckill.entity.*;
import org.seckill.service.BaseService;
import org.seckill.utils.CONST;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import javax.servlet.http.Cookie;
import java.util.List;

@Service
public class BaseServiceImpl implements BaseService {
    @Autowired
    BaseDao baseDao;

    /**
     * 系统日志
     */
    public int addLogs(int id, String type) {
        return baseDao.addLogs(id, type);
    }

    public List<SysLogs> querySysLogs(int page, int pageSize) {
        return baseDao.querySysLogs(page, pageSize);
    }

    public int querySysLogsTotal() {
        return baseDao.querySysLogsTotal();
    }

    /**
     * 权限分配
     */
    public List<Role1> queryRole1() {
        return baseDao.queryRole1();
    }

    public List<Role2> queryRole2(int parentId) {
        return baseDao.queryRole2(parentId);
    }

    public List<Role3> queryRole3(int parentId) {
        return baseDao.queryRole3(parentId);
    }

    public List<Role4> queryRole4(int parentId) {
        return baseDao.queryRole4(parentId);
    }
    public int insertRole(int userId,String role1,String role2,String role3,String role4){
        return baseDao.insertRole(userId, role1, role2, role3, role4);
    }
    public String getRole(int userId,String filed){
        return baseDao.getRole(userId,filed);
    }
    public String getRoleId(int userId,String filed){
        return baseDao.getRoleId(userId,filed);
    }

    /**
     * 登录
     */
    public Users login(String account, String pwd) {
        Users users = baseDao.login(account, pwd);
        if (users != null) {
            baseDao.addLogs(users.getId(), CONST.LOGIN_TYPE);
        }
        return users;
    }


    /**
     * 系统管理员
     */
    public int delSystem(int id) {

        return baseDao.delSystem(id);
    }

    public int modifySystem(int id, String account, String name, String pwd) {
        return baseDao.modifySystem(id, account, name, pwd);
    }

    public int addSystem(String account, String name, String pwd) {
        return baseDao.addSystem(account, name, pwd);
    }

    public List<Users> querySystem(int page, int pageSize) {
        return baseDao.querySystem(page, pageSize);
    }

    public List<Users> querySystemAll() {
        return baseDao.querySystemAll();
    }

    public int querySystemTotal() {
        return baseDao.querySystemTotal();
    }

    /**
     * 部门管理
     */
    public int delDepartment(int id) {

        return baseDao.delDepartment(id);
    }

    public int modifyDepartment(int id, String name) {
        return baseDao.modifyDepartment(id, name);
    }

    public int addDepartment(String name, String company) {
        return baseDao.addDepartment(name, company);
    }

    public List<Department> queryDepartment(int page, int pageSize) {
        return baseDao.queryDepartment(page, pageSize);
    }

    public List<Department> queryDepartmentAll() {
        return baseDao.queryDepartmentAll();
    }

    public int queryDepartmentTotal() {
        return baseDao.queryDepartmentTotal();
    }

    /**
     * 合同管理
     */
    public int delContact(int id) {
        return baseDao.delContact(id);
    }

    public int modifyContact(int id, String name, String sort) {
        return baseDao.modifyContact(id, name, sort);
    }

    public int addContact(String name, String sort) {
        return baseDao.addContact(name, sort);
    }

    public List<Contact> queryContact(int page, int pageSize) {
        return baseDao.queryContact(page, pageSize);
    }

    public List<Contact> queryContactAll() {
        return baseDao.queryContactAll();
    }

    public int queryContactTotal() {
        return baseDao.queryContactTotal();
    }

    /**
     * 车位类型
     */
    public int delCar(int id) {
        return baseDao.delCar(id);
    }

    public int modifyCar(int id, String name) {
        return baseDao.modifyCar(id, name);
    }

    public int addCar(String name) {
        return baseDao.addCar(name);
    }

    public List<Car> queryCar(int page, int pageSize) {
        return baseDao.queryCar(page, pageSize);
    }

    public List<Car> queryCarAll() {
        return baseDao.queryCarAll();
    }

    public int queryCarTotal() {
        return baseDao.queryCarTotal();
    }


    /**
     * 广告类型
     */
    public int delAd(int id) {
        return baseDao.delAd(id);
    }

    public int modifyAd(int id, String name) {
        return baseDao.modifyAd(id, name);
    }

    public int addAd(String name) {
        return baseDao.addAd(name);
    }

    public List<Ad> queryAd(int page, int pageSize) {
        return baseDao.queryAd(page, pageSize);
    }

    public List<Ad> queryAdAll() {
        return baseDao.queryAdAll();
    }

    public int queryAdTotal() {
        return baseDao.queryAdTotal();
    }

    /**
     * 商品名称
     */
    public int delGoodsName(int id) {
        return baseDao.delGoodsName(id);
    }

    public int modifyGoodsName(int id, String name) {
        return baseDao.modifyGoodsName(id, name);
    }

    public int addGoodsName(String name) {
        return baseDao.addGoodsName(name);
    }

    public List<GoodsName> queryGoodsName(int page, int pageSize) {
        return baseDao.queryGoodsName(page, pageSize);
    }

    public List<GoodsName> queryGoodsNameAll() {
        return baseDao.queryGoodsNameAll();
    }

    public int queryGoodsNameTotal() {
        return baseDao.queryGoodsNameTotal();
    }

    /**
     * 商品状态
     */
    public int delGoodsStatus(int id) {
        return baseDao.delGoodsStatus(id);
    }

    public int modifyGoodsStatus(int id, String name, String status) {
        return baseDao.modifyGoodsStatus(id, name, status);
    }

    public int addGoodsStatus(String name, String status) {
        return baseDao.addGoodsStatus(name, status);
    }

    public List<GoodsStatus> queryGoodsStatus(int page, int pageSize) {
        return baseDao.queryGoodsStatus(page, pageSize);
    }

    public List<GoodsStatus> queryGoodsStatusAll() {
        return baseDao.queryGoodsStatusAll();
    }

    public int queryGoodsStatusTotal() {
        return baseDao.queryGoodsStatusTotal();
    }

    /**
     * 用户管理
     */


    public int delUser(int id) {
        return baseDao.delUser(id);
    }

    public int modifyUser(int id, String account, String name, String pwd, int departmentId) {
        return baseDao.modifyUser(id, account, name, pwd, departmentId);
    }

    public int addUser(String account, String name, String pwd, int departmentId) {
        return baseDao.addUser(account, name, pwd, departmentId);
    }

    public List<Users> queryUser(int page, int pageSize) {
        return baseDao.queryUser(page, pageSize);
    }

    public int queryUserTotal() {
        return baseDao.queryUserTotal();
    }

    public int repeatUser(String account) {
        return baseDao.repeatUser(account);
    }

    public int forbidAccount(int id) {
        return baseDao.forbidAccount(id);
    }

    public int unForbidAccount(int id) {
        return baseDao.unForbidAccount(id);
    }


    /**
     * 费用管理
     */
    public int delFree(int id) {
        return baseDao.delFree(id);
    }

    public int modifyFree(int id, String name, String price, String unit) {
        return baseDao.modifyFree(id, name, price, unit);
    }

    public int addFree(String name, String price, String unit) {
        return baseDao.addFree(name, price, unit);
    }

    public List<Free> queryFree(int page, int pageSize) {
        return baseDao.queryFree(page, pageSize);
    }

    public List<Free> queryFreeAll() {
        return baseDao.queryFreeAll();
    }

    public int queryFreeTotal() {
        return baseDao.queryFreeTotal();
    }
}

package org.seckill.service;

import org.apache.ibatis.annotations.Param;
import org.seckill.entity.*;

import java.util.List;

public interface BaseService {
    /**
     * 系统日志
     */
    int addLogs(int id,String type);
    List<SysLogs> querySysLogs( int page,  int pageSize);
    int querySysLogsTotal();
    /**
     * 权限分配
     *
     */
    List<Role1> queryRole1();
    List<Role2> queryRole2(int parentId);
    List<Role3> queryRole3(int parentId);
    List<Role4> queryRole4(int parentId);
    int insertRole(int userId,String role1,String role2,String role3,String role4);
    String getRole(int userId,String filed);
    String getRoleId(int userId,String filed);
    /**
     * 登录
     */
    Users login(String account,String pwd);

    /**
     *系统管理员
     */
    int delSystem(int id);
    int modifySystem(int id,String account,String name,String pwd);
    int addSystem(String account,String name,String pwd);
    List<Users> querySystem(int page, int pageSize);
    List<Users> querySystemAll();
    int querySystemTotal();

    /**
     *部门管理
     */
     int delDepartment(int id);
     int modifyDepartment(int id,String name);
     int addDepartment(String name,String company);
    List<Department> queryDepartment(int page, int pageSize);
    List<Department> queryDepartmentAll();
    int queryDepartmentTotal();
    /**
     *合同管理
     */
    int delContact(int id);
    int modifyContact(int id,String name,String sort);
    int addContact(String name,String sort);
    List<Contact> queryContact(int page, int pageSize);
    List<Contact> queryContactAll();
    int queryContactTotal();
    /**
     *车位类型
     */
    int delCar(int id);
    int modifyCar(int id,String name);
    int addCar(String name);
    List<Car> queryCar(int page, int pageSize);
    List<Car> queryCarAll();
    int queryCarTotal();

    /**
     *广告类型
     */
    int delAd(int id);
    int modifyAd(int id,String name);
    int addAd(String name);
    List<Ad> queryAd(int page, int pageSize);
    List<Ad> queryAdAll();
    int queryAdTotal();

    /**
     *车位名称
     */
    int delGoodsName(int id);
    int modifyGoodsName(int id,String name);
    int addGoodsName(String name);
    List<GoodsName> queryGoodsName(int page, int pageSize);
    List<GoodsName> queryGoodsNameAll();
    int queryGoodsNameTotal();

    /**
     *商品状态
     */
    int delGoodsStatus(int id);
    int modifyGoodsStatus(int id,String name,String status);
    int addGoodsStatus(String name,String status);
    List<GoodsStatus> queryGoodsStatus(int page, int pageSize);
    List<GoodsStatus> queryGoodsStatusAll();
    int queryGoodsStatusTotal();
    /**
     * 用户管理
     */
    int delUser( int id);
    int modifyUser(int id,String account,String name,String pwd,int departmentId);
    int addUser(String account,String name,String pwd,int departmentId);
    List<Users> queryUser(int page, int pageSize);
    int queryUserTotal();
    int repeatUser(String account);
    int forbidAccount( int id);
    int unForbidAccount( int id);

    /**
     * 费用管理
     */
    int delFree(int id);
    int modifyFree(int id,String name,String price,String unit);
    int addFree(String name,String price,String unit);
    List<Free> queryFree(int page, int pageSize);
    List<Free> queryFreeAll();
    int queryFreeTotal();
}

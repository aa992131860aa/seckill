package org.seckill.dao;

import org.apache.ibatis.annotations.Param;
import org.seckill.entity.*;

import java.util.List;

public interface BaseDao {
    /**
     * 系统日志
     */
    int addLogs(@Param("id") int id, @Param("type") String type);

    List<SysLogs> querySysLogs(@Param("page") int page, @Param("pageSize") int pageSize);
    int querySysLogsTotal();

    /**
     * 权限分配
     */
    List<Role1> queryRole1();
    List<Role2> queryRole2(@Param("parentId") int parentId);
    List<Role3> queryRole3(@Param("parentId") int parentId);
    List<Role4> queryRole4(@Param("parentId") int parentId);
    int insertRole(@Param("userId")int userId,@Param("role1")String role1,@Param("role2")String role2,@Param("role3")String role3,@Param("role4")String role4);
    String getRole(@Param("userId")int userId,@Param("filed")String filed);
    String getRoleId(@Param("userId")int userId,@Param("filed")String filed);
    /**
     * 部门管理
     */
    int delDepartment(@Param("id") int id);

    int modifyDepartment(@Param("id") int id, @Param("name") String name);

    int addDepartment(@Param("name") String name, @Param("company") String company);

    List<Department> queryDepartment(@Param("page") int page, @Param("pageSize") int pageSize);

    List<Department> queryDepartmentAll();

    int queryDepartmentTotal();

    /**
     * 登录
     */
    Users login(@Param("account") String account, @Param("pwd") String pwd);

    /**
     * 系统管理员
     */
    int delSystem(@Param("id") int id);

    int modifySystem(@Param("id") int id,@Param("account") String account,@Param("name") String name,@Param("pwd")String pwd);

    int addSystem( @Param("account") String account,@Param("name") String name,@Param("pwd")String pwd);

    List<Users> querySystem(@Param("page") int page, @Param("pageSize") int pageSize);

    List<Users> querySystemAll();

    int querySystemTotal();

    /**
     * 合同管理
     */
    int delContact(@Param("id") int id);

    int modifyContact(@Param("id") int id, @Param("name") String name,@Param("sort")String sort);

    int addContact(@Param("name") String name,@Param("sort")String sort);

    List<Contact> queryContact(@Param("page") int page, @Param("pageSize") int pageSize);

    List<Contact> queryContactAll();

    int queryContactTotal();

    /**
     * 车位管理
     */
    int delCar(@Param("id") int id);

    int modifyCar(@Param("id") int id, @Param("name") String name);

    int addCar(@Param("name") String name);

    List<Car> queryCar(@Param("page") int page, @Param("pageSize") int pageSize);

    List<Car> queryCarAll();

    int queryCarTotal();

    /**
     * 广告管理
     */
    int delAd(@Param("id") int id);

    int modifyAd(@Param("id") int id, @Param("name") String name);

    int addAd(@Param("name") String name);

    List<Ad> queryAd(@Param("page") int page, @Param("pageSize") int pageSize);

    List<Ad> queryAdAll();

    int queryAdTotal();

    /**
     * 商品名称
     */
    int delGoodsName(@Param("id") int id);

    int modifyGoodsName(@Param("id") int id, @Param("name") String name);

    int addGoodsName(@Param("name") String name);

    List<GoodsName> queryGoodsName(@Param("page") int page, @Param("pageSize") int pageSize);

    List<GoodsName> queryGoodsNameAll();

    int queryGoodsNameTotal();

    /**
     * 商品状态
     */
    int delGoodsStatus(@Param("id") int id);

    int modifyGoodsStatus(@Param("id") int id, @Param("name") String name,@Param("status")String status);

    int addGoodsStatus(@Param("name") String name,@Param("status")String status);

    List<GoodsStatus> queryGoodsStatus(@Param("page") int page, @Param("pageSize") int pageSize);

    List<GoodsStatus> queryGoodsStatusAll();

    int queryGoodsStatusTotal();

    /**
     * 用户管理
     */

    int delUser(@Param("id") int id);

    int modifyUser(@Param("id") int id, @Param("account") String account, @Param("name") String name, @Param("pwd") String pwd, @Param("departmentId") int departmentId);

    int addUser(@Param("account") String account, @Param("name") String name, @Param("pwd") String pwd, @Param("departmentId") int departmentId);

    List<Users> queryUser(@Param("page") int page, @Param("pageSize") int pageSize);

    int queryUserTotal();

    int repeatUser(@Param("account") String account);

    int forbidAccount(@Param("id") int id);

    int unForbidAccount(@Param("id") int id);

    /**
     * 费用管理
     */

    int delFree(@Param("id") int id);

    int modifyFree(@Param("id") int id, @Param("name") String name, @Param("price") String price, @Param("unit") String unit);

    int addFree(@Param("name") String name, @Param("price") String price, @Param("unit") String unit);

    List<Free> queryFree(@Param("page") int page, @Param("pageSize") int pageSize);

    List<Free> queryFreeAll();

    int queryFreeTotal();

}

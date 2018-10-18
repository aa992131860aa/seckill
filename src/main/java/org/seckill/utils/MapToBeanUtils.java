package org.seckill.utils;



import org.apache.poi.util.StringUtil;
import org.springframework.beans.BeanWrapper;
import org.springframework.beans.BeanWrapperImpl;

import java.lang.reflect.Field;
import java.lang.reflect.Method;
import java.lang.reflect.Modifier;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by Boomer on 2017/5/19.
 * @author Boomer
 */
public class MapToBeanUtils {

    /**
     * 获取类类型的所有Field包括父类中的Field
     *
     * @param clazz 类类型
     * @return 返回类类型的所有Field包括父类中的Field
     */
    public static Field[] getAllFields(Class clazz) {
        Map<String, Field> map = new HashMap<String, Field>();
        for (Field field : clazz.getDeclaredFields()) {

            Class fieldType = field.getType();
            String fieldName = field.getName();
            if(isBaseType(fieldType)){
                try {
                    map.put(fieldName, field);
                } catch (Exception e) {
                    e.printStackTrace();
                }
            }
        }

        while (clazz.getSuperclass() != null) {
            clazz = clazz.getSuperclass();
            if (clazz == Object.class) {
                break;
            }

            for (Field field : clazz.getDeclaredFields()) {
                if (!map.containsKey(field.getName())) {
                    map.put(field.getName(), field);
                }
            }
        }
        return map.values().toArray(new Field[map.size()]);
    }

    /**
     * <p>Description:【判断是否是基本类型】</p>
     * <p>Author:【Boomer】</p>
     * <p>Date:【2018/1/8 16:13】</p>
     * @param fieldType
     * @return
     **/
    public static Boolean isBaseType(Class fieldType){

        if (fieldType == String.class) {
            return true;
        } else if (fieldType == double.class || fieldType == Double.class) {
            return true;
        } else if (fieldType == int.class || fieldType == Integer.class) {
            return true;
        } else if (fieldType == Boolean.class || fieldType == boolean.class) {
            return true;
        } else if (fieldType == Date.class) {
            return true;
        }

        return false;
    }

    /**
     * <p>Description:【将首字母转换为大写】</p>
     * <p>Author:【Boomer】</p>
     * <p>Date:【2018/1/5 15:54】</p>
     *
     * @param a
     * @return
     **/
    public static String firstCharToUpper(String a) {

        return (new StringBuilder()).insert(0, a.substring(0, 1).toUpperCase()).append(a.substring(1)).toString();
    }

    /**
     * <p>Description:【将map隐射到实体类】</p>
     * <p>Author:【Boomer】</p>
     * <p>Date:【2018/1/5 16:27】</p>
     *
     * @param map
     * @param model
     * @return
     **/
    public static <T> T getModel(Map map, Class<T> model) {

        Field[] fields = getAllFields(model);
        String value;
        Method method;
        T obj;
        try {
            obj = model.newInstance();
        } catch (Exception e) {
            throw new RuntimeException(e);
        }

        for (Field field : fields) {
            int modifiers = field.getModifiers();
            if (Modifier.isStatic(modifiers) || Modifier.isFinal(modifiers)) {
                continue;
            }

            //根据传入的获取str来判断用哪个字符串获取参数
//            value = MapUtils.getString(map, field.getName());
//            if (StringUtil.isEmpty(value)) {
                if (field.getType() == String.class) {
                    try {
                        method = model.getMethod("get" + firstCharToUpper(field.getName()));
                        Object invokeValue = method.invoke(obj);
                        if (invokeValue != null) {
                            value = invokeValue.toString();
                        }
                    } catch (Exception e) {
                        if (field.getType() == Boolean.class || field.getType() == boolean.class) {
                            try {
                                String fieldName = field.getName();
                                method = model.getMethod("get" + firstCharToUpper(fieldName.startsWith("is") ? fieldName.replace("is", "") : fieldName));
                                Object invokeValue = method.invoke(obj);
                                if (invokeValue != null) {
                                    value = invokeValue.toString();
                                }
                            } catch (Exception e1) {
                                System.out.println(e1.getMessage());
                            }
                        } else {
                            System.out.println(e.getMessage());
                        }
                    }
                }
//            }

//            if (StringUtil.isNotEmpty(value)) {
//                invokeMethod(model, obj, value, field.getName(), field.getType());
//            }
        }

        return obj;
    }

    /**
     * <p>Description:【调用方法】</p>
     * <p>Author:【Boomer】</p>
     * <p>Date:【2018/1/5 16:26】</p>
     *
     * @param modelClass
     * @param object
     * @param value
     * @param fieldName
     * @param fieldType
     * @return
     **/
    private static <T> void invokeMethod(Class<T> modelClass, T object, String value, String fieldName, Class fieldType) {

        Method method = null;
        try {
            method = modelClass.getMethod("set" + firstCharToUpper(fieldName), fieldType);
        } catch (NoSuchMethodException e) {
            if (fieldType == Boolean.class || fieldType == boolean.class) {
                try {
                    method = modelClass.getMethod("set" + firstCharToUpper(fieldName.startsWith("is") ? fieldName.replace("is", "") : fieldName), fieldType);
                } catch (NoSuchMethodException e1) {
                }
            } else {
            }
        }
        try {
            if (null != method) {
                if (fieldType == String.class) {
                    method.invoke(object, value);
                } else if (fieldType == double.class || fieldType == Double.class) {
                    try {
                        method.invoke(object, Double.parseDouble(value));
                    } catch (NumberFormatException e) {
                        e.printStackTrace();
                    }
                } else if (fieldType == int.class || fieldType == Integer.class) {
                    try {
                        method.invoke(object, Integer.parseInt(value));
                    } catch (NumberFormatException e) {
                        e.printStackTrace();
                    }
                } else if (fieldType == Boolean.class || fieldType == boolean.class) {
                    try {
                        method.invoke(object, Boolean.parseBoolean(value));
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                } else if (fieldType == Date.class) {
                    try {
                        SimpleDateFormat sdf = (value.length() == 10 ? new SimpleDateFormat("yyyy-MM-dd") : new SimpleDateFormat("yyyy-MM-dd HH:mm:ss"));
                        method.invoke(object, sdf.parse(value));
                    } catch (Exception e) {
                        e.printStackTrace();
                    }
                }
            }
        } catch (Exception e) {
            e.printStackTrace();
        }
    }
    public static <T> List<T> mapToBean(List<Map> maps, Class<T> obj) throws IllegalAccessException, InstantiationException {
        List<T> list = new ArrayList<T>();
        for (Map<String, Object> map : maps) {
            T module = obj.newInstance();
            BeanWrapper wapper = new BeanWrapperImpl(module);
            for (Map.Entry entry : map.entrySet()) {
                if (wapper.isWritableProperty(entry.getKey().toString())) {
                    wapper.setPropertyValue(entry.getKey().toString(), entry.getValue().toString());
                }
            }
            list.add(module);
        }
        return list;
    }
}

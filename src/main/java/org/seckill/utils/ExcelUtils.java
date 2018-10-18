package org.seckill.utils;


import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.hssf.util.HSSFColor;
import org.apache.poi.ss.usermodel.*;
import org.apache.poi.ss.util.CellUtil;
import org.apache.poi.xssf.streaming.SXSSFSheet;
import org.apache.poi.xssf.streaming.SXSSFWorkbook;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.multipart.commons.CommonsMultipartFile;

import javax.servlet.http.HttpServletResponse;
import java.io.*;
import java.lang.reflect.Field;
import java.util.*;

/**
 * <p>@description:【Excel写入和导出工具】</p>
 * <p>@author:【Boomer】</p>
 * <p>@date:【2018/1/11 11:18】</p>
 **/
public class ExcelUtils {




    /*** 总行数 **/
    private int totalRows = 0;
    /*** 总条数 **/
    private int totalCells = 0;
    /*** 数据读取开始索引 **/
    private int dataReadIndex = 3;
    /*** 字段名读取开始索引 **/
    private int fieldReadIndex = 2;

    public ExcelUtils() {
    }


    public int getTotalRows() {
        return totalRows;
    }

    public int getTotalCells() {
        return totalCells;
    }


    public int getDataReadIndex() {
        return dataReadIndex;
    }

    public void setDataReadIndex(int dataReadIndex) {
        this.dataReadIndex = dataReadIndex;
    }

    public int getFieldReadIndex() {
        return fieldReadIndex;
    }

    public void setFieldReadIndex(int fieldReadIndex) {
        this.fieldReadIndex = fieldReadIndex;
    }

    /**
     * <p>Description:【验证EXCEL文件】</p>
     * <p>Author:【Boomer】</p>
     * <p>Date:【2018/1/11 14:07】</p>
     * @param filePath
     * @return
     **/
    public boolean validateExcel(String filePath) {

        return true;
    }

    /**
     * <p>Description:【是否是2003的excel，返回true是2003】</p>
     * <p>Author:【Boomer】</p>
     * <p>Date:【2018/1/11 14:07】</p>
     * @param filePath
     * @return
     **/
    public static boolean isExcel2003(String filePath) {
        return filePath.matches("^.+.(xls)$");
    }

    /**
     * <p>Description:【是否是2007的excel，返回true是2007】</p>
     * <p>Author:【Boomer】</p>
     * <p>Date:【2018/1/11 14:07】</p>
     * @param filePath
     * @return
     **/
    public static boolean isExcel2007(String filePath) {
        return filePath.matches("^.+.(xlsx)$");
    }


    /**
     * <p>Description:【读EXCEL文件，获取客户信息集合】</p>
     * <p>Author:【Boomer】</p>
     * <p>Date:【2018/1/11 14:07】</p>
     * @param fileName
     * @param Mfile
     * @return
     **/
//    public List<Map> getExcelInfo(String fileName, MultipartFile Mfile) {
//
//        //把spring文件上传的MultipartFile转换成CommonsMultipartFile类型
//        CommonsMultipartFile cf = (CommonsMultipartFile) Mfile;
//        //获取本地存储路径
//        File fileFolder = new File(Sysutils.getUploadFilePath());
//        if (!fileFolder.exists()) {
//            fileFolder.mkdirs();
//        }
//
//        //新建一个文件
//        File uploadFile = new File(Sysutils.getUploadFilePath() + System.currentTimeMillis() + ".xlsx");
//        //将上传的文件写入新建的文件中
//        try {
//            cf.getFileItem().write(uploadFile);
//        } catch (Exception e) {
//            e.printStackTrace();
//        }
//
//        //初始化信息的集合
//        List<Map> list = new ArrayList<Map>();
//        //初始化输入流
//        InputStream is = null;
//        try {
//            //验证文件名是否合格
//            if (!validateExcel(fileName)) {
//                return null;
//            }
//            //根据新建的文件实例化输入流
//            is = new FileInputStream(uploadFile);
//            //根据excel里面的内容读取客户信息
//            list = getExcelInfo(is, isExcel2003(fileName));
//            is.close();
//        } catch (Exception e) {
//            e.printStackTrace();
//        } finally {
//            if (is != null) {
//                try {
//                    is.close();
//                } catch (IOException e) {
//                    e.printStackTrace();
//                }
//            }
//        }
//        return list;
//    }

    /**
     * <p>Description:【根据excel里面的内容读取客户信息】</p>
     * <p>Author:【Boomer】</p>
     * <p>Date:【2018/1/11 14:07】</p>
     * @param is          输入流
     * @param isExcel2003 excel是2003还是2007版本
     * @return
     * @throws IOException
     **/
    public List<Map> getExcelInfo(InputStream is, boolean isExcel2003) {
        List<Map> list;
        try {
            /** 根据版本选择创建Workbook的方式 */
            Workbook wb;
            //当excel是2003时
            if (isExcel2003) {
                wb = new HSSFWorkbook(is);
            } else {//当excel是2007时
                wb = new XSSFWorkbook(is);
            }
            //读取Excel里面客户的信息
            list = readExcelValue(wb);
        } catch (IOException e) {
            throw new RuntimeException(e.getMessage());
        } catch (NumberFormatException e) {
            throw new RuntimeException("读取错误，请确认Excel是否包含错误字符");
        }
        return list;
    }

    /**
     * <p>Description:【读取Excel里面客户的信息】</p>
     * <p>Author:【Boomer】</p>
     * <p>Date:【2018/1/11 14:07】</p>
     * @param wb
     * @return
     **/
    private List<Map> readExcelValue(Workbook wb) {
        //得到第一个shell
        Sheet sheet = wb.getSheetAt(0);

        //得到Excel的行数
        this.totalRows = sheet.getPhysicalNumberOfRows();

        //得到Excel的列数(前提是有行数)
        if (totalRows >= this.dataReadIndex && sheet.getRow(0) != null) {
            this.totalCells = sheet.getRow(0).getPhysicalNumberOfCells();
        }

        List<Map> list = new ArrayList<Map>();
        Map tempMap;
        //获取列数据对应的字段
        Row title = sheet.getRow(this.fieldReadIndex);
        List<String> header = new ArrayList<String>();
        //循环Excel的列
        for (int c = 0; c < this.totalCells; c++) {
            Cell cell = title.getCell(c);
            header.add(cell.getStringCellValue());
        }

        //循环Excel行数,从第二行开始。标题不入库
        for (int r = this.dataReadIndex; r < totalRows; r++) {
            Row row = sheet.getRow(r);
            if (row == null) {
                continue;
            }
            tempMap = new HashMap(this.totalCells);

            //循环Excel的列
            for (int c = 0; c < this.totalCells; c++) {
                Cell cell = row.getCell(c);
                if (null != cell) {
                    cell.setCellType(CellType.STRING);
                    tempMap.put(header.get(c), cell.getStringCellValue());
                }
            }
            //添加客户
            list.add(tempMap);
        }
        return list;
    }

    /**
     * <p>Description:【导出到file】</p>
     * <p>Author:【Boomer】</p>
     * <p>Date:【2018/1/11 14:07】</p>
     * @param clz
     * @param data
     * @param filePath
     * @param <T>
     * @throws IOException
     **/
    public static <T> void export(Class<T> clz, List<? extends T> data, String filePath) throws IOException {
        FileOutputStream out = new FileOutputStream(filePath);
        getBook(clz, data).write(out);
        out.close();
    }

    /**
     * <p>Description:【导出到httpServletResponse】</p>
     * <p>Author:【Boomer】</p>
     * <p>Date:【2018/1/11 14:07】</p>
     * @param clz
     * @param data
     * @param fileName
     * @param response
     * @param <T>
     **/
    public static <T> void export(Class<T> clz, List<? extends T> data, String fileName, HttpServletResponse response) {
        try {
            response.setContentType("application/vnd.ms-excel");
            response.setHeader("Content-disposition", "attachment;filename=\"" + new String(fileName.getBytes("gb2312"), "ISO8859-1") + ".xlsx" + "\"");
            getBook(clz, data).write(response.getOutputStream());
        } catch (Exception e) {
            throw new RuntimeException("系统异常");
        } finally {
            try {
                response.getOutputStream().close();
            } catch (IOException e) {

            }
        }
    }

    /**
     * <p>Description:【生成Excel】</p>
     * <p>Author:【Boomer】</p>
     * <p>Date:【2018/1/11 14:07】</p>
     * @param clz
     * @param data
     * @return
     **/
    private static <T> SXSSFWorkbook getBook(Class<T> clz, List<? extends T> data) {
        if (null == clz || null == data || data.size() <= 0) {
            throw new RuntimeException("参数异常");
        }
        XSSFWorkbook workbook = new XSSFWorkbook();
        SXSSFWorkbook sxssfWorkbook = new SXSSFWorkbook(workbook, 100);
        //第一个工作本
        SXSSFSheet sheet = sxssfWorkbook.createSheet();
        sheet.trackAllColumnsForAutoSizing();
        //表头
        Row header = sheet.createRow(0);
        //读取类字段、注解信息
        Field[] fields = clz.getDeclaredFields();
        //写入表头
        int invalidFieldNum = 0;
        for (Field field : fields) {
            ExcelColumn excelColumn = field.getAnnotation(ExcelColumn.class);
            if (excelColumn == null) {
                continue;
            }
            Cell headerCell = header.createCell(invalidFieldNum++);
            headerCell.setCellStyle(headerCellStyle(sxssfWorkbook));
            headerCell.setCellValue(excelColumn.title());
        }
        //写入数据
        for (int i = 0; i < data.size(); i++) {
            //第0行为表头
            Row row = sheet.createRow(i + 1);
            //循环读取字段
            int cellIndex = 0;
            for (int j = 0; j < fields.length; j++) {
                Field field = fields[j];
                field.setAccessible(true);
                Object cellValue;
                ExcelColumn excelColumn = field.getAnnotation(ExcelColumn.class);
                if (null == excelColumn) {
                    continue;
                }
                Object o;
                try {
                    o = field.get(data.get(i));
                    cellValue = o;
                } catch (Exception e) {
                    throw new RuntimeException("系统异常");
                }

                CellUtil.createCell(row, cellIndex++, String.valueOf(cellValue));
            }
        }
        //自适应宽度
        for (int i = 0; i < invalidFieldNum; i++) {
            sheet.autoSizeColumn(i);
        }
        return sxssfWorkbook;
    }

    /**
     * <p>Description:【设置Excel表头样式】</p>
     * <p>Author:【Boomer】</p>
     * <p>Date:【2018/1/11 14:07】</p>
     * @param wb
     * @return
     **/
    public static CellStyle headerCellStyle(Workbook wb) {

        CellStyle style = wb.createCellStyle();
        Font font = wb.createFont();
        font.setFontName("宋体");
        //设置字体大小
        font.setFontHeightInPoints((short) 12);
        //加粗
        font.setBold(true);
        // 设置背景色
        style.setFillForegroundColor(HSSFColor.HSSFColorPredefined.SKY_BLUE.getIndex());
        style.setFillPattern(FillPatternType.SOLID_FOREGROUND);
        //让单元格居中
        style.setAlignment(HorizontalAlignment.CENTER_SELECTION);
        // 左右居中
        style.setAlignment(HorizontalAlignment.CENTER);
        // 上下居中
        style.setVerticalAlignment(VerticalAlignment.CENTER);
        //设置自动换行
        style.setWrapText(true);
        style.setFont(font);
        return style;
    }

}
package com.spring.boardexcel;

import java.io.BufferedInputStream;
import java.io.FileInputStream;
import java.io.InputStream;
import java.text.SimpleDateFormat;
import java.util.Calendar;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.apache.poi.hssf.usermodel.HSSFWorkbook;
import org.apache.poi.ss.usermodel.Workbook;
import org.springframework.web.servlet.view.document.AbstractExcelView;

import net.sf.jxls.transformer.XLSTransformer;



@SuppressWarnings("deprecation")
public class ListExcelView extends AbstractExcelView {

	@Override
	protected void buildExcelDocument(Map<String, Object> model, HSSFWorkbook arg1, HttpServletRequest request,
			HttpServletResponse response) throws Exception {
		response.setHeader("Content-Disposition", "attachment;fileName=\"" + model.get("file_name") + "_" 
			+ new SimpleDateFormat("yyyyMMdd").format(Calendar.getInstance().getTime()) + ".xlsx" + "\"");
		response.setContentType("application/x-msexcel;charset=EUC-KR");
		
		XLSTransformer trans = new XLSTransformer();
		String docRoot = request.getSession().getServletContext().getRealPath("");
		
		InputStream is = new BufferedInputStream(new FileInputStream(docRoot + "/WEB-INF/excel/" + model.get("template")));
		Workbook workbook = trans.transformXLS(is, model);
		
		is.close();
		workbook.write(response.getOutputStream());
	}

}

package com.spring.boardfileupload;

import java.io.File;
import java.io.IOException;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

public class FileUploadUtil {

	private static Logger logger = LoggerFactory.getLogger(FileUploadUtil.class);
	
	public static String fileUpload(MultipartFile file, HttpServletRequest request) 
			throws IOException {
		logger.info("fileUpload 호출 성공");
		
		String real_name = null;
		String org_name = file.getOriginalFilename();
		logger.info("org_name = " + org_name);
		
		if (org_name != null && (!org_name.equals(""))) {
			real_name = "board_" + System.currentTimeMillis() + "_" + org_name;
			String docRoot = request.getSession().getServletContext().getRealPath("/uploadStorage");
			
			File fileDir = new File(docRoot);
			if (!fileDir.exists()) {
				fileDir.mkdir();
			}
			
			File fileAdd = new File(docRoot + "/" + real_name);
			logger.info(fileAdd.toString());
			
			file.transferTo(fileAdd);
		}
		return real_name;
	}
	
	public static void fileDelete(String fileName, HttpServletRequest request) throws IOException {
		logger.info("fileDelete 호출 성공");
		boolean result = false;
		String docRoot = request.getSession().getServletContext().getRealPath("/uploadStorage");
		
		File fileDelete = new File(docRoot + "/" + fileName);
		if (fileDelete.exists() && fileDelete.isFile()) {
			result = fileDelete.delete();
		}
		logger.info("result = " + result);
	}
}

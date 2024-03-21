package com.apollo.exchange.common.file;

import org.springframework.web.multipart.MultipartFile;

public interface IFileUpload {

	public void processUpload(MultipartFile file, String realName, String path);
	
}

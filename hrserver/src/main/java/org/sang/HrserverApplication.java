package org.sang;

import org.mybatis.spring.annotation.MapperScan;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.servlet.MultipartConfigFactory;
import org.springframework.cache.annotation.EnableCaching;
import org.springframework.context.annotation.Bean;

import javax.servlet.MultipartConfigElement;

@SpringBootApplication
@MapperScan("org.sang.mapper")
@EnableCaching
public class HrserverApplication {

	public static void main(String[] args) {
		SpringApplication.run(HrserverApplication.class, args);
	}

	@Bean
	public MultipartConfigElement multipartConfigElement() {
		MultipartConfigFactory factory = new MultipartConfigFactory();
		//文件最大
		factory.setMaxFileSize("100MB");
		//设置总上传数据总大小
		factory.setMaxRequestSize("1024MB");
		return factory.createMultipartConfig();
	}
}

package org.sang.config;

import org.sang.common.Constant;
import org.springframework.beans.factory.annotation.Value;
import org.springframework.boot.web.servlet.MultipartConfigFactory;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.web.servlet.config.annotation.ResourceHandlerRegistry;
import org.springframework.web.servlet.config.annotation.WebMvcConfigurerAdapter;

import javax.servlet.MultipartConfigElement;

/**
 * @author WindJunn
 * @date 2019-06-21 18:08
 */
@Configuration
public class WebAppConfig extends WebMvcConfigurerAdapter {

    /**
     * 在配置文件中配置的文件保存路径
     */
    @Value("${dir}")
    private String location;

    @Bean
    public MultipartConfigElement multipartConfigElement(){
        MultipartConfigFactory factory = new MultipartConfigFactory();
        //文件最大KB,MB
        factory.setMaxFileSize("50MB");
        //设置总上传数据总大小
        factory.setMaxRequestSize("1024MB");
        return factory.createMultipartConfig();
    }

    /**
     * 配置的图片映射
     */
    private static final String imgPath = "file:" + Constant.UPLOAD_PATH + Constant.IMG_FILE_NAME +  "/";

    @Override
    public void addResourceHandlers(ResourceHandlerRegistry registry) {
        //将所有访问img/virtual/**的请求映射到文件上传的路径下 C:\Users\wanghao/upload/img（图片的保存路径）
        registry.addResourceHandler("/img/virtual/**").addResourceLocations(imgPath);
        super.addResourceHandlers(registry);
    }
}

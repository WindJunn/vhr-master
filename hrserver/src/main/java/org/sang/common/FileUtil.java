package org.sang.common;

import org.apache.commons.lang3.StringUtils;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;

/**
 * @author WindJunn
 * @date 2019-06-22 09:36
 */
public class FileUtil {
    private static Logger logger = LoggerFactory.getLogger(FileUtil.class);
    /**
     * 图片存储 完整路径（{user.home}/img/coldStone/XXX.jpg）
     * @param file
     * @return 返回相对路径
     */
    public static String saveImg(MultipartFile file) {
        //获取文件上传的根目录 C:\Users\wanghao/upload/img
        String  path = Constant.UPLOAD_PATH + Constant.IMG_FILE_NAME;

        //拿到文件的后缀名和UUID进行拼接形成新的文件名
        //4ca64e85b1544c96b4a6154bb521476f.jpg
        String saveName = CommonUtil.getUuid() + "." + getFileSuffix(file.getOriginalFilename());

        logger.info(" --- 图片保存路径：{}, 图片保存名称：{} --- ", path, saveName);

        // 保存
        try {
            // 保存文件图片
            File targetFile = new File(path);
            if (!targetFile.exists()) {
                targetFile.mkdirs();
            }
            file.transferTo(new File(path + "/" + saveName));
        } catch (Exception e) {
            e.printStackTrace();
            logger.debug("--- 图片保存异常：{} ---" + e.getMessage());
            return null;
        }
        String filePath =  Constant.VIRTUAL_IMG_PATH;;
        //返回相对路径  img/virtual/4ca64e85b1544c96b4a6154bb521476f.jpg
        return path + "/" + saveName;
    }
    /**
     * 返回截取的文件后缀
     * @param path
     * @return
     */
    private static String getFileSuffix(String path) {
        return getFileSuffix(path, "2");
    }

    /**
     * 获取文件名称或后缀(最后一个"."之后内容)
     * @param path
     * @param type 1名称 2后缀
     * @return
     */
    private static String getFileSuffix(String path, String type){
        if(StringUtils.isNotEmpty(path) && path.indexOf(".") > 0) {
            // 名称
            String name = path.substring(0, path.lastIndexOf("."));

            // 后缀
            String suffix = path.substring(path.lastIndexOf(".") + 1);

            return StringUtils.equals("1", type) ? name : suffix;
        } else {
            return null;
        }
    }
}

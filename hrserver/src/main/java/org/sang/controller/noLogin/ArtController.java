package org.sang.controller.noLogin;

import org.apache.commons.io.IOUtils;
import org.sang.bean.Article;
import org.sang.bean.Articletop;
import org.sang.bean.RespBean;
import org.sang.common.Util;
import org.sang.service.ArticleService;
import org.sang.service.ArticletopService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import javax.servlet.http.HttpServletRequest;
import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * Created by sang on 2017/12/20.
 */
@RestController
@RequestMapping("/art")
public class ArtController {

    private SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMdd");

    @Autowired
    ArticleService articleService;

    @Autowired
    ArticletopService articletopService;

    @RequestMapping(value = "/", method = RequestMethod.POST)
    public RespBean addNewArticle(@RequestBody Article article) {
        int result = articleService.addNewArticle(article);
        if (result == 1) {
            return RespBean.ok("操作成功" + article.getId() + "");
        } else {
            return RespBean.error(article.getState() == 0 ? "文章保存失败!" : "文章发表失败!");
        }
    }

    /**
     * 上传图片
     *
     * @return 返回值为图片的地址
     */
    @RequestMapping(value = "/uploadimg", method = RequestMethod.POST)
    public RespBean uploadImg(HttpServletRequest req, MultipartFile image) {
        StringBuffer url = new StringBuffer();
        String filePath = "/blogimg/" + sdf.format(new Date());
        String imgFolderPath = req.getServletContext().getRealPath(filePath);
        File imgFolder = new File(imgFolderPath);
        if (!imgFolder.exists()) {
            imgFolder.mkdirs();
        }
        url.append(req.getScheme())
                .append("://")
                .append(req.getServerName())
                .append(":")
                .append(req.getServerPort())
                .append(req.getContextPath())
                .append(filePath);
        String imgName = UUID.randomUUID() + "_" + image.getOriginalFilename().replaceAll(" ", "");
        try {
            IOUtils.write(image.getBytes(), new FileOutputStream(new File(imgFolder, imgName)));
            url.append("/").append(imgName);
            return RespBean.ok(url.toString());
        } catch (IOException e) {
            e.printStackTrace();
        }
        return RespBean.error("上传失败!");
    }

    @RequestMapping(value = "/all/user", method = RequestMethod.GET)
    public Map<String, Object> getArticleByUser(@RequestParam(value = "page", defaultValue = "1") Integer page,
                                                @RequestParam(value = "count", defaultValue = "100") Integer count,
                                                @RequestParam(value = "cid") Long cid, Long hrId,
                                                String keywords) {
        int totalCount = articleService.getArticleCountByState(1, hrId, keywords);
        List<Article> articles = articleService.getArticleByUser(1, page, count, hrId, keywords);
        Map<String, Object> map = new HashMap<>();
        map.put("totalCount", totalCount);
        map.put("articles", articles);
        return map;
    }

    @RequestMapping(value = "/all", method = RequestMethod.GET)
    public Map<String, Object> getArticleByState(@RequestParam(value = "page", defaultValue = "1") Integer page,
                                                 @RequestParam(value = "count", defaultValue = "10") Integer count,
                                                 @RequestParam(value = "cid") Long cid,
                                                 String keywords) {
        int totalCount = articleService.getArticleCount(cid, keywords);
        List<Article> articles = articleService.getAllArticle(page, count, cid, keywords);
        Map<String, Object> map = new HashMap<>();
        map.put("articles", articles);
        map.put("totalCount", totalCount);
        return map;
    }

    @RequestMapping(value = "/home", method = RequestMethod.GET)
    public Map<String, Object> getArticleByCid() {
        List<Article> art1 = articleService.getAllArticle(1, 5, 1L, "");
        List<Article> art2 = articleService.getAllArticle(1, 5, 2L, "");
        List<Article> art3 = articleService.getAllArticle(1, 5, 3L, "");
        List<Article> art4 = articleService.getAllArticle(1, 5, 4L, "");
        List<Article> art5 = articleService.getAllArticle(1, 5, 5L, "");
        Articletop articletop = articletopService.getArticletop();
        Article articlehome = articleService.getArticletopById(articletop.getAid());

        Map<String, Object> map = new HashMap<>(7);
        map.put("art1", art1);
        map.put("art2", art2);
        map.put("art3", art3);
        map.put("art4", art4);
        map.put("art5", art5);
        map.put("articletop", articletop);
        map.put("articlehome", articlehome);
        return map;
    }

    @RequestMapping(value = "/{aid}", method = RequestMethod.GET)
    public Article getArticleById(@PathVariable Long aid) {
        return articleService.getArticleById(aid);
    }

    @RequestMapping(value = "/dustbin", method = RequestMethod.PUT)
    public RespBean updateArticleState(Long[] aids, Integer state) {
        if (articleService.updateArticleState(aids, state) == aids.length) {
            return RespBean.ok("删除成功!");
        }
        return RespBean.error("删除失败!");
    }

    @RequestMapping("/dataStatistics")
    public Map<String, Object> dataStatistics() {
        Map<String, Object> map = new HashMap<>();
        List<String> categories = articleService.getCategories();
        List<Integer> dataStatistics = articleService.getDataStatistics();
        map.put("categories", categories);
        map.put("ds", dataStatistics);
        return map;
    }
}

package org.sang.service;

import org.sang.bean.Article;
import org.sang.common.Util;
import org.sang.mapper.ArticleMapper;
import org.sang.mapper.TagsMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.sql.Timestamp;
import java.util.List;

/**
 * Created by sang on 2017/12/20.
 */
@Service
@Transactional
public class ArticleService {
    @Autowired
    ArticleMapper articleMapper;
    @Autowired
    TagsMapper tagsMapper;

    public int addNewArticle(Article article) {
        //处理文章摘要
        if (article.getSummary() == null || "".equals(article.getSummary())) {
            //直接截取
            String stripHtml = stripHtml(article.getHtmlContent());
            article.setSummary(stripHtml.substring(0, stripHtml.length() > 50 ? 50 : stripHtml.length()));
        }
        if (article.getId() == -1) {
            //添加操作
            Timestamp timestamp = new Timestamp(System.currentTimeMillis());
            if (article.getState() == 1) {
                //设置发表日期
                article.setPublishDate(timestamp);
            }
            article.setEditTime(timestamp);
            //设置当前用户
            if (article.getUid()==null) {
                article.setUid(Util.getCurrentUser().getId());

            }

            String htmlContent = article.getHtmlContent();
            article.setHtmlContent(editPhoto(htmlContent));

            int i = articleMapper.addNewArticle(article);
            //打标签
            /*String[] dynamicTags = article.getDynamicTags();
            if (dynamicTags != null && dynamicTags.length > 0) {
                int tags = addTagsToArticle(dynamicTags, article.getId());
                if (tags == -1) {
                    return tags;
                }
            }*/
            return i;
        } else {
            Timestamp timestamp = new Timestamp(System.currentTimeMillis());
            if (article.getState() == 1) {
                //设置发表日期
                article.setPublishDate(timestamp);
            }
            //更新
            article.setEditTime(new Timestamp(System.currentTimeMillis()));
            String htmlContent = article.getHtmlContent();
            article.setHtmlContent(editPhoto(htmlContent));
            int i = articleMapper.updateArticle(article);
            //修改标签
            /*String[] dynamicTags = article.getDynamicTags();
            if (dynamicTags != null && dynamicTags.length > 0) {
                int tags = addTagsToArticle(dynamicTags, article.getId());
                if (tags == -1) {
                    return tags;
                }
            }*/
            return i;
        }
    }

    private String editPhoto(String htmlContent) {
        int width = 400;
        int height = 300;
//        String img = "<div align=\"center\"><img width=\""+width+"\" height=\""+height+"\"";
        String img = "<div align=\"center\"><img ";
        String replace = htmlContent.replace("<img", img);
        replace = replace.replace("/>", "/></div>");
        return replace;

    }

    private int addTagsToArticle(String[] dynamicTags, Long aid) {
        //1.删除该文章目前所有的标签
        tagsMapper.deleteTagsByAid(aid);
        //2.将上传上来的标签全部存入数据库
        tagsMapper.saveTags(dynamicTags);
        //3.查询这些标签的id
        List<Long> tIds = tagsMapper.getTagsIdByTagName(dynamicTags);
        //4.重新给文章设置标签
        int i = tagsMapper.saveTags2ArticleTags(tIds, aid);
        return i == dynamicTags.length ? i : -1;
    }

    public String stripHtml(String content) {
        content = content.replaceAll("<p .*?>", "");
        content = content.replaceAll("<br\\s*/?>", "");
        content = content.replaceAll("\\<.*?>", "");
        return content;
    }

    public List<Article> getArticleByState(Integer state, Integer page, Integer count, String keywords) {
        int start = (page - 1) * count;
        Long uid = Util.getCurrentUser().getId();
        return articleMapper.getArticleByState(state, start, count, uid, keywords);
    }

    public List<Article> getArticleByUser(Integer state, Integer page, Integer count,Long uid,String keywords) {
        int start = (page - 1) * count;
        return articleMapper.getArticleByState(state, start, count, uid, keywords);
    }

    public List<Article> getAllArticle(Integer page, Integer count, Long cid, String keywords) {
        int start = (page - 1) * count;
        return articleMapper.getAllArticle(start, count, cid, keywords);
    }

    public int getArticleCount(Long cid, String keywords) {
        return articleMapper.getArticleCount(cid, keywords);
    }

    public List<Article> getArticleByStateByAdmin(Integer page, Integer count, Long cid, String keywords) {
        int start = (page - 1) * count;
        return articleMapper.getArticleByStateByAdmin(start, count, cid, keywords);
    }

    public int getArticleCountByState(Integer state, Long uid, String keywords) {
        return articleMapper.getArticleCountByState(state, uid, keywords);
    }

    public int updateArticleState(Long[] aids, Integer state) {
        if (state == 2) {
            return articleMapper.deleteArticleById(aids);
        } else {
            return articleMapper.updateArticleState(aids, 2);
            //放入到回收站中
        }
    }

    public Article getArticleById(Long aid) {
        Article article = articleMapper.getArticleById(aid);
        articleMapper.pvIncrement(aid);
        return article;
    }

    public Article getArticletopById(Long aid) {
        Article article = articleMapper.getArticleById(aid);
        return article;
    }

    public int shield(Long enable, Long aid) {
        return articleMapper.shield(enable, aid);
    }

    public void pvStatisticsPerDay() {
        articleMapper.pvStatisticsPerDay();
    }

    /**
     * 获取最近七天的日期
     *
     * @return
     */
    public List<String> getCategories() {
        return articleMapper.getCategories(Util.getCurrentUser().getId());
    }

    /**
     * 获取最近七天的数据
     *
     * @return
     */
    public List<Integer> getDataStatistics() {
        return articleMapper.getDataStatistics(Util.getCurrentUser().getId());
    }
}

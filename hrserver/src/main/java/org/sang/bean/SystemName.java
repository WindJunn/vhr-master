package org.sang.bean;

import java.util.Date;

/**
 * Created by sang on 2018/1/7.
 */
public class SystemName {
    private Long id;
    private String title;
    private String leftname;
    private String rightname;
    private String path;
    private String image;
    private String des;
    private Date updatetime;

    private Date cratedate;
    private String copyrighted;
    private String phone;
    private String email;
    private String identificationcode;


    public String getCopyrighted() {
        return copyrighted;
    }

    public void setCopyrighted(String copyrighted) {
        this.copyrighted = copyrighted;
    }

    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    public String getEmail() {
        return email;
    }

    public void setEmail(String email) {
        this.email = email;
    }

    public String getIdentificationcode() {
        return identificationcode;
    }

    public void setIdentificationcode(String identificationcode) {
        this.identificationcode = identificationcode;
    }



    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getLeftname() {
        return leftname;
    }

    public void setLeftname(String leftname) {
        this.leftname = leftname;
    }

    public String getRightname() {
        return rightname;
    }

    public void setRightname(String rightname) {
        this.rightname = rightname;
    }

    public String getPath() {
        return path;
    }

    public void setPath(String path) {
        this.path = path;
    }

    public String getImage() {
        return image;
    }

    public void setImage(String image) {
        this.image = image;
    }

    public String getDes() {
        return des;
    }

    public void setDes(String des) {
        this.des = des;
    }

    public Date getCratedate() {
        return cratedate;
    }

    public void setCratedate(Date cratedate) {
        this.cratedate = cratedate;
    }

    public Date getUpdatetime() {
        return updatetime;
    }

    public void setUpdatetime(Date updatetime) {
        this.updatetime = updatetime;
    }



}

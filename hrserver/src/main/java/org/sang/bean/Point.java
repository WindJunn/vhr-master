package org.sang.bean;

import java.util.Date;

/**
 * Created by sang on 2017/12/20.
 */
public class Point {
    private Long id;
    private Long poid;
    private Long sid;
    private Long pointuse;
    private Date pointTime;
    private Date modifyTime;
    private String memo;
    private String des;
    private Pointoption pointoption;

    public Pointoption getPointoption() {
        return pointoption;
    }

    public void setPointoption(Pointoption pointoption) {
        this.pointoption = pointoption;
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getPoid() {
        return poid;
    }

    public void setPoid(Long poid) {
        this.poid = poid;
    }

    public Long getSid() {
        return sid;
    }

    public void setSid(Long sid) {
        this.sid = sid;
    }

    public Long getPointuse() {
        return pointuse;
    }

    public void setPointuse(Long pointuse) {
        this.pointuse = pointuse;
    }

    public Date getPointTime() {
        return pointTime;
    }

    public void setPointTime(Date pointTime) {
        this.pointTime = pointTime;
    }

    public Date getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Date modifyTime) {
        this.modifyTime = modifyTime;
    }

    public String getMemo() {
        return memo;
    }

    public void setMemo(String memo) {
        this.memo = memo;
    }

    public String getDes() {
        return des;
    }

    public void setDes(String des) {
        this.des = des;
    }
}

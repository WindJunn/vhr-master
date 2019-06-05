package org.sang.bean;

import java.sql.Timestamp;

/**
 * Created by sang on 2017/12/20.
 */
public class Point {
    private Long id;
    private Long poid;
    private Long sid;
    private Long pointuse;
    private Timestamp createTime;
    private Timestamp modifyTime;
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

    public Timestamp getCreateTime() {
        return createTime;
    }

    public void setCreateTime(Timestamp createTime) {
        this.createTime = createTime;
    }

    public Timestamp getModifyTime() {
        return modifyTime;
    }

    public void setModifyTime(Timestamp modifyTime) {
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

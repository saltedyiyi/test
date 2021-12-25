package com.typhoon.bean;

import java.math.BigDecimal;

public class Car {
    private Integer id;

    private Integer gid;

    private Integer uid;

    
    private String gname,danwei,pic;
    private BigDecimal cxprice;    
    private BigDecimal price;


    public String getGname() {
		return gname;
	}

	public void setGname(String gname) {
		this.gname = gname;
	}

	public String getDanwei() {
		return danwei;
	}

	public void setDanwei(String danwei) {
		this.danwei = danwei;
	}

	public String getPic() {
		return pic;
	}

	public void setPic(String pic) {
		this.pic = pic;
	}

	public BigDecimal getCxprice() {
		return cxprice;
	}

	public void setCxprice(BigDecimal cxprice) {
		this.cxprice = cxprice;
	}

	public BigDecimal getPrice() {
		return price;
	}

	public void setPrice(BigDecimal price) {
		this.price = price;
	}

	public Integer getId() {
        return id;
    }

    public void setId(Integer id) {
        this.id = id;
    }

    public Integer getGid() {
        return gid;
    }

    public void setGid(Integer gid) {
        this.gid = gid;
    }

    public Integer getUid() {
        return uid;
    }

    public void setUid(Integer uid) {
        this.uid = uid;
    }

	@Override
	public String toString() {
		return "Car [id=" + id + ", gid=" + gid + ", uid=" + uid + ", gname=" + gname + ", danwei=" + danwei + ", pic="
				+ pic + ", cxprice=" + cxprice + ", price=" + price + "]";
	}

}
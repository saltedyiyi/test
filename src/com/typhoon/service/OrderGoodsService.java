package com.typhoon.service;

import java.util.List;

import org.apache.ibatis.annotations.Param;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.typhoon.bean.Goods;
import com.typhoon.bean.OrderGoods;
import com.typhoon.dao.OrderGoodsMapper;

@Service
public class OrderGoodsService {
	@Autowired
	private OrderGoodsMapper mapper;

	
	public List<OrderGoods> selectByUser(int uid) {
		return mapper.selectByUser(uid);

	}
	public List<OrderGoods> selectAll() {
		return mapper.selectAll();

	}

	public OrderGoods selectById(int id) {
		return mapper.selectByPrimaryKey(id);

	}

	public int add(OrderGoods bean) {
		return mapper.insert(bean);

	}

	public int update(OrderGoods bean) {
		return mapper.updateByPrimaryKey(bean);
	}
	
	
	public int delete(int id) {
		return mapper.deleteByPrimaryKey(id);
	}
	

}
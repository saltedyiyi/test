package com.typhoon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.typhoon.bean.Goods;
import com.typhoon.dao.GoodsMapper;

@Service
public class GoodsService {
	@Autowired
	private GoodsMapper mapper;

	
	public List<Goods> selectAll(String keyword) {
		return mapper.selectAll(keyword);

	}
	public List<Goods> selectByUser(int uid) {
		return mapper.selectByUser(uid);
		
	}
	
	
	

	public Goods selectById(int id) {
		return mapper.selectByPrimaryKey(id);

	}

	public int add(Goods bean) {
		return mapper.insert(bean);

	}

	public int update(Goods bean) {
		return mapper.updateByPrimaryKey(bean);
	}
	
	
	public int delete(int id) {
		return mapper.deleteByPrimaryKey(id);
	}
}
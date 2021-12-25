package com.typhoon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.typhoon.bean.QiuGou;
import com.typhoon.dao.QiuGouMapper;

@Service
public class QiuGouService {
	@Autowired
	private QiuGouMapper mapper;

	
	public List<QiuGou> selectAll() {
		return mapper.selectAll();

	}
	
	public List<QiuGou> selectByUser(int uid) {
		return mapper.selectByUser(uid);
		
	}


	public QiuGou selectById(int id) {
		return mapper.selectByPrimaryKey(id);

	}

	public int add(QiuGou bean) {
		return mapper.insert(bean);

	}

	public int update(QiuGou bean) {
		return mapper.updateByPrimaryKey(bean);
	}
	
	
	public int delete(int id) {
		return mapper.deleteByPrimaryKey(id);
	}
}
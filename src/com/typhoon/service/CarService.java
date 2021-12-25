package com.typhoon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.typhoon.bean.Car;
import com.typhoon.dao.CarMapper;

@Service
public class CarService {
	@Autowired
	private CarMapper mapper;

	
	public List<Car> selectAll() {
		return mapper.selectAll();

	}
	
	public List<Car> selectByUser(int uid) {
		return mapper.selectByUser(uid);
		
	}


	public Car selectById(int id) {
		return mapper.selectByPrimaryKey(id);

	}

	public int add(Car bean) {
		return mapper.insert(bean);

	}

	public int update(Car bean) {
		return mapper.updateByPrimaryKey(bean);
	}
	
	
	public int delete(int id) {
		return mapper.deleteByPrimaryKey(id);
	}
}
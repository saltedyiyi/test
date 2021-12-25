package com.typhoon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.typhoon.bean.Address;
import com.typhoon.dao.AddressMapper;

@Service
public class AddressService {
	@Autowired
	private AddressMapper mapper;

	
	public List<Address> selectAll() {
		return mapper.selectAll();

	}
	
	public List<Address> selectByUser(int uid) {
		return mapper.selectByUser(uid);
		
	}

	public Address selectById(int id) {
		return mapper.selectByPrimaryKey(id);

	}

	public int add(Address bean) {
		return mapper.insert(bean);

	}

	public int update(Address bean) {
		return mapper.updateByPrimaryKey(bean);
	}
	
	
	public int delete(int id) {
		return mapper.deleteByPrimaryKey(id);
	}
}
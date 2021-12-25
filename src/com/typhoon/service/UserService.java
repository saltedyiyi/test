package com.typhoon.service;

import java.util.HashMap;
import java.util.List;
import java.util.Map;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.typhoon.bean.User;
import com.typhoon.dao.UserMapper;

@Service
public class UserService {
	@Autowired
	private UserMapper mapper;

	public User selectByAccount(String account) {
		User user = mapper.selectByAccount(account);
		return user;
	}

	public List<User> selectAll() {
		return mapper.selectAll();

	}
	public List<User> selectByType(int type) {
		return mapper.selectByType(type);
		
	}
	

	public User selectById(int id) {
		return mapper.selectByPrimaryKey(id);

	}

	public int add(User user) {
		return mapper.insert(user);

	}

	public int update(User user) {
		return mapper.updateByPrimaryKey(user);
	}

	public int updatePassword(User user) {
		return mapper.updatePassword(user);
	}

	public int delete(int id) {
		return mapper.deleteByPrimaryKey(id);
	}
}
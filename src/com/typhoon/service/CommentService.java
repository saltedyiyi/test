package com.typhoon.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.typhoon.bean.Comment;
import com.typhoon.dao.CommentMapper;

@Service
public class CommentService {
	@Autowired
	private CommentMapper mapper;

	
	public List<Comment> selectAll() {
		return mapper.selectAll();

	}
	
	public List<Comment> selectByUser(int uid) {
		return mapper.selectByUser(uid);
		
	}
	public List<Comment> selectByGid(int gid) {
		return mapper.selectByGid(gid);
		
	}
	

	public Comment selectById(int id) {
		return mapper.selectByPrimaryKey(id);

	}

	public int add(Comment bean) {
		return mapper.insert(bean);

	}

	public int update(Comment bean) {
		return mapper.updateByPrimaryKey(bean);
	}
	
	
	public int delete(int id) {
		return mapper.deleteByPrimaryKey(id);
	}
}
package com.typhoon.controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.context.request.RequestContextHolder;
import org.springframework.web.context.request.ServletRequestAttributes;

import com.typhoon.bean.Goods;
import com.typhoon.bean.QiuGou;
import com.typhoon.bean.User;
import com.typhoon.service.QiuGouService;

@Controller
@Transactional
@RequestMapping("/qiugou") // 表示命名空间
public class QiuGouController {
	@Autowired
	private QiuGouService service;

	@RequestMapping(value = "/selectAll.do")
	@ResponseBody
	public Map<String, Object> selectAll() {
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("code", 0);
			map.put("msg", "success");
			map.put("data", service.selectAll());
			return map;
		} catch (Exception e) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("code", 1);
			map.put("msg", "服务器繁忙");
			map.put("data", "[]");
			map.put("count", 0);
			e.printStackTrace();
			return map;
		}

	}
	@RequestMapping(value = "/selectFour.do")
	@ResponseBody
	public Map<String, Object> selectFour() {
		 List<QiuGou> data=	service.selectAll();
		 List<QiuGou> data2=new ArrayList<QiuGou>();
		for(int i=0;i<4&&i<data.size();i++) {
			data2.add(data.get(i));
		}
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("code", 0);
			map.put("msg", "success");
			map.put("data",data2 );
			return map;
		} catch (Exception e) {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("code", 1);
			map.put("msg", "服务器繁忙");
			map.put("data", "[]");
			map.put("count", 0);
			e.printStackTrace();
			return map;
		}
		
	}
	@RequestMapping(value = "/selectByUser.do")
	@ResponseBody
	public Map<String, Object> selectByUser(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			User user = (User) request.getSession().getAttribute("user");
			if(user==null) {
				map.put("code", 2);
				map.put("msg", "登录失效");
				return map;
			}
			map.put("code", 0);
			map.put("msg", "success");
			map.put("data", service.selectByUser(user.getId()));
			return map;
		} catch (Exception e) {
			map.put("code", 1);
			map.put("msg", "服务器繁忙");
			map.put("data", "[]");
			map.put("count", 0);
			e.printStackTrace();
			return map;
		}
		
	}
	
	@RequestMapping(value = "/getById.do")
	@ResponseBody
	public Map<String, Object> getById( int id) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			QiuGou bean = service.selectById(id);
			map.put("code", 0);
			map.put("msg", "success");
			map.put("data", bean);
			return map;
		} catch (Exception e) {
			map.put("code", 1);
			map.put("msg", "服务器繁忙");
			map.put("data", "");
			e.printStackTrace();
			return map;
		}

	}

	@RequestMapping(value = "/add.do")
	@ResponseBody
	public Map<String, Object> add(QiuGou bean,HttpServletRequest request) {
		System.out.println(bean);
		Map<String, Object> map = new HashMap<String, Object>();
		User user = (User) request.getSession().getAttribute("user");
		if(user==null) {
			map.put("code", 2);
			map.put("msg", "登录失效");
			return map;
		}
		bean.setUid(user.getId());
		try {
			int flag = service.add(bean);
			System.out.println(bean);
			if (flag == 0) {
				map.put("code", 1);
				map.put("msg", "操作失败");
			} else {
				map.put("code", 0);
				map.put("msg", "success");
			}

		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", 1);
			map.put("msg", "操作失败");
		}
		return map;
	}

	
	@RequestMapping(value = "/update.do")
	@ResponseBody
	public Map<String, Object> update(QiuGou bean) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			int flag = service.update(bean);
			if (flag == 0) {
				map.put("code", 1);
				map.put("msg", "操作失败");
			} else {
				map.put("code", 0);
				map.put("msg", "success");
			}

		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", 1);
			map.put("msg", "操作失败");
		}
		return map;
	}

	

	@RequestMapping(value = "/delete.do")
	@ResponseBody
	public Map<String, Object> delete(int id) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			int flag = service.delete(id);
			if (flag == 0) {
				map.put("code", 1);
				map.put("msg", "操作失败");
			} else {
				map.put("code", 0);
				map.put("msg", "success");
			}

		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", 1);
			map.put("msg", "操作失败");
		}
		return map;
	}
}

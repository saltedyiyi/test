package com.typhoon.controller;

import java.io.IOException;
import java.util.HashMap;
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

import com.typhoon.bean.User;
import com.typhoon.service.UserService;

@Controller
@Transactional
@RequestMapping("/user") // 表示命名空间
public class UserController {
	@Autowired
	private UserService service;

	@RequestMapping(value = "/spash.do")
	@ResponseBody
	public void spash(HttpServletRequest request, HttpServletResponse response) {
		try {
			User user = (User) request.getSession().getAttribute("user");
			if (user != null && user.getType() == 1) {
				response.setContentType("text/html;charset=utf-8");
				((HttpServletResponse) response).sendRedirect(request.getContextPath() + "/jsp/index.jsp");
			} else {
				((HttpServletResponse) response).sendRedirect(request.getContextPath() + "/jsp/login.jsp");
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}

	@RequestMapping(value = "/logout.do")
	@ResponseBody
	public void logout(HttpServletRequest request, HttpServletResponse response) {
		request.getSession().removeAttribute("user");
		response.setContentType("text/html;charset=utf-8");
		try {
			((HttpServletResponse) response).sendRedirect(request.getContextPath() + "/jsp/login.jsp");
		} catch (IOException e) {
			e.printStackTrace();
		}
	}

	@RequestMapping(value = "/login.do", method = RequestMethod.POST)
	@ResponseBody
	public Map<String, Object> login(String account, String password) {
		ServletRequestAttributes attributes = (ServletRequestAttributes) RequestContextHolder.getRequestAttributes();
		HttpServletRequest request = attributes.getRequest();
		System.out.println(account + "===" + password);
		User user = service.selectByAccount(account);
		System.out.println(user);
		Map<String, Object> map = new HashMap<String, Object>();
		if (user != null) {
			if (user.getPassword().equals(password)) {
				map.put("code", 0);
				map.put("msg", "登录成功");
				map.put("data", user);
				request.getSession().setAttribute("user", user);
			} else {
				map.put("code", 1);
				map.put("msg", "用户名或密码错误");
			}

		} else {
			map.put("code", 1);
			map.put("msg", "用户不存在");
		}

		return map;
	}

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
	@RequestMapping(value = "/selectByType.do")
	@ResponseBody
	public Map<String, Object> selectByType(int type) {
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("code", 0);
			map.put("msg", "success");
			map.put("data", service.selectByType(type));
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

	@RequestMapping(value = "/getById.do")
	@ResponseBody
	public Map<String, Object> getById( int id) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			User user = service.selectById(id);
			map.put("code", 0);
			map.put("msg", "success");
			map.put("data", user);
			return map;
		} catch (Exception e) {
			map.put("code", 1);
			map.put("msg", "服务器繁忙");
			map.put("data", "");
			e.printStackTrace();
			return map;
		}

	}

	@RequestMapping(value = "/getSelf.do")
	@ResponseBody
	public Map<String, Object> getSelf( HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		User tt=(User) request.getSession().getAttribute("user");
		if(tt==null) {
			map.put("code", 2);
			map.put("msg", "登录过期，请重新登录");
			return map;
		}
		try {
			User user = service.selectById(tt.getId());
			map.put("code", 0);
			map.put("msg", "success");
			map.put("data", user);
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
	public Map<String, Object> add(User user) {
		System.out.println(user);
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			User bean = service.selectByAccount(user.getAccount());
			if (bean != null) {
				map.put("code", 1);
				map.put("msg", "该用户已经存在");
				return map;
			}
			int flag = service.add(user);
			System.out.println(user);
			if (flag == 0) {
				map.put("code", 1);
				map.put("msg", "操作失败");
			} else {
				map.put("code", 0);
				map.put("msg", "success");
			}

		} catch (Exception e) {
			map.put("code", 1);
			map.put("msg", "操作失败");
		}
		return map;
	}

	@RequestMapping(value = "/updateSelf.do")
	@ResponseBody
	public Map<String, Object> updateSelf(User user,HttpServletRequest request) {
		System.out.println(user.toString());
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			User tt=(User) request.getSession().getAttribute("user");
			if(tt==null) {
				map.put("code", 2);
				map.put("msg", "登录过期，请重新登录");
				return map;
			}
			user.setId(tt.getId());
			System.out.println(user);
			int flag = service.update(user);
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
	@RequestMapping(value = "/updatePassword.do")
	@ResponseBody
	public Map<String, Object> updatePassword(String prepassword,String password,int type,HttpServletRequest request) {
		Map<String, Object> map = new HashMap<String, Object>();
		User user = (User) request.getSession().getAttribute("user");
		if(user==null) {
			map.put("code", 2);
			map.put("msg", "登录失效");
			return map;
		}
		if(!prepassword.equals(user.getPassword())) {
			map.put("code", 1);
			map.put("msg", "原密码错误");
			return map;
		}
		try {
			user.setPassword(password);
			int flag = service.updatePassword(user);
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
	public Map<String, Object> update(User user) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			User bean = service.selectByAccount(user.getAccount());
			if (bean != null && bean.getId() != user.getId()) {
				map.put("code", 1);
				map.put("msg", "该用户已经存在");
				return map;
			}
			int flag = service.update(user);
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

package com.typhoon.controller;

import java.io.File;
import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import java.util.UUID;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;

import com.typhoon.bean.Goods;
import com.typhoon.bean.User;
import com.typhoon.service.GoodsService;

@Controller
@Transactional
@RequestMapping("/goods") // 表示命名空间
public class GoodsController {
	@Autowired
	private GoodsService service;

	@RequestMapping(value = "/selectAll.do")
	@ResponseBody
	public Map<String, Object> selectAll() {
		System.out.println("1111");
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("code", 0);
			map.put("msg", "success");
			map.put("data", service.selectAll(""));
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
		System.out.println("1111");
		List<Goods> data = service.selectAll("");
		List<Goods> data2 = new ArrayList<Goods>();
		for (int i = 0; i < 4 && i < data.size(); i++) {
			data2.add(data.get(i));
		}
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("code", 0);
			map.put("msg", "success");
			map.put("data", data2);
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

	@RequestMapping(value = "/selectByKey.do")
	@ResponseBody
	public Map<String, Object> selectByKey(String key) {
		System.out.println("1111" + key);
		try {
			Map<String, Object> map = new HashMap<String, Object>();
			map.put("code", 0);
			map.put("msg", "success");
			map.put("data", service.selectAll(key));
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
		User user = (User) request.getSession().getAttribute("user");
		if (user == null) {
			map.put("code", 2);
			map.put("msg", "登录失效");
			return map;
		}
		try {
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
	public Map<String, Object> getById(int id) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			Goods bean = service.selectById(id);
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
	public Map<String, Object> add(Goods bean, HttpServletRequest request) {
		System.out.println(bean);
		Map<String, Object> map = new HashMap<String, Object>();
		User user = (User) request.getSession().getAttribute("user");
		if (user == null) {
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
	public Map<String, Object> update(Goods bean) {
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

	@RequestMapping("/upload.do")
	@ResponseBody
	public Map<String, Object> upload(MultipartFile file, HttpSession session) throws Exception {
		// 文件路径url
		System.out.println(file.getName());
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			if (file != null && !file.isEmpty()) {
				// 获取上传文件的原始名称
				String originalFilename = file.getOriginalFilename();
				String end = "";
				if (originalFilename.contains(".")) {
					end = originalFilename.substring(originalFilename.lastIndexOf("."));
				}
				// 获取项目部署目录根
				File rootPath = new File(session.getServletContext().getRealPath("/")).getParentFile();
				File uploadFile = new File(rootPath.getPath() + "/mallfiles/");
				// 如果保存文件的地址不存在，就先创建目录
				if (!uploadFile.exists()) {
					uploadFile.mkdirs();
				}
				String newFilename = new Date().getTime() + "" + UUID.randomUUID();
				newFilename = newFilename.replace("-", "");
				String url = rootPath.getPath() + "/mallfiles/" + newFilename + end;
				// 文件路径url
				System.out.println("/mallfiles/" + newFilename + end);
				try {
					// 使用MultipartFile接口的方法完成文件上传到指定位置
					file.transferTo(new File(url));
				} catch (Exception e) {
					e.printStackTrace();
				}

				map.put("code", 0);
				map.put("msg", "上传成功");
				map.put("data", "/mallfiles/" + newFilename + end);
			} else {
				map.put("code", 1);
				map.put("msg", "上传失败");
			}
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", 1);
			map.put("msg", "上传失败");
		}
		return map;

	}
	
	@RequestMapping(value = "/search.do")
	@ResponseBody
	public  Map<String, Object> search(String keyword, HttpServletRequest request, HttpServletResponse response) {
		Map<String, Object> map = new HashMap<String, Object>();
		try {
			request.getSession().setAttribute("keyword", keyword);
	
			map.put("code", 0);
			map.put("msg", "success");
		} catch (Exception e) {
			e.printStackTrace();
			map.put("code", 1);
			map.put("msg", "success");
		}
		return map;
	}

	@RequestMapping(value = "/searchByKeyword.do")
	@ResponseBody
	public Map<String, Object> searchByKeyword(HttpServletRequest request, String keyword) {
		if(keyword.equals("-1")) {
			keyword=(String) request.getSession().getAttribute("keyword");
		}
		System.out.println("searchByKeyword" + keyword);

		Map<String, Object> map = new HashMap<String, Object>();
		try {
			map.put("code", 0);
			map.put("msg", "success");
			map.put("data", service.selectAll(keyword));
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
}

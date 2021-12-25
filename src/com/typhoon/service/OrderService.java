package com.typhoon.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.typhoon.bean.Goods;
import com.typhoon.bean.Order;
import com.typhoon.bean.OrderGoods;
import com.typhoon.dao.CarMapper;
import com.typhoon.dao.GoodsMapper;
import com.typhoon.dao.OrderGoodsMapper;
import com.typhoon.dao.OrderMapper;

@Service
public class OrderService {
	@Autowired
	private OrderMapper mapper;
	@Autowired
	private GoodsMapper gmapper;
	@Autowired
	private CarMapper cmapper;
	@Autowired
	private OrderGoodsMapper ogmapper;
	public List<Order> selectAll() {
		return mapper.selectAll();

	}

	public List<Order> selectByUser(int uid) {
		List<Order> data=mapper.selectByUser(uid);
		for(Order bean:data) {
			List<OrderGoods> ogs= ogmapper.selectByOid(bean.getId());
			List<Goods> goods= new ArrayList<Goods>();
			for (int i = 0; i < ogs.size(); i++) {
				int gid =ogs.get(i).getGid() ;
				goods.add(gmapper.selectByPrimaryKey(gid));
			}
			bean.setGoods(goods);
		}
		return data;

	}

	public Order selectById(int id) {
		return mapper.selectByPrimaryKey(id);

	}

	public int add(Order bean) {
		String[] gids = bean.getGid().split(",");
		String[] cids = null;
		if (bean.getCid() != null)
			cids = bean.getCid().split(",");
		int ff=mapper.insert(bean);
		for (int i = 0; i < gids.length; i++) {
			int gid = Integer.parseInt(gids[i]);
			int kuncun=gmapper.selectByPrimaryKey(gid).getKucun();
			gmapper.updateKucun(gid, kuncun-1);
			if(cids!=null) {
				int cid = Integer.parseInt(cids[i]);
				cmapper.deleteByPrimaryKey(cid);
			}
			OrderGoods og=new OrderGoods();
			og.setGid(gid);
			og.setOid(bean.getId());
			ogmapper.insert(og);
		}
		return ff;

	}

	public int update(Order bean) {
		return mapper.updateByPrimaryKey(bean);
	}

	public int delete(int id) {
		return mapper.deleteByPrimaryKey(id);
	}
}
package com.typhoon.dao;

import com.typhoon.bean.OrderGoods;
import java.util.List;

public interface OrderGoodsMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(OrderGoods record);

    OrderGoods selectByPrimaryKey(Integer id);

    List<OrderGoods> selectAll();

	 List<OrderGoods> selectByUser(int uid);
    List<OrderGoods> selectByOid(int oid);
    int updateByPrimaryKey(OrderGoods record);
}
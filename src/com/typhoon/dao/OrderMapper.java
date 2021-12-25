package com.typhoon.dao;

import com.typhoon.bean.Order;
import java.util.List;

public interface OrderMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Order record);

    Order selectByPrimaryKey(Integer id);

    List<Order> selectAll();
    List<Order> selectByUser(int uid);

    int updateByPrimaryKey(Order record);
}
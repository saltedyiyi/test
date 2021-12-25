package com.typhoon.dao;

import com.typhoon.bean.Car;
import java.util.List;

public interface CarMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Car record);

    Car selectByPrimaryKey(Integer id);

    List<Car> selectAll();
    List<Car> selectByUser(int uid);

    int updateByPrimaryKey(Car record);
}
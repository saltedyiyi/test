package com.typhoon.dao;

import com.typhoon.bean.Address;
import java.util.List;

public interface AddressMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Address record);

    Address selectByPrimaryKey(Integer id);

    List<Address> selectAll();
    List<Address> selectByUser(int uid);

    int updateByPrimaryKey(Address record);
}
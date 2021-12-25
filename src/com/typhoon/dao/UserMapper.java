package com.typhoon.dao;

import com.typhoon.bean.User;
import java.util.List;

public interface UserMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(User record);

    User selectByPrimaryKey(Integer id);

    List<User> selectAll();
    List<User> selectByType(int type);
    int updateByPrimaryKey(User record);
    int updatePassword(User record);
    User selectByAccount(String  account);
}
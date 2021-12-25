package com.typhoon.dao;

import com.typhoon.bean.QiuGou;
import java.util.List;

public interface QiuGouMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(QiuGou record);

    QiuGou selectByPrimaryKey(Integer id);

    List<QiuGou> selectAll();
    List<QiuGou> selectByUser(int uid);

    int updateByPrimaryKey(QiuGou record);
}
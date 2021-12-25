package com.typhoon.dao;

import com.typhoon.bean.Goods;
import java.util.List;

import org.apache.ibatis.annotations.Param;

public interface GoodsMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Goods record);

    Goods selectByPrimaryKey(Integer id);

    List<Goods> selectAll(String keyword);
    List<Goods>  selectByUser(int uid);

    int updateByPrimaryKey(Goods record);
    int updateKucun(@Param("id") int id,@Param("kucun") int kucun);
}
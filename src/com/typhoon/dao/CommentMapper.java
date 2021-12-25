package com.typhoon.dao;

import com.typhoon.bean.Comment;
import java.util.List;

public interface CommentMapper {
    int deleteByPrimaryKey(Integer id);

    int insert(Comment record);

    Comment selectByPrimaryKey(Integer id);

    List<Comment> selectAll();
    List<Comment> selectByUser(int uid);
    List<Comment> selectByGid(int gid);

    int updateByPrimaryKey(Comment record);
}
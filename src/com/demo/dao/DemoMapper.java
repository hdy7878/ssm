package com.demo.dao;

import java.util.List;

import org.apache.ibatis.annotations.Param;

import com.demo.pojo.Demo;
import com.demo.pojo.News;

public interface DemoMapper {

	public List<Demo> findAllDemo();

	public Demo findUserByName(String username);

	public void addUserNotAdmin(Demo demo);

	public Demo findUser(@Param("username")String username, @Param("password")String password, @Param("isAdminFlag")String isAdminFlag);

	public List<News> findAllNews();

	public void addNews(News news);

	public void updateNews1(String id);
	
	public void updateNews2(String id);

	public List<News> findNotDeleteNews();

	public News findNewsById(String id);
	
}

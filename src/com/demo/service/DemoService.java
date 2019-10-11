package com.demo.service;

import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.List;

import javax.annotation.Resource;

import org.springframework.stereotype.Service;

import com.demo.dao.DemoMapper;
import com.demo.pojo.Demo;
import com.demo.pojo.News;

@Service
public class DemoService {
	@Resource
	private DemoMapper demoMapper;

	public List<Demo> findAllDemo() {
		return demoMapper.findAllDemo();
	}

	public void addUserNotAdmin(String username, String password) {
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMddhhmmss");
		String date = df.format(new Date());
		String id = "A" + date;
		Demo demo = new Demo();
		demo.setId(id);
		demo.setUsername(username);
		demo.setPassword(password);
		demo.setIsAdminFlag(0);
		demoMapper.addUserNotAdmin(demo);
	}

	public Demo findUserByName(String username) {
		return demoMapper.findUserByName(username);
	}

	public Demo findUser(String username,String password, String isAdminFlag) {
		return demoMapper.findUser(username,password,isAdminFlag);
	}

	public List<News> findAllNews() {
		return demoMapper.findAllNews();
	}

	public void addNews(String title, String content, String imgName, Integer isDeleteFlag) {
		SimpleDateFormat df = new SimpleDateFormat("yyyyMMddhhmmss");
		String date = df.format(new Date());
		String id = "A" + date;
		News news = new News();
		news.setId(id);
		news.setTitle(title);
		news.setContent(content);
		news.setPicture(imgName);
		news.setIsDeleteFlag(isDeleteFlag);
		demoMapper.addNews(news);
	}

	public void updateNews(String id, String isDeleteFlag) {
		if (isDeleteFlag.equals("0")) {
			demoMapper.updateNews1(id);
		}else{
			demoMapper.updateNews2(id);
		}
	}

	public List<News> findNotDeleteNews() {
		return demoMapper.findNotDeleteNews();
	}

	public News findNewsById(String id) {
		return demoMapper.findNewsById(id);
	}

}

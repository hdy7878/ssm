package com.demo.action;

import java.io.File;
import java.io.IOException;
import java.text.SimpleDateFormat;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.annotation.Resource;
import javax.servlet.http.HttpServletRequest;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartFile;
import org.springframework.web.servlet.ModelAndView;

import com.demo.pojo.Demo;
import com.demo.pojo.News;
import com.demo.service.DemoService;

@Controller
@RequestMapping("/demo")
public class DemoController {

	@Resource
	private DemoService demoService;

	@RequestMapping("/list")
	public String list(Model model) {
		List<Demo> list = demoService.findAllDemo();
		model.addAttribute("list", list);
		return "demo";
	}

	@ResponseBody
	@RequestMapping("/regist")
	public Map<String, Object> regist(HttpServletRequest request, String username, String password) {
		Map<String, Object> map = new HashMap<>();
		Demo demo = demoService.findUserByName(username);
		if (demo != null) {
			map.put("code", 500);
			map.put("msg", "用户名已存在");
			return map;
		}
		demoService.addUserNotAdmin(username, password);
		map.put("code", 200);
		return map;
	}

	@ResponseBody
	@RequestMapping("/login")
	public Map<String, Object> login(HttpServletRequest request, String username, String password, String isAdminFlag) {
		Map<String, Object> map = new HashMap<>();
		// 普通用户登录
		if (isAdminFlag != null && Integer.parseInt(isAdminFlag) == 0) {
			Demo demo = demoService.findUser(username, password, isAdminFlag);
			if (demo == null) {
				map.put("code", 500);
				map.put("msg", "该用户不存在");
				return map;
			}
			request.getSession().setAttribute("User", demo);
			map.put("code", 201);
		}
		// 管理员登录
		if (isAdminFlag != null && Integer.parseInt(isAdminFlag) == 1) {
			Demo demo = demoService.findUser(username, password, isAdminFlag);
			if (demo == null) {
				map.put("code", 500);
				map.put("msg", "该用户不存在");
				return map;
			}
			request.getSession().setAttribute("adminUser", demo);
			map.put("code", 202);
		}
		return map;
	}

	@RequestMapping("/toLogin")
	public ModelAndView toLogin(HttpServletRequest request) {
		ModelAndView model = new ModelAndView();
		model.setViewName("../login");
		return model;
	}

	@RequestMapping("/listNews")
	public ModelAndView listNews(HttpServletRequest request) {
		ModelAndView model = new ModelAndView();
		Demo demo = (Demo) request.getSession().getAttribute("User");
		if (demo == null) {
			model.setViewName("redirect:../demo/toLogin.action");
			return model;
		}
		List<News> listNews = demoService.findNotDeleteNews();
		request.setAttribute("listNews", listNews);
		model.setViewName("../listNews");
		return model;
	}

	@RequestMapping("/addNews")
	public ModelAndView addNews(HttpServletRequest request, String username, String password, String isAdminFlag) {
		ModelAndView model = new ModelAndView();
		Demo demo = (Demo) request.getSession().getAttribute("adminUser");
		if (demo == null) {
			model.setViewName("redirect:../demo/toLogin.action");
			return model;
		}
		model.setViewName("../addNews");
		return model;
	}

	@ResponseBody
	@RequestMapping("/getListNews")
	public Map<String, Object> getListNews(HttpServletRequest request) {
		Map<String, Object> map = new HashMap<>();
		List<News> listNews = demoService.findAllNews();
		if (listNews != null && listNews.size() > 0) {
			map.put("code", 0);
			map.put("msg", "");
			map.put("count", listNews.size());
			map.put("data", listNews);
		} else {
			map.put("code", 0);
			map.put("msg", "");
			map.put("count", 0);
			map.put("data", null);
		}
		return map;
	}

	@ResponseBody
	@RequestMapping("/fileupload")
	public Map<String, Object> upload(MultipartFile file, HttpServletRequest request) throws IOException {
		Map<String, Object> map = new HashMap<>();
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		String res = sdf.format(new Date());
		// uploads文件夹位置
		String rootPath = request.getSession().getServletContext().getRealPath("newsImage/");
		// 原始名称
		String originalFileName = file.getOriginalFilename();
		// 新文件名
		String newFileName = res + originalFileName.substring(originalFileName.lastIndexOf("."));
		// 新文件
		File newFile = new File(rootPath + File.separator + newFileName);
		
		// 判断目标文件所在目录是否存在
		if (!newFile.getParentFile().exists()) {
			// 如果目标文件所在的目录不存在，则创建父目录
			newFile.getParentFile().mkdirs();
		}
		// 将内存中的数据写入磁盘
		file.transferTo(newFile);
		// 完整的url
		map.put("code",0);
		map.put("msg","");
		map.put("data",newFile.getName());
		return map;
	}
	
	@ResponseBody
	@RequestMapping("/addNews2")
	public Map<String, Object> addNews2(HttpServletRequest request,String title,String content,String imgName,String isDeleteFlag) {
		Map<String, Object> map = new HashMap<>();
		demoService.addNews(title,content,imgName,Integer.parseInt(isDeleteFlag));
		map.put("code", 200);
		return map;
	}
	
	@ResponseBody
	@RequestMapping("/updateNews")
	public Map<String, Object> updateNews(HttpServletRequest request,String id,String isDeleteFlag) {
		Map<String, Object> map = new HashMap<>();
		demoService.updateNews(id,isDeleteFlag);
		map.put("code", 200);
		return map;
	}
	
	@RequestMapping("/outLogin")
	public ModelAndView outLogin(HttpServletRequest request) {
		ModelAndView model = new ModelAndView();
		request.getSession().removeAttribute("User");
		request.getSession().removeAttribute("adminUser");
		model.setViewName("../login");
		return model;
	}
	
	@RequestMapping("/newsInfo")
	public ModelAndView newsInfo(HttpServletRequest request,String id) {
		ModelAndView model = new ModelAndView();
		News news = demoService.findNewsById(id);
		System.out.println("=======" + news.getTitle());
		request.setAttribute("news", news);
		model.setViewName("../newsInfo");
		return model;
	}

}

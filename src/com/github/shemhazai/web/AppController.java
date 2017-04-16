package com.github.shemhazai.web;

import java.io.IOException;
import java.util.List;

import javax.annotation.PostConstruct;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import com.github.shemhazai.dao.BoardDao;
import com.github.shemhazai.model.Board;
import com.google.gson.Gson;

@Controller
public class AppController {

	@Autowired
	private BoardDao boardDao;

	@RequestMapping("/")
	public ModelAndView listBoard(ModelAndView model) throws IOException {
		List<Board> listBoard = boardDao.getBoards();
		for (Board b : listBoard) {
			b.setJson("");
			b.setAuthor("");
			b.setDescription("");
		}
		model.addObject("listBoard", listBoard);
		model.setViewName("index");
		return model;
	}

	@RequestMapping("/create")
	public ModelAndView createBoard(ModelAndView model) throws IOException {
		model.setViewName("edit");
		model.addObject("option", "create");
		return model;
	}

	@RequestMapping(value = "/get", method = RequestMethod.POST)
	@ResponseBody
	public String get(@RequestParam Integer id, HttpServletRequest request, HttpServletResponse response, Model model) {
		Board board = boardDao.getBoard(id);
		return new Gson().toJson(board);
	}

	@RequestMapping(value = "/update", method = RequestMethod.POST)
	@ResponseBody
	public String update(@RequestParam Integer id, @RequestParam String name, @RequestParam String author,
			@RequestParam String description, @RequestParam String json) {
		boardDao.update(id, name, author, description, json);
		return "successfully updated";
	}

	@RequestMapping("/edit")
	public ModelAndView editBoard(ModelAndView model) throws IOException {
		model.setViewName("edit");
		model.addObject("option", "edit");
		return model;
	}

	@RequestMapping("/play")
	public ModelAndView playBoard(ModelAndView model) throws IOException {
		model.setViewName("play");
		return model;
	}

	@PostConstruct
	public void createTable() {
		boardDao.createBoardTableIfNotExists();
	}

}

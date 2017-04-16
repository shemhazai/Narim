package com.github.shemhazai.dao;

import java.util.List;

import javax.sql.DataSource;

import com.github.shemhazai.model.Board;

public interface BoardDao {

	public void setDataSource(DataSource dataSource);

	public void createBoardTableIfNotExists();

	public Board getBoard(Integer id);

	public List<Board> getBoards();

	public void create(String name, String author, String description, String json);

	public void update(Integer id, String name, String author, String description, String json);

	public void delete(Integer id);

	public void clear();
}

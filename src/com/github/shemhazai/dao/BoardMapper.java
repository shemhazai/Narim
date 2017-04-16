package com.github.shemhazai.dao;

import java.sql.ResultSet;
import java.sql.SQLException;

import org.springframework.jdbc.core.RowMapper;

import com.github.shemhazai.model.Board;

public class BoardMapper implements RowMapper<Board> {

	@Override
	public Board mapRow(ResultSet rs, int rowNum) throws SQLException {
		Board board = new Board();
		board.setId(rs.getInt("id"));
		board.setName(rs.getString("name"));
		board.setAuthor(rs.getString("author"));
		board.setDescription(rs.getString("description"));
		String json = rs.getString("json");
		board.setJson(json);
		board.setBlank(json.length() == 0);
		return board;
	}
}

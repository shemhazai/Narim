package com.github.shemhazai.dao;

import java.sql.PreparedStatement;
import java.sql.SQLException;
import java.util.List;

import javax.sql.DataSource;

import org.springframework.jdbc.core.BatchPreparedStatementSetter;
import org.springframework.jdbc.core.JdbcTemplate;

import com.github.shemhazai.model.Board;

public class BoardDaoImpl implements BoardDao {
	private JdbcTemplate jdbcTemplate;

	public void setDataSource(DataSource dataSource) {
		jdbcTemplate = new JdbcTemplate(dataSource);
	}

	@Override
	public void createBoardTableIfNotExists() {
		String SQL = "CREATE TABLE IF NOT EXISTS `board` (`id` int(11) auto_increment not null,"
				+ "`name` varchar(255), `author` varchar(255), `description` varchar(1024), `json` text,"
				+ " primary key(`id`)) default character set utf8 default collate utf8_general_ci";

		jdbcTemplate.update(SQL);

		if (getBoards().isEmpty()) {
			fillWithBlankData();
		}
	}

	private void fillWithBlankData() {
		String sql = "INSERT INTO board (name, author, description, json) VALUES (?, ?, ?, ?);";
		jdbcTemplate.batchUpdate(sql, new BatchPreparedStatementSetter() {
			@Override
			public void setValues(PreparedStatement ps, int i) throws SQLException {
				ps.setString(1, "");
				ps.setString(2, "");
				ps.setString(3, "");
				ps.setString(4, "");
			}

			@Override
			public int getBatchSize() {
				return 400;
			}
		});
	}

	@Override
	public Board getBoard(Integer id) {
		String SQL = "SELECT * FROM board WHERE id = ?;";
		Board board = jdbcTemplate.queryForObject(SQL, new Object[] { id }, new BoardMapper());
		return board;
	}

	@Override
	public List<Board> getBoards() {
		String SQL = "SELECT * FROM board;";
		List<Board> boards = jdbcTemplate.query(SQL, new BoardMapper());
		return boards;
	}

	@Override
	public void create(String name, String author, String description, String json) {
		String SQL = "INSERT INTO board (name, author, description, json) VALUES (?, ?, ?, ?);";
		jdbcTemplate.update(SQL, name, author, description, json);
	}

	@Override
	public void update(Integer id, String name, String author, String description, String json) {
		String SQL = "UPDATE board SET name = ?, author = ?, description = ?, json = ? WHERE id = ?;";
		jdbcTemplate.update(SQL, name, author, description, json, id);
	}

	@Override
	public void delete(Integer id) {
		String SQL = "DELETE FROM board WHERE id = ?;";
		jdbcTemplate.update(SQL, id);
	}

	@Override
	public void clear() {
		String SQL = "TRUNCATE TABLE board;";
		jdbcTemplate.update(SQL);
	}
}

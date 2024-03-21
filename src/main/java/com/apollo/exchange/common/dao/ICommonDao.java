package com.apollo.exchange.common.dao;

import org.springframework.dao.DataAccessException;

import java.util.List;

/**
 * @author ionio.dev
 * @apiNote Common Data Access Object Interface
 */
@SuppressWarnings("all")
public interface ICommonDao {

    public Object insert(String query, Object model) throws DataAccessException;
    public int update(String query, Object model) throws DataAccessException;
    public int delete(String query, Object search) throws DataAccessException;
    public <E> E selectOne(String query, Object search) throws DataAccessException;
    public <E> List<E> selectList(String query, Object search) throws DataAccessException;
    public <E> List<E> selectAll(String query) throws DataAccessException;
    public int count(String query, Object search) throws DataAccessException;
}

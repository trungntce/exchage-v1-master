package com.apollo.exchange.common.dao.impl;

import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.common.dao.support.SessionDaoSupport;
import org.springframework.dao.DataAccessException;
import org.springframework.stereotype.Repository;

import java.util.List;

/**
 * @author ionio.dev
 * @apiNote Common Data Access Object Interface Implementation
 */
@Repository
public class CommonDaoImpl extends SessionDaoSupport implements ICommonDao {

    public Object insert(String query, Object model) throws DataAccessException {
        getSqlSession().insert(query, model);
        return model;
    }

    public int update(String query, Object model) throws DataAccessException {
        return getSqlSession().update(query, model);
    }

    public int delete(String query, Object search) throws DataAccessException {
        return getSqlSession().delete(query, search);
    }

    public <E> E selectOne(String query, Object search) throws DataAccessException {
        return getSqlSession().selectOne(query, search);
    }

    public <E> List<E> selectList(String query, Object search) throws DataAccessException {
        return getSqlSession().selectList(query, search);
    }

    @Override
    public <E> List<E> selectAll(String query) throws DataAccessException {
        return getSqlSession().selectList(query);
    }

    public int count(String query, Object search) throws DataAccessException {
        return getSqlSession().selectOne(query, search);
    }

}

package com.apollo.exchange.common.accessLog.service;

import com.apollo.exchange.common.accessLog.dto.AccessLogDTO;
import com.apollo.exchange.common.dao.ICommonDao;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

/**
 * @author ionio.dev
 * @apiNote AccessLog entity business class
 */
@Service
@RequiredArgsConstructor
public class AccessLogService {

    private final ICommonDao commonDao;

    public void register(AccessLogDTO accessLogDTO) {
        commonDao.insert("AccessLog.insertOne", accessLogDTO);
    }
}

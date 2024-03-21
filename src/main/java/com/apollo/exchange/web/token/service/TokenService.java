package com.apollo.exchange.web.token.service;


import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.web.token.dto.TokenDTO;
import com.apollo.exchange.web.token.dto.TokenSearchDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author ntt.dev
 * @apiNote logic business class
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class TokenService {

    final ICommonDao iCommonDao;

    public int count(TokenSearchDTO tokenSearchDTO) {
        return iCommonDao.count("TokenSymbol.selectCount", tokenSearchDTO);
    }

    public List<TokenDTO> getTokenList() {
        return iCommonDao.selectAll("TokenSymbol.selectTokenList");
    }

    public List<TokenDTO> getTokenListByOperator(TokenSearchDTO tokenSearchDTO) {
        return iCommonDao.selectList("TokenSymbol.selectByOperator", tokenSearchDTO);
    }

    public TokenDTO getToken(TokenSearchDTO tokenSearchDTO) {
        return iCommonDao.selectOne("TokenSymbol.selectOne", tokenSearchDTO);
    }
}

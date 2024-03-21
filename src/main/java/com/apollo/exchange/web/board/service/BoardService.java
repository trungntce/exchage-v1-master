package com.apollo.exchange.web.board.service;

import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.web.board.dto.BoardDTO;
import com.apollo.exchange.web.board.dto.BoardSearchDTO;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import java.util.List;

/**
 * @author hipo.dev
 * @apiNote Board entity business class
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class BoardService {
    private final ICommonDao commonDao;

    public Integer getBoardCount(BoardSearchDTO boardSearchDTO) {
        return commonDao.count("Board.selectCount", boardSearchDTO);
    }

    public List<BoardDTO> getBoardTitleList(BoardSearchDTO boardSearchDTO) {
        return commonDao.selectList("Board.selectBoardTitleList", boardSearchDTO);
    }

    public List<BoardDTO> getBoardList(BoardSearchDTO boardSearchDTO) {
        return commonDao.selectList("Board.selectBoardList", boardSearchDTO);
    }

    public BoardDTO getBoardDetail(BoardSearchDTO boardSearchDTO) {
        return commonDao.selectOne("Board.selectBoardDetail", boardSearchDTO);
    }
}

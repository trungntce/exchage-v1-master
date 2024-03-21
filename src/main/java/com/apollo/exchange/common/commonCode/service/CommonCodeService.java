package com.apollo.exchange.common.commonCode.service;

import com.apollo.exchange.common.commonCode.dto.CommonCodeDTO;
import com.apollo.exchange.common.dao.ICommonDao;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;

import java.util.List;

/**
 * @author ionio.dev
 * @apiNote CommonCode entity business class
 */
@Service
@RequiredArgsConstructor
public class CommonCodeService {

    private final ICommonDao commonDao;

    public List<CommonCodeDTO> getListByGroupName(String groupName) {
        CommonCodeDTO commonCodeDTO = new CommonCodeDTO();
        commonCodeDTO.setGroupName(groupName);
        return commonDao.selectList("CommonCode.selectListByGroupName", commonCodeDTO);
    }

}

package com.apollo.exchange.admin.analysis.service;

import com.apollo.exchange.admin.analysis.dto.AnalysisDTO;
import com.apollo.exchange.admin.analysis.dto.AnalysisHomeDTO;
import com.apollo.exchange.admin.analysis.dto.AnalysisSearchDTO;
import com.apollo.exchange.admin.buy.dto.AdminBuySearchDTO;
import com.apollo.exchange.admin.buy.service.AdminBuyMyTradeService;
import com.apollo.exchange.admin.buy.service.AdminBuySafeService;
import com.apollo.exchange.admin.sell.dto.AdminSellSearchDTO;
import com.apollo.exchange.admin.sell.service.AdminSellMyTradeService;
import com.apollo.exchange.admin.sell.service.AdminSellSafeService;
import com.apollo.exchange.admin.wallet.dto.AdminWalletDTO;
import com.apollo.exchange.admin.wallet.dto.AdminWalletSearchDTO;
import com.apollo.exchange.admin.wallet.service.AdminWalletService;
import com.apollo.exchange.common.api.service.ApiService;
import com.apollo.exchange.common.dao.ICommonDao;
import com.apollo.exchange.common.properties.DataStatic;
import com.apollo.exchange.common.utils.DateUtils;
import com.apollo.exchange.common.wallet.dto.WalletDTO;
import com.google.gson.Gson;
import lombok.RequiredArgsConstructor;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.web3j.crypto.Wallet;

import javax.servlet.http.HttpServletRequest;
import java.lang.reflect.Array;
import java.math.BigDecimal;
import java.text.SimpleDateFormat;
import java.util.*;

/**
 * @author hipo.dev
 * @apiNote Analysis entity business class
 */
@Slf4j
@Service
@RequiredArgsConstructor
public class AnalysisService {

    final ICommonDao iCommonDao;

    @Autowired
    private AdminBuyMyTradeService adminBuyMyTradeService;

    @Autowired
    private AdminSellMyTradeService adminSellMyTradeService;

    @Autowired
    private AdminWalletService adminWalletService;

    @Autowired
    private AdminSellSafeService adminSellSafeService;

    @Autowired
    private AdminBuySafeService adminBuySafeService;

    @Autowired
    private ApiService apiService;

    public AnalysisSearchDTO initParam(WalletDTO walletLogin, AnalysisSearchDTO searchDTO){
        switch (walletLogin.getRole()){
            case "CENTRAL_BANK":
                searchDTO.setRole(DataStatic.WALLET_ROLE.VIETKO_FEE);
                break;
            case "OPERATOR":
                searchDTO.setRole(DataStatic.WALLET_ROLE.OPERATOR_FEE);
                searchDTO.setSymbol(walletLogin.getSymbol());
                break;
            case "CLIENT":
                searchDTO.setRole(DataStatic.WALLET_ROLE.OPERATOR_FEE);
                searchDTO.setClientCode(walletLogin.getClientCode());
                break;
        }
        return searchDTO;
    }

    public List<AnalysisDTO> getAnalysisList(AnalysisSearchDTO analysisSearchDTO) {
        return iCommonDao.selectList("Analysis.selectAnalysisList", analysisSearchDTO);
    }
/*
    public List<AnalysisDTO> getAnalysisSellList(AnalysisSearchDTO analysisSearchDTO) {
        Calendar calendar = Calendar.getInstance();

        //현재 날짜로 설정
        int year = calendar.get(Calendar.YEAR);
        int month = calendar.get(Calendar.MONTH);

        //현재 달의 시작일과 마지막일 구하기
        int start = calendar.getActualMinimum(Calendar.DAY_OF_MONTH);
        int end = calendar.getActualMaximum(Calendar.DAY_OF_MONTH);

        //DateFormat에 맞춰 String에 담기

        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
        calendar.set(year, month, start);
        String startdate =  dateFormat.format(calendar.getTime());
        calendar.set(year, month, end);
        String enddate = dateFormat.format(calendar.getTime());

        analysisSearchDTO.setSearchDateStart(startdate);
        analysisSearchDTO.setSearchDateEnd(enddate);
        log.error("{}", new Gson().toJson(analysisSearchDTO));
        log.error("{}",new Gson().toJson(analysisSearchDTO));
        return iCommonDao.selectList("Analysis.selectAnalysisSellList", analysisSearchDTO);
    }
*/
    public Map<String, Object> getStatisticByUser(HttpServletRequest request){
        WalletDTO walletLogin = (WalletDTO) request.getSession().getAttribute(DataStatic.SESSION.WALLET);
        if(walletLogin == null) return null;
        Map<String, Object> result = new HashMap<>();
        switch (walletLogin.getRole()){
            case "CENTRAL_BANK":
            case "CLIENT":
                result.put("buyOp", adminBuyMyTradeService.count(new AdminBuySearchDTO(walletLogin.getWalletAddress(), DataStatic.VIEW_ROLE.getRole(walletLogin.getRole(), "OPERATOR"), 2)));
                result.put("sellOp", adminSellMyTradeService.count(new AdminSellSearchDTO(walletLogin.getWalletAddress(), DataStatic.VIEW_ROLE.getRole(walletLogin.getRole(), "OPERATOR"), 2)));
                break;
            case "OPERATOR":
                result.put("buyBanker", adminBuyMyTradeService.count(new AdminBuySearchDTO(walletLogin.getWalletAddress(), DataStatic.VIEW_ROLE.getRole(walletLogin.getRole(), "CENTRAL_BANK"), 2)));
                result.put("sellBanker", adminSellMyTradeService.count(new AdminSellSearchDTO(walletLogin.getWalletAddress(), DataStatic.VIEW_ROLE.getRole(walletLogin.getRole(), "CENTRAL_BANK"), 2)));
                result.put("buyClient", adminBuyMyTradeService.count(new AdminBuySearchDTO(walletLogin.getWalletAddress(), DataStatic.VIEW_ROLE.getRole(walletLogin.getRole(), "CLIENT"), 2)));
                result.put("sellClient", adminSellMyTradeService.count(new AdminSellSearchDTO(walletLogin.getWalletAddress(), DataStatic.VIEW_ROLE.getRole(walletLogin.getRole(), "CLIENT"), 2)));
                result.put("buyTrader", adminBuyMyTradeService.count(new AdminBuySearchDTO(walletLogin.getWalletAddress(), DataStatic.VIEW_ROLE.getRole(walletLogin.getRole(), "TRADER"), 2)));
                result.put("sellTrader", adminSellMyTradeService.count(new AdminSellSearchDTO(walletLogin.getWalletAddress(), DataStatic.VIEW_ROLE.getRole(walletLogin.getRole(), "TRADER"), 2)));
                result.put("buySafe", adminBuySafeService.count(new AdminBuySearchDTO(walletLogin.getWalletAddress(), DataStatic.VIEW_ROLE.USER_SAFE, 2, 4)));
                result.put("sellSafe", adminSellSafeService.count(new AdminSellSearchDTO(walletLogin.getWalletAddress(), DataStatic.VIEW_ROLE.USER_SAFE, 4)));
                break;
        }
        return result;
    }

    public List<AnalysisDTO> selectAnalysisBuyByDay(AnalysisSearchDTO analysisSearchDTO){
        return iCommonDao.selectList("Analysis.selectAnalysisBuyByDay", analysisSearchDTO);
    }

    public List<AnalysisDTO> selectAnalysisSellByDay(AnalysisSearchDTO analysisSearchDTO){
        List<AnalysisDTO> result = iCommonDao.selectList("Analysis.selectAnalysisSellByDay", analysisSearchDTO);
        return (result == null) ? new ArrayList<>() : result;
    }

    public AnalysisDTO selectSumBuyHomePage(AnalysisSearchDTO search){
        AnalysisDTO result = iCommonDao.selectOne("Analysis.selectSumBuyHomePage", search);
        return (result == null) ? new AnalysisDTO() : result;
    }

    public AnalysisDTO selectSumSellHomePage(AnalysisSearchDTO search){
        AnalysisDTO result = iCommonDao.selectOne("Analysis.selectSumSellHomePage", search);
        return (result == null) ? new AnalysisDTO() : result;
    }

    public AnalysisDTO selectCountWalletHomePage(AnalysisSearchDTO search){
        AnalysisDTO result = iCommonDao.selectOne("Analysis.selectCountWalletHomePage", search);
        return (result == null) ? new AnalysisDTO() : result;
    }

    public AnalysisDTO selectSumFeeHomePage(AnalysisSearchDTO search){
        AnalysisDTO result = iCommonDao.selectOne("Analysis.selectSumFeeHomePage", search);
        return (result == null) ? new AnalysisDTO() : result;
    }

    public Object analysisHolderGroup(AnalysisSearchDTO search){

        List<AdminWalletDTO> wallets = adminWalletService.selectListNoLimit(new AdminWalletSearchDTO(Arrays.asList("BANI"), Arrays.asList("CENTRAL_BANK", "OPERATOR", "OPERATOR_FEE", "VIETKO_FEE", "CLIENT", "CLIENT_TRADER", "TRADER")));
        Map<String, AnalysisHomeDTO> result = new LinkedHashMap<>();
        //Holder
        if(wallets.size() > 0){
            for(int i = 0; i < wallets.size(); i++){
                AdminWalletDTO wallet = wallets.get(i);
                String symbol = wallet.getSymbol();
                if(result.get(symbol) == null){
                    result.put(symbol, new AnalysisHomeDTO(symbol, search.getSearchDateStart(), search.getSearchDateEnd()));
                }
                BigDecimal balance = apiService.getBalance(null, symbol, wallet.getWalletAddress());
//                if(balance.doubleValue() > 0){
                    result.get(symbol).addHolders(wallet, balance);
//                }
            }
        }

        //Order
        List<AnalysisDTO> analysisBuy = selectAnalysisBuyByDay(search);
        List<AnalysisDTO> analysisSell = selectAnalysisSellByDay(search);
        if(analysisBuy.size() > 0){
            for (AnalysisDTO analysisDTO : analysisBuy) {
                String symbol = analysisDTO.getSymbol();
                result.get(symbol).addOrder("BUY", analysisDTO);
            }
        }
        if(analysisSell.size() > 0){
            for (AnalysisDTO analysisDTO : analysisSell) {
                String symbol = analysisDTO.getSymbol();
                result.get(symbol).addOrder("SELL", analysisDTO);
            }
        }
        return result;
    }
}

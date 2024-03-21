package com.apollo.exchange.admin.analysis.dto;

import com.apollo.exchange.common.dto.PageDTO;
import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

import java.lang.reflect.Array;
import java.text.SimpleDateFormat;
import java.util.*;

@Data
@AllArgsConstructor
public class AnalysisSearchDTO extends PageDTO {
    private String symbol = "BANI";
    private String role = null;
    private List<String> symbols = Arrays.asList("BANI");
    private String walletAddress;
    private String clientId = null;
    private String clientCode;
    private Integer state = null;
    private String stateName = null;
    private String timeSearchKey = null;
    private String searchDateStart = null;
    private String searchDateEnd = null;

    public AnalysisSearchDTO() {
        init();
    }

    public AnalysisSearchDTO(String ...symbols) {
        this.symbols = Arrays.asList(symbols);
        init();
    }

    private void init(){
        Calendar calendar = Calendar.getInstance();
        SimpleDateFormat dateFormat = new SimpleDateFormat("yyyy-MM-dd", Locale.KOREA);
        this.searchDateEnd = dateFormat.format(calendar.getTime());
        calendar.add(Calendar.DAY_OF_YEAR, -30);
        this.searchDateStart = dateFormat.format(calendar.getTime());
    }
}

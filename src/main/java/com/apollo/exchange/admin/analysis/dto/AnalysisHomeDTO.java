package com.apollo.exchange.admin.analysis.dto;

import com.apollo.exchange.admin.wallet.dto.AdminWalletDTO;
import com.apollo.exchange.common.utils.DateUtils;
import lombok.Data;
import lombok.val;

import java.math.BigDecimal;
import java.text.ParseException;
import java.text.SimpleDateFormat;
import java.util.*;

@Data
public class AnalysisHomeDTO {
    private String symbol;
    private BigDecimal totalSupply = new BigDecimal(100000000000000L);
    /**
     * holder: ROLE -> Info
     * */
    private Map<String, Holder> holders = new LinkedHashMap<>();
    /**
     * order: BUY/SELL -> Info
     * */
    private Map<String, Order> orders = new LinkedHashMap<>();
    private List<String> titles = new ArrayList<>();

    public AnalysisHomeDTO(String symbol, Date start, Date end) {
        this.symbol = symbol;
        this.init(start, end);
    }

    public AnalysisHomeDTO(String symbol, String start, String end) {
        this.symbol = symbol;
        try {
            this.init(new SimpleDateFormat("yyyy-MM-dd").parse(start), new SimpleDateFormat("yyyy-MM-dd").parse(end));
        } catch (ParseException e) {
            e.printStackTrace();
        }
    }

    public void addHolders(AdminWalletDTO wallet, BigDecimal balance){
        String role = wallet.getRole();
        if(holders.get(role) == null) holders.put(role, new Holder(role));
        holders.get(role).add(wallet.getWalletAddress(), balance);
    }

    public void init(Date s, Date e){
        titles.addAll(DateUtils.dayList(s, e));
        orders.put("BUY", new Order("BUY", this.titles.size()));
        orders.put("SELL", new Order("SELL", this.titles.size()));
    }

    public void addOrder(String type, AnalysisDTO data){
        if(data.getTitle() != null && this.titles.contains(data.getTitle())){
            int position = this.titles.indexOf(data.getTitle());
            this.orders.get(type).values.set(position, data.getTotalQuantity());
        }
    }

    @Data
    public class Holder {
        private String name;
        private Map<String, Object> balances = new LinkedHashMap<>();
        private Double value = 0.0;

        public Holder(String name) {
            this.name = name;
        }

        public void add(String wallet, Integer val){
            this.value += val;
            balances.put(wallet, val);
        }

        public void add(String wallet, Double val){
            this.value += val;
            balances.put(wallet, val);
        }

        public void add(String wallet, BigDecimal val){
            this.value += val.doubleValue();
            balances.put(wallet, val);
        }
    }

    @Data
    public class Order {
        /**
         * name: BUY - SELL
         * */
        private String name;
        private List<Double> values = new ArrayList<>();

        public Order(String name, Integer size) {
            this.name = name;
            for(int i = 0; i < size; i++){
                values.add(0.0);
            }
        }
    }
}

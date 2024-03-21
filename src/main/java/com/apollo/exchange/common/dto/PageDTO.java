package com.apollo.exchange.common.dto;

import lombok.Data;
import org.springframework.context.i18n.LocaleContextHolder;

import java.util.LinkedHashMap;
import java.util.Locale;
import java.util.Map;

@Data
public class PageDTO {

	private String id;
	protected Integer start = 0;
	private Integer page = 1;
	private Integer rows = 10;
	private Integer limit = 10;
	private Integer total = 0;
	private Integer navi = 10;
	private Integer totalPageSize;

	protected String orderByColumn;
	protected String orderByType;
	protected String startDateSearch;
	protected String endDateSearch;

	private String targetView;
	private String langCode = LocaleContextHolder.getLocale().toString();
	public Integer getPage() {
		return page;
	}
	public void setPage(int page) {
		this.page = page;
	}
	public Integer getLimit() {
		return limit;
	}
	public void setLimit(int limit) {
		this.limit = limit;
		this.rows = limit;
	}
	public Integer getTotal() {
		return total;
	}
	public void setTotal(int total) {
		this.total = total;
		totalPageSize = (int)Math.ceil( (double)total / getRows() );
	}
	public Integer getNavi() {
		return navi;
	}
	public void setNavi(int navi) {
		this.navi = navi;
	}
	public Integer getTotalPageSize() {
		return totalPageSize;
	}
	public void setTotalPageSize(int totalPageSize) {
		this.totalPageSize = totalPageSize;
	}
	public Integer getRows() {
		return rows;
	}
	public void setRows(int rows) {
		this.rows = rows;
		this.limit = rows;
	}
	public Integer getStart() {
		return (page-1)*limit;
	}
	public void setStart(int start) {
		this.start = start;
	}
	public String getId() {
		return id;
	}
	public void setId(String id) {
		this.id = id;
	}

	public String getLangCode() {
		return langCode;
	}
	public void setLangCd(String langCd) {
		this.langCode = langCd;
	}

	public Map<String, Object> toMap(){
		Map<String, Object> m = new LinkedHashMap<>();
		m.put("start", this.start);
		m.put("page", this.page);
		m.put("rows", this.rows);
		m.put("limit", this.limit);
		m.put("langCd", this.langCode);

		//m.put("orderColumn", this.orderColumn);
		//m.put("orderFlag", this.orderFlag);
		return m;
	}


	public String getOrderByColumn() {
		return orderByColumn;
	}

	public void setOrderByColumn(String orderByColumn) {
		this.orderByColumn = orderByColumn;
	}

	public String getOrderByType() {
		return orderByType;
	}

	public void setOrderByType(String orderByType) {
		this.orderByType = orderByType;
	}

	public String getStartDateSearch() {
		return startDateSearch;
	}

	public void setStartDateSearch(String startDateSearch) {
		this.startDateSearch = startDateSearch;
	}

	public String getEndDateSearch() {
		return endDateSearch;
	}

	public void setEndDateSearch(String endDateSearch) {
		this.endDateSearch = endDateSearch;
	}
}

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/layout/admin/head.jsp"%>
<body class="pace-done">
<%@ include file="/WEB-INF/layout/admin/loader.jsp"%>

<div id="app" class="app app-header-fixed app-sidebar-fixed">
  <%@ include file="/WEB-INF/layout/admin/header.jsp"%>
  <%@ include file="/WEB-INF/layout/admin/sidebar.jsp"%>

  <div id="content" class="app-content app-wrapper">
    <!-- MAIN PANEL -->
    <div id="main" class="panel panel-inverse">
      <div class="panel-heading panel-top">
        <h4 class="panel-title">
          <spring:message code="admin.subtitle.sell.mytrade.list.title"/>
        </h4>
        <!-- RIBBON -->
        <div class="panel-heading-btn">
          <ol class="breadcrumb float-xl-end">
            <li class="breadcrumb-item"><spring:message code="admin.subtitle.sell.management.title"/></li>
            <li class="breadcrumb-item active">
              <a href="javascript:window.location.reload();">
                <spring:message code="admin.subtitle.sell.mytrade.list.title"/>
              </a>
            </li>
          </ol>
        </div>
        <!-- END RIBBON -->
      </div>
      <!-- MAIN CONTENT -->
      <div class="panel-body">
        <!-- 총 기간 별 대쉬 보드 시작 -->
        <div class="note note-gray-500">
          <div class="note-content">
            <form name="search" id="search" method="GET" class="input-group input-group-sm">
              <select name="symbol" class="form-select">
                <option value="">:::<spring:message code="search.name.symbol.title"/>:::</option>
                <c:forEach items="${tokenDTOList}" var="item" varStatus="loop">
                  <option <c:if test="${search.symbol == item.symbol}"> selected </c:if> value="${item.symbol}">${item.name}</option>
                </c:forEach>
              </select>
              <select name="clientId" class="form-select">
                <option value="">:::<spring:message code="search.name.client.id.title"/>:::</option>
                <c:forEach items="${clientDTOList}" var="item" varStatus="loop">
                  <option <c:if test="${search.clientId == item.clientId}"> selected </c:if> value="${item.clientId}">${item.name}</option>
                </c:forEach>
              </select>
              <select name="keywordType" class="form-select">
                <option value=""><spring:message code="search.name.select.title"/></option>
                <option value="SELLER_WALLET_ADDRESS" <c:if test="${search.keywordType == 'SELLER_WALLET_ADDRESS'}"> selected </c:if>>
                  <spring:message code="search.name.keywordType.option.seller.wallet.title"/>
                </option>
                <option value="BUYER_WALLET_ADDRESS" <c:if test="${search.keywordType == 'BUYER_WALLET_ADDRESS'}"> selected </c:if>>
                  <spring:message code="search.name.keywordType.option.buyer.wallet.title"/>
                </option>
                <option value="BANK_NAME" <c:if test="${search.keywordType == 'BANK_NAME'}"> selected </c:if>>
                  <spring:message code="search.name.keywordType.option.bank.name.title"/>
                </option>
                <option value="BANK_OWNER" <c:if test="${search.keywordType == 'BANK_OWNER'}"> selected </c:if>>
                  <spring:message code="search.name.keywordType.option.bank.owner.title"/>
                </option>
                <option value="BANK_ACCOUNT" <c:if test="${search.keywordType == 'BANK_ACCOUNT'}"> selected </c:if>>
                  <spring:message code="search.name.keywordType.option.bank.account.title"/>
                </option>
              </select>
              <input type="text" name="keyword" value="${search.keyword}" class="form-control form-control-sm" placeholder="<spring:message code="search.name.keyword.hint"/>">
              <select name="useYn" class="form-select d-none">
                <option value="" <c:if test="${search.useYn == ''}"> selected </c:if>><spring:message code="search.name.useyn.title"/></option>
                <c:forEach items="${useYn}" var="item" varStatus="loop">
                  <option value="${item.codeValue}" <c:if test="${search.useYn == item.codeValue}"> selected </c:if>>${item.codeName}</option>
                </c:forEach>
              </select>
              <select name="timeSearchKey" class="form-select">
                <option value="" <c:if test="${search.timeSearchKey == ''}"> selected </c:if>><spring:message code="search.name.all.title"/></option>
                <option value="TS.TRADE_COMPLETION_DATE" <c:if test="${search.timeSearchKey == 'TS.TRADE_COMPLETION_DATE'}"> selected </c:if>><spring:message code="search.name.trade.completion.date.title"/></option>
                <option value="TS.REG_DATE" <c:if test="${search.timeSearchKey == 'TS.REG_DATE'}"> selected </c:if>><spring:message code="search.name.regdt.title"/></option>
              </select>
              <span class="input-group-text"><i class="fa fa-calendar"></i></span>
              <input type="text" name="searchDateStart" value="${search.searchDateStart}" class="form-control form-control-sm datepicker" data-dateformat="yyyy-mm-dd" placeholder="<spring:message code="search.name.start.date.title"/>" value="">
              <span class="input-group-append"><span class="input-group-text">~</span></span>
              <input type="text" name="searchDateEnd" value="${search.searchDateEnd}" class="form-control form-control-sm datepicker" data-dateformat="yyyy-mm-dd" placeholder="<spring:message code="search.name.end.date.title"/>" value="">
              <button type="button" class="btn btn-sm btn-info" onclick="searchInit();"><spring:message code="common.button.init.title"/></button>
              <input type="submit" class="btn btn-sm btn-info" value="<spring:message code="common.button.search.title"/>">
              <select name="orderByColumn" class="form-select " onchange="submitForm('#search')" value="${search.orderByColumn}">
                <option value="SELL_ID" <c:if test="${search.orderByColumn == 'SELL_ID'}"> selected </c:if>><spring:message code="search.name.orderByColumn.option.sell.id.title"/></option>
                <option value="SYMBOL" <c:if test="${search.orderByColumn == 'SYMBOL'}"> selected </c:if>><spring:message code="search.name.symbol.title"/></option>
                <option value="CLIENT_ID" <c:if test="${search.orderByColumn == 'CLIENT_ID'}"> selected </c:if>><spring:message code="search.name.client.id.title"/></option>
                <option value="TRADE_COMPLETION_DATE" <c:if test="${search.orderByColumn == 'TRADE_COMPLETION_DATE'}"> selected </c:if>><spring:message code="search.name.trade.completion.date.title"/></option>
                <option value="REG_DATE" <c:if test="${search.orderByColumn == 'REG_DATE'}"> selected </c:if>><spring:message code="search.name.regdt.title"/></option>
              </select>
              <select name="orderByType" class="form-select " onchange="submitForm('#search')">
                <option value="DESC" <c:if test="${search.orderByType == 'DESC'}"> selected </c:if>><spring:message code="search.name.order.sort.desc.title"/></option>
                <option value="ASC" <c:if test="${search.orderByType == 'ASC'}"> selected </c:if>><spring:message code="search.name.order.sort.asc.title"/></option>
              </select>
              <select name="limit" class="form-select view" onchange="submitForm('#search')">
                <option value="10" <c:if test="${search.limit == '10'}"> selected </c:if>><spring:message code="search.name.row.10.title"/></option>
                <option value="20" <c:if test="${search.limit == '20'}"> selected </c:if>><spring:message code="search.name.row.20.title"/></option>
                <option value="50" <c:if test="${search.limit == '50'}"> selected </c:if>><spring:message code="search.name.row.50.title"/></option>
                <option value="100" <c:if test="${search.limit == '100'}"> selected </c:if>><spring:message code="search.name.row.100.title"/></option>
                <option value="200" <c:if test="${search.limit == '200'}"> selected </c:if>><spring:message code="search.name.row.200.title"/></option>
              </select>
            </form>
          </div>
        </div>
        
        <hr>

        <div class="row">
          <div class="table-responsive mb-3">
            <table class="table table-bordered table-hover text-nowrap align-middle mb-0 table-sm">
              <thead>
              <tr>
                <th colspan="8"><spring:message code="sell.table.seller.info.title"/></th>
                <th colspan="2"><spring:message code="sell.table.buyer.info.title"/></th>
                <th colspan="8"><spring:message code="sell.table.trade.info.title"/></th>
                <th rowspan="2">Action</th>
              </tr>
              <tr>
                <th><spring:message code="sell.table.sell.id.title"/></th>
                <th><spring:message code="sell.table.symbol.title"/></th>
                <th><spring:message code="sell.table.client.id.title"/></th>
                <th><spring:message code="sell.table.sellerWalletAddress.title"/></th>
                <th><spring:message code="sell.table.seller.name.title"/></th>
                <th><spring:message code="sell.table.bankName.title"/></th>
                <th><spring:message code="sell.table.bankOwner.title"/></th>
                <th><spring:message code="sell.table.bankAccount.title"/></th>
                <th><spring:message code="sell.table.wallet.address.title"/></th>
                <th><spring:message code="sell.table.buyer.name.title"/></th>
                <th><spring:message code="sell.table.state.title"/></th>
                <th><spring:message code="sell.table.trade.state.title"/></th>
                <th><spring:message code="sell.table.quantity.title"/></th>
                <th><spring:message code="sell.table.unit.price.title"/></th>
                <th><spring:message code="sell.table.total.price.title"/></th>
                <th><spring:message code="sell.table.txid.title"/></th>
                <th><spring:message code="sell.table.trade.finish.date.title"/></th>
                <th><spring:message code="sell.table.regdt.title"/></th>
              </tr>
              </thead>
              <tbody id="tbodyMember" class="text-wrap">
              <c:choose>
                <c:when test="${sellDTOList.size() > 0}">
                  <c:forEach items="${sellDTOList}" var="item" varStatus="loop">
                    <tr class="table-success">
                      <td>${item.sellId}</td>
                      <td>${item.symbol}</td>
                      <td>${item.clientName}</td>
                      <td class="tx-hash" title="${item.sellerWalletAddress}">${item.sellerWalletAddress}</td>
                      <td>${item.sellerName}</td>
                      <td>${item.bankName}</td>
                      <td>${item.bankOwner}</td>
                      <td>${item.bankAccount}</td>
                      <td class="tx-hash" title="${item.buyerWalletAddress}">${item.buyerWalletAddress}</td>
                      <td>${item.buyerName}</td>
                      <td>${item.stateName}</td>
                      <td>${item.tradeStateName}</td>
                      <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.quantity}" /></td>
                      <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.unitPrice}" /></td>
                      <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.totalPrice}" /></td>
                      <td class="tx-hash">${item.txid}</td>
                      <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${item.tradeCompletionDate}" /></td>
                      <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${item.regDate}" /></td>
                      <td>
                        <!-- Client -->
                        <c:if test="${wallet.role eq 'CLIENT'}">
                          <c:if test="${item.state == 1}">
                              <form method="POST" action="/admin/sell/request/client/apply">
                                  <input type="hidden" name="sellId" value="${item.sellId}">
                                  <button>Apply</button>
                              </form>
                          </c:if>
                          <c:if test="${item.state == 2 && item.tradeState == 3 && empty item.refSellId}">
                              <form method="POST" action="/admin/sell/request/client/request">
                                  <input type="hidden" name="sellId" value="${item.sellId}">
                                  <button>Request</button>
                              </form>
                          </c:if>
                          <c:if test="${item.state == 2 && item.tradeState == 3 && item.refSellState == 3}">
                              <form method="POST" action="/admin/sell/request/client/finish">
                                  <input type="hidden" name="sellId" value="${item.sellId}">
                                  <button>Finish</button>
                              </form>
                          </c:if>
                        </c:if>
                        <!-- * Client -->

                        <!-- OP -->
                        <c:if test="${wallet.role eq 'OPERATOR'}">
                            <c:if test="${item.state == 2 && item.tradeState == 2 }">
                                <form method="POST" action="/admin/sell/request/op/apply">
                                    <input type="hidden" name="sellId" value="${item.sellId}">
                                    <button>Apply</button>
                                </form>
                            </c:if>
                        </c:if>
                        <!-- * OP -->
                      </td>
                    </tr>
                  </c:forEach>
                </c:when>
                <c:otherwise>
                  <tr>
                    <td colspan="19"><spring:message code="common.message.noData.title"/></td>
                  </tr>
                </c:otherwise>
              </c:choose>
              </tbody>
            </table>
          </div>
        </div>

        <div class="row mt-10px">
          <div class="d-md-flex align-items-center">
            <%-- 추후 필요에 따라 사용 --%>
            <div class="me-md-auto text-md-left text-center mb-2 mb-md-0">
              <!-- 총보유액 : <span style="color: red;">8,116,903</span> -->
              <!-- 총포인트 : <span style="color: blue;">0</span> -->
            </div>
            <pg:paging page="${search}"/>
          </div>
        </div>
        <!-- 총 기간 별 대쉬 보드 끝 -->
      </div>
    </div>
  </div>
</div>
<script>
  function submitForm(target){
    $(target).submit();
  }
  function searchInit(){
    location.href="/admin/sell/general/list";
  }
</script>
</body>
</html>
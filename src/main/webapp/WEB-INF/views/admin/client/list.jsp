<%--
  Created by IntelliJ IDEA.
  User: dongwon
  Date: 2022-09-05
  Time: 오후 4:59
  To change this template use File | Settings | File Templates.
--%>
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
          <spring:message code="admin.subtitle.client.setup.title"/>
        </h4>
        <!-- RIBBON -->
        <div class="panel-heading-btn">
          <ol class="breadcrumb float-xl-end">
            <li class="breadcrumb-item"><spring:message code="admin.subtitle.client.management.title"/></li>
            <li class="breadcrumb-item active">
              <a href="javascript:window.location.reload();">
                <spring:message code="admin.subtitle.client.setup.title"/>
              </a>
            </li>
          </ol>
        </div>
        <!-- END RIBBON -->
      </div>

      <!-- MAIN CONTENT -->
      <div class="panel-body">
        <!-- 총 기간 별 대쉬 보드 시작 -->
        <div class="panel-body">
          <div class="note note-gray-500">
            <div class="note-content">
              <form name="search" id="search" method="GET" class="input-group input-group-sm">
              <c:if test="${wallet.role != 'OPERATOR'}">
              <select name="symbol" class="form-select">
                <option value="">:::<spring:message code="search.name.symbol.title"/>:::</option>
                <c:forEach items="${tokenDTOList}" var="item" varStatus="loop">
                  <option <c:if test="${search.symbol == item.symbol}"> selected </c:if> value="${item.symbol}">${item.name}</option>
                </c:forEach>
              </select>
              </c:if>
              
              <select name="keywordType" class="form-select">
                <option value=""><spring:message code="search.name.select.title"/></option>
                <option value="C.CLIENT_CODE" <c:if test="${search.keywordType == 'C.CLIENT_CODE'}"> selected </c:if>>
                  <spring:message code="search.name.keywordType.option.client.code.title"/>
                </option>
                <option value="C.NAME" <c:if test="${search.keywordType == 'C.NAME'}"> selected </c:if>>
                  <spring:message code="search.name.keywordType.option.client.name.title"/>
                </option>
                <option value="C.API_KEY" <c:if test="${search.keywordType == 'C.API_KEY'}"> selected </c:if>>
                  <spring:message code="search.name.keywordType.option.apikey.title"/>
                </option>
                <option value="W.WALLET_ADDRESS" <c:if test="${search.keywordType == 'W.WALLET_ADDRESS'}"> selected </c:if>>
                  <spring:message code="search.name.keywordType.option.wallet.address.title"/>
                </option>
              </select>
              <input type="text" name="keyword" value="${search.keyword}" class="form-control form-control-sm" placeholder="<spring:message code="search.name.keyword.hint"/>">
              <select name="useYn" class="form-select">
                <option value="" <c:if test="${search.useYn == ''}"> selected </c:if>><spring:message code="search.name.useyn.title"/></option>
                <c:forEach items="${useYn}" var="item" varStatus="loop">
                  <option value="${item.codeValue}" <c:if test="${search.useYn == item.codeValue}"> selected </c:if>>${item.codeName}</option>
                </c:forEach>
              </select>
              <select name="timeSearchKey" class="form-select">
                <option value="" <c:if test="${search.timeSearchKey == ''}"> selected </c:if>><spring:message code="search.name.all.title"/></option>
                <option value="REG_DATE" <c:if test="${search.timeSearchKey == 'REG_DATE'}"> selected </c:if>><spring:message code="search.name.regdt.title"/></option>
              </select>
              <span class="input-group-text"><i class="fa fa-calendar"></i></span>
              <input type="text" name="searchDateStart" value="${search.searchDateStart}" class="form-control form-control-sm datepicker" data-dateformat="yyyy-mm-dd" placeholder="<spring:message code="search.name.start.date.title"/>" value="">
              <span class="input-group-append"><span class="input-group-text">~</span></span>
              <input type="text" name="searchDateEnd" value="${search.searchDateEnd}" class="form-control form-control-sm datepicker" data-dateformat="yyyy-mm-dd" placeholder="<spring:message code="search.name.end.date.title"/>" value="">
              <button type="button" class="btn btn-sm btn-info" onclick="searchInit();"><spring:message code="common.button.init.title"/></button>
              <input type="submit" class="btn btn-sm btn-info" value="<spring:message code="common.button.search.title"/>">
              <select name="orderByColumn" class="form-select " onchange="submitForm('#search')" value="${search.orderByColumn}">
                <option value="ROWNUM" <c:if test="${search.orderByColumn == 'ROWNUM'}"> selected </c:if>><spring:message code="search.name.orderByColumn.option.no.title"/></option>
                <option value="SYMBOL" <c:if test="${search.orderByColumn == 'SYMBOL'}"> selected </c:if>><spring:message code="search.name.orderByColumn.option.symbol.title"/></option>
                <option value="CLIENT_CODE" <c:if test="${search.orderByColumn == 'CLIENT_CODE'}"> selected </c:if>><spring:message code="search.name.orderByColumn.option.client.code.title"/></option>
                <option value="NAME" <c:if test="${search.orderByColumn == 'NAME'}"> selected </c:if>><spring:message code="search.name.orderByColumn.option.name.title"/></option>
                <option value="API_KEY" <c:if test="${search.orderByColumn == 'API_KEY'}"> selected </c:if>><spring:message code="search.name.orderByColumn.option.apikey.title"/></option>
                <option value="REG_DATE" <c:if test="${search.orderByColumn == 'REG_DATE'}"> selected </c:if>><spring:message code="search.name.orderByColumn.option.regdt.title"/></option>
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

          <div class="text-end">
            <button type="button" class="btn btn-primary btn-sm me-1" redirect="${_ctx}/admin/client/write">
              <spring:message code="button.client.add.title"/>
            </button>
          </div>

          <div class="row mt-3">
            <div class="table-responsive mb-3">
              <table class="table table-bordered table-hover text-nowrap align-middle mb-0 table-sm tbl-clients" style="min-width: 1500px;">
                <thead>
                <tr>
                  <th class="text-center">NO</th>
                  <th class="text-center"><spring:message code="client.field.symbol.title" /></th>
                  <th class="text-center"><spring:message code="client.field.clientCode.title" /></th>
                  <th class="text-center"><spring:message code="client.field.name.title" /></th>
                  <th class="text-center"><spring:message code="client.field.apiKey.title" /></th>
                  <th class="text-center"><spring:message code="client.field.walletAddress.title" /></th>
                  <th class="text-center"><spring:message code="common.message.balances.title" /></th>
                  <th class="text-center"><spring:message code="client.field.client.trader.title" /></th>
                  <th class="text-center"><spring:message code="client.field.buy.benifit.title" /></th>
                  <th class="text-center"><spring:message code="client.field.sell.benifit.title" /></th>
                  <th class="text-center"><spring:message code="client.field.useYn.title" /></th>
                  <th class="text-center"><spring:message code="token.table.transfer.quantity.title" /></th>
                  <th><spring:message code="trade.buy.createDate.title" /></th>
                  <th><spring:message code="common.admin.field.action.title" /></th>
                </tr>
                </thead>
                <tbody id="tbodyMember" class="text-wrap">
                <c:choose>
                  <c:when test="${clinetDTOList.size() > 0}">
                    <c:forEach items="${clinetDTOList}" var="item" varStatus="loop">
                      <tr class="table-success" wallet-address="${item.walletAddress}">
                        <td>${item.rownum}</td>
                        <td>${item.symbol}</td>
                        <td>${item.clientCode}</td>
                        <td>${item.name}</td>
                        <td class="tx-hash">${item.apiKey} </td>
                        <td class="tx-hash" title="${item.walletAddress}">${item.walletAddress}</td>
                        <td>
                          <label class="my-balance" wallet-address="${item.walletAddress}" data-symbol="${item.symbol}">0</label>
                          <button type="button" class="btn btn-warning btn-xs btn-reload-balance float-end" onclick="loadBalance({walletAddress: '${item.walletAddress}', symbol: '${item.symbol}'})">
                            <i class="fas fa-redo"></i>
                          </button>
                        </td>
                        <td>${item.clientTraderUseYn}</td>
                        <td>${item.buyBenifitUseYn}</td>
                        <td>${item.sellBenifitUseYn}</td>
                        <td>${item.useYn}</td>
                        <td>
                          <form id="transferForm" method="POST" action="/admin/token/transfer">
                            <input type="number" name="quantity" class="w-100px">
                            <input type="hidden" name="fromWalletAddress" id="fromWalletAddress">
                            <input type="hidden" name="toWalletAddress" id="toWalletAddress">
                            <input type="hidden" name="symbol" value="${item.symbol}">
                            <button type="button" class="btn btn-success btn-xs" onclick="javascript:clickTransfer(this)" data-from="${wallet.walletAddress}" data-to="${item.walletAddress}">
                              <i class="fas fa-arrow-up"></i>
                            </button>
                            <button type="button" class="btn btn-danger btn-xs" onclick="javascript:clickReceipt(this)" data-from="${item.walletAddress}" data-to="${wallet.walletAddress}">
                              <i class="fas fa-arrow-down"></i>
                            </button>

                          </form>
                        </td>
                        <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${item.regDate}" /></td>
                        <td>
                          <button type="button" class="btn btn-success btn-xs" redirect="${_ctx}/admin/client/edit?clientId=${item.clientId}">
                            <spring:message code="button.update.title"/>
                          </button>
                          <button type="button" class="btn btn-success btn-xs" redirect="${_ctx}/admin/client/detail?clientId=${item.clientId}">
                            <spring:message code="button.detail.title"/>
                          </button>
                        </td>
                      </tr>
                    </c:forEach>
                  </c:when>
                  <c:otherwise>
                    <td colspan="9"><spring:message code="common.message.noData.title"/></td>
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
        </div>
        <!-- 총 기간 별 대쉬 보드 끝 -->
      </div>
    </div>
  </div>
</div>
<script>
  init();

  function init(){
    //Load balance in list
    $(".tbl-clients").find(".my-balance[wallet-address]").each(function(){
      if($(this).attr("wallet-address").length == 0) return;
    })
  }

  function clickTransfer(obj){
    obj.parentNode.querySelector("#fromWalletAddress").value = obj.dataset.from;
    obj.parentNode.querySelector("#toWalletAddress").value = obj.dataset.to;

    var strMessage = "Do you want transfer";
    if(confirm(strMessage) == true){
        //transfer
        $("#loader").removeClass("loaded");
        obj.parentNode.submit();
    }else{
        return false;
    }
  }

  function clickReceipt(obj){
    obj.parentNode.querySelector("#fromWalletAddress").value = obj.dataset.from;
    obj.parentNode.querySelector("#toWalletAddress").value = obj.dataset.to;

    var strMessage = "Do you want receipt";
    if(confirm(strMessage) == true){
        //transfer
        $("#loader").removeClass("loaded");
        obj.parentNode.submit();
    }else{
        return false;
    }
  }

  function searchInit(){
    location.href="/admin/client/list";
  }
</script>
</body>
</html>
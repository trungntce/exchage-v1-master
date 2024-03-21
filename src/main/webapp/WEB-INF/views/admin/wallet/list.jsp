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
                    <spring:message code="admin.subtitle.account.wallet.list.title"/>
                </h4>
                <!-- RIBBON -->
                <div class="panel-heading-btn">
                    <ol class="breadcrumb float-xl-end">
                        <li class="breadcrumb-item"><spring:message code="admin.subtitle.account.title"/></li>
                        <li class="breadcrumb-item active">
                            <a href="javascript:window.location.reload();">
                                <spring:message code="admin.subtitle.account.wallet.list.title"/>
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
                            <c:if test="${wallet.role != 'OPERATOR'}">
                            <select name="symbol" class="form-select">
                                <option value="">:::<spring:message code="search.name.symbol.title"/>:::</option>
                                <c:forEach items="${tokenDTOList}" var="item" varStatus="loop">
                                    <option <c:if test="${search.symbol eq item.symbol}"> selected </c:if> value="${item.symbol}">${item.name}</option>
                                </c:forEach>
                            </select>
                            </c:if>
                            
                            <select name="clientId" class="form-select">
                                <option value="">:::<spring:message code="search.name.client.id.title"/>:::</option>
                                <c:forEach items="${clientDTOList}" var="item" varStatus="loop">
                                    <option <c:if test="${search.clientId == item.clientId}"> selected </c:if> value="${item.clientId}">${item.name}</option>
                                </c:forEach>
                            </select>
                            <select name="keywordType" class="form-select">
                                <option value="" <c:if test="${search.keywordType == ''}"> selected </c:if>><spring:message code="search.name.select.title"/></option>
                                <option value="U.LOGIN_ID" <c:if test="${search.keywordType == 'U.LOGIN_ID'}"> selected </c:if>>
                                    <spring:message code="search.name.keywordType.option.login.id.title"/>
                                </option>
                                <option value="W.NAME" <c:if test="${search.keywordType == 'W.NAME'}"> selected </c:if>>
                                    <spring:message code="search.name.keywordType.option.name.title"/>
                                </option>
                                <option value="W.WALLET_ADDRESS" <c:if test="${search.keywordType == 'W.WALLET_ADDRESS'}"> selected </c:if>>
                                    <spring:message code="search.name.keywordType.option.wallet.address.title"/>
                                </option>
                                <option value="W.BANK_NAME" <c:if test="${search.keywordType == 'W.BANK_NAME'}"> selected </c:if>>
                                    <spring:message code="search.name.keywordType.option.bank.name.title"/>
                                </option>
                                <option value="W.BANK_OWNER" <c:if test="${search.keywordType == 'W.BANK_OWNER'}"> selected </c:if>>
                                    <spring:message code="search.name.keywordType.option.bank.owner.title"/>
                                </option>
                                <option value="W.BANK_ACCOUNT" <c:if test="${search.keywordType == 'W.BANK_ACCOUNT'}"> selected </c:if>>
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
                                <option value="" <c:if test="${search.timeSearchKey == ''}"> selected </c:if>><spring:message code="search.name.select.title"/></option>
                                <option value="W.REG_DATE" <c:if test="${search.timeSearchKey == 'W.REG_DATE'}"> selected </c:if>><spring:message code="search.name.regdt.title"/></option>
                            </select>
                            <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                            <input type="text" name="searchDateStart" value="${search.searchDateStart}" class="form-control form-control-sm datepicker" data-dateformat="yyyy-mm-dd" placeholder="<spring:message code="search.name.start.date.title"/>" value="">
                            <span class="input-group-append"><span class="input-group-text">~</span></span>
                            <input type="text" name="searchDateEnd" value="${search.searchDateEnd}" class="form-control form-control-sm datepicker" data-dateformat="yyyy-mm-dd" placeholder="<spring:message code="search.name.end.date.title"/>" value="">
                            <button type="button" class="btn btn-sm btn-info" onclick="searchInit();"><spring:message code="common.button.init.title"/></button>
                            <input type="submit" class="btn btn-sm btn-info" value="<spring:message code="common.button.search.title"/>">
                            <select name="orderByColumn" class="form-select " onchange="submitForm('#search')" value="${search.orderByColumn}">
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

                <div class="text-end d-none">
                    <button type="button" class="btn btn-primary btn-sm me-1" redirect="${_ctx}/admin/wallet/write">
                        <spring:message code="button.wallet.add.title"/>
                    </button>
                </div>

                <hr>

                <div class="row">
                    <div class="table-responsive mb-3">
                        <table class="table table-bordered table-hover text-nowrap align-middle mb-0 table-sm">
                            <thead>
                            <tr>
                                <th><spring:message code="wallet.table.no.title"/></th>
                                <th><spring:message code="wallet.table.symbol.title"/></th>
                                <th><spring:message code="wallet.table.client.id.title"/></th>
                                <th><spring:message code="wallet.table.login.id.title"/></th>
                                <th><spring:message code="wallet.table.role.title"/></th>
                                <th><spring:message code="wallet.table.wallet.address.title"/></th>
                                <th><spring:message code="wallet.table.balances.title"/></th>
                                <th><spring:message code="wallet.table.name.title"/></th>
                                <th><spring:message code="wallet.table.tel.title"/></th>
                                <th><spring:message code="wallet.table.mail.title"/></th>
                                <th><spring:message code="wallet.table.bank.name.title"/></th>
                                <th><spring:message code="wallet.table.bank.owner.title"/></th>
                                <th><spring:message code="wallet.table.bank.account.title"/></th>
                                <th><spring:message code="wallet.table.regdt.title"/></th>
                                <th><spring:message code="wallet.table.action.title"/></th>
                            </tr>
                            </thead>
                            <tbody id="tbodyMember" class="text-wrap">
                            <c:choose>
                                <c:when test="${walletDTOList.size() > 0}">
                                    <c:forEach items="${walletDTOList}" var="item" varStatus="loop">
                                        <tr class="table-success">
                                            <td>${item.rownum}</td>
                                            <td>${item.symbol}</td>
                                            <td>${item.clientCode}</td>
                                            <td>${item.loginId}</td>
                                            <td>${item.roleName}</td>
                                            <td><label class="tx-hash">${item.walletAddress}</label></td>
                                            <td>
                                                <label class="my-balance tx-hash" wallet-address="${item.walletAddress}" data-symbol="${item.symbol}">0</label>
                                                <button type="button" class="btn btn-warning btn-xs btn-reload-balance float-end" onclick="loadBalance({walletAddress: '${item.walletAddress}', symbol: '${item.symbol}'})"><i class="fas fa-redo"></i></button>
                                            </td>
                                            <td>${item.name}</td>
                                            <td>${item.tel}</td>
                                            <td class="tx-hash">${item.email}</td>
                                            <td>${item.bankName}</td>
                                            <td>${item.bankOwner}</td>
                                            <td class="tx-hash">${item.bankAccount}</td>
                                            <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${item.regDate}" /></td>
                                            <td>
                                                <button type="button" class="btn btn-success btn-xs" redirect="${_ctx}/admin/wallet/detail?walletId=${item.walletId}">
                                                    <spring:message code="button.detail.title"/>
                                                </button>
                                                <c:if test="${wallet.role != 'OPERATOR'}">
                                                <button type="button" class="btn btn-success btn-xs d-none" redirect="${_ctx}/admin/wallet/edit?walletId=${item.walletId}">
                                                    <spring:message code="button.update.title"/>
                                                </button>
                                                </c:if>
                                            </td>
                                        </tr>
                                    </c:forEach>
                                </c:when>
                                <c:otherwise>
                                    <tr>
                                        <td colspan="13"><spring:message code="common.message.noData.title"/></td>
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

    init();

    function init(){
        //Load balance in list
        $(".tbl-tokens").find(".my-balance[wallet-address]").each(function(){
          if($(this).attr("wallet-address").length == 0) return;
          var symbol = $(this).data("symbol")
          loadBalance({walletAddress: $(this).attr("wallet-address"), symbol: symbol});
        })
    }
    function submitForm(target){
        $(target).submit();
    }
    
    function searchInit(){
        location.href="/admin/wallet/list";
    }
</script>
</body>
</html>
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
                    <spring:message code="admin.subtitle.analysis.buy.management.title"/>
                </h4>
                <!-- RIBBON -->
                <div class="panel-heading-btn">
                    <ol class="breadcrumb float-xl-end">
                        <li class="breadcrumb-item"><spring:message code="admin.subtitle.analysis.management.title"/></li>
                        <li class="breadcrumb-item active">
                            <a href="javascript:window.location.reload();">
                                <spring:message code="admin.subtitle.analysis.buy.management.title"/>
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

                            <c:if test="${wallet.role != 'OPERATOR' && wallet.role != 'CLIENT'}">
                            <select name="symbol" class="form-select">
                                <option value="">:::<spring:message code="search.name.symbol.title"/>:::</option>
                                <c:forEach items="${tokenDTOList}" var="item" varStatus="loop">
                                    <option <c:if test="${search.symbol == item.symbol}"> selected </c:if> value="${item.symbol}">${item.name}</option>
                                </c:forEach>
                            </select>
                            </c:if>
                            
                            <c:if test="${wallet.role != 'CLIENT'}">
                            <select name="clientId" class="form-select">
                                <option value="">:::<spring:message code="search.name.client.id.title"/>:::</option>
                                <c:forEach items="${clientDTOList}" var="item" varStatus="loop">
                                    <option <c:if test="${search.clientId == item.clientId}"> selected </c:if> value="${item.clientId}">${item.name}</option>
                                </c:forEach>
                            </select>
                            </c:if>
                            
                            <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                            <input type="text" name="searchDateStart" value="${search.searchDateStart}" class="form-control form-control-sm datepicker" data-dateformat="yyyy-mm-dd">
                            <span class="input-group-append"><span class="input-group-text">~</span></span>
                            <input type="text" name="searchDateEnd" value="${search.searchDateEnd}" class="form-control form-control-sm datepicker" data-dateformat="yyyy-mm-dd">
                            <button type="button" class="btn btn-sm btn-info" onclick="searchInit();"><spring:message code="common.button.init.title"/></button>
                            <button type="submit" class="btn btn-sm btn-info"><spring:message code="common.button.search.title"/></button>
                        </form>
                    </div>
                </div>

                <hr>

                <div class="row">
                    <div class="table-responsive mb-3">
                        <table class="table table-bordered table-hover text-nowrap align-middle mb-0 table-sm">
                            <thead>
                                <tr>
                                    <th class="align-middle" rowspan="2"><spring:message code="history.table.symbol.title"/></th>
                                    <th class="align-middle" rowspan="2"><spring:message code="common.admin.field.client.title"/></th>
                                    <th colspan="2"><spring:message code="common.admin.field.buy.title"/></th>
                                    <th colspan="2"><spring:message code="common.admin.field.sell.title"/></th>
                                    <c:if test="${wallet.role == 'CENTRAL_BANK'}">
                                    <th colspan="2"><spring:message code="common.admin.field.fee.title"/></th>
                                    </c:if>
                                    <c:if test="${wallet.role != 'CENTRAL_BANK'}">
                                    <th><spring:message code="common.admin.field.fee.title"/></th>
                                    </c:if>
                                </tr>
                                <tr>
                                    <th><spring:message code="common.admin.field.token.title"/></th>
                                    <th><spring:message code="common.admin.field.price.title"/></th>
                                    <th><spring:message code="common.admin.field.token.title"/></th>
                                    <th><spring:message code="common.admin.field.price.title"/></th>
                                    <c:if test="${wallet.role == 'CENTRAL_BANK'}">
                                    <th><spring:message code="common.admin.field.transfer.title"/></th>
                                    </c:if>
                                    <th><spring:message code="common.admin.field.benefit.title"/></th>
                                </tr>
                            </thead>
                            <tbody id="tbodyMember" class="text-wrap">
                                <c:if test="${analysisList.size() > 0}">
                                    <c:forEach items="${analysisList}" var="item" varStatus="loop">
                                        <tr>
                                            <td>${item.symbol}</td>
                                            <td><a href="${_ctx}/admin/analysis/detail?walletAddress=${item.walletAddress}">${item.clientName}</a></td>
                                            <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.buyQuantity}" /></td>
                                            <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.buyTotalPrice}" /></td>
                                            <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.sellQuantity}" /></td>
                                            <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.sellTotalPrice}" /></td>
                                            <c:if test="${wallet.role == 'CENTRAL_BANK'}">
                                            <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.transferFee}" /></td>
                                            </c:if>
                                            <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.benefitFee}" /></td>
                                        </tr>
                                    </c:forEach>
                                    <tr>
                                        <td colspan="8">
                                            <a href="${_ctx}/admin/analysis/detail?walletAddress=${ownerWalletFee.walletAddress}"><spring:message code="common.admin.field.benefit.fee.title"/></a>
                                        </td>
                                    </tr>
                                    <c:if test="${wallet.role == 'CENTRAL_BANK'}">
                                        <tr>
                                            <td colspan="8">
                                                <a href="${_ctx}/admin/analysis/detail?walletAddress=${ownerWalletFee.walletAddress}&transferFromType=USER&transferToType=VIETKO_FEE"><spring:message code="common.admin.field.transfer.fee.title"/></a>
                                            </td>
                                        </tr>
                                    </c:if>
                                </c:if>
                                <c:if test="${analysisList.size() == 0}">
                                    <tr>
                                        <td colspan="8"><spring:message code="common.message.noData.title"/></td>
                                    </tr>
                                </c:if>

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
        location.href="/admin/analysis/buy/list";
    }
</script>
</body>
</html>
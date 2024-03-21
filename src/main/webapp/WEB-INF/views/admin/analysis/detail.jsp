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
                <!--  -->

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
                            <select name="clientCode" class="form-select">
                                <option value="">:::<spring:message code="search.name.client.id.title"/>:::</option>
                                <c:forEach items="${clientDTOList}" var="item" varStatus="loop">
                                    <option <c:if test="${search.clientCode == item.clientCode}"> selected </c:if> value="${item.clientCode}">${item.clientCode}</option>
                                </c:forEach>
                            </select>
                            </c:if>

                            <select name="transferFromType" class="form-select">
                                <option value="">:::<spring:message code="common.admin.field.transfer.from.type.title"/>:::</option>
                                <c:forEach items="${roleList}" var="item" varStatus="loop">
                                    <option <c:if test="${search.transferFromType == item.codeValue}"> selected </c:if> value="${item.codeValue}">${item.codeName}</option>
                                </c:forEach>
                            </select>
                            <select name="transferToType" class="form-select">
                                <option value="">:::<spring:message code="common.admin.field.transfer.to.type.title"/>:::</option>
                                <c:forEach items="${roleList}" var="item" varStatus="loop">
                                    <option <c:if test="${search.transferToType == item.codeValue}"> selected </c:if> value="${item.codeValue}">${item.codeName}</option>
                                </c:forEach>
                            </select>
                            
                            <input type="hidden" name="walletAddress" value="${search.walletAddress}">
                            <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                            <input type="text" name="searchDateStart" value="${search.searchDateStart}" class="form-control form-control-sm datepicker" data-dateformat="yyyy-mm-dd">
                            <span class="input-group-append"><span class="input-group-text">~</span></span>
                            <input type="text" name="searchDateEnd" value="${search.searchDateEnd}" class="form-control form-control-sm datepicker" data-dateformat="yyyy-mm-dd">
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
                            <button type="submit" class="btn btn-sm btn-info"><spring:message code="common.button.search.title"/></button>
                        </form>
                    </div>
                </div>
                <!--  -->
                <!-- 총 기간 별 대쉬 보드 시작 -->
                <div class="row">
                    <div class="table-responsive mb-3">
                        <table class="table table-bordered table-hover text-nowrap align-middle mb-0 table-sm">
                            <thead>

                                <tr>
                                    <th>#</th>
                                    <th><spring:message code="analysis.detail.table.symbol.title"/></th>
                                    <th><spring:message code="analysis.detail.table.client.title"/></th>
                                    <th><spring:message code="analysis.detail.table.txid.title"/></th>
                                    <th><spring:message code="analysis.detail.table.from.type.title"/></th>
                                    <th><spring:message code="analysis.detail.table.from.wallet.title"/></th>
                                    <th><spring:message code="analysis.detail.table.to.type.title"/></th>
                                    <th><spring:message code="analysis.detail.table.to.wallet.title"/></th>
                                    <th><spring:message code="analysis.detail.table.to.quantity.title"/></th>
                                    <th><spring:message code="analysis.detail.table.to.reg.date.title"/></th>
                                </tr>
                            </thead>
                            <tbody id="tbodyMember" class="text-wrap">
                                <c:if test="${transferHistory.size() > 0}">
                                    <c:forEach items="${transferHistory}" var="item" varStatus="loop">
                                        <tr>
                                            <td>${item.rownum}</td>
                                            <td>${item.symbol}</td>
                                            <td>${item.clientCode}</td>
                                            <td>${item.txid}</td>
                                            <td>${item.transferFromType}</td>
                                            <td>${item.fromWalletAddress}</td>
                                            <td>${item.transferToType}</td>
                                            <td>${item.toWalletAddress}</td>
                                            <td><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.quantity}" /></td>
                                            <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${item.regDate}" /></td>
                                        </tr>
                                    </c:forEach>
                                </c:if>
                                <c:if test="${transferHistory.size() == 0}">
                                    <tr>
                                        <td colspan="10"><spring:message code="common.message.noData.title"/></td>
                                    </tr>
                                </c:if>
                            </tbody>
                        </table>
                    </div>
                </div>

                <div class="row mt-10px">
                    <div class="d-md-flex align-items-center">
                        <%-- 추후 필요에 따라 사용 --%>
                        <div class="me-md-auto text-md-left text-center mb-2 mb-md-0"></div>
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
        location.href="/admin/analysis/buy/detail?walletAddress=${search.walletAddress}";
    }
</script>
</body>
</html>
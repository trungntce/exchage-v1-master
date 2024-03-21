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
                    <spring:message code="admin.subtitle.account.user.list.title"/>
                </h4>
                <!-- RIBBON -->
                <div class="panel-heading-btn">
                    <ol class="breadcrumb float-xl-end">
                        <li class="breadcrumb-item"><spring:message code="admin.subtitle.account.title"/></li>
                        <li class="breadcrumb-item active">
                            <a href="javascript:window.location.reload();">
                                <spring:message code="admin.subtitle.account.user.list.title"/>
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
                                <option value=""><spring:message code="search.name.select.title"/></option>
                                <option value="LOGIN_ID" <c:if test="${search.keywordType == 'LOGIN_ID'}"> selected </c:if>>
                                    <spring:message code="search.name.keywordType.option.login.id.title"/>
                                </option>
                                <option value="U.NAME" <c:if test="${search.keywordType == 'NAME'}"> selected </c:if>>
                                    <spring:message code="search.name.keywordType.option.name.title"/>
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
                                <option value="U.REG_DATE" <c:if test="${search.timeSearchKey == 'U.REG_DATE'}"> selected </c:if>><spring:message code="search.name.regdt.title"/></option>
                            </select>
                            <span class="input-group-text"><i class="fa fa-calendar"></i></span>
                            <input type="text" name="searchDateStart" value="${search.searchDateStart}" class="form-control form-control-sm datepicker" data-dateformat="yyyy-mm-dd" placeholder="<spring:message code="search.name.start.date.title"/>" value="">
                            <span class="input-group-append"><span class="input-group-text">~</span></span>
                            <input type="text" name="searchDateEnd" value="${search.searchDateEnd}" class="form-control form-control-sm datepicker" data-dateformat="yyyy-mm-dd" placeholder="<spring:message code="search.name.end.date.title"/>" value="">
                            <button type="button" class="btn btn-sm btn-info" onclick="searchInit();"><spring:message code="common.button.init.title"/></button>
                            <input type="submit" class="btn btn-sm btn-info" value="<spring:message code="common.button.search.title"/>">
                            <select name="orderByColumn" class="form-select " onchange="submitForm('#search')" value="${search.orderByColumn}">
                                <option value="ROWNUM" <c:if test="${search.orderByColumn == 'ROWNUM'}"> selected </c:if>><spring:message code="search.name.orderByColumn.option.no.title"/></option>
                                <option value="USER_ID" <c:if test="${search.orderByColumn == 'USER_ID'}"> selected </c:if>><spring:message code="search.name.orderByColumn.option.user.id.title"/></option>
                                <option value="NAME" <c:if test="${search.orderByColumn == 'NAME'}"> selected </c:if>><spring:message code="search.name.orderByColumn.option.name.title"/></option>
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
                    <button type="button" class="btn btn-primary btn-sm me-1" redirect="${_ctx}/admin/user/write">
                        <spring:message code="button.user.add.title"/>
                    </button>
                </div>

                <hr>

                <div class="row">
                    <div class="table-responsive mb-3">
                        <table class="table table-bordered table-hover text-nowrap align-middle mb-0 table-sm">
                            <thead>
                            <tr>
                                <th><spring:message code="user.table.no.title"/></th>
                                <th><spring:message code="user.table.symbol.title"/></th>
                                <th><spring:message code="user.table.client.id.title"/></th>
                                <th><spring:message code="user.table.id.title"/></th>
                                <th><spring:message code="user.table.name.title"/></th>
                                <th><spring:message code="user.table.state.title"/></th>
                                <th><spring:message code="user.table.regdt.title"/></th>
                                <th><spring:message code="user.table.action.title"/></th>
                            </tr>
                            </thead>
                            <tbody id="tbodyMember" class="text-wrap">
                            <c:choose>
                                <c:when test="${userDTOList.size() > 0}">
                                    <c:forEach items="${userDTOList}" var="item" varStatus="loop">
                                        <tr class="table-success">
                                            <td>${item.rownum}</td>
                                            <td>${item.symbol}</td>
                                            <td>${item.clientCode}</td>
                                            <td>${item.loginId}</td>
                                            <td>${item.name}</td>
                                            <td>${item.state}</td>
                                            <td><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${item.regDate}" /></td>
                                            <td>
                                                <c:if test="${wallet.role != 'OPERATOR'}">
                                                <button type="button" class="btn btn-success btn-xs" onclick="javascript:goEdit('${item.userId}')">
                                                    <spring:message code="button.update.title"/>
                                                </button>
                                                </c:if>
                                                <button type="button" class="btn btn-success btn-xs" onclick="javascript:goDetail('${item.userId}')">
                                                    <spring:message code="button.detail.title"/>
                                                </button>
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
function submitForm(target){
    $(target).submit();
}
function searchInit(){
    location.href="/admin/user/list";
}
function goEdit(userId){
    if(location.search.length > 0){
        location.href="/admin/user/edit"+location.search+"&userId="+userId;
    } else {
        location.href="/admin/user/edit?userId="+userId;
    }
}
function goDetail(userId){
    if(location.search.length > 0){
        location.href="/admin/user/detail"+location.search+"&userId="+userId;
    } else {
        location.href="/admin/user/detail?userId="+userId;
    }

}
</script>
</body>
</html>
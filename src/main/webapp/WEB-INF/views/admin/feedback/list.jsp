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
                        <select name="feedback-state" class="feedback-state" class="form-select">
                                <option value="">:::<spring:message code="admin.search.feedback.state.title"/>:::</option>
                                <c:forEach items="${feedbackState}" var="item" varStatus="loop">
                                    <option <c:if test="${search.state == item.codeValue}"> selected </c:if> value="${item.codeValue}">${item.codeName}</option>
                                </c:forEach>
                            </select>
                            

                        </form>
                    </div>
                </div>

                <div class="text-end">
                    <!-- <button type="button" class="btn btn-primary btn-sm me-1" redirect="${_ctx}/admin/user/write">
                        <spring:message code="button.user.add.title"/>
                    </button> -->
                </div>

                <hr>

                <div class="row">
                    <div class="table-responsive mb-3">
                        <table class="table table-bordered table-hover text-nowrap align-middle mb-0 table-sm">
                            <thead>
                            <tr>
                                <th><spring:message code="search.name.orderByColumn.option.no.title"/></th>
                                <th><spring:message code="feedback.list.title"/></th>
                                <th><spring:message code="feedback.list.regWallet.title"/></th>
                                <th><spring:message code="feedback.list.regDate.title"/></th>
                                <th><spring:message code="feedback.list.ipAddress.title"/></th>
                                <th><spring:message code="feedback.list.state.title"/></th>                                
                            </tr>
                            </thead>
                            <tbody id="tbodyMember" class="text-wrap">
                            <c:choose>
                                <c:when test="${feedbacks.size() > 0}">
                                      <c:forEach items="${feedbacks}" var="item" varStatus="loop">
                                        <tr class="table-success">
                                            <td>${item.rowNum}</td>
                                            <td>${item.title}</td>
                                            <td>${item.regUser}</td>        
                                            <td><fmt:formatDate value="${item.regDate}" pattern="yyyy-MM-dd HH:mm:ss"/></td>        
                                            <td>${item.ipAddress}</td>        
                                            <td>
                                                 <c:if test="${item.state == 1}"><button type="button" class="btn btn-danger btn-xs" redirect="${_ctx}/admin/feedback/edit?feedbackId=${item.feedbackId}">
                                                    <spring:message code="feedback.list.state.request"/>
                                                  </button></c:if>
                                                  <c:if test="${item.state == 2}"><button type="button" class="btn btn-warning btn-xs" redirect="${_ctx}/admin/feedback/edit?feedbackId=${item.feedbackId}" >
                                                    <spring:message code="feedback.list.state.checking"/>
                                                  </button></c:if>
                                                  <c:if test="${item.state == 3}"><button type="button" class="btn btn-warning btn-xs" redirect="${_ctx}/admin/feedback/edit?feedbackId=${item.feedbackId}" >
                                                    <spring:message code="feedback.list.state.processing"/>
                                                  </button></c:if>
                                                  <c:if test="${item.state == 4}"><button type="button" class="btn btn-success btn-xs" redirect="${_ctx}/admin/feedback/edit?feedbackId=${item.feedbackId}" >
                                                    <spring:message code="feedback.list.state.finished"/>
                                                  </button></c:if>
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
 if(${feedbackSearch.showDetail == 'Y' && feedbackSearch.refId != null}){
        showModal('#feedbackModal', false);
    }
    
function submitForm(target){
    $(target).submit();
}
function searchInit(){
    location.href="/admin/user/list";
}


$(".feedback-state").change(function(){   
    let state = $(this).find("option:selected").val();       
    var url = changeSearchParam({state: state})
    document.location.href = url;
   
})

</script>

</body>
</html>
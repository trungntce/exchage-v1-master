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
                    <spring:message code="admin.subtitle.account.user.detail.title"/>
                </h4>
                <!-- RIBBON -->
                <div class="panel-heading-btn">
                    <ol class="breadcrumb float-xl-end">
                        <li class="breadcrumb-item"><spring:message code="admin.subtitle.account.title"/></li>
                        <li class="breadcrumb-item active">
                            <a href="${_ctx}/admin/user/list">
                                <spring:message code="admin.subtitle.account.user.list.title"/>
                            </a>
                        </li>
                        <li class="breadcrumb-item active">
                            <a href="javascript:window.location.reload();">
                                <spring:message code="admin.subtitle.account.user.detail.title"/>
                            </a>
                        </li>
                    </ol>
                </div>
                <!-- END RIBBON -->
            </div>

            <!-- MAIN CONTENT -->
            <div class="panel-body">
                <!-- 총 기간 별 대쉬 보드 시작 -->
                <table style="width: 100%">
                    <tr>
                        <td class="dev-form-title"><label><spring:message code="user.table.id.title"/></label></td>
                        <td class="dev-form-content form-group">${userDTO.userId}</td>
                    </tr>
                    <tr>
                        <td class="dev-form-title"><label><spring:message code="user.table.login.id.title"/></label></td>
                        <td class="dev-form-content form-group">${userDTO.loginId}</td>
                    </tr>
                    <tr>
                        <td class="dev-form-title"><label><spring:message code="wallet.table.wallet.address.title"/></label></td>
                        <td class="dev-form-content form-group">${userDTO.walletAddress}</td>
                    </tr>
                    <tr>
                        <td class="dev-form-title" for="name"><label><spring:message code="user.table.name.title"/></label></td>
                        <td class="dev-form-content form-group">${userDTO.name}</td>
                    </tr>

                    <tr>
                        <td class="dev-form-title"><label><spring:message code="wallet.table.fee.title"/></label></td>
                        <td class="dev-form-content form-group">${userDTO.fee}</td>
                    </tr>

                    <!-- Tel -->
                    <tr>
                        <td class="dev-form-title" for="tel"><label><spring:message code="register.input.phone"/></label></td>
                        <td class="dev-form-content form-group">${userDTO.tel}</td>
                    </tr>
                    <!-- * Tel -->

                    <!-- Bank Name -->
                    <tr>
                        <td class="dev-form-title" for="bankName"><label><spring:message code="register.input.bank.name.title"/></label></td>
                        <td class="dev-form-content form-group">${userDTO.bankName}</td>
                    </tr>
                    <!-- * Bank Name -->

                    <!-- Bank Owner -->
                    <tr>
                        <td class="dev-form-title" for="bankOwner"><label><spring:message code="register.input.bank.owner.title"/></label></td>
                        <td class="dev-form-content form-group">${userDTO.bankOwner}</td>
                    </tr>
                    <!-- * Bank Owner -->

                    <!-- Bank Number -->
                    <tr>
                        <td class="dev-form-title" for="bankAccount"><label><spring:message code="register.input.bank.account.title"/></label></td>
                        <td class="dev-form-content form-group">${userDTO.bankAccount}</td>
                    </tr>
                    <!-- * Bank Number -->

                    <!-- Mail -->
                    <tr>
                        <td class="dev-form-title"><label><spring:message code="register.input.mail"/></label></td>
                        <td class="dev-form-content form-group">${userDTO.email}</td>
                    </tr>
                    <!-- * Mail -->
                    <tr>
                        <td colspan="2" class="text-center">
                            <button type="button" class="btn btn-success" onclick="javascript:goEdit('${userDTO.userId}');"><spring:message code="button.edit.title"/></button>
                            <button type="button" class="btn btn-success" onclick="javascript:back();"><spring:message code="button.return.title"/></button>
                        </td>
                    </tr>
                </table>
                <!-- 총 기간 별 대쉬 보드 끝 -->
            </div>
        </div>
    </div>
</div>
<script>
    function goEdit(userId){
        let queryString = window.location.search;
        let urlParams = new URLSearchParams(queryString);
        urlParams.delete("userId");

        location.href=window.location.origin+"/admin/user/edit?"+urlParams.toString()+"&userId="+userId;
    }

    function back(){
        let queryString = window.location.search;
        let urlParams = new URLSearchParams(queryString);
        urlParams.delete("userId");

        if(urlParams.toString().length > 0){
            location.href=window.location.origin+"/admin/user/list"+"?"+urlParams.toString();
        } else {
            location.href=window.location.origin+"/admin/user/list";
        }
    }
</script>
</body>
</html>
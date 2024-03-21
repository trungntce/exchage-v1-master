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
                    <spring:message code="admin.subtitle.account.wallet.detail.title"/>
                </h4>
                <!-- RIBBON -->
                <div class="panel-heading-btn">
                    <ol class="breadcrumb float-xl-end">
                        <li class="breadcrumb-item"><spring:message code="admin.subtitle.account.title"/></li>
                        <li class="breadcrumb-item active">
                            <a href="${_ctx}/admin/wallet/list">
                                <spring:message code="admin.subtitle.account.wallet.list.title"/>
                            </a>
                        </li>
                        <li class="breadcrumb-item active">
                            <a href="javascript:window.location.reload();">
                                <spring:message code="admin.subtitle.account.wallet.detail.title"/>
                            </a>
                        </li>
                    </ol>
                </div>
                <!-- END RIBBON -->
            </div>

            <!-- MAIN CONTENT -->
            <div class="panel-body">
                <table style="width: 100%">
                    <tr>
                        <td class="dev-form-title"><label><spring:message code="wallet.table.symbol.title"/></label></td>
                        <td class="text-left dev-form-content">${walletDTO.symbol}</td>
                    </tr>
                    <tr>
                        <td class="dev-form-title"><label><spring:message code="wallet.table.login.id.title"/></label></td>
                        <td class="text-left dev-form-content">${walletDTO.loginId}</td>
                    </tr>
                    <tr>
                        <td class="dev-form-title"><label><spring:message code="wallet.table.role.title"/></label></td>
                        <td class="text-left dev-form-content">${walletDTO.roleName}</td>
                    </tr>
                    <tr>
                        <td class="dev-form-title"><label><spring:message code="wallet.table.wallet.address.title"/></label></td>
                        <td class="text-left dev-form-content">${walletDTO.walletAddress}</td>
                    </tr>
                    <tr>
                        <td class="dev-form-title"><label><spring:message code="wallet.table.fee.title"/></label></td>
                        <td class="text-left dev-form-content">${walletDTO.fee}</td>
                    </tr>
                    <tr>
                        <td class="dev-form-title"><label><spring:message code="wallet.table.name.title"/></label></td>
                        <td class="text-left dev-form-content">${walletDTO.name}</td>
                    </tr>
                    <tr>
                        <td class="dev-form-title"><label><spring:message code="wallet.table.tel.title"/></label></td>
                        <td class="text-left dev-form-content">${walletDTO.tel}</td>
                    </tr>
                    <tr>
                        <td class="dev-form-title"><label><spring:message code="wallet.table.mail.title"/></label></td>
                        <td class="text-left dev-form-content">${walletDTO.email}</td>
                    </tr>
                    <tr>
                        <td class="dev-form-title"><label><spring:message code="wallet.table.bank.name.title"/></label></td>
                        <td class="text-left dev-form-content">${walletDTO.bankName}</td>
                    </tr>
                    <tr>
                        <td class="dev-form-title"><label><spring:message code="wallet.table.bank.owner.title"/></label></td>
                        <td class="text-left dev-form-content">${walletDTO.bankOwner}</td>
                    </tr>
                    <tr>
                        <td class="dev-form-title"><label><spring:message code="wallet.table.bank.account.title"/></label></td>
                        <td class="text-left dev-form-content">${walletDTO.bankAccount}</td>
                    </tr>
                    <tr>
                        <td class="dev-form-title"><label><spring:message code="wallet.table.regdt.title"/></label></td>
                        <td class="text-left dev-form-content"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${walletDTO.regDate}" /></td>
                    </tr>
                    <tr>
                        <td colspan="2" class="text-center">
                            <button type="button" class="btn btn-success" onclick="javascript:goEdit('${walletDTO.walletId}');"><spring:message code="button.edit.title"/></button>
                            <button type="button" class="btn btn-success" onclick="javascript:back();"><spring:message code="button.return.title"/></button>
                        </td>
                    </tr>
                </table>
            </div>
        </div>
    </div>
</div>
<script>
    function goEdit(walletId){
        location.href="/admin/wallet/edit?walletId="+walletId;
    }
    function back(){
        location.href="/admin/wallet/list";
    }
</script>
</body>
</html>
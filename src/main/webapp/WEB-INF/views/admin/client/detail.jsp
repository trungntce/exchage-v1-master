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
                    <spring:message code="admin.menu.admin.client.write.title"/>
                </h4>
                <!-- RIBBON -->
                <div class="panel-heading-btn">
                    <ol class="breadcrumb float-xl-end">
                        <li class="breadcrumb-item"><spring:message code="admin.subtitle.client.management.title"/></li>
                        <li class="breadcrumb-item active">
                            <a href="${_ctx}/admin/client/list">
                                <spring:message code="admin.menu.admin.client.setup.title"/>
                            </a>
                        </li>
                        <li class="breadcrumb-item active">
                            <a href="javascript:window.location.reload();">
                                <spring:message code="admin.menu.admin.client.write.title"/>
                            </a>
                        </li>
                    </ol>
                </div>
                <!-- END RIBBON -->
            </div>

            <!-- MAIN CONTENT -->
            <div class="panel-body">
                <!-- 총 기간 별 대쉬 보드 시작 -->
                <form id="clientForm" method="POST" action="">
                    <!-- Body Page Content -->
                    <table style="width: 100%">
                        <!-- Symbol -->
                        <tr>
                            <td class="dev-form-title"><label><spring:message code="client.field.symbol.title"/></label></td>
                            <td class="dev-form-content form-group ps-1">${client.symbol}</td>
                        </tr>
                        <!-- * Symbol -->

                        <!-- Wallet Address -->
                        <tr>
                            <td class="dev-form-title"><label><spring:message code="client.field.walletAddress.title"/></label></td>
                            <td class="dev-form-content form-group ps-1">${client.walletAddress}</td>
                        </tr>
                        <!-- * Wallet Address -->

                        <!-- Client Code -->
                        <tr>
                            <td class="dev-form-title"><label><spring:message code="client.field.clientCode.title"/></label></td>
                            <td class="dev-form-content form-group ps-1">${client.clientCode}</td>
                        </tr>
                        <!-- * Client Code -->
                        <!-- API KEY -->
                        <tr>
                            <td class="dev-form-title"><label><spring:message code="client.field.apiKey.title"/></label></td>
                            <td class="dev-form-content form-group ps-1">${client.apiKey}</td>
                        </tr>
                        <!-- * API KEY -->
                        <!-- Name -->
                        <tr>
                            <td class="dev-form-title"><label><spring:message code="client.field.name.title"/></label></td>
                            <td class="dev-form-content form-group ps-1">${client.name}</td>
                        </tr>
                        <!-- * Name -->

                        <!-- clientTraderUseYn -->
                        <tr>
                            <td class="dev-form-title"><label><spring:message code="client.field.client.trader.title"/></label></td>
                            <td class="dev-form-content form-group ps-1">${client.clientTraderUseYn}</td>
                        </tr>
                        <!-- * clientTraderUseYn -->

                        <!-- buyBenifitUseYn -->
                        <tr>
                            <td class="dev-form-title"><label><spring:message code="client.field.buy.benifit.title"/></label></td>
                            <td class="dev-form-content form-group ps-1">${client.buyBenifitUseYn}</td>
                        </tr>
                        <!-- * buyBenifitUseYn -->

                        <!-- sellBenifitUseYn -->
                        <tr>
                            <td class="dev-form-title"><label><spring:message code="client.field.sell.benifit.title"/></label></td>
                            <td class="dev-form-content form-group ps-1">${client.sellBenifitUseYn}</td>
                        </tr>
                        <!-- * sellBenifitUseYn -->

                        <!-- Use YN -->
                        <tr>
                            <td class="dev-form-title"><label><spring:message code="client.field.useYn.title"/></label></td>
                            <td class="dev-form-content form-group ps-1">${client.useYn}</td>
                        </tr>
                        <!-- * Use YN -->

                        <!-- Bank Name -->
                        <tr>
                            <td class="dev-form-title"><label><spring:message code="register.input.bank.name.title"/></label></td>
                            <td class="dev-form-content form-group ps-1">${client.bankName}</td>
                        </tr>
                        <!-- * Bank Name -->
                        
                        <!-- Bank Owner -->
                        <tr>
                            <td class="dev-form-title"><label><spring:message code="register.input.bank.owner.title"/></label></td>
                            <td class="dev-form-content form-group ps-1">${client.bankOwner}</td>
                        </tr>
                        <!-- * Bank Owner -->
                        
                        <!-- Bank Number -->
                        <tr>
                            <td class="dev-form-title"><label><spring:message code="register.input.bank.account.title"/></label></td>
                            <td class="dev-form-content form-group ps-1">${client.bankAccount}</td>
                        </tr>
                        <!-- * Bank Number -->

                        <tr>
                            <td colspan="2" class="text-center">
                                <button type="button" class="btn btn-success" onclick="javascript:back();"><spring:message code="button.return.title"/></button>
                            </td>
                        </tr>
                    </table>
                </form>
                <!-- 총 기간 별 대쉬 보드 끝 -->
            </div>
        </div>
    </div>
</div>
</body>
<script>
    function back(){
        location.href="/admin/client/list";
    }
</script>
</html>
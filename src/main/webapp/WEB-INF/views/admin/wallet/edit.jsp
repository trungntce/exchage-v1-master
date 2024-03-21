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
                    <spring:message code="admin.subtitle.account.wallet.edit.title"/>
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
                                <spring:message code="admin.subtitle.account.wallet.edit.title"/>
                            </a>
                        </li>
                    </ol>
                </div>
                <!-- END RIBBON -->
            </div>

            <!-- MAIN CONTENT -->
            <div class="panel-body">
                <!-- 총 기간 별 대쉬 보드 시작 -->
                <form id="walletEditForm" name="walletEditForm" method="POST" action="">
                    <!-- Body Page Content -->
                    <table style="width: 100%">
                        <tr>
                            <td class="dev-form-title"><label><spring:message code="wallet.table.symbol.title"/></label></td>
                            <td class="dev-form-content form-group">${walletDTO.symbol}</td>
                        </tr>
                        <tr>
                            <td class="dev-form-title"><label><spring:message code="wallet.table.login.id.title"/></label></td>
                            <td class="dev-form-content form-group">${walletDTO.loginId}</td>
                        </tr>
                        <tr>
                            <td class="dev-form-title"><label><spring:message code="wallet.table.wallet.address.title"/></label></td>
                            <td class="dev-form-content form-group">${walletDTO.walletAddress}</td>
                        </tr>

                        <tr>
                            <td class="dev-form-title"><label><spring:message code="wallet.table.role.title"/></label></td>
                            <td class="dev-form-content form-group">${walletDTO.role}</td>
                        </tr>

                        <!-- Password -->
                        <tr>
                            <td class="dev-form-title" for="walletPw"><label><spring:message code="register.input.password"/></label></td>
                            <td class="dev-form-content form-group">
                                <spring:message code="register.input.password.hint" var="passwordHint"/>
                                <input id="walletPw" name="walletPw" type="password" class="dev-form-input" placeholder="${passwordHint}" maxlength="100" >
                                <span class="input-info message text-danger" hidden><spring:message code="register.input.password.message"/></span>
                            </td>
                        </tr>
                        <!-- * Password -->
                        
                        <!-- Password Confirm -->
                        <tr>
                            <td class="dev-form-title" for="re-password"><label><spring:message code="register.input.password.confirm"/></label></td>
                            <td class="dev-form-content form-group">
                                <input id="re-password" type="password" class="dev-form-input" placeholder='<spring:message code="register.input.password.confirm.hint"/>' maxlength="100" >
                                <span class="input-info message text-danger" hidden><spring:message code="register.input.password.confirm.message"/></span>
                            </td>
                        </tr>
                        <!-- Password Confirm -->
                        
                        <tr>
                            <td class="dev-form-title" field="NN"><label><spring:message code="wallet.table.fee.title"/></label></td>
                            <td class="dev-form-content form-group">
                                <input type="text" name="fee" id="fee" class="dev-form-input" value="${walletDTO.fee}">
                            </td>
                        </tr>
                        <tr>
                            <td class="dev-form-title" field="NN"><label><spring:message code="wallet.table.name.title"/></label></td>
                            <td class="dev-form-content form-group">
                                <input type="text" name="name" id="name" class="dev-form-input" value="${walletDTO.name}">
                            </td>
                        </tr>
                        <tr>
                            <td class="dev-form-title" field="NN"><label><spring:message code="wallet.table.tel.title"/></label></td>
                            <td class="dev-form-content form-group">
                                <input type="text" name="tel" id="tel" class="dev-form-input" value="${walletDTO.tel}">
                            </td>
                        </tr>
                        <tr>
                            <td class="dev-form-title" field="NN"><label><spring:message code="wallet.table.mail.title"/></label></td>
                            <td class="dev-form-content form-group">
                                <input type="text" name="email" id="email" class="dev-form-input" value="${walletDTO.email}">
                            </td>
                        </tr>
                        <tr>
                            <td class="dev-form-title" field="NN"><label><spring:message code="wallet.table.bank.name.title"/></label></td>
                            <td class="dev-form-content form-group">
                                <input type="text" name="bankName" id="bankName" class="dev-form-input" value="${walletDTO.bankName}">
                            </td>
                        </tr>
                        <tr>
                            <td class="dev-form-title" field="NN"><label><spring:message code="wallet.table.bank.owner.title"/></label></td>
                            <td class="dev-form-content form-group">
                                <input type="text" name="bankOwner" id="bankOwner" class="dev-form-input" value="${walletDTO.bankOwner}">
                            </td>
                        </tr>
                        <tr>
                            <td class="dev-form-title" field="NN"><label><spring:message code="wallet.table.bank.account.title"/></label></td>
                            <td class="dev-form-content form-group">
                                <input type="text" name="bankAccount" id="bankAccount" class="dev-form-input" value="${walletDTO.bankAccount}">
                            </td>
                        </tr>
                        <tr>
                            <td class="dev-form-title"><label><spring:message code="wallet.table.regdt.title"/></label></td>
                            <td class="dev-form-content form-group"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${walletDTO.regDate}" /></td>
                        </tr>
                        <tr>
                            <td colspan="2" class="text-center">
                                <div class="mt-2">
                                    <button type="button" class="btn btn-success" id="btn-submit"><spring:message code="common.button.submit.title"/></button>
                                    <button type="button" class="btn btn-success" onclick="javascript:back();"><spring:message code="button.return.title"/></button>
                                </div>
                            </td>
                        </tr>
                    </table>
                </form>
                <!-- * Body Page Content -->
                <!-- 총 기간 별 대쉬 보드 끝 -->
            </div>
        </div>
    </div>
</div>
<script>
    

    $(document).ready(function(){
        $("#btn-submit").click(function(){
            var p1 = $("#walletPw").val().trim();
            var p2 = $("#re-password").val().trim();
            if(p1.length > 0 && p1 != p2){
                alert("<spring:message code='register.input.mess.please.check.title'/>")
                return;
            }
            var isNull = checkFieldNotNull(null);
            if(isNull){
                alert("<spring:message code='register.input.mess.please.check.title'/>")
                return;
            }
            submitForm('#walletEditForm')
        })
    })

    function back(){
        location.href="/admin/wallet/list";
    }
</script>
</body>
</html>
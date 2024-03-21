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
                <!-- * Header Page Content -->
                <form id="userEditForm" name="userEditForm" method="POST" action="">
                    <input type="hidden" name="userId" id="userId" value="${userDTO.userId}">
                    <input type="hidden" name="walletId" id="walletId" value="${userDTO.walletId}">
                    <!-- Body Page Content -->
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
                            <td class="dev-form-title" for="name" field="NN"><label><spring:message code="user.table.name.title"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <input type="text" class="dev-form-input" name="name" id="name" value="${userDTO.name}"/>
                                <span class="input-info message text-danger" hidden><spring:message code="register.input.name.message"/></span>
                            </td>
                        </tr>
                        <tr>
                            <td class="dev-form-title" for="loginPw"><label><spring:message code="user.table.login.pw.title"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <input type="password" class="dev-form-input" name="loginPw" id="loginPw" value=""/>
                                <span class="input-info message text-danger" hidden><spring:message code="register.input.password.message"/></span>
                            </td>
                        </tr>
                        <tr>
                            <td class="dev-form-title" for="re-password"><label><spring:message code="user.table.login.pw.check.title"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <input type="password" class="dev-form-input" name="re-password" id="re-password" value=""/>
                                <span class="input-info message text-danger" hidden><spring:message code="register.input.password.confirm.message"/></span>
                            </td>
                        </tr>

                        <tr>
                            <td class="dev-form-title" field="NN"><label><spring:message code="wallet.table.fee.title"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <input type="number" name="fee" id="fee" class="dev-form-input" value="${userDTO.fee}">
                                <span class="form-message form-message-admin text-red"></span>
                            </td>
                        </tr>

                        <!-- Tel -->
                        <tr>
                            <td class="dev-form-title" for="tel" field="NN"><label><spring:message code="register.input.phone"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <spring:message code="register.input.phone.hint" var="telHint"/>
                                <input type="number" id="tel" name="tel" class="dev-form-input" placeholder="${telHint}" value="${userDTO.tel}">
                                <span class="form-message form-message-admin text-red"></span>
                            </td>
                        </tr>
                        <!-- * Tel -->

                        <!-- Bank Name -->
                        <tr>
                            <td class="dev-form-title" for="bankName" field="NN"><label><spring:message code="register.input.bank.name.title"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <spring:message code="register.input.bank.name.hint" var="bankNameHint"/>
                                <input id="bankName" name="bankName" class="dev-form-input" placeholder="${bankNameHint}" value="${userDTO.bankName}">
                                <span class="form-message form-message-admin text-red"></span>
                            </td>
                        </tr>
                        <!-- * Bank Name -->

                        <!-- Bank Owner -->
                        <tr>
                            <td class="dev-form-title" for="bankOwner" field="NN"><label><spring:message code="register.input.bank.owner.title"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <spring:message code="register.input.bank.owner.hint" var="bankOwnerHint"/>
                                <input id="bankOwner" name="bankOwner" class="dev-form-input" placeholder="${bankOwnerHint}" value="${userDTO.bankOwner}">
                                 <span class="form-message form-message-admin text-red"></span>
                            </td>
                        </tr>
                        <!-- * Bank Owner -->

                        <!-- Bank Number -->
                        <tr>
                            <td class="dev-form-title" for="bankAccount" field="NN"><label><spring:message code="register.input.bank.account.title"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <spring:message code="register.input.bank.account.hint" var="bankAccountHint"/>
                                <input type="number" id="bankAccount" name="bankAccount" class="dev-form-input onlynum" placeholder="${bankAccountHint}" value="${userDTO.bankAccount}">
                                <span class="form-message form-message-admin text-red"></span>
                            </td>
                        </tr>
                        <!-- * Bank Number -->

                        <!-- Mail -->
                        <tr>
                            <td class="dev-form-title"><label><spring:message code="register.input.mail"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <spring:message code="register.input.mail.hint" var="mailHint"/>
                                <input id="mail" name="mail" class="dev-form-input" placeholder="${mailHint}" value="${userDTO.email}">
                                <span class="form-message form-message-admin text-red"></span>
                            </td>
                        </tr>
                        <!-- * Mail -->
                        <tr>
                            <td class="dev-form-title"><label><spring:message code="user.table.state.title"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <select class="dev-form-input" id="state" name="state">
                                    <option value="1"><spring:message code="button.yes.title"/></option>
                                    <option value="2" <c:if test="${userDTO.state == 2}"> selected </c:if>><spring:message code="button.no.title"/></option>
                                </select>
                            </td>
                        </tr>
                        <tr>
                            <td class="dev-form-title"><label><spring:message code="user.table.regdt.title"/></label></td>
                            <td class="dev-form-content form-group"><fmt:formatDate pattern="yyyy-MM-dd HH:mm:ss" value="${userDTO.regDate}" /></td>
                        </tr>
                        <tr>
                            <td colspan="2" class="text-center">
                                <div class="mt-2">
                                    <button type="submit" class="btn btn-success"><spring:message code="common.button.submit.title"/></button>
                                    <button type="button" class="btn btn-success" onclick="history.back()"><spring:message code="button.return.title"/></button>
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

    document.addEventListener('DOMContentLoaded', function () {
        //valid input
        Validator({
            form: '#userForm',
            formGroupSelector: '.form-group',
            errorSelector: '.form-message',
            rules: [

                // Check null
                Validator.isRequired('#name', "<spring:message code='the.input.not.valid'/>"),
                Validator.isRequired('#tel', "<spring:message code='the.input.not.valid'/>"),
                Validator.isRequired('#bankName', "<spring:message code='the.input.not.valid'/>"),
                Validator.isRequired('#bankOwner', "<spring:message code='the.input.not.valid'/>"),
                Validator.isRequired('#bankAccount', "<spring:message code='the.input.not.valid'/>"),

                // Check minimum input
                Validator.minLength('#name', 3, "<spring:message code='login.minimum.length'/>"),
                Validator.minLength('#tel', 3, "<spring:message code='login.minimum.length'/>"),
                Validator.minLength('#bankName', 3, "<spring:message code='login.minimum.length'/>"),
                Validator.minLength('#bankOwner', 3, "<spring:message code='login.minimum.length'/>"),
                Validator.minLength('#bankAccount', 3, "<spring:message code='login.minimum.length'/>"),
                // Check maximum
                Validator.maxLength('#name', 32, "<spring:message code='login.maximum.length'/>"),
                Validator.maxLength('#tel', 32, "<spring:message code='login.maximum.length'/>"),
                Validator.maxLength('#bankName', 32, "<spring:message code='login.maximum.length'/>"),
                Validator.maxLength('#bankOwner', 32, "<spring:message code='login.maximum.length'/>"),
                Validator.maxLength('#bankAccount', 32, "<spring:message code='login.maximum.length'/>"),

                // Validator regexPattern
                Validator.isRegexPattern('#name', "<spring:message code='the.input.not.valid'/>"),
                Validator.isRegexPhoneNumber('#tel', "<spring:message code='the.input.not.valid'/>"),
                //Validator.isRegexPattern('#bankName', "<spring:message code='the.input.not.valid'/>"),
                //Validator.isRegexPattern('#bankOwner', "<spring:message code='the.input.not.valid'/>"),
                //Validator.isRegexPattern('#bankAccount', "<spring:message code='the.input.not.valid'/>"),

                // Check confirm password

                Validator.isConfirmed( '#re-password', function () {
                    return document.querySelector('#userForm #loginPw').value;
                  },
                  "<spring:message code='register.input.password.confirm.message'/>"),
            ],
        });
    });
    
</script>
</body>
</html>
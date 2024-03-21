<%--
  Created by IntelliJ IDEA.
  User: dongwon
  Date: 2022-09-05
  Time: 오후 4:59
  To change this template use File | Settings | File Templates.
--%>
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
        <div id="main" class="panel panel-inverse">
            <!-- Header Page Content -->
            <div class="panel-heading panel-top">
                <h4 class="panel-title">
                    <spring:message code="admin.subtitle.token.setup.edit.title"/>
                </h4>
                <!-- RIBBON -->
                <div class="panel-heading-btn">
                    <ol class="breadcrumb float-xl-end">
                        <li class="breadcrumb-item"><spring:message code="admin.subtitle.token.management.title"/></li>
                        <li class="breadcrumb-item">
                            <a href="${_ctx}/admin/token/list">
                                <spring:message code="admin.subtitle.token.setup.title"/>
                            </a>
                        </li>
                        <li class="breadcrumb-item active">
                            <a href="javascript:window.location.reload();">
                                <spring:message code="admin.subtitle.token.setup.edit.title"/>
                            </a>
                        </li>
                    </ol>
                </div>
            </div>
            <!-- * Header Page Content -->
            <form id="tokenForm" name="tokenForm" method="POST" action="">
                <!-- Body Page Content -->
                <table style="width: 100%">

                    <tr>
                        <td colspan="2"><div class="mt-2"><b>Token</b></div></td>
                    </tr>
                    <!-- Operator -->
                    <tr>
                        <td class="dev-form-title" for="operator"><label><spring:message code="token.table.operator.title"/></label></td>
                        <td class="dev-form-content form-group input-group">
                            <select class="dev-form-input" id="operator" name="operator">
                                <option value="VIETKO" <c:if test="${token.operator == 'VIETKO'}"> selected </c:if>>Vietko</option>
                                <option value="OTHER" <c:if test="${token.operator == 'OTHER'}"> selected </c:if>>Other</option>
                            </select>
                        </td>
                    </tr>
                    <!-- * Operator -->

                    <tr>
                        <td class="dev-form-title"><label><spring:message code="token.table.symbol.title"/></label></td>
                        <td class="dev-form-content form-group ps-1">${token.symbol}</td>
                    </tr>
                    <tr>
                        <td class="dev-form-title" field="NN"><label><spring:message code="token.table.name.title"/></label></td>
                        <td class="dev-form-content form-group input-group">
                            <input type="text" name="name" class="dev-form-input" value="${token.name}" placeholder="<spring:message code="token.table.name.title"/>" maxlength="100">
                        </td>
                    </tr>
                    <tr>
                        <td class="dev-form-title" field="NN"><label><spring:message code="token.table.unit.price.title"/></label></td>
                        <td class="dev-form-content form-group input-group">
                            <input type="text" name="unitPrice" class="dev-form-input onlynum" value="${token.unitPrice}" placeholder="<spring:message code="token.table.unit.price.title"/>" maxlength="100">
                        </td>
                    </tr>

                    <!-- Use YN -->
                    <tr>
                        <td class="dev-form-title" for="useYn"><label><spring:message code="client.field.useYn.title"/></label></td>
                        <td class="dev-form-content form-group input-group">
                            <select class="dev-form-input" id="useYn" name="useYn">
                                <option value="Y" <c:if test="${token.useYn == 'Y'}"> selected </c:if>>Y</option>
                                <option value="N" <c:if test="${token.useYn == 'N'}"> selected </c:if>>N</option>
                            </select>
                        </td>
                    </tr>
                    <!-- * Use YN -->

                    <tr>
                        <td colspan="2"><div class="mt-2"><b>Account</b></div></td>
                    </tr>
                    
                    <!-- User ID -->
                    <tr>
                        <td class="dev-form-title" for="loginId"><label><spring:message code="register.input.userId"/></label></td>
                        <td class="dev-form-content form-group ps-1">${walletDTO.loginId}</td>
                    </tr>
                    <!-- * User ID -->
                    
                    <!-- Tel -->
                    <tr>
                        <td class="dev-form-title" for="tel"><label><spring:message code="register.input.phone"/></label></td>
                        <td class="dev-form-content form-group ps-1">${walletDTO.tel}</td>
                    </tr>
                    <!-- * Tel -->
                    
                    <!-- Bank Name -->
                    <tr>
                        <td class="dev-form-title" for="bankName"><label><spring:message code="register.input.bank.name.title"/></label></td>
                        <td class="dev-form-content form-group ps-1">${walletDTO.bankName}</td>
                    </tr>
                    <!-- * Bank Name -->
                    
                    <!-- Bank Owner -->
                    <tr>
                        <td class="dev-form-title" for="bankOwner"><label><spring:message code="register.input.bank.owner.title"/></label></td>
                        <td class="dev-form-content form-group ps-1">${walletDTO.bankOwner}</td>
                    </tr>
                    <!-- * Bank Owner -->
                    
                    <!-- Bank Number -->
                    <tr>
                        <td class="dev-form-title" for="bankAccount"><label><spring:message code="register.input.bank.account.title"/></label></td>
                        <td class="dev-form-content form-group ps-1">${walletDTO.bankAccount}</td>
                    </tr>
                    <!-- * Bank Number -->

                    <!-- Mail -->
                    <tr>
                        <td class="dev-form-title"><label><spring:message code="register.input.mail"/></label></td>
                        <td class="dev-form-content form-group ps-1">${walletDTO.email}</td>
                    </tr>
                    <!-- * Mail -->
                    <tr>
                        <td colspan="2" class="text-center">
                            <button type="button" class="btn btn-success" id="btn-submit"><spring:message code="common.button.submit.title"/></button>
                            <button type="button" class="btn btn-success" onclick="javascript:back();"><spring:message code="button.return.title"/></button>
                        </td>
                    </tr>
                </table>
            </form>
            <!-- * Body Page Content -->
        </div>
    </div>
</div>
<script>
    $(document).ready(function(){
        $("#btn-submit").click(function(){
            var isNull = checkFieldNotNull(null);
            if(isNull){
                alert("<spring:message code='register.input.mess.please.check.title'/>")
                return;
            }
            submitForm('#tokenForm')
        })
    })

    function back(){
        location.href="/admin/token/list";
    }
</script>
</body>
</html>
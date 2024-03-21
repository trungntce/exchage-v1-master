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
                    <spring:message code="admin.subtitle.token.setup.write.title"/>
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
                                <spring:message code="admin.subtitle.token.setup.write.title"/>
                            </a>
                        </li>
                    </ol>
                </div>
            </div>
            <!-- * Header Page Content -->

            <!-- Body Page Content -->
            <div class="panel-body">
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
                                    <option value="VIETKO">Vietko</option>
                                    <option value="OTHER">Other</option>
                                </select>
                            </td>
                        </tr>
                        <!-- * Operator -->

                        <tr>
                            <td class="dev-form-title" for="symbol" field="NN"><label><spring:message code="token.table.symbol.title"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <spring:message code="token.table.symbol.hint" var="symbolHint"/>
                                <input type="text" id="symbol" name="symbol" class="dev-form-input" placeholder="${symbolHint}" maxlength="100">
                                <span class="input-info message text-danger" for="symbol" hidden><spring:message code="token.table.symbol.message"/></span>
                                <div class="invalid-tooltip" for="symbol"><spring:message code="token.table.symbol.is.exists.message"/></div>
                            </td>
                        </tr>

                        <!-- Name -->
                        <tr>
                            <td class="dev-form-title" field="NN"><label><spring:message code="token.table.name.title"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <spring:message code="token.table.name.hint" var="nameHint"/>
                                <input type="text" name="name" class="dev-form-input" placeholder="${nameHint}" maxlength="100">
                                <span class="input-info message text-danger" for="name" hidden><spring:message code="token.table.name.message"/></span>
                            </td>
                        </tr>
                        <!-- * Name -->

                        <!-- Unit price -->
                        <tr>
                            <td class="dev-form-title" field="NN"><label><spring:message code="token.table.unit.price.title"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <spring:message code="token.table.unit.price.hint" var="symbolHint"/>
                                <input type="number" name="unitPrice" class="dev-form-input" placeholder="${symbolHint}" maxlength="100">
                                <span class="input-info message text-danger" for="symbol" hidden><spring:message code="token.table.unit.price.message"/></span>
                            </td>
                        </tr>
                        <!-- * Unit price -->

                        <tr>
                            <td colspan="2"><div class="mt-2"><b>Account</b></div></td>
                        </tr>
                        
                        <!-- User ID -->
                        <tr>
                            <td class="dev-form-title" for="loginId" field="NN"><label><spring:message code="register.input.userId"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <spring:message code="register.input.userId.hint" var="userIdHint"/>
                                <input id="loginId" name="loginId" class="dev-form-input" placeholder="${userIdHint}" maxlength="100" >
                                <span class="input-info message text-danger" hidden><spring:message code="register.input.userId.message"/></span>
                                <div class="invalid-tooltip" for="loginId"><spring:message code="register.input.userId.is.exists.message"/></div>
                            </td>
                        </tr>
                        <!-- * User ID -->

                        <!-- Password -->
                        <tr>
                            <td class="dev-form-title" for="loginPw" field="NN"><label><spring:message code="register.input.password"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <spring:message code="register.input.password.hint" var="passwordHint"/>
                                <input id="loginPw" name="loginPw" type="password" class="dev-form-input" placeholder="${passwordHint}" maxlength="100" >
                                <span class="input-info message text-danger" hidden><spring:message code="register.input.password.message"/></span>
                            </td>
                        </tr>
                        <!-- * Password -->

                        <!-- Tel -->
                        <tr>
                            <td class="dev-form-title" for="tel" field="NN"><label><spring:message code="register.input.phone"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <spring:message code="register.input.phone.hint" var="telHint"/>
                                <input id="tel" name="tel" class="dev-form-input onlynum" placeholder="${telHint}" maxlength="100" >
                                <span class="input-info message text-danger" hidden><spring:message code="register.input.phone.message"/></span>
                            </td>
                        </tr>
                        <!-- * Tel -->
                        
                        <!-- Bank Name -->
                        <tr>
                            <td class="dev-form-title" for="bankName" field="NN"><label><spring:message code="register.input.bank.name.title"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <spring:message code="register.input.bank.name.hint" var="bankNameHint"/>
                                <input id="bankName" name="bankName" class="dev-form-input" placeholder="${bankNameHint}" maxlength="100" >
                                <span class="input-info message text-danger" hidden><spring:message code="register.input.bank.name.message"/></span>
                            </td>
                        </tr>
                        <!-- * Bank Name -->
                        
                        <!-- Bank Owner -->
                        <tr>
                            <td class="dev-form-title" for="bankOwner" field="NN"><label><spring:message code="register.input.bank.owner.title"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <spring:message code="register.input.bank.owner.hint" var="bankOwnerHint"/>
                                <input id="bankOwner" name="bankOwner" class="dev-form-input" placeholder="${bankOwnerHint}" maxlength="100" >
                                <span class="input-info message text-danger" hidden><spring:message code="register.input.bank.owner.message"/></span>
                            </td>
                        </tr>
                        <!-- * Bank Owner -->
                        
                        <!-- Bank Number -->
                        <tr>
                            <td class="dev-form-title" for="bankAccount" field="NN"><label><spring:message code="register.input.bank.account.title"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <spring:message code="register.input.bank.account.hint" var="bankOccountHint"/>
                                <input id="bankAccount" name="bankAccount" class="dev-form-input onlynum" placeholder="${bankOccountHint}" maxlength="100" >
                                <span class="input-info message text-danger" hidden><spring:message code="register.input.bank.account.message"/></span>
                            </td>
                        </tr>
                        <!-- * Bank Number -->

                        <!-- Mail -->
                        <tr>
                            <td class="dev-form-title"><label><spring:message code="register.input.mail"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <spring:message code="register.input.mail.hint" var="mailHint"/>
                                <input id="email" name="email" class="dev-form-input" placeholder="${mailHint}" maxlength="100" >
                            </td>
                        </tr>
                        <!-- * Mail -->

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
            </div>
            
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

        $("#apiKey").keyup(delay(async function(e){
            
            var isExists = await client.isExists($(this).val(), "")
            if(isExists) {
                $(`.invalid-tooltip[for="apiKey"]`).addClass("d-block");  
                $("#btn-submit").addClass("disabled")
            } 
            else{
                $(`.invalid-tooltip[for="apiKey"]`).removeClass("d-block")
                $("#btn-submit").removeClass("disabled")
            }
        }, 1000))

        $("#clientCode").keyup(delay(async function(e){
            
            var isExists = await client.isExists("", $(this).val())
            if(isExists) {
                $(`.invalid-tooltip[for="clientCode"]`).addClass("d-block");  
                if ($("#btn-submit.disabled").length == 0) $("#btn-submit").addClass("disabled")
            } 
            else{
                $(`.invalid-tooltip[for="clientCode"]`).removeClass("d-block")
                if ($(`.invalid-tooltip.d-block`).length == 0) $("#btn-submit").removeClass("disabled")
            }
        }, 1000))

        $("#symbol").keyup(delay(async function(e){
            
            var isExists = await token.isExists($(this).val())
            if(isExists) {
                $(`.invalid-tooltip[for="symbol"]`).addClass("d-block");
                if ($("#btn-submit.disabled").length == 0) $("#btn-submit").addClass("disabled")
            } 
            else{
                $(`.invalid-tooltip[for="symbol"]`).removeClass("d-block")
                if ($(`.invalid-tooltip.d-block`).length == 0) $("#btn-submit").removeClass("disabled")
            }
        }, 1000))

        $("#loginId").keyup(delay(async function(e){
            
            var isExists = await user.isExists($(this).val())
            if(isExists) {
                $(`.invalid-tooltip[for="loginId"]`).addClass("d-block");
                if ($("#btn-submit.disabled").length == 0) $("#btn-submit").addClass("disabled")
            } 
            else{
                $(`.invalid-tooltip[for="loginId"]`).removeClass("d-block")
                if ($(`.invalid-tooltip.d-block`).length == 0) $("#btn-submit").removeClass("disabled")
            }
        }, 1000))
    })

    function back(){
        location.href="/admin/token/list";
    }

</script>
</body>
</html>
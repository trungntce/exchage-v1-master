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
                        <tr>
                            <td colspan="2"><div class="mt-2"><b>Client</b></div></td>
                        </tr>
                        <!-- Symbol -->
                        <tr>
                            <td class="dev-form-title" for="symbol"><label><spring:message code="client.field.symbol.title"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <select class="dev-form-input" id="symbol" name="symbol">
                                    <c:forEach items="${tokenDTOList}" var="item" varStatus="loop">
                                        <option value="${item.symbol}">${item.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>
                        <!-- * Symbol -->

                        <!-- Client Code -->
                        <tr>
                            <td class="dev-form-title" for="clientCode" field="NN"><label><spring:message code="client.field.clientCode.title"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <spring:message code="client.field.clientCode.hint" var="clientCodeHint"/>
                                <input id="clientCode" name="clientCode" class="dev-form-input" placeholder="${clientCodeHint}" maxlength="100" >
                                <span class="input-info message text-danger" hidden><spring:message code="client.field.clientCode.message"/></span>
                                <div class="invalid-tooltip" for="clientCode"><spring:message code="client.field.clientCode.is.exists.message"/></div>
                            </td>
                        </tr>
                        <!-- * Client Code -->
                        
                        <!-- API KEY -->
                        <tr>
                            <td class="dev-form-title" for="apiKey" field="NN"><label><spring:message code="client.field.apiKey.title"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <spring:message code="client.field.apiKey.hint" var="apiKeyHint"/>
                                <input id="apiKey" name="apiKey" class="dev-form-input" placeholder="${apiKeyHint}" maxlength="100" >
                                <span class="input-info message text-danger" hidden><spring:message code="client.field.apiKey.message"/></span>
                                <div class="invalid-tooltip" for="apiKey"><spring:message code="client.field.apiKey.is.exists.message"/></div>
                            </td>
                        </tr>
                        <!-- * API KEY -->
                        
                        <!-- Name -->
                        <tr>
                            <td class="dev-form-title" for="name" field="NN"><label><spring:message code="client.field.name.title"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <spring:message code="client.field.name.hint" var="nameHint"/>
                                <input id="name" name="name" class="dev-form-input" placeholder="${nameHint}" maxlength="100" >
                                <span class="input-info message text-danger" hidden><spring:message code="client.field.name.message"/></span>
                            </td>
                        </tr>
                        <!-- * Name -->
                        
                        <!-- clientTraderUseYn -->
                        <tr>
                            <td class="dev-form-title" for="clientTraderUseYn"><label><spring:message code="client.field.client.trader.title"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <select class="dev-form-input" id="clientTraderUseYn" name="clientTraderUseYn">
                                    <option value="Y">Y</option>
                                    <option value="N">N</option>
                                </select>
                            </td>
                        </tr>
                        <!-- * clientTraderUseYn -->

                        <!-- buyBenifitUseYn -->
                        <tr>
                            <td class="dev-form-title" for="buyBenifitUseYn"><label><spring:message code="client.field.buy.benifit.title"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <select class="dev-form-input" id="buyBenifitUseYn" name="buyBenifitUseYn">
                                    <option value="Y">Y</option>
                                    <option value="N">N</option>
                                </select>
                            </td>
                        </tr>
                        <!-- * buyBenifitUseYn -->
                        
                        <!-- sellBenifitUseYn -->
                        <tr>
                            <td class="dev-form-title" for="sellBenifitUseYn"><label><spring:message code="client.field.sell.benifit.title"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <select class="dev-form-input" id="sellBenifitUseYn" name="sellBenifitUseYn">
                                    <option value="Y">Y</option>
                                    <option value="N">N</option>
                                </select>
                            </td>
                        </tr>
                        <!-- * sellBenifitUseYn -->
                        
                        <!-- Use YN -->
                        <tr>
                            <td class="dev-form-title" for="useYn"><label><spring:message code="client.field.useYn.title"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <select class="dev-form-input" id="useYn" name="useYn">
                                    <option value="Y">Y</option>
                                    <option value="N">N</option>
                                </select>
                            </td>
                        </tr>
                        <!-- * Use YN -->

                        <tr>
                            <td colspan="2"><div class="mt-2"><b><spring:message code="common.admin.field.account.title"/></b></div></td>
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
                                <spring:message code="register.input.bank.account.hint" var="bankAccountHint"/>
                                <input id="bankAccount" name="bankAccount" class="dev-form-input onlynum" placeholder="${bankAccountHint}" maxlength="100" >
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
                <!-- 총 기간 별 대쉬 보드 끝 -->
            </div>
        </div>
    </div>
</div>
</body>
<script>
    $(document).ready(function(){
        $("#btn-submit").click(function(){
            var isNull = checkFieldNotNull(null);
            if(isNull){
                alert("<spring:message code='register.input.mess.please.check.title'/>")
                return;
            }
            submitForm('#clientForm')
        })

        $("#apiKey").change(async function(e){
            var isExists = await client.isExists($(this).val(), "")
            if(isExists) {
                $(`.invalid-tooltip[for="apiKey"]`).addClass("d-block");  
                $("#btn-submit").addClass("disabled")
            } 
            else{
                $(`.invalid-tooltip[for="apiKey"]`).removeClass("d-block")
                $("#btn-submit").removeClass("disabled")
            }
        })

        $("#clientCode").change(async function(e){
            var isExists = await client.isExists("", $(this).val())
            if(isExists) {
                $(`.invalid-tooltip[for="clientCode"]`).addClass("d-block");  
                if ($("#btn-submit.disabled").length == 0) $("#btn-submit").addClass("disabled")
            } 
            else{
                $(`.invalid-tooltip[for="clientCode"]`).removeClass("d-block")
                if ($(`.invalid-tooltip.d-block`).length == 0) $("#btn-submit").removeClass("disabled")
            }
        })

        $("#loginId").change(async function(e){
            
            var isExists = await user.isExists($(this).val())
            if(isExists) {
                $(`.invalid-tooltip[for="loginId"]`).addClass("d-block");
                if ($("#btn-submit.disabled").length == 0) $("#btn-submit").addClass("disabled")
            } 
            else{
                $(`.invalid-tooltip[for="loginId"]`).removeClass("d-block")
                if ($(`.invalid-tooltip.d-block`).length == 0) $("#btn-submit").removeClass("disabled")
            }
        })
    })

    function back(){
        location.href="/admin/client/list";
    }
</script>
</html>
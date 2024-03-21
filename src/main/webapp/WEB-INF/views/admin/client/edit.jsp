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

                            <td class="dev-form-title" for="symbol"><label><spring:message code="client.field.symbol.title"/></label></td>
                            <td class="dev-form-content form-group ps-1">
                                ${client.symbol}
                                <input type="hidden" name="clientId" value="${client.clientId}">
                                <input type="hidden" name="symbol" value="${client.symbol}">
                            </td>
                        </tr>
                        <!-- * Symbol -->

                        <!-- Client Code -->
                        <tr>
                            <td class="dev-form-title" for="clientCode"><label><spring:message code="client.field.clientCode.title"/></label></td>
                            <td class="dev-form-content form-group ps-1">
                                <spring:message code="client.field.clientCode.hint" var="clientCodeHint"/>
                                ${client.clientCode}
                                <input id="clientCode" name="clientCode" value="${client.clientCode}" type="hidden" class="dev-form-input" placeholder="${clientCodeHint}" maxlength="100" >
                                <span class="input-info message text-danger" hidden><spring:message code="client.field.clientCode.message"/></span>
                            </td>
                        </tr>
                        <!-- * Client Code -->
                        <!-- API KEY -->
                        <tr>
                            <td class="dev-form-title" for="apiKey"><label><spring:message code="client.field.apiKey.title"/></label></td>
                            <td class="dev-form-content form-group ps-1">
                                <spring:message code="client.field.apiKey.hint" var="apiKeyHint"/>
                                ${client.apiKey}
                                <input id="apiKey" name="apiKey" value="${client.apiKey}" type="hidden" class="dev-form-input" placeholder="${apiKeyHint}" maxlength="100" >
                                <span class="input-info message text-danger" hidden><spring:message code="client.field.apiKey.message"/></span>
                            </td>
                        </tr>
                        <!-- * API KEY -->
                        <!-- Name -->
                        <tr>
                            <td class="dev-form-title" for="name" field="NN"><label><spring:message code="client.field.name.title"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <spring:message code="client.field.name.hint" var="nameHint"/>
                                <input id="name" name="name" value="${client.name}" class="dev-form-input" placeholder="${nameHint}" maxlength="100" >
                                <span class="input-info message text-danger" hidden><spring:message code="client.field.name.message"/></span>
                            </td>
                        </tr>
                        <!-- * Name -->

                        <!-- clientTraderUseYn -->
                        <tr>
                            <td class="dev-form-title" for="clientTraderUseYn"><label><spring:message code="client.field.client.trader.title"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <select class="dev-form-input" id="clientTraderUseYn" name="clientTraderUseYn">
                                    <option value="Y" <c:if test="${client.clientTraderUseYn eq 'Y'}"> selected </c:if>>Y</option>
                                    <option value="N" <c:if test="${client.clientTraderUseYn eq 'N'}"> selected </c:if>>N</option>
                                </select>
                            </td>
                        </tr>
                        <!-- * clientTraderUseYn -->

                        <!-- buyBenifitUseYn -->
                        <tr>
                            <td class="dev-form-title" for="buyBenifitUseYn"><label><spring:message code="client.field.buy.benifit.title"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <select class="dev-form-input" id="buyBenifitUseYn" name="buyBenifitUseYn">
                                    <option value="Y" <c:if test="${client.buyBenifitUseYn eq 'Y'}"> selected </c:if>>Y</option>
                                    <option value="N" <c:if test="${client.buyBenifitUseYn eq 'N'}"> selected </c:if>>N</option>
                                </select>
                            </td>
                        </tr>
                        <!-- * buyBenifitUseYn -->
                        
                        <!-- sellBenifitUseYn -->
                        <tr>
                            <td class="dev-form-title" for="sellBenifitUseYn"><label><spring:message code="client.field.sell.benifit.title"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <select class="dev-form-input" id="sellBenifitUseYn" name="sellBenifitUseYn">
                                    <option value="Y" <c:if test="${client.sellBenifitUseYn eq 'Y'}"> selected </c:if>>Y</option>
                                    <option value="N" <c:if test="${client.sellBenifitUseYn eq 'N'}"> selected </c:if>>N</option>
                                </select>
                            </td>
                        </tr>
                        <!-- * sellBenifitUseYn -->

                        <!-- Use YN -->
                        <tr>
                            <td class="dev-form-title" for="useYn"><label><spring:message code="client.field.useYn.title"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <select class="dev-form-input" id="useYn" name="useYn">
                                    <option <c:if test="${client.useYn eq 'Y'}"> selected </c:if> value="Y">Y</option>
                                    <option <c:if test="${client.useYn eq 'N'}"> selected </c:if> value="N">N</option>
                                </select>
                            </td>
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
        }, 1500))

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
        }, 1500))
    })

    function back(){
        location.href="/admin/client/list";
    }
</script>
</html>
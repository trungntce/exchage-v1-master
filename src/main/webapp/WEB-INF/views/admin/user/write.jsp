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
                    <spring:message code="admin.subtitle.account.user.write.title"/>
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
                                <spring:message code="admin.subtitle.account.user.write.title"/>
                            </a>
                        </li>
                    </ol>
                </div>
                <!-- END RIBBON -->
            </div>

            <!-- MAIN CONTENT -->
            <div class="panel-body">
                <!-- 총 기간 별 대쉬 보드 시작 -->
                <form id="userForm" method="POST" action="">
                    <!-- Body Page Content -->
                    <table style="width: 100%">

                        <tr>
                            <td class="dev-form-title"><label><spring:message code="wallet.table.symbol.title"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <select class="dev-form-input" id="symbol" name="symbol">
                                    <c:forEach items="${tokens}" var="item" varStatus="loop">
                                        <option value="${item.symbol}">${item.symbol}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>

                        <tr>
                            <td class="dev-form-title"><label><spring:message code="wallet.table.client.id.title"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <select class="dev-form-input" id="clientCode" name="clientCode">
                                    <c:forEach items="${clients}" var="item" varStatus="loop">
                                        <option value="${item.clientCode}" data-symbol="${item.symbol}"> ${item.name}</option>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>

                        <!-- User ID -->
                        <tr>
                            <td class="dev-form-title" for="loginId" field="NN"><label><spring:message code="register.input.userId"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <spring:message code="register.input.userId.hint" var="userIdHint"/>
                                <input id="loginId" name="loginId" class="dev-form-input" placeholder="${userIdHint}" maxlength="100" >
                                <span class="form-message form-message-admin text-red"></span>
                               <!--  <span class="input-info message text-danger" hidden><spring:message code="register.input.userId.message"/></span>
                                <div class="invalid-tooltip" for="loginId"><spring:message code="register.input.userId.is.exists.message"/></div> -->
                            </td>
                        </tr>
                        <!-- * User ID -->

                        <tr>
                            <td class="dev-form-title"><label><spring:message code="wallet.table.role.title"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <select class="dev-form-input" id="role" name="role">
                                    <c:forEach items="${roles}" var="item" varStatus="loop">
                                        <c:if test="${rolePermission.indexOf(item.codeValue) != -1}">
                                        <option value="${item.codeValue}">${item.codeName}</option>
                                        </c:if>
                                    </c:forEach>
                                </select>
                            </td>
                        </tr>

                        <!-- Name -->
                        <tr>
                            <td class="dev-form-title" for="name" field="NN"><label><spring:message code="register.input.name"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <spring:message code="register.input.name.hint" var="nameHint"/>
                                <input id="name" name="name" class="dev-form-input" placeholder="${nameHint}" maxlength="100" >
                                 <span class="form-message form-message-admin text-red"></span>
                            </td>
                        </tr>
                        <!-- * Name -->

                        <!-- Password -->
                        <tr>
                            <td class="dev-form-title" for="loginPw" field="NN"><label><spring:message code="register.input.password"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <spring:message code="register.input.password.hint" var="passwordHint"/>
                                <input id="loginPw" name="loginPw" type="password" class="dev-form-input" placeholder="${passwordHint}" maxlength="100" >
                                <span class="form-message form-message-admin text-red"></span>
                            </td>
                        </tr>
                        <!-- * Password -->

                        <!-- Password Confirm -->
                        <tr>
                            <td class="dev-form-title" for="re-password" field="NN"><label><spring:message code="register.input.password.confirm"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <input id="re-password" type="password" class="dev-form-input" placeholder='<spring:message code="register.input.password.confirm.hint"/>' maxlength="100" >
                                <span class="form-message form-message-admin text-red"></span>
                            </td>
                        </tr>
                        <!-- Password Confirm -->

                        <!-- Tel -->
                        <tr>
                            <td class="dev-form-title" for="tel" field="NN"><label><spring:message code="register.input.phone"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <spring:message code="register.input.phone.hint" var="telHint"/>
                                <input type="number" id="tel" name="tel" class="dev-form-input onlynum" placeholder="${telHint}" maxlength="100" >
                               <span class="form-message form-message-admin text-red"></span>
                            </td>
                        </tr>
                        <!-- * Tel -->

                        <!-- Bank Name -->
                        <tr>
                            <td class="dev-form-title" for="bankName" field="NN"><label><spring:message code="register.input.bank.name.title"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <spring:message code="register.input.bank.name.hint" var="bankNameHint"/>
                                <input id="bankName" name="bankName" class="dev-form-input" placeholder="${bankNameHint}" maxlength="100" >
                                <span class="form-message form-message-admin text-red"></span>
                            </td>
                        </tr>
                        <!-- * Bank Name -->

                        <!-- Bank Owner -->
                        <tr>
                            <td class="dev-form-title" for="bankOwner" field="NN"><label><spring:message code="register.input.bank.owner.title"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <spring:message code="register.input.bank.owner.hint" var="bankOwnerHint"/>
                                <input id="bankOwner" name="bankOwner" class="dev-form-input" placeholder="${bankOwnerHint}" maxlength="100" >
                                 <span class="form-message form-message-admin text-red"></span>
                            </td>
                        </tr>
                        <!-- * Bank Owner -->

                        <!-- Bank Number -->
                        <tr>
                            <td class="dev-form-title" for="bankAccount" field="NN"><label><spring:message code="register.input.bank.account.title"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <spring:message code="register.input.bank.account.hint" var="bankOccountHint"/>
                                <input type="number" id="bankAccount" name="bankAccount" class="dev-form-input onlynum" placeholder="${bankOccountHint}" maxlength="100" >
                                <span class="form-message form-message-admin text-red"></span>
                            </td>
                        </tr>
                        <!-- * Bank Number -->

                        <!-- Mail -->
                        <tr>
                            <td class="dev-form-title"><label><spring:message code="register.input.mail"/></label></td>
                            <td class="dev-form-content form-group input-group">
                                <spring:message code="register.input.mail.hint" var="mailHint"/>
                                <input id="mail" name="mail" class="dev-form-input" placeholder="${mailHint}" maxlength="100" >
                                <span class="form-message form-message-admin text-red"></span>
                            </td>
                        </tr>
                        <!-- * Mail -->
                        <tr>
                            <td colspan="2" class="text-center">
                                <div class="mt-2">
                                    <button type="submit" class="btn btn-success" id="btn-submit"><spring:message code="button.add.title"/></button>
                                    <button type="button" class="btn btn-success" onclick="javascript:back();"><spring:message code="button.cancle.title"/></button>
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
        $(`#userForm [name="symbol"]`).change()
    })

    init();
    function init(){
        console.log("Start")
        $(`#userForm [name="symbol"]`).find("option").each(function(){
            if($(`#userForm [data-symbol="`+$(this).val()+`"]`).length == 0){
                $(this).remove();
            }
        })
    }

    $(`#userForm [name="symbol"]`).change(function(){
        var symbol = $(this).find("option:selected").val();
        $(`#userForm [name="clientCode"]`).find("option").addClass("d-none");
        $(`#userForm [name="clientCode"]`).find(`option[data-symbol="`+symbol+`"]`).removeClass("d-none");
        $(`#userForm [name="clientCode"]`).val($(`#userForm [name="clientCode"]`).find(`option[data-symbol="`+symbol+`"]:eq(0)`).val())
    })

    function back(){
        location.href=window.location.origin+"/admin/user/list";
    }
    //form input validate
    document.addEventListener('DOMContentLoaded', function () {
        //valid input
        Validator({
            form: '#userForm',
            formGroupSelector: '.form-group',
            errorSelector: '.form-message',
            rules: [

                // Check null
                Validator.isRequired('#loginId', "<spring:message code='the.input.not.valid'/>"),
                Validator.isRequired('#name', "<spring:message code='the.input.not.valid'/>"),
                Validator.isRequired('#loginPw', "<spring:message code='the.input.not.valid'/>"),
                Validator.isRequired('#re-password', "<spring:message code='the.input.not.valid'/>"),
                Validator.isRequired('#tel', "<spring:message code='the.input.not.valid'/>"),
                Validator.isRequired('#bankName', "<spring:message code='the.input.not.valid'/>"),
                Validator.isRequired('#bankOwner', "<spring:message code='the.input.not.valid'/>"),
                Validator.isRequired('#bankAccount', "<spring:message code='the.input.not.valid'/>"),

                // Check minimum input
                Validator.minLength('#loginId', 3, "<spring:message code='login.minimum.length'/>"),
                Validator.minLength('#name', 3, "<spring:message code='login.minimum.length'/>"),
                Validator.minLength('#loginPw', 3, "<spring:message code='login.minimum.length'/>"),
                Validator.minLength('#re-password', 3, "<spring:message code='login.minimum.length'/>"),
                Validator.minLength('#tel', 3, "<spring:message code='login.minimum.length'/>"),
                Validator.minLength('#bankName', 3, "<spring:message code='login.minimum.length'/>"),
                Validator.minLength('#bankOwner', 3, "<spring:message code='login.minimum.length'/>"),
                Validator.minLength('#bankAccount', 3, "<spring:message code='login.minimum.length'/>"),
                // Check maximum
                Validator.maxLength('#loginId', 32, "<spring:message code='login.maximum.length'/>"),
                Validator.maxLength('#name', 32, "<spring:message code='login.maximum.length'/>"),
                Validator.maxLength('#loginPw', 32, "<spring:message code='login.maximum.length'/>"),
                Validator.maxLength('#re-password', 32, "<spring:message code='login.maximum.length'/>"),
                Validator.maxLength('#tel', 32, "<spring:message code='login.maximum.length'/>"),
                Validator.maxLength('#bankName', 32, "<spring:message code='login.maximum.length'/>"),
                Validator.maxLength('#bankOwner', 32, "<spring:message code='login.maximum.length'/>"),
                Validator.maxLength('#bankAccount', 32, "<spring:message code='login.maximum.length'/>"),

                // Validator regexPattern
                Validator.isRegexPattern('#loginId', "<spring:message code='the.input.not.valid'/>"),
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
</html>
<%--
  Created by IntelliJ IDEA.
  User: ntt.dev
  The page register for wallet
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- head -->
<%@ include file="/WEB-INF/layout/web/head.jsp"%>


<!-- Main -->
<section class="wrap join-wrap">
      <%@ include file="/WEB-INF/layout/web/header.jsp"%>
    <div class="container">

        <div class="container-join">
            <div class="container-title">
                <h2><spring:message code="register.logo.title"/></h2>
            </div>

            <div class="container-login-box">
                <form:form modelAttribute="registerWalletForm" method="POST">
                    <!-- Name -->
                    <div class="form-wrap form-full">
                        <label field="NN"></label>
                        <spring:message code="register.input.name.hint" var="nameHint"/>
                        <form:input path="name" onkeyup="javascript:validatorInput(this)" placeholder="${nameHint}" type="text" maxlength="32" />
                        <label for="name" class="input-label-error"><spring:message code="register.input.name.message"/></label>
                    </div>
                    <!-- * Name -->

                    <!-- Password -->
                    <div class="form-wrap form-full">
                        <label field="NN"></label>
                        <spring:message code="register.input.password.hint" var="passwordHint"/>
                        <form:input path="password" onkeyup="javascript:validatorInput(this)" placeholder="${passwordHint}" type="password" maxlength="32" />
                        <label for="password" class="input-label-error"><spring:message code="register.input.password.message"/></label>
                    </div>
                    <!-- * Password -->

                    <!-- Re-Password -->
                    <div class="form-wrap form-full">
                        <label field="NN"></label>
                        <spring:message code="register.input.password.confirm.hint" var="userRePwHint"/>
                        <input id="re-password" onkeyup="javascript:validatorInput(this)" placeholder="${userRePwHint}" type="password" maxlength="32" />
                        <label for="re-password" class="input-label-error"><spring:message code="register.input.password.confirm.message"/></label>
                    </div>
                    <!-- * Re-Password -->

                    <!-- Bank Name -->
                    <div class="form-wrap form-full">
                        <label field="NN"></label>
                        <spring:message code="register.input.bank.name.hint" var="bankNameHint"/>
                        <form:input path="bankName" onkeyup="javascript:validatorInput(this)" placeholder="${bankNameHint}" type="text" maxlength="32" />
                        <label for="bankName" class="input-label-error"><spring:message code="register.input.bank.name.message"/></label>
                    </div>
                    <!-- * Bank Name -->

                    <!-- Bank Owner -->
                    <div class="form-wrap form-full">
                        <label field="NN"></label>
                        <spring:message code="register.input.bank.owner.hint" var="bankOwnerHint"/>
                        <form:input path="bankOwner" onkeyup="javascript:validatorInput(this)" placeholder="${bankOwnerHint}" type="text" maxlength="32" />
                        <label for="bankOwner" class="input-label-error"><spring:message code="register.input.bank.owner.message"/></label>
                    </div>
                    <!-- * Bank Owner -->

                    <!-- Bank Account -->
                    <div class="form-wrap form-full">
                        <label field="NN"></label>
                        <spring:message code="register.input.bank.account.hint" var="bankAccountHint"/>
                        <form:input path="bankAccount" onkeyup="javascript:validatorInput(this)" placeholder="${bankAccountHint}" type="text" maxlength="32" />
                        <label for="bankAccount" class="input-label-error"><spring:message code="register.input.bank.account.message"/></label>
                    </div>
                    <!-- * Bank Account -->
                    <!-- Tel -->
                    <div class="form-wrap form-full">
                        <label field="NN"></label>
                        <spring:message code="register.input.phone.hint" var="telHint"/>
                        <form:input path="tel" onkeyup="javascript:validatorInput(this)" placeholder="${telHint}" type="text" maxlength="32" cssClass="onlynum"/>
                        <label for="tel" class="input-label-error"><spring:message code="register.input.phone.message"/></label>
                    </div>
                    <!-- * Tel -->

                    <!-- Mail -->
                    <div class="form-wrap form-full">
                        <spring:message code="register.input.mail.hint" var="mailHint"/>
                        <form:input path="mail" placeholder="${mailHint}" type="text" maxlength="32" />
                    </div>
                    <!-- * Mail -->

                </form:form>

                <div class="box-hr">
                    <div class="box-hr-txt">이용 약관</div>
                </div>

                <div class="join-terms">
                    <div class="title"><spring:message code="register.using.term.title"/><input type="checkbox" id="cb-term-all"></div>
                    <div class="agree"><span onclick="javascript:showModal('.modal-term-1');"><spring:message code="register.using.agreement.important.title"/></span><input type="checkbox" class="cb-term"></div>
                    <div class="agree"><span onclick="javascript:showModal('.modal-term-2');"><spring:message code="register.using.personal.info.agreement.important.title"/></span><input type="checkbox" class="cb-term"></div>
                </div>

                <div class="start-login">
                    <div class="btn btn-primary btn-register" onclick="javascript:registerSubmit()" style="pointer-events: none; background-color: #6a4d78"><spring:message code="common.button.submit.title"/></div>
                    <div class="btn secondary" redirect="${_ctx}/login"><spring:message code="common.button.login.title"/></div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- * Main -->
<!-- footer -->
    <%@ include file="/WEB-INF/layout/web/footer.jsp"%>
<!-- * footer -->
<script>
    $("#cb-term-all").change(function(){
        $(".cb-term").prop('checked', $(this).prop("checked"));
        if($(this).is(":checked")){
            $(".btn-register").css({"pointer-events": "unset", "background-color": "#b17acc"});
        }else{
            $(".btn-register").css({"pointer-events": "none", "background-color": "#6a4d78"});
        }
    })

    $(".cb-term").change(function(){
        var c = $(".cb-term:not(:checked)").length;
        if(c !== 0){
            $("#cb-term-all").prop('checked', false);
            $(".btn-register").css({"pointer-events": "none", "background-color": "#6a4d78"});
        }else{
            $("#cb-term-all").prop('checked', true);
            $(".btn-register").css({"pointer-events": "unset", "background-color": "#b17acc"});
        }
    })

    function validatorInput(obj){
        var val = obj.value;
        if(val.trim().length > 0){
            obj.parentNode.querySelector(".input-label-error").classList.remove("show");
        }else{
            obj.parentNode.querySelector(".input-label-error").classList.add("show");
        }
    }

    function registerSubmit(){
        var target = "#registerWalletForm";
        console.log(target);
        //Check value in field input
        var p1 = $("#password").val();
        var p2 = $("#re-password").val();
        if(p1 != p2){
             console.log(p1);
             console.log(p2);
            $("#re-password").parent().parent().find(".message").removeAttr("hidden")
            return;
        }
        var isNN = checkFieldNotNull(target, true);
        if(isNN){
            console.log(isNN);
            return;
        }
        $(target).submit();
    }
</script>
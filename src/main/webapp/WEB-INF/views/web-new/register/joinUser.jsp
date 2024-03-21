<%--
  Created by IntelliJ IDEA.
  User: ntt.dev
  The join user page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- head -->
<%@ include file="/WEB-INF/layout/web-new/include/head.jsp"%>
  <body class="pace-done">
    <div class="wrapper">   
      <!-- header -->
        <%@ include file="/WEB-INF/layout/web-new/include/header.jsp"%>
      <!-- #header -->

      <!-- body -->
        <section class="container">

        <article class="join-wrap">
          <div class="article-inner">
            <div class="join__head">
              <h1><spring:message code="register.logo.title"/></h1>
            </div>
            <!-- FORM -->
            <form id="joinUserForm" method="POST" action="">
              <div class="join__cont">
                <dl>
                  <dt><spring:message code="register.user.information"/></dt>
                  <dd>                  
                      <!-- LOGIN ID -->
                      <div class="mb-4 form-group">
                        <label class="form-label required-label"><spring:message code="register.input.userId"/></label>
                        <input id="loginId" name="loginId" type="text" maxlength="32" class="form-control" pattern="[a-z0-9]{2,}$"
                         placeholder="<spring:message code='register.input.userId.hint'/>">
                        <!-- <div class="form-text text-red">We'll never share your email with anyone else.</div> -->
                        <span class="form-message form-text text-red"></span>   
                      </div>
                      <!-- #LOGIN ID -->

                      <!-- NAME -->
                      <div class="mb-4 form-group">
                        <label class="form-label required-label"><spring:message code="register.input.name"/></label>
                        <input type="text" id="name" name="name" maxlength="32" class="form-control" placeholder="<spring:message code='register.input.name.hint'/>">
                        <span class="form-message form-text text-red"></span>   
                      </div>
                      <!-- #NAME -->

                      <!-- PASSWORD -->
                      <div class="mb-4 form-group">
                        <label class="form-label required-label"><spring:message code="register.input.password"/></label>
                        <input type="password" id="loginPw" name="loginPw" maxlength="32" class="form-control" placeholder="<spring:message code='register.input.password.hint'/>">
                        <span class="form-message form-text text-red"></span>   
                      </div>
                      <!-- #PASSWORD -->

                      <!-- PASSWORD CONFIRM -->
                      <div class="mb-4 form-group">
                        <label class="form-label required-label"><spring:message code="register.input.password.confirm"/></label>
                        <input type="password" id="passwordConfirm" name="passwordConfirm" maxlength="32" class="form-control" placeholder="<spring:message code='register.input.password.confirm.hint'/>">
                        <span class="form-message form-text text-red"></span>   
                      </div>
                      <!-- #PASSWORD CONFIRM -->

                      <!-- PHONE -->
                      <div class="mb-4 form-group">
                        <label class="form-label required-label"><spring:message code="register.input.phone"/></label>
                        <input type="number" id="tel" name="tel"  maxlength="32" class="form-control" placeholder="<spring:message code='register.input.phone.hint'/>">
                        <span class="form-message form-text text-red"></span>   
                      </div>
                      <!-- #PHONE -->

                      <!-- BANK NAME -->
                      <div class="mb-4 form-group">
                        <label class="form-label required-label"><spring:message code="register.input.bank.name.title"/></label>
                        <input type="text" id="bankName" name="bankName" maxlength="32" class="form-control" placeholder="<spring:message code='register.input.bank.name.hint'/>">
                        <span class="form-message form-text text-red"></span>   
                      </div> 
                      <!-- #BANK NAME -->

                      <!-- BANK OWNER -->
                      <div class="mb-4 form-group">
                        <label class="form-label required-label"><spring:message code="register.input.bank.owner.title"/></label>
                        <input type="text" id="bankOwner" name="bankOwner" maxlength="32" class="form-control" placeholder="<spring:message code='register.input.bank.owner.hint'/>">
                        <span class="form-message form-text text-red"></span>   
                      </div>
                      <!-- #BANK OWNER -->

                      <!-- BANK ACCOUNT -->
                      <div class="mb-4 form-group">
                        <label class="form-label required-label"><spring:message code="register.input.bank.account.title"/></label>
                        <input type="number" id="bankAccount" name="bankAccount" maxlength="32" class="form-control" placeholder="<spring:message code='register.input.bank.name.hint'/>">
                        <span class="form-message form-text text-red"></span>   
                      </div>     
                     <!-- #BANK ACCOUNT -->                 
                  </dd>
                </dl>
                <dl>
                  <dt><spring:message code='register.using.term.service.title'/></dt>
                  <dd>
                    <div class="mb-3 form-check form-group">
                      <input type="checkbox" class="form-check-input cb-term-all" id="exampleCheck1">
                      <label class="form-check-label" for="exampleCheck1"><b><strong class="text-primary"><spring:message code="register.using.full.consent"/></strong></b></label>
                    </div>
                  </dd>
                  <dd>
                    <div class="mb-3 form-check">
                      <input type="checkbox" class="form-check-input cb-term" id="exampleCheck2">
                      <label class="form-check-label" for="exampleCheck2"><b><strong class="text-primary"><spring:message code="register.using.agreement.important.title"/></strong></b>
                      </label>
                      <span class="form-message form-text text-red"></span>   
                    </div>
                    <div class="term-content">
                      <h3><spring:message code="join.term.content1"/></h3>
                      <h4><spring:message code="join.term.content2"/></h4>
                      <p><spring:message code="join.term.content3"/></p>
                      <p><spring:message code="join.term.content4"/></p>
                      <p><spring:message code="join.term.content5"/></p>
                      <p><spring:message code="join.term.content6"/></p>
                      <p><spring:message code="join.term.content7"/></p>
                      <p><spring:message code="join.term.content8"/></p>
                      <p><spring:message code="join.term.content9"/></p>
                      <p><spring:message code="join.term.content10"/></p>
                      <p><spring:message code="join.term.content11"/></p>
                      <p><spring:message code="join.term.content12"/></p>
                      <p><spring:message code="join.term.content13"/></p>
                      <p><spring:message code="join.term.content14"/></p>
                      <p><spring:message code="join.term.content15"/></p>
                    </div>
                  </dd>
                  <dd>
                    <div class="mt-4 mb-3 form-check">
                      <input type="checkbox" class="form-check-input cb-term" id="exampleCheck3">
                      <label class="form-check-label" for="exampleCheck3"><b><strong class="text-primary"><spring:message code="register.using.personal.info.agreement.important.title"/></strong></b></label>
                    </div>
                    <div class="term-content">
                      <h3><spring:message code="join.term.content16"/></h3>
                      <p><spring:message code="join.term.content17"/></p>
                    </div>
                  </dd>
                </dl>
                <button type="submit" class="btn btn-primary is-full-width mb-3 btn-lg btn-register" style="pointer-events: none; background-color: #6a4d78"><spring:message code="common.button.submit.title"/></button>
                <button class="btn btn-secondary is-full-width btn-lg" redirect="${_ctx}/login"><spring:message code="common.button.login.title"/></button>
              </div>
          </form>
          <!-- #FORM -->
          </div>
        </article>
      </section>
    </div>
    <!-- #body -->     
  <!-- footer -->
  <%@ include file="/WEB-INF/layout/web-new/include/footer.jsp"%>
  <!-- #footer -->
  </body>

  <script type="text/javascript">
    //form input validate
    document.addEventListener('DOMContentLoaded', function () {
        //valid input
        Validator({
            form: '#joinUserForm',
            formGroupSelector: '.form-group',
            errorSelector: '.form-message',
            rules: [
                // Check null
                Validator.isRequired('#loginId', "<spring:message code='the.input.not.valid'/>"),
                Validator.isRequired('#name', "<spring:message code='the.input.not.valid'/>"),
                Validator.isRequired('#loginPw', "<spring:message code='the.input.not.valid'/>"),
                Validator.isRequired('#passwordConfirm', "<spring:message code='the.input.not.valid'/>"),
                Validator.isRequired('#tel', "<spring:message code='the.input.not.valid'/>"),
                Validator.isRequired('#bankName', "<spring:message code='the.input.not.valid'/>"),
                Validator.isRequired('#bankOwner', "<spring:message code='the.input.not.valid'/>"),
                Validator.isRequired('#bankAccount', "<spring:message code='the.input.not.valid'/>"),                
                // Check minimum input
                Validator.minLength('#loginId', 3, "<spring:message code='login.minimum.length'/>"),
                Validator.minLength('#name', 3, "<spring:message code='login.minimum.length'/>"),
                Validator.minLength('#loginPw', 3, "<spring:message code='login.minimum.length'/>"),
                Validator.minLength('#passwordConfirm', 3, "<spring:message code='login.minimum.length'/>"),
                Validator.minLength('#tel', 3, "<spring:message code='login.minimum.length'/>"),
                Validator.minLength('#bankName', 3, "<spring:message code='login.minimum.length'/>"),
                Validator.minLength('#bankOwner', 3, "<spring:message code='login.minimum.length'/>"),
                Validator.minLength('#bankAccount', 3, "<spring:message code='login.minimum.length'/>"),
                // Check maximum
                Validator.maxLength('#name', 32, "<spring:message code='login.maximum.length'/>"),
                Validator.maxLength('#loginPw', 32, "<spring:message code='login.maximum.length'/>"),
                Validator.maxLength('#passwordConfirm', 32, "<spring:message code='login.maximum.length'/>"),
                Validator.maxLength('#tel', 32, "<spring:message code='login.maximum.length'/>"),
                Validator.maxLength('#bankName', 32, "<spring:message code='login.maximum.length'/>"),
                Validator.maxLength('#bankOwner', 32, "<spring:message code='login.maximum.length'/>"),
                Validator.maxLength('#bankAccount', 32, "<spring:message code='login.maximum.length'/>"),

                // Validator regexPattern
                Validator.isRegexPattern('#loginId', "<spring:message code='the.input.not.valid'/>"),
                // Validator.isRegexPattern('#name', "<spring:message code='the.input.not.valid'/>"),
                Validator.isRegexPhoneNumber('#tel', "<spring:message code='the.input.not.valid'/>"),
                // Validator.isRegexPattern('#bankName', "<spring:message code='the.input.not.valid'/>"),
                // Validator.isRegexPattern('#bankOwner', "<spring:message code='the.input.not.valid'/>"),
                // Validator.isRegexPattern('#bankAccount', "<spring:message code='the.input.not.valid'/>"),

                Validator.isRegexPassword('#loginPw', "<spring:message code='login.password.type.message'/>"),

                // Check confirm password
                Validator.isConfirmed( '#passwordConfirm', function () {
                    return document.querySelector('#joinUserForm #loginPw').value;
                  }, 
                  "<spring:message code='register.input.password.confirm.message'/>"),                
            ],
        });
    });  
    $(".cb-term-all").change(function(){
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
            $(".cb-term-all").prop('checked', false);
            $(".btn-register").css({"pointer-events": "none", "background-color": "#6a4d78"});
        }else{
            $(".cb-term-all").prop('checked', true);
            $(".btn-register").css({"pointer-events": "unset", "background-color": "#b17acc"});
        }
    })
   
  </script>
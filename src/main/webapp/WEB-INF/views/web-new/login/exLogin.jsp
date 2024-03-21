<%--
  Created by IntelliJ IDEA.
  User: ntt.dev
  The login page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- head -->
<%@ include file="/WEB-INF/layout/web-new/include/head.jsp"%>
<!-- #head -->
  <body class="pace-done">
    <div class="wrapper">
      <!-- body -->
      <section class="container">
        <!-- Login form -->
        <form method="POST" id = "login-form" action="${_ctx}/security/login">          
          <article class="login-wrap">
            <div class="article-inner">
              <div class="login__head">
                <h1><spring:message code="login.page.title"/></h1>
                <p><spring:message code="login.page.content"/></p>
              </div>
                <div class="tabs">
                  <ul>
                     <c:forEach items="${loginTypeList}" var="loginType" varStatus="loop">
                        <c:if test="${loop.index == 0}">
                          <li class="is-current" dev_loginType="${loginType.codeValue}"><a><spring:message code="login.tab.title.${loginType.codeValue}"/></a></li>
                          <input type="text" name="loginType" id="loginType" value="${loginType.codeValue}" hidden>
                        </c:if>
                        <c:if test="${loop.index > 0}">
                          <li class="" dev_loginType="${loginType.codeValue}"><a><spring:message code="login.tab.title.${loginType.codeValue}"/></a></li>
                        </c:if>
                      </c:forEach>
                  </ul>
                </div>
                <div class="tabs-contentbox">
                  <div class="tabs-content is-current">
                    <div class="mb-4 form-group">
                      <label class="form-label" for="username"><spring:message code="login.input.userid.title"/></label>
                      <input type="text" name="loginId" id="loginId" class="form-control mb-3" maxlength="100" placeholder="<spring:message code='login.input.information.here'/>">
                      <span class="form-message"></span>
                    </div>
                    <div class="mb-4 form-group">
                      <label class="form-label" for="password"><spring:message code="login.input.password.title"/></label>
                      <input type="password" name="loginPw" id="loginPw" class="form-control mb-3" maxlength="32" placeholder="<spring:message code='login.input.password.here'/>">
                      <span class="form-message"></span>
                    </div>
                    
                    <button type="submit" class="btn btn-primary is-full-width mb-5 btn-lg"><spring:message code="common.button.login.title"/></button>

                  </div>
                  
                   <c:if test="${not empty mess}">
                      <script>    
                          alert('<c:out value="${mess}" />');
                      </script>
                  </c:if>
              <script>
                $(document).ready(function(){                 
                    window.close();
                  $('.tabs > ul > li').eq(0).addClass( "is-current" );
                  $('.tabs-contentbox > div').eq(0).addClass( "is-current" );
                  $('.tabs > ul').on('click','li',function(){
                    var aElement = $('.tabs > ul > li');
                    var divContent = $('.tabs-contentbox > div');

                    aElement.removeClass( "is-current");
                    $(this).addClass( "is-current");

                    // var clicked_index = aElement.index(this);
                    // divContent.css('display','none');
                    // divContent.eq(clicked_index).css('display','block');
                    $(this).blur();

                    //Dev set loginType
                    let tagetType = this.getAttribute('dev_loginType');
                    $('#loginType').val(tagetType);
                    if(tagetType == '1'){
                          $("label[for=username]").text("<spring:message code="login.input.wallet.address.title"/>");
                          $("label[for=password]").text("<spring:message code="login.input.wallet.password.title"/>");
                      } else {
                          $("label[for=username]").text("<spring:message code="login.input.userid.title"/>");
                          $("label[for=password]").text("<spring:message code="login.input.password.title"/>");
                      }
                    return false;
                  });
                });

                //form input validate
                document.addEventListener('DOMContentLoaded', function () {
                    //valid input
                    Validator({
                        form: '#login-form',
                        formGroupSelector: '.form-group',
                        errorSelector: '.form-message',
                        rules: [
                            Validator.isRequired('#loginId', "<spring:message code='the.input.not.valid'/>"),
                            Validator.minLength('#loginId', 3, "<spring:message code='login.minimum.length'/>"),
                            Validator.maxLength('#loginId', 100, "<spring:message code='login.maximum.wallet.length'/>"),
                            Validator.isRequired('#loginPw', "<spring:message code='the.password.input.not.valid'/>"),
                            Validator.maxLength('#loginPw', 30, "<spring:message code='login.maximum.length'/>"),
                            Validator.minLength('#loginPw', 3, "<spring:message code='login.minimum.length'/>"),
                        ],
                    });
                });               
              
                 $(".bnt-close").click(function(){
                      window.close();
                  })

              </script>
            </div>
          </article>
        </form>
        <!-- #body -->
      </section>
    </div>

  </body>



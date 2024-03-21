<%--
  Created by IntelliJ IDEA.
  User: ntt.dev
  The login page
--%>
<!-- head -->
<%@ include file="/WEB-INF/layout/web/head.jsp"%>
<body class="banner-app-view">
    <!-- header -->
    <%@ include file="/WEB-INF/layout/web/header.jsp"%>
    <!-- Main -->
    <section class="wrap login-wrap">
        <div class="container">
            <div class="container-login">
                <div class="container-title">
                    <h2><spring:message code="login.page.title"/></h2>
                    <p><spring:message code="login.page.content"/></p>
                </div>

                <img src="${baseUrl}/resources/skin/dist/img_login_title.png" class="login-img">
                <div class="container-login-box">
                    <!-- Login form -->
                    <form:form method="POST" id = "login-form" action="${_ctx}/security/login">   
                        <div class="box-selector login-box-selector">
                            <c:forEach items="${loginTypeList}" var="loginType">                          
                                <input type="radio" id="rd-${loginType.codeValue}" tab-target="#target-form" name="loginType" value="${loginType.codeValue}" checked>
                                <label target="#rd-${loginType.codeValue}" for="login-selector" onclick="javascript:changeTab(this)"><spring:message code="login.tab.title.${loginType.codeValue}"/></label>
                            </c:forEach>                 
                        </div>
                        <!-- User Address -->
                        <div class="form-wrap form-full form-group">
                            <label for="username" class="input-label" field="NN"><spring:message code="login.input.userid.title"/></label>
                            <spring:message code="login.input.information.here" var="useridHint"/>
                            <input placeholder="${useridHint}" id="username" name="loginId" type="text" maxlength="100"/>
                            <span class="form-message"></span>                        
                        </div>
                        <!-- * User address -->

                        <!-- User password -->
                        <div class="form-wrap form-full form-group">
                            <label for="password" class="input-label" field="NN"><spring:message code="login.input.password.title"/></label>
                            <spring:message code="login.input.password.here" var="userPwHint"/>
                            <input path="password" placeholder="${userPwHint}" id="password" name="loginPw" type="password" maxlength="32"/>
                            <span class="form-message"></span>                        
                        </div>
                        <!-- * User password -->
                    </form:form>
                    <!-- * User login -->

                    <div class="start-login">
                        <div class="btn btn-primary" onclick="javascript:login()"><spring:message code="common.button.login.title"/></div>
                    </div>

                    <div class="box-hr">
                        <div class="box-hr-txt"><spring:message code="login.remember.wallet.account"/></div>
                    </div>

                    <div class="start-login-join">
                        <div class="btn btn-secondary" redirect="${baseUrl}/registerWallet"><spring:message code="common.button.register.wallet.title"/></div>
                        <div class="btn btn-secondary" redirect="${baseUrl}/registerUser"><spring:message code="common.button.register.user.title"/></div>
                    </div>

                </div>
            </div>
        </div>
    </section>
    <!-- * Main -->
</body>
<!-- footer -->
    <%@ include file="/WEB-INF/layout/web/footer.jsp"%> 
<!-- * footer -->

<script>
    init();    
    function init(){

     // Get urlParams
     const queryString = window.location.search;
     const urlParams = new URLSearchParams(queryString);
     switch(urlParams.get('error')){
                   case "1":
                       alert("<spring:message code='login.message.fail.wallet.not.exist'/>");
                       break;                  
                   case "2":
                       alert("<spring:message code='login.message.fail.user.not.exist'/>");
                       break;    
                   case "3":
                        alert("<spring:message code='login.message.fail.unauthorized.access'/>");
                   break;                  
       }
    }
    
    /**
     * @FunctionName: Change tab when change type login
     * */  
    function changeTab(obj){
      var target = obj.getAttribute("target");
        $(target).prop("checked", true);
         if(target == '#rd-1'){
            $("label[for=username]").text("<spring:message code="login.input.wallet.address.title"/>");
            $("label[for=password]").text("<spring:message code="login.input.wallet.password.title"/>");
        } else {
            $("label[for=username]").text("<spring:message code="login.input.userid.title"/>");
            $("label[for=password]").text("<spring:message code="login.input.password.title"/>");
        }

        
    }
     //form input validate
    document.addEventListener('DOMContentLoaded', function () {
        //valid input
        Validator({
            form: '#login-form',
            formGroupSelector: '.form-group',
            errorSelector: '.form-message',
            rules: [
                Validator.isRequired('#username', "<spring:message code='the.input.not.valid'/>"),
                Validator.minLength('#username', 3, "<spring:message code='login.minimum.length'/>"),
                Validator.isRequired('#password', "<spring:message code='the.password.input.not.valid'/>"),
                Validator.minLength('#password', 3, "<spring:message code='login.minimum.length'/>"),
            ],
        });
    });     
     

    function login(){       
        $('#login-form').submit();
    }

</script>
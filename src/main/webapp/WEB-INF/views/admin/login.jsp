<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/layout/common/tags/commonTags.jspf"%>
<!DOCTYPE html>
<html>
<%@ include file="/WEB-INF/layout/admin/head.jsp"%>
<body>
<!-- BEGIN #app -->
<%@ include file="/WEB-INF/layout/admin/loader.jsp"%>
<div id="app" class="app">
    <!-- BEGIN login -->
    <div class="login login-v1">
        <!-- BEGIN login-container -->
        <div class="login-container">
            <!-- BEGIN login-header -->
            <div class="login-header">
                <div class="brand">
                    <div class="d-flex align-items-center">
                        <span class="logo"></span> <b><spring:message code="login.title"/></b> <spring:message code="login.sub.title"/>
                    </div>
                    <small><spring:message code="lgoin.sub.description.title"/></small>
                </div>
            </div>
            <!-- END login-header -->

            <!-- BEGIN login-body -->
            <form action="${_ctx}/security/login" method="post">
                <div class="login-body">
                    <!-- BEGIN login-content -->
                    <div class="login-content mb-10px">
                        <c:forEach items="${loginTypeList}" var="loginType" varStatus="type">
                            <input type="radio" id="login-type-${loginType.codeValue}" name="loginType" value="${loginType.codeValue}" onclick="javascript:changeLoginType('${loginType.codeValue}');">
                            <label for="login-type-${loginType.codeValue}">${loginType.codeName}</label>
                        </c:forEach>
                    </div>
                    <div class="login-content fs-13px ">
                        <div class="form-floating mb-20px">
                            <spring:message code="login.input.user.id.hint" var="walletAddressHint"/>
                            <input type="text" name="loginId" class="form-control fs-13px h-45px" placeholder="${walletAddressHint}">
                            <label for="loginId" class="d-flex align-items-center py-0"><spring:message code="login.input.user.id.title"/></label>
                        </div>
                        <div class="form-floating mb-20px">
                            <spring:message code="login.input.user.password.hint" var="walletPasswordHint"/>
                            <input type="password" name="loginPw" class="form-control fs-13px h-45px" placeholder="${walletPasswordHint}">
                            <label for="loginPw" class="d-flex align-items-center py-0"><spring:message code="login.input.user.password.title"/></label>
                        </div>
                        <div class="login-buttons">
                            <button class="btn h-45px btn-success d-block w-100 btn-lg" id="loginBtn"><spring:message code="button.login.title"/></button>
                        </div>
                        <div class="mt-10px text-center">
                            <div class="flag-icon flag-icon-lr h1 rounded mb-0 hand lang-item" onclick="languageChange('en_US')"></div>
                            <div class="flag-icon flag-icon-kr h1 rounded mb-0 hand lang-item" onclick="languageChange('ko_KR')"></div>
                        </div>
                    </div>
                    <!-- END login-content -->
                </div>
            </form>
            <!-- END login-body -->
        </div>
        <!-- END login-container -->
    </div>
    <!-- END login -->
</div>
<!-- END #app -->
<script>
    var headerJs = {
        getError: function(){
            const urlParams = new URLSearchParams((window.location.search));
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
    }

    $(function(){
        $("input[name=loginType]").eq(0).attr("checked", true);
        headerJs.getError();
    });
    function changeLoginType(loginType){
        if(loginType == 1){
            $("label[for=loginId]").text("<spring:message code="login.input.wallet.address.hint"/>");
            $("label[for=loginPw]").text("<spring:message code="login.input.wallet.password.hint"/>");
        } else {
            $("label[for=loginId]").text("<spring:message code="login.input.user.id.hint"/>");
            $("label[for=loginPw]").text("<spring:message code="login.input.user.password.hint"/>");
        }
    }
    function languageChange(lang){
        location.href=window.location.origin+window.location.pathname+"?langCode="+lang;
    }
</script>
</body>
</html>


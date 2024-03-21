<%--
  Created by IntelliJ IDEA.
  User: ntt.dev
  The page show information when register successful for user
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- head -->
<%@ include file="/WEB-INF/layout/web-new/include/head.jsp"%>
<!-- #head -->

<!-- Main -->
<body class="pace-done">
    <div class="wrapper">
        <!-- header -->
        <%@ include file="/WEB-INF/layout/web-new/include/header.jsp"%>
        <!-- #header -->
        
        <div class="container">
            <div class="container-join">
                <div class="container-title">
                    <h2><spring:message code="register.user.information"/></h2>
                </div>

                <div class="container-login-box">
                    <!-- User ID -->
                    <div class="form-wrap form-full">
                        <label field="NN"><spring:message code="register.input.userId"/>:</label>
                        <div><strong>${dataWallet.loginId}</strong></div>
                    </div>
                    <!-- * User ID -->

                    <!-- Name -->
                    <div class="form-wrap form-full">
                        <label field="NN"><spring:message code="register.input.name"/>:</label>
                        <div><strong>${dataWallet.name}</strong></div>
                    </div>
                    <!-- * Name -->

                    <!-- Tel -->
                    <div class="form-wrap form-full">
                        <label field="NN"><spring:message code="register.input.phone"/>:</label>
                        <div><strong>${dataWallet.tel}</strong></div>
                    </div>
                    <!-- * Tel -->


                    <div class="start-login">
                        <div class="btn secondary" redirect="${_ctx}/login"><spring:message code="common.button.login.title"/></div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">

        $(document).ready(function (){

            if (${dataWallet.loginId != null && dataWallet.loginPw != null}) {
                // reset cookies
                  $.cookie('username', null, { path: '/' });
                  $.cookie('password', null, { path: '/' });
                  $.cookie('remember', null, { path: '/' });
                  $.cookie('dev_logintype', 2, { path: '/' });

                  $.cookie('username',  '${dataWallet.loginId}', { expires: 14, path: '/' });
                  $.cookie('password', '${dataWallet.loginPw}', { expires: 14, path: '/' });
                  // $.cookie('dev_logintype', $('#loginType').val(), { expires: 14, path: '/' });
                  $.cookie('remember', true, { expires: 14, path: '/' });
            }
        });
    </script>
</body>
    <!-- * Main -->
<!-- footer -->
<%@ include file="/WEB-INF/layout/web-new/include/footer.jsp"%>
<!-- #footer -->
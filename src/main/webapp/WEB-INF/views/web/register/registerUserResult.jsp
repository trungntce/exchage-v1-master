<%--
  Created by IntelliJ IDEA.
  User: ntt.dev
  The page show information when register successful for user
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- head -->
<%@ include file="/WEB-INF/layout/web/head.jsp"%>

<!-- Main -->
<section class="wrap join-wrap">
      <!-- header -->
    <%@ include file="/WEB-INF/layout/web/header.jsp"%>
    <div class="container">
        <div class="container-join">
            <div class="container-title">
                <h2><spring:message code="register.user.information"/></h2>
            </div>

            <div class="container-login-box">
                <!-- User ID -->
                <div class="form-wrap form-full">
                    <label field="NN"><spring:message code="register.input.userId"/>:</label>
                    <div><b>${dataWallet.loginId}</b></div>
                </div>
                <!-- * User ID -->

                <!-- Name -->
                <div class="form-wrap form-full">
                    <label field="NN"><spring:message code="register.input.name"/>:</label>
                    <div><b>${dataWallet.name}</b></div>
                </div>
                <!-- * Name -->
            
                <!-- Tel -->
                <div class="form-wrap form-full">
                    <label field="NN"><spring:message code="register.input.phone"/>:</label>
                    <div><b>${dataWallet.tel}</b></div>
                </div>
                <!-- * Tel -->
                
                
                <div class="start-login">
                    <div class="btn secondary" redirect="${_ctx}/login">취소</div>
                </div>
            </div>
        </div>
    </div>
</section>
<!-- * Main -->
<!-- footer -->
    <%@ include file="/WEB-INF/layout/web/footer.jsp"%>
<!-- * footer -->
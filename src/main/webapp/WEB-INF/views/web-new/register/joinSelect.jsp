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
      <!-- header -->
      <%@ include file="/WEB-INF/layout/web-new/include/header.jsp"%>
      <!-- #header -->
      <!-- body -->
      <section class="container">
        <!-- Register form -->
        <article class="login-wrap">
          <div class="article-inner">
            <div class="login__head">
              <h1><spring:message code="register.page.title"/></h1>
              <p><spring:message code="register.page.content"/></p>
            </div>    
            <button type="button" class="btn btn-secondary is-full-width btn-lg mb-3" redirect="${_ctx}/join/wallet"><spring:message code="common.button.register.wallet.title"/></button>
            <button type="button" class="btn btn-secondary is-full-width btn-lg" redirect="${_ctx}/join/user"><spring:message code="common.button.register.user.title"/></button>
        </article>
        <!-- #body -->   
      </section>
    </div>
<!-- footer -->
<%@ include file="/WEB-INF/layout/web-new/include/footer.jsp"%>
<!-- #footer -->
</body>



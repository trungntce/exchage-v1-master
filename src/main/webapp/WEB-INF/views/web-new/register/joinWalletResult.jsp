<%--
  Created by IntelliJ IDEA.
  User: ntt.dev
  The page show information when register successful for wallet
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- head -->
<%@ include file="/WEB-INF/layout/web-new/include/head.jsp"%>
<!-- #head -->
<body class="pace-done">  
    <!-- Main -->
    <!-- <section class="wrap join-wrap"> -->
        <div class="wrapper">
        <!-- header -->
        <%@ include file="/WEB-INF/layout/web-new/include/header.jsp"%>
        <!-- #header -->
        <section class="container">
            <!-- <article class="join-wrap"> -->
                <div class="container-join">
                    <div class="container-title">
                        <h2><spring:message code="register.wallet.information"/></h2>
                    </div>

                    <div class="container-login-box">
                        <!-- Wallet address -->
                        <div class="form-wrap form-full">
                            <label field="NN"><spring:message code="result.register.wallet.address.title"/>:</label>
                            <div><strong>${dataWallet.walletAddress}</strong></div>
                        </div>
                        <!-- * Wallet address -->

                        <!-- Private key -->
                        <div class="form-wrap form-full">
                            <label field="NN"><spring:message code="result.register.private.key.title"/>:</label>
                            <div><strong>${dataWallet.privateKey}</strong></div>
                        </div>
                        <!-- * Private key -->          

                        <!-- Bank Name -->
                        <div class="form-wrap form-full">
                            <label field="NN"><spring:message code="register.input.bank.name.title"/>:</label>
                            <div><strong>${dataWallet.bankName}</strong></div>
                        </div>
                        <!-- * Bank Name -->

                        <!-- Bank Owner -->
                        <div class="form-wrap form-full">
                            <label field="NN"><spring:message code="register.input.bank.owner.title"/>:</label>
                            <div><strong>${dataWallet.bankOwner}</strong></div>
                        </div>
                        <!-- * Bank Owner -->

                        <!-- Bank Account -->
                        <div class="form-wrap form-full">
                            <label field="NN"><spring:message code="register.input.bank.account.title"/>:</label>
                            <div><strong>${dataWallet.bankAccount}</strong></div>
                        </div>
                        <!-- * Bank Account -->

                        <div class="start-login">
                            <div class="btn secondary" redirect="${_ctx}/login"><spring:message code="common.button.login.title"/></div>
                        </div>
                    </div>
                </div>
            <!-- </article> -->
        </section>
    <!-- footer -->
    <%@ include file="/WEB-INF/layout/web-new/include/footer.jsp"%>
    <!-- #footer -->
    </div>
    <!-- </section> -->
    <!-- * Main -->
</body>
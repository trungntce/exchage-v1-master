<%--
  Created by IntelliJ IDEA.
  User: ntt.dev
  The page show information when register successful for wallet
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
                <h2><spring:message code="register.wallet.information"/></h2>
            </div>

            <div class="container-login-box">
                <!-- Wallet address -->
                <div class="form-wrap form-full">
                    <label field="NN"><spring:message code="result.register.wallet.address.title"/>:</label>
                    <div><b>${dataWallet.walletAddress}</b></div>
                </div>
                <!-- * Wallet address -->

                <!-- Private key -->
                <div class="form-wrap form-full">
                    <label field="NN"><spring:message code="result.register.private.key.title"/>:</label>
                    <div><b>${dataWallet.privateKey}</b></div>
                </div>
                <!-- * Private key -->          

                <!-- Bank Name -->
                <div class="form-wrap form-full">
                    <label field="NN"><spring:message code="register.input.bank.name.title"/>:</label>
                    <div><b>${dataWallet.bankName}</b></div>
                </div>
                <!-- * Bank Name -->

                <!-- Bank Owner -->
                <div class="form-wrap form-full">
                    <label field="NN"><spring:message code="register.input.bank.owner.title"/>:</label>
                    <div><b>${dataWallet.bankOwner}</b></div>
                </div>
                <!-- * Bank Owner -->

                <!-- Bank Account -->
                <div class="form-wrap form-full">
                    <label field="NN"><spring:message code="register.input.bank.account.title"/>:</label>
                    <div><b>${dataWallet.bankAccount}</b></div>
                </div>
                <!-- * Bank Account -->

                <div class="start-login">
                    <div class="btn secondary" redirect="${_ctx}/login">취소</div>
                </div>
            </div>
        </div>
    </div>
    <!-- footer -->
    <%@ include file="/WEB-INF/layout/web/footer.jsp"%>
    <!-- * footer -->
</section>
<!-- * Main -->

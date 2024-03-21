<%--
  Created by IntelliJ IDEA.
  User: ntt.dev
  The home page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- head -->
<%@ include file="/WEB-INF/layout/web/head.jsp"%>

<!-- Main -->
<section class="wrap element-main-top">
<%@ include file="/WEB-INF/layout/web/header.jsp"%>
    <div class="container">
        <div class="container-main-top">
            <h2 class="main-title">Buy, trade, and hold 600+ cryptocurrencies on HERA</h2>
            <div class="join-present">
                <c:if test="${_userInfo == null}">
                    <p><img src="${_ctx}/resources/skin/dist/ic_present.png" class="present-img"><spring:message code="main.sign.up.today"/></p>
                    <div class="btn btn-primary" redirect="${_ctx}/registerUser"><spring:message code="main.sign.up.today"/></div>
                </c:if>
            </div>
            <img src="${_ctx}/resources/skin/dist/img_coin_title.png" class="top-img">
        </div>
    </div>
</section>

<section class="wrap element-main-score">
    <div class="container">
        <div class="container-main-score">
            <div class="container-main-score-item">
                <p class="container-main-score-item-score">$76 billion</p>
                <p class="container-main-score-item-info">24h trading volume on Binance exchange</p>
            </div>
            <div class="container-main-score-item">
                <p class="container-main-score-item-score">600+</p>
                <p class="container-main-score-item-info">Cryptocurrencies listed</p>
            </div>
            <div class="container-main-score-item">
                <p class="container-main-score-item-score">90 million</p>
                <p class="container-main-score-item-info">Registered users who trust Hera Cryptocurrency Market</p>
            </div>
            <div class="container-main-score-item">
                <p class="container-main-score-item-score">< 0.10%</p>
                <p class="container-main-score-item-info">Lowest transaction fees</p>
            </div>
        </div>
    </div>
</section>

<section class="wrap element-main-portfolio">
    <div class="container">
        <div class="container-main-portfolio">
            <div class="container-title">
                <h2><spring:message code="main.building.an.encryption.portfolio"/></h2>
                <p><spring:message code="main.building.an.encryption.portfolio.detailed.description"/></p>
            </div>
            <div class="portfolio-item account">
                <p><spring:message code="main.add.funds.to.your.account"/></p>
                <span><spring:message code="main.add.funds.to.your.account.detailed.description"/></span>
            </div>
            <div class="portfolio-item identity">
                <p><spring:message code="main.easy.identification"/></p>
                <span><spring:message code="main.easy.identification.detailed.description"/></span>
            </div>
            <div class="portfolio-item trading">
                <p><spring:message code="main.trading.begin"/></p>
                <span><spring:message code="main.trading.begin.detailed.description"/></span>
            </div>
            <div class="start-portfolio">
                <div class="btn btn-primary" redirect="${_ctx}/trade"><spring:message code="main.get.started.now"/></div>
            </div>
            <img src="${_ctx}/resources/skin/dist/img_pc.png" class="portfolio-img1">
            <img src="${_ctx}/resources/skin/dist/img_phone.png" class="portfolio-img2">
        </div>
    </div>
</section>

<section class="wrap element-main-explore">
    <div class="container">
        <div class="container-main-explore">
            <div class="container-title">
                <h2><spring:message code="main.explore.the.limitless.possibilities.with.hera.cryptocurrency.market"/></h2>
            </div>
            <div class="box-wrap">
                <div class="box-item">
                    <img src="${_ctx}/resources/skin/dist/img_box1.png">
                    <div class="box-info">
                        <p><spring:message code="main.simple.trading.and.low.commission"/></p>
                        <span>Add funds to your crypto account to start trading crypto. You can add funds with a variety of payment methods.</span>
                    </div>
                </div>
                <div class="box-item">
                    <div class="box-info">
                        <p><spring:message code="main.hera.cryptocurrency.market.and.business.growth"/></p>
                        <span>Add funds to your crypto account to start trading crypto. You can add funds with a variety of payment methods.</span>
                    </div>
                    <img src="${_ctx}/resources/skin/dist/img_box2.png">
                </div>
                <div class="box-item">
                    <img src="${_ctx}/resources/skin/dist/img_box3.png">
                    <div class="box-info">
                        <p><spring:message code="main.earn.commission.from.hera.cryptocurrency.market"/></p>
                        <span>Add funds to your crypto account to start trading crypto. You can add funds with a variety of payment methods.</span>
                    </div>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="wrap element-main-app">
    <div class="container">
        <div class="container-main-app">
            <div class="container-title">
                <h2><spring:message code="main.trading.on.the.go.anytime.anywhere"/></h2>
                <p><spring:message code="main.stay.up.to.date.with.our.mobile.app.and.desktop.client"/></p>
            </div>
            <img src="${_ctx}/resources/skin/dist/img_pc.png" class="app-img1">
            <img src="${_ctx}/resources/skin/dist/img_phone.png" class="app-img2">
            <div class="qr">
                <img src="${_ctx}/resources/skin/dist/qr.png">
                <div class="qr-txt">
                    <p>Scan to Download</p>
                    <span>iOS & Android</span>
                </div>
            </div>
            <div class="app">
                <div class="app-item">
                    <img src="${_ctx}/resources/skin/dist/ic_app_apple.png">
                    <p>App Store</p>
                </div>
                <div class="app-item">
                    <img src="${_ctx}/resources/skin/dist/ic_app_play.png">
                    <p>Google Play</p>
                </div>
                <div class="app-item">
                    <img src="${_ctx}/resources/skin/dist/ic_app_and.png">
                    <p>Android APK</p>
                </div>
            </div>
        </div>
    </div>
</section>

<section class="wrap element-main-portfolio">
    <div class="container">
        <div class="container-main-portfolio">
            <div class="container-title">
                <h2><spring:message code="main.trusted.cryptocurrency.exchange"/></h2>
                <p><spring:message code="main.hera.stores"/></p>
            </div>
            <div class="portfolio-item safu">
                <p><spring:message code="main.safu"/></p>
                <span><spring:message code="main.add.funds.to.your.cryptocurrency.account.to.start.trading.cryptocurrency"/></span>
            </div>
            <div class="portfolio-item control">
                <p><spring:message code="main.personalized.access.control"/></p>
                <span><spring:message code="main.advanced.access.control"/></span>
            </div>
            <div class="portfolio-item encryption">
                <p><spring:message code="main.advanced.data.encryption"/></p>
                <span><spring:message code="main.your.transaction.data.is.protected.by.end-to-end.encryption"/></span>
            </div>
            <img src="${_ctx}/resources/skin/dist/img_coin_trust.png" class="portfolio-img3">
        </div>
    </div>
</section>

<section class="wrap element-main-score">
    <div class="container">
        <div class="container-main-start">
            <h2 class="container-main-start-title"><spring:message code="main.starting.today.make.a.profit.with.the.cryptocurrency.market"/></h2>
            <div class="start-start">
                <div class="btn btn-primary" redirect="${_ctx}/trade"><spring:message code="main.register.now"/></div>
            </div>
        </div>
    </div>
</section>
<!-- * Main -->

<!-- footer -->
    <%@ include file="/WEB-INF/layout/web/footer.jsp"%>
<!-- * footer -->
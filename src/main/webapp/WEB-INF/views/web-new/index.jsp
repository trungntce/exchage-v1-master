<%--
  Created by IntelliJ IDEA.
  User: ntt.dev
  The home page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- head -->
<%@ include file="/WEB-INF/layout/web-new/include/head.jsp"%>
<!-- #head -->

<body class="pace-done">
	<div class="wrapper">

		<section class="top-banner">
			<div class="top-banner__inner">
				<div class="top-banner__hera-app-link">
					<div class="img-box"><img src="${_ctx}/resources/skinWeb/images/simbol2.png" alt=""></div>
					<div class="txt-box">
						<b><spring:message code="main.app.download.title"/></b>
						<p><spring:message code="main.secure.title"/></p>
					</div>
					<button class="top-banner__hera-app-link__download-btn">
						<i class="ci ci-download"></i>
					</button>
				</div>
				<button class="top-banner__close-btn" type="button"><i class="bi bi-x-lg"></i></button>
			</div>
		</section>

		<!-- header -->
		<%@ include file="/WEB-INF/layout/web-new/include/header.jsp"%>
		<!-- #header -->

		<section class="container">

			<article class="main-visual d-none">
				<div class="article-inner">
					<div class="main-visual__img-box"><img src="${_ctx}/resources/skinWeb/images/img_coin_title.png"></div>
					<h2 class="main-visual__title"><spring:message code="page.install.title"/></h2>
					<div class="main-visual__cont">
						<c:choose>
                            <c:when test="${wallet != null}">
                                <p><i class="bi bi-gift-fill text-primary me-2"></i><spring:message code="main.welcome.text"/></p>
                                <button class="btn btn-primary btn-lg" redirect="${_ctx}/trade"><spring:message code="common.button.trade.title"/></button>
                            </c:when>
                            <c:otherwise>
                                <p><i class="bi bi-gift-fill text-primary me-2"></i><spring:message code="main.welcome.text"/></p>
                                <button class="btn btn-primary btn-lg" redirect="${_ctx}/join/user"><spring:message code="button.register.title"/></button>
                            </c:otherwise>
                        </c:choose>
					</div>
				</div>
			</article>
			
            <div class="wallet-info__visual">
                <div class="inner">
                    <div class="wallet-info__visual__logo"><img src="${_ctx}/resources/skinWeb/images/wallet_logo_w.png" alt="HERA COIN WALLET"></div>
                    <div class="wallet-info__visual__txt-box"><b><spring:message code="page.install.title"/></b></div>
                    <div class="wallet-info__visual__cta">
                        <p>Download now!</p>
                        <div class="flex-box">
                            <button type="button" onclick="javascript:download('apple');" class="btn btn-light"><i class="ci ci-store-apple"></i><spring:message code="page.install.button.apple.store"/></button>
                            <button type="button" onclick="javascript:download('android');" class="btn btn-light"><i class="ci ci-store-google"></i><spring:message code="page.install.button.google.play"/></button>
                            <button type="button" onclick="javascript:download('android_apk');" class="btn btn-light"><i class="ci ci-store-android"></i><spring:message code="page.install.button.android.apk"/></button>
                        </div>
                    </div>
                    <div class="wallet-info__visual__img-box">
                        <div class="phone"></div>
                        <div class="hand"></div>
                    </div>
                </div>
            </div>

			<article class="main-score">
				<div class="article-inner">
					<div class="main-score__item">
						<p class="score"><spring:message code="main.score.title"/></p>
						<p class="info"><spring:message code="main.info.title"/></p>
					</div>
					<div class="main-score__item">
						<p class="score"><spring:message code="main.score2.title"/> </p>
						<p class="info"><spring:message code="main.info2.title"/></p>
					</div>
					<div class="main-score__item">
						<p class="score"><spring:message code="main.score3.title"/></p>
						<p class="info"><spring:message code="main.info3.title"/></p>
					</div>
					<div class="main-score__item">
						<p class="score">&lt; <spring:message code="main.score4.title"/></p>
						<p class="info"><spring:message code="main.info4.title"/></p>
					</div>
				</div>
			</article>


			<article class="main-portfolio">
				<div class="article-inner">
					<div class="main-portfolio__head">
						<h2><spring:message code="main.building.an.encryption.portfolio"/></h2>
						<p><spring:message code="main.building.an.encryption.portfolio.detailed.description"/></p>
					</div>
					<div class="main-portfolio__cont">
						<dl class="dl-bg-1">
							<dt><spring:message code="main.add.funds.to.your.account"/></dt>
							<dd><spring:message code="main.add.funds.to.your.account.detailed.description"/></dd>
						</dl>
						<dl class="dl-bg-2">
							<dt><spring:message code="main.easy.identification"/></dt>
							<dd><spring:message code="main.easy.identification.detailed.description"/></dd>
						</dl>
						<dl class="dl-bg-3">
							<dt><spring:message code="main.trading.begin"/></dt>
							<dd><spring:message code="main.trading.begin.detailed.description"/></dd>
						</dl>
						<button class="btn btn-primary btn-lg" redirect="${_ctx}/trade"><spring:message code="main.get.started.now"/></button>
					</div>
					<div class="main-portfolio__img-box">
						<img src="${_ctx}/resources/skinWeb/images/img_pc.png" class="portfolio-img1">
						<img src="${_ctx}/resources/skinWeb/images/img_phone.png" class="portfolio-img2">
					</div>
				</div>
			</article>

			<article class="main-explore">
				<div class="article-inner">
					<div class="main-explore__head">
						<h2><spring:message code="main.explore.the.limitless.possibilities.with.hera.cryptocurrency.market"/></h2>
					</div>
					<div class="main-explore__cont">
						<dl>
							<dt><spring:message code="main.simple.trading.and.low.commission"/></dt>
							<dd class="dd-img"><img src="${_ctx}/resources/skinWeb/images/img_box1.png"></dd>
							<dd><spring:message code="main.explore.title"/></dd>
						</dl>
						<dl>
							<dt><spring:message code="main.hera.cryptocurrency.market.and.business.growth"/></dt>
							<dd class="dd-img"><img src="${_ctx}/resources/skinWeb/images/img_box2.png"></dd>
							<dd><spring:message code="main.explore.title2"/></dd>
						</dl>
						<dl>
							<dt><spring:message code="main.earn.commission.from.hera.cryptocurrency.market"/></dt>
							<dd class="dd-img"><img src="${_ctx}/resources/skinWeb/images/img_box3.png"></dd>
							<dd><spring:message code="main.explore.title3"/></dd>
						</dl>
					</div>
				</div>
			</article>

			<article class="main-app">
				<div class="article-inner">
					<div class="device-img">
						<img src="${_ctx}/resources/skinWeb/images/img_pc.png" class="app-img1">
						<img src="${_ctx}/resources/skinWeb/images/img_phone.png" class="app-img2">
					</div>
					<div class="main-app__head">
						<h2><spring:message code="main.trading.on.the.go.anytime.anywhere"/></h2>
						<p><spring:message code="main.stay.up.to.date.with.our.mobile.app.and.desktop.client"/></p>
					</div>
					<div class="main-app__cont">
						<div class="qr">
							<img src="${_ctx}/resources/skinWeb/images/qr.png">
							<div class="qr-txt">
								<b><spring:message code="main.scan.download.title"/></b>
								<p>iOS &amp; Android</p>
							</div>
						</div>
						<div class="app">
							<div class="app-item">
								<img src="${_ctx}/resources/skinWeb/images/ic_app_apple.png">
								<p>App Store</p>
							</div>
							<div class="app-item">
								<img src="${_ctx}/resources/skinWeb/images/ic_app_play.png">
								<p>Google Play</p>
							</div>
							<div class="app-item">
								<img src="${_ctx}/resources/skinWeb/images/ic_app_and.png">
								<p>Android APK</p>
							</div>
						</div>
					</div>
				</div>
			</article>


			<article class="main-portfolio main-portfolio-2">
				<div class="article-inner">
					<div class="main-portfolio__head">
						<h2><spring:message code="main.trusted.cryptocurrency.exchange"/></h2>
						<p><spring:message code="main.hera.stores"/></p>
					</div>
					<div class="main-portfolio__cont">
						<dl class="dl-bg-4">
							<dt><spring:message code="main.safu"/></dt>
							<dd><spring:message code="main.add.funds.to.your.cryptocurrency.account.to.start.trading.cryptocurrency"/></dd>
						</dl>
						<dl class="dl-bg-5">
							<dt><spring:message code="main.personalized.access.control"/></dt>
							<dd><spring:message code="main.advanced.access.control"/></dd>
						</dl>
						<dl class="dl-bg-6">
							<dt><spring:message code="main.advanced.data.encryption"/></dt>
							<dd><spring:message code="main.your.transaction.data.is.protected.by.end-to-end.encryption"/></dd>
						</dl>
					</div>
					<div class="main-portfolio__img-box">
						<img src="${_ctx}/resources/skinWeb/images/img_coin_trust.png" class="portfolio-img3">
					</div>
				</div>
			</article>

            <c:choose>
                <c:when test="${wallet != null}">

                    <article class="bottom-banner">
                        <div class="article-inner">
                            <h2><spring:message code="main.starting.today.make.a.profit.with.the.cryptocurrency.market"/></h2>
                            <button class="btn btn-light btn-lg" redirect="${_ctx}/trade"><spring:message code="common.button.trade.title"/></button>
                        </div>
                    </article>
                </c:when>
                <c:otherwise>
                    <article class="bottom-banner">
                        <div class="article-inner">
                            <h2><spring:message code="main.starting.today.make.a.profit.with.the.cryptocurrency.market"/></h2>
                            <button class="btn btn-light btn-lg"><spring:message code="main.register.now"/></button>
                        </div>
                    </article>
                </c:otherwise>
            </c:choose>
		</section>

		<!-- footer -->
		<%@ include file="/WEB-INF/layout/web-new/include/footer.jsp"%>
		<!-- #footer -->

	</div>
</body>

</html>
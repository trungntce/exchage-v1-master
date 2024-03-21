<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/layout/web-new/modals/chatForm.jsp"%>
<footer>
	<div class="footer__inner">
		<ul class="footer__nav">
			<li><a href="${_ctx}/trade">P2P Market<span class="footer__nav__badge">KRW</span></a></li>
			<li><a href="${_ctx}/walletInstall"><spring:message code="navigator.wallet.installation.title"/></a></li>
			<li><a href="${_ctx}/manual"><spring:message code="navigator.exchange.manual.title"/></a></li>
			<li><a href="${_ctx}/information"><spring:message code="navigator.exchange.information.title"/></a></li>
			<li><a href="${_ctx}/faq"><spring:message code="navigator.exchange.faq.title"/></a></li>
			<li><a href="${_ctx}/about"><spring:message code="navigator.exchange.about.title"/></a></li>
		</ul>
		<ul class="footer__sns">
			<li><a href=""><i class="ci ci-sns-facebook"></i></a></li>
			<li><a href=""><i class="ci ci-sns-instagram"></i></a></li>
			<li><a href=""><i class="ci ci-sns-twitter"></i></a></li>
			<li><a href=""><i class="ci ci-sns-youtube"></i></a></li>
		</ul>
		<div class="footer__info">
            <p><spring:message code="exchange.use.warning.statement.1"/></p>
            <p><spring:message code="exchange.use.warning.statement.2"/></p>
		</div>
		<div class="footer__copy">
            <p><spring:message code="exchange.use.footer.copy"/></p>
		</div>
	</div>
</footer>
<script src="${_ctx}/resources/js/chat-js.js"></script>
<%@ include file="/WEB-INF/layout/web-new/modals/wallets.jsp"%>
<%@ include file="/WEB-INF/layout/web-new/modals/walletSelectModal.jsp"%>
<%@ include file="/WEB-INF/layout/web-new/modals/alarmSettings.jsp"%>
<%@ include file="/WEB-INF/layout/web-new/modals/feedbackModal.jsp"%>
<%@ include file="/WEB-INF/layout/web-new/modals/feedbackRequestModal.jsp"%>

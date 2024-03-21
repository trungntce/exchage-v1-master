<%--
  Created by IntelliJ IDEA.
  User: ntt.dev
  The template footer common.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ include file="/WEB-INF/layout/web/tags/commonTags.jspf" %>
<footer>
    <nav class="navi-wrap">
        <div class="navi-item" redirect="${_ctx}/trade">
            P2P Market
            <div class="navi-item-hot">KRW</div>
        </div>
        <div class="navi-item" redirect="${_ctx}/walletInstall"><spring:message code="navigator.wallet.installation.title"/></div>
        <div class="navi-item" redirect="${_ctx}/manual"><spring:message code="navigator.exchange.manual.title"/></div>
        <div class="navi-item" redirect="${_ctx}/information."><spring:message code="navigator.exchange.information.title"/></div>
        <div class="navi-item" redirect="${_ctx}/faq"><spring:message code="navigator.exchange.faq.title"/></div>
        <div class="navi-item" redirect="${_ctx}/about.al"><spring:message code="navigator.exchange.about.title"/></div>
        <div class="navi-item" onclick="javascript:showModal('.modal-term-1', true)"><spring:message code="navigator.terms.of.use.title"/></div>
        <div class="navi-item" onclick="javascript:showModal('.modal-term-2', true)"><spring:message code="navigator.personal.information.collection.and.usage.agreement.title"/></div>
    </nav>
    <ul class="footer-sns">
        <li class="face"></li>
        <li class="in"></li>
        <li class="twit"></li>
        <li class="you"></li>
    </ul>

    <div class="footer-info">
        <p><spring:message code="exchange.use.warning.statement.1"/></p>
        <p><spring:message code="exchange.use.warning.statement.2"/></p>
    </div>

    <div class="footer-copy">
        <p><spring:message code="exchange.use.footer.copy"/></p>
    </div>
</footer>


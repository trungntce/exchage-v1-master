<%--
  Created by IntelliJ IDEA.
  User: ntt.dev
  The page list buy/sell
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- head -->
<%@ include file="/WEB-INF/layout/web/head.jsp"%>
<style type="text/css">
    .btn-buy , .btn-sell{
        background-color: #b17acc !important;
        color: #fff !important;
    }
</style>
<!-- Main -->
<section class="wrap trade-wrap">
	<!-- header -->
	<%@ include file="/WEB-INF/layout/web/header.jsp"%>    
    <div class="sub-title trade-title">
        <h2><spring:message code="trade.page.title"/></h2>
        <p>
            <spring:message code="trade.page.content.fist.title"/><br/>
            <spring:message code="trade.page.content.second.title"/>
        </p>
    </div>

    <div class="sub-snb-wrap trade-snb">
        <div class="sub-snb-container">
            <ul class="sub-snb-menu" trade-tab="${buySearch.targetView}">
                <li class="sub-snb-menu-item" tab-target="#buy-order"><spring:message code="trade.tab.buy.title"/></li>
                <li class="sub-snb-menu-item" tab-target="#sell-order"><spring:message code="trade.tab.sell.title"/></li>
            </ul>
            <div class="sub-snb-btn">
                <ul class="list-select" trade-status="${buySearch.idOrderStatus}">
                    <li class="list-select-item order-status" data-status=""><spring:message code="trade.status.order.all.title"/></li>
                    <li class="list-select-item order-status" data-status="1"><spring:message code="trade.status.order.wait.title"/></li>
                    <li class="list-select-item order-status" data-status="2"><spring:message code="trade.status.order.trade.title"/></li>
                    <li class="list-select-item order-status" data-status="3"><spring:message code="trade.status.order.finish.title"/></li>
                </ul>
                <div class="btn refresh-btn order-status" data-status=""><spring:message code="trade.status.order.refresh.title"/></div>
            </div>
        </div>
    </div>

    <div class="sub-snb-coin-wrap">
        <ul class="sub-snb-coin-container" trade-symbol="${buySearch.symbol}">
            <li class="sub-snb-coin-item trade-symbol" data-symbol=""><spring:message code="trade.token.all.title"/></li><!-- active -->
            <c:forEach items="${tokens}" var="item" varStatus="loop">
                <li class="sub-snb-coin-item trade-symbol" data-symbol="${item.symbol}">${item.symbol}</li>
            </c:forEach>
        </ul>
    </div>

    <div class="container">
        <div class="container-trade">
        
            <div class="trade-btn-wrap">
            <c:choose>
                <c:when test="${not empty wallet && wallet.wallets.size() > 0 && (wallet.role == 'USER' || wallet.role == 'TRADER')}">
                    <div class="btn btn-secondry btn-buy hide" trade-register="#buy-order" redirect="${_ctx}/buyRegister"><spring:message code="common.button.buy.register.title"/></div>
                    <div class="btn btn-secondry btn-sell hide" trade-register="#sell-order" redirect="${_ctx}/sellRegister"><spring:message code="common.button.sell.register.title"/></div>
                </c:when>
                <c:otherwise>                    
                    <div class="btn btn-secondry btn-buy btn-question-login hide" trade-register="#buy-order" style="background-color: #6a4d78"><spring:message code="common.button.buy.register.title"/></div>
                    <div class="btn btn-secondry btn-sell btn-question-login hide" trade-register="#sell-order" style="background-color: #6a4d78"><spring:message code="common.button.sell.register.title"/></div>
                </c:otherwise>
            </c:choose>
            </div>
            
            <div class="list-wrap trade-list-wrap hide" id="buy-order">
                <div class="trade-list-wrap">
                    <div class="trade-list-head">
                        <div class="trade-list-th"><spring:message code="trade.buy.orderNumber.title"/></div>
                        <div class="trade-list-th"><spring:message code="trade.buy.coin.title"/></div>
                        <!-- <div class="trade-list-th"><spring:message code="trade.buy.orderKind.title"/></div> -->
                        <div class="trade-list-th"><spring:message code="trade.buy.tokenCnt.title"/></div>
                        <div class="trade-list-th"><spring:message code="trade.buy.price.title"/></div>
                        <div class="trade-list-th"><spring:message code="trade.buy.totalAmount.title"/></div>
                        <div class="trade-list-th"><spring:message code="trade.buy.createDate.title"/></div>
                        <div class="trade-list-th"><spring:message code="trade.buy.status.title"/></div>
                    </div>
                    <c:if test="${buyList.size() == 0}">
                        <div class="trade-list-tr">
                          <div class="trade-list-td other-num"><spring:message code="common.message.noData.title"/></div>
                        </div>
                    </c:if>                    
                    <c:forEach items="${buyList}" var="item" varStatus="loop">
                        <jsp:useBean id="buyTime" class="java.util.Date"/>
                        
                        <div class="trade-list-tr">
                            <div class="trade-list-td other-num">${item.symbol}<fmt:formatDate value="${item.buyRegDate}" pattern="yyyyMMddHHmmss"/>${item.buyId}</div>
                            <div class="trade-list-td coin-name">${item.symbol}</div>
                            <!-- <div class="trade-list-td category">${item.buyType}</div> -->
                            <div class="trade-list-td ea"><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.quantity}"/><spring:message code="common.unit.count.title"/></div>
                            <div class="trade-list-td price-one"><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.unitPrice}"/><spring:message code="common.unit.won.title"/></div>
                            <div class="trade-list-td price-total"><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.totalPrice}"/><spring:message code="common.unit.won.title"/></div>
                            <div class="trade-list-td date"><fmt:formatDate value="${item.buyRegDate}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
                            <div class="trade-list-td status">
                                <c:choose>
                                    <c:when test="${(item.state == 1
                                    || fn:containsIgnoreCase(wallet.wallets, item.sellerWalletAddress)
                                    || fn:containsIgnoreCase(wallet.wallets, item.buyerWalletAddress))
                                    && not empty wallet }">
                                        <c:if test="${item.state == 1}"><div class="status-btn status-wait" data-id="" redirect="${_ctx}/tradeBuyDetail?buyId=${item.buyId}">${item.stateName}</div></c:if>
                                        <c:if test="${item.state == 2}"><div class="status-btn status-ing" data-id="" redirect="${_ctx}/tradeBuyDetail?buyId=${item.buyId}">${item.stateName}</div></c:if>
                                        <c:if test="${item.state == 3}"><div class="status-btn status-end" data-id="" redirect="${_ctx}/tradeBuyDetail?buyId=${item.buyId}">${item.stateName}</div></c:if>
                                    </c:when>
                                    <c:when test="${empty wallet}">
                                        <c:if test="${item.state == 1}"><div class="status-btn status-wait btn-question-login">${item.stateName}</div></c:if>
                                        <c:if test="${item.state == 2}"><div class="status-btn status-ing btn-question-login">${item.stateName}</div></c:if>
                                        <c:if test="${item.state == 3}"><div class="status-btn status-end btn-question-login">${item.stateName}</div></c:if>
                                    </c:when>
                                    <c:otherwise>
                                        <c:if test="${item.state == 1}"><div class="status-btn status-wait">${item.stateName}</div></c:if>
                                        <c:if test="${item.state == 2}"><div class="status-btn status-ing">${item.stateName}</div></c:if>
                                        <c:if test="${item.state == 3}"><div class="status-btn status-end">${item.stateName}</div></c:if>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <pg:webpaging page="${buySearch}" script="goBuyPage"/>
            </div>

            <div class="list-wrap trade-list-wrap hide" id="sell-order">
                <div class="trade-list-wrap">
                    <div class="trade-list-head">
                        <div class="trade-list-th"><spring:message code="trade.buy.orderNumber.title"/></div>
                        <div class="trade-list-th"><spring:message code="trade.buy.coin.title"/></div>
                        <!-- <div class="trade-list-th"><spring:message code="trade.buy.orderKind.title"/></div> -->
                        <div class="trade-list-th"><spring:message code="trade.buy.tokenCnt.title"/></div>
                        <div class="trade-list-th"><spring:message code="trade.buy.price.title"/></div>
                        <div class="trade-list-th"><spring:message code="trade.buy.totalAmount.title"/></div>
                        <div class="trade-list-th"><spring:message code="trade.buy.createDate.title"/></div>
                        <div class="trade-list-th"><spring:message code="trade.buy.status.title"/></div>
                    </div>

                    <c:if test="${sellList.size() == 0}">
                        <div class="trade-list-tr">
                          <div class="trade-list-td other-num"><spring:message code="common.message.noData.title"/></div>
                        </div>
                    </c:if>

                    <c:forEach items="${sellList}" var="item" varStatus="loop">
                    <jsp:useBean id="sellTime" class="java.util.Date"/>
                    
                        <div class="trade-list-tr">
                            <div class="trade-list-td other-num">${item.symbol}<fmt:formatDate value="${item.sellRegDate}" pattern="yyyyMMddHHmmss"/>${item.sellId}</div>
                            <div class="trade-list-td coin-name">${item.symbol}</div>
                            <!-- <div class="trade-list-td category">${item.sellType}</div> -->
                            <div class="trade-list-td ea"><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.quantity}"/><spring:message code="common.unit.count.title"/></div>
                            <div class="trade-list-td price-one"><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.unitPrice}"/><spring:message code="common.unit.won.title"/></div>
                            <div class="trade-list-td price-total"><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.totalPrice}"/><spring:message code="common.unit.won.title"/></div>
                            <div class="trade-list-td date"><fmt:formatDate value="${item.sellRegDate}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
                            <div class="trade-list-td status">
                                <c:choose>
                                    <c:when test="${(item.state == 1
                                    || fn:containsIgnoreCase(wallet.wallets, item.buyerWalletAddress)
                                    || fn:containsIgnoreCase(wallet.wallets, item.sellerWalletAddress))
                                    && not empty wallet }">
                                        <c:if test="${item.state == 1}"><div class="status-btn status-wait" data-id="" redirect="${_ctx}/tradeSellDetail?sellId=${item.sellId}">${item.stateName}</div></c:if>
                                        <c:if test="${item.state == 2}"><div class="status-btn status-ing" data-id="" redirect="${_ctx}/tradeSellDetail?sellId=${item.sellId}">${item.stateName}</div></c:if>
                                        <c:if test="${item.state == 3}"><div class="status-btn status-end" data-id="" redirect="${_ctx}/tradeSellDetail?sellId=${item.sellId}">${item.stateName}</div></c:if>
                                    </c:when>
                                    <c:when test="${empty wallet}">
                                        <c:if test="${item.state == 1}"><div class="status-btn status-wait btn-question-login">${item.stateName}</div></c:if>
                                        <c:if test="${item.state == 2}"><div class="status-btn status-ing btn-question-login">${item.stateName}</div></c:if>
                                        <c:if test="${item.state == 3}"><div class="status-btn status-end btn-question-login">${item.stateName}</div></c:if>
                                    </c:when>
                                    <c:otherwise>
                                        <c:if test="${item.state == 1}"><div class="status-btn status-wait">${item.stateName}</div></c:if>
                                        <c:if test="${item.state == 2}"><div class="status-btn status-ing">${item.stateName}</div></c:if>
                                        <c:if test="${item.state == 3}"><div class="status-btn status-end">${item.stateName}</div></c:if>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </c:forEach>
                </div>

                <pg:webpaging page="${sellSearch}" script="goSellPage"/>

            </div>
        </div>
    </div>
</section>
<!-- * Main -->
<!-- footer -->
    <%@ include file="/WEB-INF/layout/web/footer.jsp"%>
<!-- * footer -->


<script>
    $(document).ready(function(){
        init();
    })

    function init(){


        //Tab target
        var tradeTab = $("[trade-tab]").attr("trade-tab");
        tradeTab = (tradeTab == "" || tradeTab == null) ? "#buy-order" : tradeTab;
        $(".sub-snb-menu-item[tab-target='"+tradeTab+"']").addClass("active");
        $(tradeTab).removeClass("hide");
        $("[trade-register='"+tradeTab+"']").removeClass("hide");

        //Status target
        var tradeStatus = $("[trade-status]").attr("trade-status");
        tradeStatus = (tradeStatus == "" || tradeStatus == null) ? "" : tradeStatus;
        $(".order-status[data-status='"+tradeStatus+"']").addClass("active");

        //Symbol target
        var tradeSymbol = $("[trade-symbol]").attr("trade-symbol");
        tradeSymbol = (tradeSymbol == "" || tradeSymbol == null) ? "" : tradeSymbol;
        $(".trade-symbol[data-symbol='"+tradeSymbol+"']").addClass("active");
    }

    function goSellPage(mPage){
        var url = changeSearchParam({sellPage: mPage})
        document.location.href = url;
    }
    
    function goBuyPage(mPage){
        var url = changeSearchParam({buyPage: mPage})
        document.location.href = url;
    }

    $(".trade-symbol").click(function(){
        var symbol = $(this).attr("data-symbol");
        var url = changeSearchParam({symbol: symbol, sellPage: 1, buyPage: 1})
        document.location.href = url;
    })

    $(".order-status").click(function(){
        var status = $(this).attr("data-status");
        var url = changeSearchParam({idOrderStatus: status, sellPage: 1, buyPage: 1})
        document.location.href = url;
    })

    $(".sub-snb-menu-item:not(.acitve)").click(function(){
        var target = $(this).attr("tab-target");
        var url = changeSearchParam({targetView: target})
        document.location.href = url;
    })
    $(".btn-question-login").click(function(){

          if (confirm("<spring:message code="trade.question.login.message"/>") == true) {                       
            document.location.href= "${_ctx}/login";
          } 
    });
    
</script>
<%--
  Created by IntelliJ IDEA.
  User: ntt.dev
  The page trade sell detail
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- head -->
<%@ include file="/WEB-INF/layout/web/head.jsp"%>


<!-- Sell detail info -->

<section class="wrap trade-wrap">
	<script type="text/javascript">console.log('${wallet.role}')</script>
	<!-- header -->
	<%@ include file="/WEB-INF/layout/web/header.jsp"%>
    <div class="sub-title trade-title">
        <h2><spring:message code="sell.detail.page.title"/></h2>
        <p><spring:message code="sell.detail.page.content"/></p>
    </div>
    <div class="container" id="modal-sell-detail">

        <div class="trade-pop-form">
            <div class="form-wrap form-full">
                <spring:message code="common.message.balances.title"/>: <label class="my-balance" wallet-address="${wallet.walletAddress}">N/A</label> BANI
                <div class="form-wrap-txt">${sellDetail.sellerWalletAddress}</div>
            </div>
            <div class="trade-pop-form-btn">
                <div class="btn btn-primary" data-clipboard-text="${sellDetail.sellerWalletAddress}" onclick='alert(`<spring:message code="common.copy.toast.title"/>`)'><spring:message code="common.copy.title"/></div>
                <!-- TODO: copy clipboard -->
            </div>

            <div class="trade-pop-form-btn" style="margin-top: 6px">
                <div class="btn btn-primary" onclick="location.reload();"><i class="fas fa-sync"></i> <spring:message code="trade.status.order.refresh.title"/></div>
            </div>
            
            <div class="trade-pop-form-info">
                <dl class="trade-pop-form-info-item">
                    <dt><spring:message code="sell.detail.orderNumber.title"/></dt>
                    <dd>${sellDetail.symbol}<fmt:formatDate value="${sellDetail.sellRegDate}" pattern="yyyyMMddHHmmss"/>${sellDetail.sellId}</dd>
                    <dd></dd>
                </dl>
                <dl class="trade-pop-form-info-item">
                    <dt><spring:message code="sell.detail.symbol.title"/></dt>
                    <dd>${sellDetail.symbol}</dd>
                    <dd></dd>
                </dl>
                <dl class="trade-pop-form-info-item">
                    <dt><spring:message code="sell.detail.cnt.title"/></dt>
                    <dd><span><fmt:formatNumber type="number" maxFractionDigits="3" value="${sellDetail.quantity}"/></span><spring:message code="common.unit.count.title"/></dd>
                    <dd></dd>
                </dl>
                <dl class="trade-pop-form-info-item">
                    <dt><spring:message code="sell.detail.unit.title"/></dt>
                    <dd class="price-one"><fmt:formatNumber type="number" maxFractionDigits="3" value="${sellDetail.unitPrice}"/><spring:message code="common.unit.won.title"/></dd>
                    <dd></dd>
                </dl>
                <dl class="trade-pop-form-info-item">
                    <dt><spring:message code="sell.detail.fee.title"/></dt>
                    <dd>0.1<spring:message code="common.unit.count.title"/></dd>
                    <dd></dd>
                </dl>
                <dl class="trade-pop-form-info-item">
                    <dt><spring:message code="sell.detail.price.title"/></dt>
                    <dd>100,000<spring:message code="common.unit.won.title"/> <span>(<spring:message code="buy.detail.fee.title"/> -10,000<spring:message code="common.unit.won.title"/>)</span></dd>
                    <dd></dd>
                </dl>
                <dl class="trade-pop-form-info-item">
                    <dt><spring:message code="sell.detail.totalPrice.title"/></dt>
                    <dd class="price-total"><fmt:formatNumber type="number" maxFractionDigits="3" value="${sellDetail.totalPrice}"/><spring:message code="common.unit.won.title"/></dd>
                    <dd></dd>
                </dl>
                <dl class="trade-pop-form-info-item">
                    <dt><spring:message code="sell.detail.status.title"/></dt>
                    <dd>
                        <c:if test="${sellDetail.state == 1 || sellDetail.state == 2}"><div class="status-btn status-wait">${sellDetail.stateName}</div></c:if>
                        <c:if test="${sellDetail.state == 3}"><div class="status-btn status-ing">${sellDetail.stateName}</div></c:if>
                        <c:if test="${sellDetail.state == 5}"><div class="status-btn status-ing">Cancel</div></c:if>
                    </dd>
                    <dd></dd>
                </dl>
            </div>

            <!-- order status description -->
            <div class="trade-pop-form-alt">
                <c:if test="${sellDetail.state == 1}">
                    <spring:message code="sell.detail.description.wait.title"/>
                </c:if>
                <c:if test="${sellDetail.tradeState == 1}">
                    <spring:message code="sell.detail.description.trade.fist.title"/>
                </c:if>
                <c:if test="${sellDetail.tradeState == 2}">
                    <spring:message code="sell.detail.description.trade.second.title"/>
                </c:if>
                <c:if test="${sellDetail.tradeState == 3}">
                    <spring:message code="sell.detail.description.trade.third.title"/>
                </c:if>
                <c:if test="${sellDetail.tradeState == 4}">
                    <spring:message code="sell.detail.description.trade.four.title"/>
                </c:if>
                <spring:message code="sell.detail.description.trade.common.title"/>    
            </div>

            <!-- Action for user -->
            <div class="start-login">

            <!-- ROLE = TRADER AND SELL_TYPE = 2 (API) -->
            <c:if test="${(wallet.role == 'TRADER' && sellDetail.sellType == 2)}">

                <!-- WHEN ORDER IS NOT YOUR ORDER AND STATE == 1, MAYBE APPLY SELL -->
                <c:if test="${wallet.wallets.size() > 0
                    && !fn:containsIgnoreCase(wallet.wallets, sellDetail.sellerWalletAddress)
                    && sellDetail.state == 1}">
                    <!-- role<USER_ROLE> + order<1> -->
                    
                        <a href="${_ctx}/sellTradeApply?sellId=${sellDetail.sellId}&buyerWalletAddress=${wallet.wallets[0].walletAddress}">
                            <div class="btn btn-primary">
                                <spring:message code="common.button.applyTrade.title"/>
                            </div>
                        </a>
                </c:if>

                <!-- WHEN ORDER IS NOT YOUR ORDER AND STATE = 2, TRADE_STATE = 1 AND SELL_TYPE = 2 (API), MAY BE USE TRANSFER  -->
                <c:if test="${wallet.wallets.size() > 0
                    && fn:containsIgnoreCase(wallet.wallets, sellDetail.sellerWalletAddress)
                    && sellDetail.state == 2
                    && sellDetail.tradeState == 1
                    && sellDetail.sellType == 2
                    && sellDetail.viewRole == 'TRADER'}">
                    
                        <a href="${_ctx}/sell/applyWithTransfer?sellId=${sellDetail.sellId}">
                            <div class="btn btn-primary">
                                <spring:message code="common.button.transfer.title"/>
                            </div>
                        </a>
                </c:if>

                <c:if test="${wallet.wallets.size() > 0
                    && fn:containsIgnoreCase(wallet.wallets, sellDetail.buyerWalletAddress)
                    && sellDetail.state == 2
                    && sellDetail.sellType == 2 
                    && sellDetail.viewRole == 'API'}">
                    <div class="trade-pop-form-info">
                        <dl class="trade-pop-form-info-item">
                            <dd><spring:message code="sell.detail.bank.info.title"/></dd>
                        </dl>
                        <dl class="trade-pop-form-info-item">
                            <dt><spring:message code="sell.detail.bank.owner.title"/></dt>
                            <dd>${sellDetail.bankOwner}</dd>
                        </dl>
                        <dl class="trade-pop-form-info-item">
                            <dt><spring:message code="sell.detail.bank.name.title"/></dt>
                            <dd>${sellDetail.bankName}</dd>
                        </dl>
                        <dl class="trade-pop-form-info-item">
                            <dt><spring:message code="sell.detail.bank.account.title"/></dt>
                            <dd>${sellDetail.bankAccount}</dd>
                        </dl>
                        <dl class="trade-pop-form-info-item">
                            <dt><spring:message code="sell.detail.bank.totalPrice.title"/></dt>
                            <dd><fmt:formatNumber type="number" maxFractionDigits="3" value="${sellDetail.totalPrice}"/></dd>
                        </dl>
                    </div>
                    
                     <a href="${_ctx}/sell/applyWithTransfer?sellId=${sellDetail.sellId}">
                        <div class="btn btn-primary">
                            <spring:message code="common.button.finish.title"/>
                        </div>
                    </a>
                </c:if>
            </c:if>
            <!-- * ROLE = TRADER -->

            <!-- ROLE = USER -->
            <c:if test="${(wallet.role == 'USER' || wallet.role == 'TRADER')}">
                <c:if test="${wallet.wallets.size() > 0 
                    && fn:containsIgnoreCase(wallet.wallets, sellDetail.sellerWalletAddress) 
                    && sellDetail.state == 1}">
                    <!-- IS OWNER ORDER + order<1> -->
                    <a href="${_ctx}/sellCancel?sellId=${sellDetail.sellId}">
                        <div class="btn btn-primary">
                            <spring:message code="common.button.cancel.title"/>
                        </div>
                    </a>
                </c:if>

                <c:if test="${wallet.wallets.size() > 0
                    && !fn:containsIgnoreCase(wallet.wallets, sellDetail.sellerWalletAddress)
                    && (wallet.role == 'USER' || (wallet.role == 'TRADER'))
                    && sellDetail.state == 1
                    && sellDetail.sellType == 1}">
                    <!-- role<USER_ROLE> + order<1> -->
                
                    <a href="${_ctx}/sellTradeApply?sellId=${sellDetail.sellId}&buyerWalletAddress=${wallet.wallets[0].walletAddress}">
                        <div class="btn btn-primary">
                            <spring:message code="common.button.apply.title"/>
                        </div>
                    </a>
                </c:if>

                <c:if test="${wallet.wallets.size() > 0
                    && fn:containsIgnoreCase(wallet.wallets, sellDetail.buyerWalletAddress)
                    && sellDetail.state == 2
                    && sellDetail.tradeState == 1
                    && sellDetail.sellType == 1}">
                    <!-- IS OWNER s + order<2> + orderTrade<1>-->

                    <div class="trade-pop-form-info">
                        <dl class="trade-pop-form-info-item">
                            <dd><spring:message code="sell.detail.bank.info.title"/></dd>
                        </dl>
                        <dl class="trade-pop-form-info-item">
                            <dt><spring:message code="sell.detail.bank.owner.title"/></dt>
                            <dd>${sellDetail.bankOwner}</dd>
                        </dl>
                        <dl class="trade-pop-form-info-item">
                            <dt><spring:message code="sell.detail.bank.name.title"/></dt>
                            <dd>${sellDetail.bankName}</dd>
                        </dl>
                        <dl class="trade-pop-form-info-item">
                            <dt><spring:message code="sell.detail.bank.account.title"/></dt>
                            <dd>${sellDetail.bankAccount}</dd>
                        </dl>
                        <dl class="trade-pop-form-info-item">
                            <dt><spring:message code="sell.detail.bank.totalPrice.title"/></dt>
                            <dd><fmt:formatNumber type="number" maxFractionDigits="3" value="${sellDetail.totalPrice}"/></dd>
                        </dl>
                    </div>
                    
                    <a href="${_ctx}/sell/confirmCashDeposit?sellId=${sellDetail.sellId}&sellTradeHistoryId=${sellDetail.sellTradeHistoryId}">
                        <div class="btn btn-primary">
                            <spring:message code="common.button.cashDeposit.title"/>
                        </div>
                    </a>
                </c:if>

                <c:if test="${wallet.wallets.size() > 0
                    && fn:containsIgnoreCase(wallet.wallets, sellDetail.sellerWalletAddress)
                    && sellDetail.state == 2
                    && sellDetail.tradeState == 2}">
                    <!-- IS OWNER s + order<2> + orderTrade<1>-->
                    <form:form modelAttribute="tradeDepositForm" method="POST" action="${_ctx}/sell/confirmTxId" cssClass="mb-1">
                         <!-- TxID -->
                        <label for="txId" class="input-label" field="NN"><spring:message code="trade.input.txid.title"/></label>
                        <div class="form-wrap form-full">
                            <form:input path="txId" type="text" placeholder="Please enter TxID"/>
                        </div>
                        <div class="input-info message" hidden><spring:message code="trade.input.txid.message"/></div>
                        <!-- * Wallet password -->

                        <form:hidden path="sellId" value="${sellDetail.sellId}"/>
                        <form:hidden path="sellTradeHistoryId" value="${sellDetail.sellTradeHistoryId}"/>
                    </form:form>

                    <div class="btn btn-primary btn-deposit">
                        <spring:message code="common.button.deposit.title"/>
                    </div>
                </c:if>

                <c:if test="${wallet.wallets.size() > 0
                    && fn:containsIgnoreCase(wallet.wallets, sellDetail.buyerWalletAddress)
                    && sellDetail.state == 2
                    && sellDetail.tradeState == 3}">
                    <!-- role<USER_ROLE> + order<2> + orderTrade<3> -->
                    <!-- TODO: Update sellTradeHistoryId -->
                    
                    <a href="${_ctx}/sell/confirmFinish?sellId=${sellDetail.sellId}&sellTradeHistoryId=${sellDetail.sellTradeHistoryId}">
                        <div class="btn btn-primary">
                            <spring:message code="common.button.finish.title"/>
                        </div>
                    </a>
                </c:if>

                <!-- ORDER_KIND = TRADER -->
            </c:if>
            <!-- * ROLE = USER -->

            <c:if test="${wallet.wallets.size() > 0
                && (fn:containsIgnoreCase(wallet.wallets, sellDetail.buyerWalletAddress) || fn:containsIgnoreCase(wallet.wallets, sellDetail.sellerWalletAddress))
                && sellDetail.state == 3
                && sellDetail.tradeState == 4}">
                <div class="trade-pop-form-info">
                    <dl class="trade-pop-form-info-item">
                        <dd><spring:message code="sell.detail.transaction.title"/></dd>
                    </dl>
                    <dl class="trade-pop-form-info-item">
                        <dt><spring:message code="sell.detail.transaction.txid.title"/></dt>
                        <dd>${sellDetail.txid}</dd>
                    </dl>
                    <dl class="trade-pop-form-info-item">
                        <dt><spring:message code="sell.detail.transaction.tradeAddress.title"/></dt>
                        <dd>${sellDetail.buyerWalletAddress}</dd>
                    </dl>
                </div>
            </c:if>           
                <div class="btn secondary bnt-close"><spring:message code="common.button.close.title"/></div>
            </div>
        </div>
    </div>
</div>
<!-- * Sell detail info -->
<!-- footer -->
    <%@ include file="/WEB-INF/layout/web/footer.jsp"%>
<!-- * footer -->
<script>
    ///new ClipboardJS('[data-clipboard-text]', {container: document.getElementById('modal-sell-detail'));
    $("#modal-sell-detail").find(".btn-deposit").click(function(){
        var isNN = checkFieldNotNull("#tradeDepositForm");
        if(isNN){
            return;
        }
        submitForm('#tradeDepositForm');
    })
     $(".bnt-close").click(function(){
            window.close();
        })
</script>
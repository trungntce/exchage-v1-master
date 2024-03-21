<%--
  Created by IntelliJ IDEA.
  User: ntt.dev
  The page trade buy detail
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- head -->
<%@ include file="/WEB-INF/layout/web/head.jsp"%>
<!-- Buy detail infor -->
<section class="wrap trade-wrap">

<!-- header -->
	<%@ include file="/WEB-INF/layout/web/header.jsp"%>
    <div class="sub-title trade-title">
        <h2><spring:message code="buy.detail.page.title"/></h2>
        <p><spring:message code="buy.detail.page.content"/></p>
    </div>

    <div class="container" id="modal-buy-detail">
        <script type="text/javascript">
            console.log('buyState: '+${buyDetail.state});
            console.log('tradeState: '+${buyDetail.state});
              console.log('role: '+ '${wallet.role}');
              console.log('buyType: '+ '${buyDetail.buyType}');
        </script>


        <div class="trade-pop-form">
            <div class="form-wrap form-full">
                <spring:message code="common.message.balances.title"/>: <label class="my-balance" wallet-address="${wallet.walletAddress}">N/A</label> BANI
                <div class="form-wrap-txt">${buyDetail.buyerWalletAddress}</div>
            </div>
            <div class="trade-pop-form-btn">
                <div class="btn btn-primary" data-clipboard-text="${buyDetail.buyerWalletAddress}" onclick='alert(`<spring:message code="common.copy.toast.title"/>`)'><spring:message code="common.copy.title"/></div>
            </div>
            <div class="trade-pop-form-btn" style="margin-top: 6px">
                <div class="btn btn-primary" onclick="location.reload();"><i class="fas fa-sync"></i> <spring:message code="trade.status.order.refresh.title"/></div>
            </div>

            <div class="trade-pop-form-info">
                <dl class="trade-pop-form-info-item">
                    <dt><spring:message code="buy.detail.orderNumber.title"/></dt>
                    <dd>${buyDetail.symbol}<fmt:formatDate value="${buyDetail.buyRegDate}" pattern="yyyyMMddHHmmss"/>${buyDetail.buyId}</dd>
                    <dd></dd>
                </dl>
                <dl class="trade-pop-form-info-item">
                    <dt><spring:message code="buy.detail.symbol.title"/></dt>
                    <dd>${buyDetail.symbol}</dd>
                    <dd></dd>
                </dl>
                <dl class="trade-pop-form-info-item">
                    <dt><spring:message code="buy.detail.cnt.title"/></dt>
                    <dd><span><fmt:formatNumber type="number" maxFractionDigits="3" value="${buyDetail.quantity}"/></span><spring:message code="common.unit.count.title"/></dd>
                    <dd></dd>
                </dl>
                <dl class="trade-pop-form-info-item">
                    <dt><spring:message code="buy.detail.unit.title"/></dt>
                    <dd class="price-one"><fmt:formatNumber type="number" maxFractionDigits="3" value="${buyDetail.unitPrice}"/><spring:message code="common.unit.won.title"/></dd>
                    <dd></dd>
                </dl>
                <dl class="trade-pop-form-info-item">
                    <dt><spring:message code="buy.detail.fee.title"/></dt>
                    <dd>0.1<spring:message code="common.unit.count.title"/></dd>
                    <dd></dd>
                </dl>
                <dl class="trade-pop-form-info-item">
                    <dt><spring:message code="buy.detail.price.title"/></dt>
                    <dd>100,000<spring:message code="common.unit.won.title"/> <span>(<spring:message code="buy.detail.fee.title"/> -10,000<spring:message code="common.unit.won.title"/>)</span></dd>
                    <dd></dd>
                </dl>
                <dl class="trade-pop-form-info-item">
                    <dt><spring:message code="buy.detail.totalPrice.title"/></dt>
                    <dd class="price-total"><fmt:formatNumber type="number" maxFractionDigits="3" value="${buyDetail.totalPrice}"/><spring:message code="common.unit.won.title"/></dd>
                    <dd></dd>
                </dl>
                <dl class="trade-pop-form-info-item">
                    <dt><spring:message code="buy.detail.status.title"/></dt>
                    <dd>
                        <c:if test="${buyDetail.state == 1 || buyDetail.state == 2}"><div class="status-btn status-wait">${buyDetail.stateName}</div></c:if>
                        <c:if test="${buyDetail.state == 3}"><div class="status-btn status-ing">${buyDetail.stateName}</div></c:if>
                        <c:if test="${buyDetail.state == 5}"><div class="status-btn status-ing">Cancel</div></c:if>
                    </dd>
                    <dd></dd>
                </dl>
            </div>

            <!-- order status description -->
            <div class="trade-pop-form-alt">
                <c:if test="${buyDetail.state == 1}">
                    <spring:message code="buy.detail.description.wait.title"/>
                </c:if>
                <c:if test="${buyDetail.tradeState == 1}">
                    <spring:message code="buy.detail.description.trade.fist.title"/>
                </c:if>
                <c:if test="${buyDetail.tradeState == 2}">
                    <spring:message code="buy.detail.description.trade.second.title"/>
                </c:if>
                <c:if test="${buyDetail.tradeState == 3}">
                    <spring:message code="buy.detail.description.trade.third.title"/>
                </c:if>
                <c:if test="${buyDetail.tradeState == 4}">
                    <spring:message code="buy.detail.description.trade.four.title"/>
                </c:if>
                <spring:message code="buy.detail.description.trade.common.title"/>
            </div>

            <!-- Action for user -->
            <div class="start-login">
            
            <!-- APPLY -->
            <!-- ROLE = TRADER and buyType = 2(API) -->               
            <c:if test="${(wallet.role == 'TRADER') && buyDetail.buyType == 2}">

                 <!-- CHECK STATE TOKEN_BUY, WHEN STATE == 1 AND BUYER_WALLET_ADDRESS != BUYER_WALLET_ADDRESS (NOT APPLY YOUR BUY REQUEST)-->
                <c:if test="${wallet.wallets.size() > 0 
                    && !fn:containsIgnoreCase(wallet.wallets, buyDetail.buyerWalletAddress) 
                    && buyDetail.state == 1}">
                    <!-- role<USER_ROLE> + order<1> -->
                    
                    <a href="${_ctx}/buyTradeApply?buyId=${buyDetail.buyId}&sellerWalletAddress=${wallet.wallets[0].walletAddress}">
                        <div class="btn btn-primary">
                            <spring:message code="common.button.applyTrade.title"/>
                        </div>
                    </a>
                </c:if>

                <!-- BUY_TYPE = 1 (GENERAL), ONLY TRADER MAYBE APPLY WHEN STATE = 2, NOT APPLY YOUR BUY REQUEST -->
                <c:if test="${wallet.wallets.size() > 0 
                    && fn:containsIgnoreCase(wallet.wallets, buyDetail.sellerWalletAddress) 
                    && buyDetail.state == 2 
                    && buyDetail.viewRole == 'API'}">

                    <a href="${_ctx}/buy/applyWithTransfer?buyId=${buyDetail.buyId}">
                        <div class="btn btn-primary">
                            <spring:message code="common.button.finish.title"/>
                        </div>
                    </a>
                </c:if>
                <!-- IF YOU HAVE APPLY BUY, WHEN STATE = 2 AND TRADE_STATE == 2 THEN CASH_DEPOSIT -->
                <c:if test="${wallet.wallets.size() > 0 
                    && fn:containsIgnoreCase(wallet.wallets, buyDetail.buyerWalletAddress) 
                    && buyDetail.state == 2
                    && buyDetail.tradeState == 2}">
                    <a href="${_ctx}/buyCashDeposit?buyId=${buyDetail.buyId}">
                        <div class="btn btn-primary btn-deposit">
                            <spring:message code="common.button.cashDeposit.title"/>
                        </div>
                    </a>
                </c:if>

            </c:if>
            <!-- * ROLE = TRADER -->

            <!-- CANCEL -->

            <!-- ROLE = USER, IF ROLE = TRADE NEED BUY_TYPE = 1, MAYBE CANCEL WHEN STATE == 1-->
            <c:if test="${(wallet.role == 'USER' || (wallet.role == 'TRADER' && buyDetail.buyType == 1))}">

                <c:if test="${wallet.wallets.size() > 0 
                    && fn:containsIgnoreCase(wallet.wallets, buyDetail.buyerWalletAddress) 
                    && buyDetail.state == 1}">
                    <!-- IS OWNER ORDER + order<1> -->
                    <a href="${_ctx}/buyCancel?buyId=${buyDetail.buyId}">
                        <div class="btn btn-primary">
                            <spring:message code="common.button.cancel.title"/>
                        </div>
                    </a>
                </c:if>
                <!-- THIS ORDER IS NOT YOUR ORDER, YOU CAN APPLY-->
                <c:if test="${wallet.wallets.size() > 0 
                    && !fn:containsIgnoreCase(wallet.wallets, buyDetail.buyerWalletAddress) 
                    && buyDetail.state == 1}">
                    <!-- role<USER_ROLE> + order<1> -->
                    <a href="${_ctx}/buyTradeApply?buyId=${buyDetail.buyId}&sellerWalletAddress=${wallet.wallets[0].walletAddress}">
                        <div class="btn btn-primary">
                            <spring:message code="common.button.apply.title"/>
                        </div>
                    </a>
                </c:if>

                <!-- DEPOSIT - STEP 1, WHEN STATE = 2 AND TRADE_STATE = 1 -->
                <c:if test="${wallet.wallets.size() > 0 
                    && fn:containsIgnoreCase(wallet.wallets, buyDetail.sellerWalletAddress) 
                    && buyDetail.state == 2 
                    && buyDetail.tradeState == 1}">
                    <!-- order<2> + orderTrade<1> + is trader -->
                    <form:form modelAttribute="tradeDepositForm" method="POST" action="${_ctx}/confirmTxId" cssClass="mb-1">

                         <!-- TxID -->
                        <label for="txId" class="input-label" field="NN"><spring:message code="trade.input.txid.title"/></label>
                        <div class="form-wrap form-full">
                            <form:input path="txId" type="text" placeholder="Please enter TxID"/>
                            <label for="txId" class="input-label-error"><spring:message code="trade.input.txid.message"/></label>
                        </div>
                        <!-- * Wallet password -->
                        
                        <form:hidden path="buyId" value="${buyDetail.buyId}"/>
                        <form:hidden path="buyTradeHistoryId" value="${buyDetail.buyTradeHistoryId}"/>
                    </form:form>
                    
                    <div class="btn btn-primary btn-deposit">
                        <spring:message code="common.button.deposit.title"/>
                    </div>
                
                    <!-- TODO: Update buyTradeHistoryId -->
                    <!-- <a href="${_ctx}/buyTradeCancel?buyId=${buyDetail.buyId}&buyTradeHistoryId=${buyDetail.buyTradeHistoryId}">
                        <div class="btn btn-primary">
                            <spring:message code="common.button.cancel.title"/>
                        </div>
                    </a> -->
                </c:if>

                <!-- DEPOSIT - STEP 2 SHOW BANK INFO WHEN INPUT TXID -->
                <c:if test="${wallet.wallets.size() > 0 
                    && fn:containsIgnoreCase(wallet.wallets, buyDetail.buyerWalletAddress) 
                    && buyDetail.state == 2 
                    && buyDetail.tradeState == 2}">
                    <!-- IS OWNER s + order<2> + orderTrade<2>-->

                        <div class="trade-pop-form-info">
                            <dl class="trade-pop-form-info-item">
                                <dd><spring:message code="buy.detail.bank.info.title"/></dd>
                            </dl>
                            <dl class="trade-pop-form-info-item">
                                <dt><spring:message code="buy.detail.bank.owner.title"/></dt>
                                <dd>${buyDetail.bankOwner}</dd>
                            </dl>
                            <dl class="trade-pop-form-info-item">
                                <dt><spring:message code="buy.detail.bank.name.title"/></dt>
                                <dd>${buyDetail.bankName}</dd>
                            </dl>
                            <dl class="trade-pop-form-info-item">
                                <dt><spring:message code="buy.detail.bank.account.title"/></dt>
                                <dd>${buyDetail.bankAccount}</dd>
                            </dl>
                            <dl class="trade-pop-form-info-item">
                                <dt><spring:message code="buy.detail.bank.totalPrice.title"/></dt>
                                <dd><fmt:formatNumber type="number" maxFractionDigits="3" value="${buyDetail.totalPrice}"/></dd>
                            </dl>
                        </div>
                        <c:if test="${buyDetail.buyType != 2 && buyDetail.viewRole != 'API'}">
                            <a href="${_ctx}/buy/confirmCashDeposit?buyId=${buyDetail.buyId}">
                                <div class="btn btn-primary">
                                    <spring:message code="common.button.cashDeposit.title"/>
                                </div>
                            </a>
                        </c:if>
                    <br>
                </c:if>
                <!-- FINISH -->
                <c:if test="${wallet.wallets.size() > 0 
                    && fn:containsIgnoreCase(wallet.wallets, buyDetail.sellerWalletAddress) 
                    && buyDetail.state == 2 && buyDetail.tradeState == 3}">
                    <!-- role<USER_ROLE> + order<2> + orderTrade<3> -->
                    <!-- TODO: Update buyTradeHistoryId -->
                    
                        <a href="${_ctx}/tradeConfirmFinish?buyId=${buyDetail.buyId}&buyTradeHistoryId=${buyDetail.buyTradeHistoryId}">
                            <div class="btn btn-primary">
                                <spring:message code="common.button.finish.title"/>
                            </div>
                        </a>
                    <br>
                </c:if>
            </c:if>
            <!-- * ROLE = USER -->

            <c:if test="${wallet.wallets.size() > 0 
                && (fn:containsIgnoreCase(wallet.wallets, buyDetail.sellerWalletAddress) || fn:containsIgnoreCase(wallet.wallets, buyDetail.buyerWalletAddress))
                && buyDetail.state == 3
                && buyDetail.tradeState == 4}">
                <div class="trade-pop-form-info">
                    <dl class="trade-pop-form-info-item">
                        <dd><spring:message code="buy.detail.transaction.title"/></dd>
                    </dl>
                    <dl class="trade-pop-form-info-item">
                        <dt><spring:message code="buy.detail.transaction.txid.title"/></dt>
                        <dd>${buyDetail.txid}</dd>
                    </dl>
                    <dl class="trade-pop-form-info-item">
                        <dt><spring:message code="buy.detail.transaction.tradeAddress.title"/></dt>
                        <dd>${buyDetail.sellerWalletAddress}</dd>
                    </dl>
                </div>
            </c:if>            
                                       
                <a class="btn secondary" href="${_ctx}/trade"><spring:message code="common.button.goList.title"/></a>
            </div>
        </div>
    </div>
<!-- * Buy detail infor -->
</div>
<!-- footer -->
    <%@ include file="/WEB-INF/layout/web/footer.jsp"%>
<!-- * footer -->
<script>
    //new ClipboardJS('[data-clipboard-text]', {container: document.getElementById('modal-buy-detail'));
    $("#modal-buy-detail").find(".btn-deposit").click(function(){
        var isNN = checkFieldNotNull("#tradeDepositForm");
        if(isNN){
            return;
        }

        submitForm('#tradeDepositForm');
    })
</script>
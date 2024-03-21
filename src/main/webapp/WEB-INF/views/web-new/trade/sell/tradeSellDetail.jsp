<%--
  Created by IntelliJ IDEA.
  User: ntt.dev
  The page trade sell detail
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- head -->
<%@ include file="/WEB-INF/layout/web-new/include/head.jsp"%>
<!-- #head -->
<body class="pace-done">
    <div class="wrapper">

            <!-- Sell detail info -->

            <section class="wrap trade-wrap">
                <script type="text/javascript">console.log('${wallet.role}')</script>
                <!-- header -->
                  <%@ include file="/WEB-INF/layout/web-new/include/header.jsp"%>
                <!-- #header -->
               <!--  <article class="sub-title sub-title--trade">
                    <h2><spring:message code="sell.detail.page.title"/></h2>
                    <p><spring:message code="sell.detail.page.content"/></p>
                </article> -->
                <div class="container" id="modal-sell-detail">

                    <div class="trade-pop-form">
                        <div class="form-wrap form-full">
                             <c:if test="${sellDetail.symbol eq 'BANI' || sellDetail.symbol eq 'EGG'}">  
                                <div class="form-full" id="balance-trade">
                                    <spring:message code="common.message.balances.title"/>: <label class="my-balance" wallet-address="${wallet_current.walletAddress}"></label> ${sellDetail.symbol}
                                    <input type="hidden" class="m-test"/>
                                    <br>
                                </div>
                            </c:if>                            
                           <!-- <spring:message code="buy.request.choose.your.wallet"/>: -->
                            <select name="buyerWalletAddress" class="walletSelect">
                                <c:forEach items="${wallet.wallets}" var="item" varStatus="loop">
                                    <c:choose>
                                        <c:when test="${item.walletAddress == walletCurrent.walletAddress}">
                                            <option value="${item.walletAddress}" fee="${item.fee}" selected>${item.walletAddress}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${item.walletAddress}" fee="${item.fee}">${item.walletAddress}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </select>
                        </div>
                        <br>

                        <c:choose>
                                <c:when test="${walletCurrent.walletAddress != null
                                    && fn:containsIgnoreCase(walletCurrent.walletAddress, sellDetail.sellerWalletAddress)}">
                                    <c:if test="${sellDetail.buyerWalletAddress != null}">
                                        <spring:message code="search.name.keywordType.option.buyer.wallet.title"/>
                                        <div class="form-wrap-txt form-wrap-txt2" data-clipboard-text="${sellDetail.buyerWalletAddress}" onclick='alert(`<spring:message code="common.copy.toast.title"/>`)'>${sellDetail.buyerWalletAddress}
                                        </div>
                                    </c:if>
                                </c:when>
                                <c:otherwise>
                                    <spring:message code="search.name.keywordType.option.seller.wallet.title"/>
                                    <div class="form-wrap-txt form-wrap-txt2" data-clipboard-text="${sellDetail.sellerWalletAddress}" onclick='alert(`<spring:message code="common.copy.toast.title"/>`)'>${sellDetail.sellerWalletAddress}
                                    </div>
                                </c:otherwise>
                            </c:choose>                        
                        <br>
                        <!--
                        <div class="trade-pop-form-btn">
                            <div class="btn btn-primary" data-clipboard-text="${sellDetail.sellerWalletAddress}" onclick='alert(`<spring:message code="common.copy.toast.title"/>`)'><spring:message code="common.copy.title"/></div>
                            TODO: copy clipboard
                        </div>
                    -->
                        <c:if test="${null != userChat.userId && sellDetail.state != 1}">
                             <div class="trade-pop-form-btn" style="margin-top: 6px">
                                <div class="btn btn-primary btn-show-chat"><i class="fas fa-sync"></i> <spring:message code="trade.send.messages.to.user.title"/></div>
                            </div>   
                        </c:if>
                       
                        <div class="trade-pop-form-btn" style="margin-top: 6px">
                            <div class="btn btn-primary" onclick="location.reload();"><i class="bi bi-arrow-repeat"></i> <spring:message code="trade.status.order.refresh.title"/></div>
                        </div>

                        <div class="trade-pop-form-info">
                            <dl class="trade-pop-form-info-item ex-height-auto">
                                <dt class="ex-height-auto"><spring:message code="sell.detail.orderNumber.title"/></dt>
                                <dd>${sellDetail.symbol}<fmt:formatDate value="${sellDetail.sellRegDate}" pattern="yyyyMMddHHmmss"/>${sellDetail.sellId}</dd>
                            </dl>
                            <dl class="trade-pop-form-info-item ex-height-auto">
                                <dt class="ex-height-auto"><spring:message code="sell.detail.symbol.title"/></dt>
                                <dd>${sellDetail.symbol}</dd>
                            </dl>
                            <dl class="trade-pop-form-info-item ex-height-auto">
                                <dt class="ex-height-auto"><spring:message code="history.table.total.quantity.title"/></dt>
                                <dd><span id="totalQuantity"><fmt:formatNumber type="number" maxFractionDigits="3" value="${sellDetail.quantity}"/></span> <spring:message code="common.unit.count.title"/></dd>
                            </dl>
                            <dl class="trade-pop-form-info-item ex-height-auto">
                                <dt class="ex-height-auto"><spring:message code="sell.detail.unit.title"/></dt>
                                <dd class="price-one"><fmt:formatNumber type="number" maxFractionDigits="3" value="${sellDetail.unitPrice}"/><spring:message code="common.unit.won.title"/></dd>
                            </dl>
                            <dl class="trade-pop-form-info-item ex-height-auto">
                            <dt class="ex-height-auto"><spring:message code="sell.detail.price.title"/></dt>
                            <dd>
                                <fmt:formatNumber type="number" maxFractionDigits="3" value="${sellDetail.unitPrice}"/> <spring:message code="common.unit.won.title"/> 
                                <div class="space-mobile"></div>
                                    <c:if test="${sellDetail.viewRole == 'API' || sellDetail.viewRole == 'USER'}">
                                        <span>(<spring:message code="buy.detail.fee.title"/> 
                                        <span id="fee-title"> <fmt:formatNumber type="number" maxFractionDigits="3" value="${sellDetail.totalPrice - sellDetail.unitPrice}"/> <spring:message code="common.unit.won.title"/>)</span>
                                    </c:if>
                                  
                            </dd>
                        </dl>
                            <dl class="trade-pop-form-info-item ex-height-auto">
                                <dt class="ex-height-auto"><spring:message code="sell.detail.totalPrice.title"/></dt>
                                <dd class="price-total"><fmt:formatNumber type="number" maxFractionDigits="3" value="${sellDetail.totalPrice}"/> <spring:message code="common.unit.won.title"/></dd>
                            </dl>
                            <c:if test="${sellDetail.viewRole == 'OWNER_SAFE'}" >
                                <dl class="trade-pop-form-info-item ex-height-auto">
                                    <dt class="ex-height-auto"><spring:message code="common.admin.field.type.title"/></dt>
                                    <dd>SAFE</dd>
                                </dl>
                            </c:if>
                            
                            <dl class="trade-pop-form-info-item ex-height-auto">
                                <dt class="ex-height-auto"><spring:message code="sell.detail.status.title"/></dt>
                                <dd>
                                    <c:if test="${sellDetail.state == 1 || sellDetail.state == 2}"><div class="status-btn status-wait">${sellDetail.stateName} <img src="${_ctx}/resources/img/loading.gif" style="width: 15px; margin-left: 4px;"></div></c:if>
                                    <c:if test="${sellDetail.state == 3}"><div class="status-btn status-ing">${sellDetail.stateName}</div></c:if>
                                    <c:if test="${sellDetail.state == 4}"><div class="status-btn status-ing">${sellDetail.stateName} <img src="${_ctx}/resources/img/loading.gif" style="width: 15px; margin-left: 4px;"></div></c:if>
                                    <c:if test="${sellDetail.state == 5}"><div class="status-btn status-ing">Cancel</div></c:if>
                                </dd>
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

                        <!-- ROLE = TRADER || CLIENT_TRADER  AND SELL_TYPE = 2 (API) -->

                        <!-- OP x Trader -->
                        <c:if test="${sellDetail.viewRole == 'TRADER' 
                            && walletCurrent.role == 'TRADER'
                            && sellDetail.state == 2
                            && sellDetail.tradeState == 2}">
                            <div class="trade-pop-form-info">
                                <dl class="trade-pop-form-info-item ex-height-auto">
                                    <dd><spring:message code="sell.detail.bank.info.title"/></dd>
                                </dl>
                                <dl class="trade-pop-form-info-item ex-height-auto">
                                    <dt class="ex-height-auto"><spring:message code="sell.detail.bank.owner.title"/></dt>
                                    <dd>${sellDetail.bankOwner}</dd>
                                </dl>
                                <dl class="trade-pop-form-info-item ex-height-auto">
                                    <dt class="ex-height-auto"><spring:message code="sell.detail.bank.name.title"/></dt>
                                    <dd>${sellDetail.bankName}</dd>
                                </dl>
                                <dl class="trade-pop-form-info-item ex-height-auto">
                                    <dt class="ex-height-auto"><spring:message code="sell.detail.bank.account.title"/></dt>
                                    <dd>${sellDetail.bankAccount}</dd>
                                </dl>
                                <dl class="trade-pop-form-info-item ex-height-auto">
                                    <dt class="ex-height-auto"><spring:message code="sell.detail.bank.totalPrice.title"/></dt>
                                    <dd><fmt:formatNumber type="number" maxFractionDigits="3" value="${sellDetail.totalPrice}"/></dd>
                                </dl>
                            </div>

                            <a href="${_ctx}/sell/applyWithTransfer?sellId=${sellDetail.sellId}">
                                <div class="btn btn-primary"><spring:message code="common.button.finish.title"/></div>
                            </a>
                        </c:if>
                        
                        <c:if test="${((walletCurrent.role == 'TRADER' || walletCurrent.role == 'CLIENT_TRADER' ) && sellDetail.sellType == 2)}">


                            <!-- WHEN ORDER IS NOT YOUR ORDER AND STATE == 1, MAYBE APPLY SELL -->
                            <c:if test="${walletCurrent.walletAddress != null
                                && !fn:containsIgnoreCase(walletCurrent.walletAddress, sellDetail.sellerWalletAddress)
                                && !fn:containsIgnoreCase(walletCurrent.walletAddress, sellDetail.regWalletAddress)
                                && sellDetail.state == 1}">
                                <!-- role<USER_ROLE> + order<1> -->

                                    <a href="${_ctx}/sellTradeApply?sellId=${sellDetail.sellId}&buyerWalletAddress=${walletCurrent.walletAddress}">
                                        <div class="btn btn-primary">
                                            <spring:message code="common.button.applyTrade.title"/>
                                        </div>
                                    </a>
                            </c:if>

                            <!-- WHEN ORDER IS NOT YOUR ORDER AND STATE = 2, TRADE_STATE = 1 AND SELL_TYPE = 2 (API), MAY BE USE TRANSFER  -->
                            <c:if test="${walletCurrent.walletAddress != null
                                && fn:containsIgnoreCase(walletCurrent.walletAddress, sellDetail.sellerWalletAddress)
                                && sellDetail.state == 2
                                && sellDetail.tradeState == 1
                                && sellDetail.sellType == 2
                                && (sellDetail.viewRole == 'TRADER'
                                    || sellDetail.viewRole == 'CLIENT_TRADER')}">

                                    <a href="${_ctx}/sell/applyWithTransfer?sellId=${sellDetail.sellId}">
                                        <div class="btn btn-primary">
                                            <spring:message code="common.button.transfer.title"/>
                                        </div>
                                    </a>
                            </c:if>

                            <c:if test="${walletCurrent.walletAddress != null
                                && (fn:containsIgnoreCase(walletCurrent.walletAddress, sellDetail.buyerWalletAddress)
                                    || fn:containsIgnoreCase(walletCurrent.walletAddress, sellDetail.regWalletAddress))
                                && sellDetail.state == 2
                                && sellDetail.sellType == 2
                                && (sellDetail.viewRole == 'API'
                                    || sellDetail.viewRole == 'CLIENT_TRADER')}">
                                <div class="trade-pop-form-info">
                                    <dl class="trade-pop-form-info-item ex-height-auto">
                                        <dd><spring:message code="sell.detail.bank.info.title"/></dd>
                                    </dl>
                                    <dl class="trade-pop-form-info-item ex-height-auto">
                                        <dt class="ex-height-auto"><spring:message code="sell.detail.bank.owner.title"/></dt>
                                        <dd>${sellDetail.bankOwner}</dd>
                                    </dl>
                                    <dl class="trade-pop-form-info-item ex-height-auto">
                                        <dt class="ex-height-auto"><spring:message code="sell.detail.bank.name.title"/></dt>
                                        <dd>${sellDetail.bankName}</dd>
                                    </dl>
                                    <dl class="trade-pop-form-info-item ex-height-auto">
                                        <dt class="ex-height-auto"><spring:message code="sell.detail.bank.account.title"/></dt>
                                        <dd>${sellDetail.bankAccount}</dd>
                                    </dl>
                                    <dl class="trade-pop-form-info-item ex-height-auto">
                                        <dt class="ex-height-auto"><spring:message code="sell.detail.bank.totalPrice.title"/></dt>
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
                        <c:if test="${(walletCurrent.role == 'USER' || walletCurrent.role == 'TRADER')}">
                            <c:if test="${walletCurrent.walletAddress != null
                                && (fn:containsIgnoreCase(walletCurrent.walletAddress, sellDetail.sellerWalletAddress)
                                    || fn:containsIgnoreCase(walletCurrent.walletAddress, sellDetail.regWalletAddress) )
                                && sellDetail.state == 1}">
                                <!-- IS OWNER ORDER + order<1> -->
                                <a href="${_ctx}/sellCancel?sellId=${sellDetail.sellId}">
                                    <div class="btn btn-primary">
                                        <spring:message code="common.button.cancel.title"/>
                                    </div>
                                </a>
                            </c:if>

                            <c:if test="${walletCurrent.walletAddress != null
                                && !fn:containsIgnoreCase(walletCurrent.walletAddress, sellDetail.sellerWalletAddress)
                                && !fn:containsIgnoreCase(walletCurrent.walletAddress, sellDetail.regWalletAddress)
                                && (walletCurrent.role == 'USER' || (walletCurrent.role == 'TRADER'))
                                && sellDetail.state == 1
                                && sellDetail.sellType == 1}">
                                <!-- role<USER_ROLE> + order<1> -->

                                <a href="${_ctx}/sellTradeApply?sellId=${sellDetail.sellId}&buyerWalletAddress=${walletCurrent.walletAddress}">
                                    <div class="btn btn-primary">
                                        <spring:message code="common.button.apply.title"/>
                                    </div>
                                </a>
                            </c:if>

                            <c:if test="${walletCurrent.walletAddress != null
                                && fn:containsIgnoreCase(walletCurrent.walletAddress, sellDetail.buyerWalletAddress)
                                && sellDetail.state == 2
                                && sellDetail.tradeState == 1
                                && sellDetail.sellType == 1}">
                                <!-- IS OWNER s + order<2> + orderTrade<1>-->

                                <div class="trade-pop-form-info">
                                    <dl class="trade-pop-form-info-item ex-height-auto">
                                        <dd><spring:message code="sell.detail.bank.info.title"/></dd>
                                    </dl>
                                    <dl class="trade-pop-form-info-item ex-height-auto">
                                        <dt class="ex-height-auto"><spring:message code="sell.detail.bank.owner.title"/></dt>
                                        <dd>${sellDetail.bankOwner}</dd>
                                    </dl>
                                    <dl class="trade-pop-form-info-item ex-height-auto">
                                        <dt class="ex-height-auto"><spring:message code="sell.detail.bank.name.title"/></dt>
                                        <dd>${sellDetail.bankName}</dd>
                                    </dl>
                                    <dl class="trade-pop-form-info-item ex-height-auto">
                                        <dt class="ex-height-auto"><spring:message code="sell.detail.bank.account.title"/></dt>
                                        <dd>${sellDetail.bankAccount}</dd>
                                    </dl>
                                    <dl class="trade-pop-form-info-item ex-height-auto">
                                        <dt class="ex-height-auto"><spring:message code="sell.detail.bank.totalPrice.title"/></dt>
                                        <dd><fmt:formatNumber type="number" maxFractionDigits="3" value="${sellDetail.totalPrice}"/></dd>
                                    </dl>
                                </div>

                                <a href="${_ctx}/sell/confirmCashDeposit?sellId=${sellDetail.sellId}&sellTradeHistoryId=${sellDetail.sellTradeHistoryId}">
                                    <div class="btn btn-primary">
                                        <spring:message code="common.button.cashDeposit.title"/>
                                    </div>
                                </a>
                            </c:if>

                            <c:if test="${walletCurrent.walletAddress != null
                                && (fn:containsIgnoreCase(walletCurrent.walletAddress, sellDetail.sellerWalletAddress)
                                    || fn:containsIgnoreCase(walletCurrent.walletAddress, sellDetail.regWalletAddress))
                                && sellDetail.state == 2
                                && sellDetail.tradeState == 2}">
                                <!-- IS OWNER s + order<2> + orderTrade<1>-->
                                <form id="tradeDepositForm" method="POST" action="${_ctx}/sell/confirmTxId" cssClass="mb-1">
                                     <!-- TxID -->
                                    <label for="txId" class="input-label" field="NN"><spring:message code="trade.input.txid.title"/></label>
                                    <div class="form-wrap form-full">
                                        <input name="txId" type="text" placeholder="Please enter TxID"/>
                                    </div>
                                    <div class="input-info message" hidden><spring:message code="trade.input.txid.message"/></div>
                                    <!-- * Wallet password -->

                                    <input hidden name="sellId" value="${sellDetail.sellId}"/>
                                    <input hidden name="sellTradeHistoryId" value="${sellDetail.sellTradeHistoryId}"/>
                                </form>

                                <div class="btn btn-primary btn-deposit">
                                    <spring:message code="common.button.deposit.title"/>
                                </div>
                            </c:if>

                            <c:if test="${walletCurrent.walletAddress != null
                                && fn:containsIgnoreCase(walletCurrent.walletAddress, sellDetail.buyerWalletAddress)
                                && sellDetail.state == 2
                                && sellDetail.tradeState == 3}">
                                <!-- role<USER_ROLE> + order<2> + orderTrade<3> -->
                                <!-- TODO: Update sellTradeHistoryId -->
                                <div class="trade-pop-form-info">
                                <dl class="trade-pop-form-info-item">
                                    <dd><spring:message code="sell.detail.transaction.title"/></dd>
                                </dl>
                                <dl class="trade-pop-form-info-item ex-height-auto">
                                    <dt class="ex-height-auto"><spring:message code="sell.detail.transaction.txid.title"/></dt>
                                    <dd>${sellDetail.txid}</dd>
                                </dl>
                               <!--  <dl class="trade-pop-form-info-item ex-height-auto">
                                    <dt class="ex-height-auto"><spring:message code="sell.detail.transaction.tradeAddress.title"/></dt>
                                    <dd>${sellDetail.buyerWalletAddress}</dd>
                                </dl> -->
                            </div>

                                <a href="${_ctx}/sell/confirmFinish?sellId=${sellDetail.sellId}&sellTradeHistoryId=${sellDetail.sellTradeHistoryId}">
                                    <div class="btn btn-primary">
                                        <spring:message code="common.button.finish.title"/>
                                    </div>
                                </a>
                            </c:if>

                            <!-- ORDER_KIND = TRADER -->
                        </c:if>
                        <!-- * ROLE = USER -->

                        <c:if test="${walletCurrent.walletAddress != null
                            && (fn:containsIgnoreCase(walletCurrent.walletAddress, sellDetail.buyerWalletAddress)
                                || fn:containsIgnoreCase(walletCurrent.walletAddress, sellDetail.sellerWalletAddress)
                                || fn:containsIgnoreCase(walletCurrent.walletAddress, sellDetail.regWalletAddress))
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
                            <a class="btn secondary" onclick="btnSellBack()"><spring:message code="common.button.goList.title"/></a>
                        </div>
                    </div>
                </div>
            </div>
<!-- * Sell detail info -->
    <!-- footer -->
     <%@ include file="/WEB-INF/layout/web-new/include/footer.jsp"%>
    <!-- #footer -->
        </section>
    </div>
</body>
<script>
    window.setInterval('loadDetail()', 3000);
    async function loadDetail(){
        var api = "/api/sell/detail";
        var param = {sellId: "${sellDetail.sellId}"};
        var res = await $.when(rest.get(api, param));
         if( res.tradeState != null && (res.tradeState != '${sellDetail.tradeState}' || res.state != '${sellDetail.state}')){
            location.reload();
        }
    }
      $(document).ready(function(){

        var valWallet = '${walletCurrent.walletAddress}';
        $('.walletSelect option[value='+valWallet+']').attr('selected','selected');
        $(this).find(".my-balance").attr("wallet-address", valWallet);
        new ClipboardJS("[data-clipboard-text]")
        loadBalanceWeb({walletAddress: valWallet, symbol: '${sellDetail.symbol}'});
    })
    $(".walletSelect").change(async function(){
        var url = changeSearchParam({walletAddress: $(this).find("option:selected").val()})
        document.location.href = url;
    });
    function loadBalancesInList(address){
        var param = {listAddress: []};
        if(address == null){
            $("#tbl-wallets").find(".my-balance[wallet-address]").each(function(){
                param.listAddress.push($(this).attr("wallet-address"))
            })
        }else{
            param.listAddress.push(address);
        }
        loadBalanceWeb(param);
    }
    $("#modal-sell-detail").find(".btn-deposit").click(function(){
        var isNN = checkFieldNotNull("#tradeDepositForm");
        if(isNN){
            return;
        }
        $('#tradeDepositForm').submit();
    })

    function btnSellBack(){
            if (history.length > 1 && !document.referrer.includes('tradeSellDetail')){
                history.go(-1);
                return;
            }
            window.location.href="${_ctx}/trade?targetView=%23sell-order";
    }
</script>
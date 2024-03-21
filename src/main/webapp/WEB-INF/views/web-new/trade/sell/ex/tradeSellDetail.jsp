<%--
  Created by IntelliJ IDEA.
  User: ntt.dev
  The page trade sell detail
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- head -->
<%@ include file="/WEB-INF/layout/web-new/include/head.jsp"%>
<c:if test="${not empty mess}">
  <script>    
      alert('<c:out value="${mess}" />');
  </script>
</c:if>
<!-- #head -->
<body class="pace-done">
    <div class="mask"></div>
    <div class="wrapper ex-wrapper">
        <!-- Sell detail info -->

        <section class="wrap trade-wrap">
            <script type="text/javascript">console.log('${wallet.role}')</script>
            <!-- <article class="sub-title sub-title--trade">
                <h2><spring:message code="sell.detail.page.title"/></h2>
                <p><spring:message code="sell.detail.page.content"/></p>
            </article> -->
            <div class="container" id="modal-sell-detail">
                <div class="language-list">
                    <div class="language-list__inner">
                        <a class="language-list__item language-list__item--ko is-current" href="" onclick="changeLanguage('ko_KR')">
                            <img src="${_ctx}/resources/skinWeb/images/lang_ko.svg" alt="한국어">
                            <b><spring:message code="header.language.ko"/></b>
                        </a>
                        <a class="language-list__item language-list__item--en" href="" onclick="changeLanguage('en_US')">
                            <img src="${_ctx}/resources/skinWeb/images/lang_en.svg" alt="영어">
                            <b><spring:message code="header.language.en"/></b>
                        </a>                       
                    </div>
                </div>
                 <br>
                <button href="" id="feedback-web" title='<spring:message code="feedback.title.create"/>' onclick="javascript:showModal('#feedbackRequestModal', false)" style="float: right;">
                            <i class="ci ci-feedback"></i><b><spring:message code="feedback.title.create"/></b>
                </button> 
                <br>   
                <br>
                <div class="trade-pop-form">
                    <div class="form-wrap form-full">
                     <div class="trade-pop-form">                        
                        <div class="form-wrap form-full">
                           <!-- <spring:message code="buy.request.choose.your.wallet"/>:  -->
                           <spring:message code="common.message.balances.title"/>: <label class="my-balance" wallet-address="${wallet.walletAddress}">N/A</label> ${sellDetail.symbol}

                           <select name="buyerWalletAddress" class="walletSelect">
                                <c:forEach items="${wallet.wallets}" var="item" varStatus="loop">
                                    <c:choose>
                                        <c:when test="${item.walletAddress == sellDetail.sellerWalletAddress}">
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
                            <c:when test="${wallet.wallets[0].walletAddress != null
                                && fn:containsIgnoreCase(wallet.wallets[0].walletAddress, sellDetail.sellerWalletAddress)}">
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
                        
                        <!--  <div class="form-wrap-txt form-wrap-txt2" data-clipboard-text="${sellDetail.sellerWalletAddress}" onclick='alert(`<spring:message code="common.copy.toast.title"/>`)'>${sellDetail.sellerWalletAddress}
                        </div> -->
                    </div>
                    <br>
                    
                    <div class="trade-pop-form-btn" style="margin-top: 6px">
                        <div class="btn btn-primary" onclick="location.reload();"><i class="fas fa-sync"></i> <spring:message code="trade.status.order.refresh.title"/></div>
                    </div>

                    <div class="trade-pop-form-info">
                        <dl class="trade-pop-form-info-item ex-height-auto">
                            <dt><spring:message code="sell.detail.orderNumber.title"/></dt>
                            <dd>${sellDetail.symbol}<fmt:formatDate value="${sellDetail.sellRegDate}" pattern="yyyyMMddHHmmss"/>${sellDetail.sellId}</dd>
                        </dl>
                        <dl class="trade-pop-form-info-item">
                            <dt><spring:message code="sell.detail.symbol.title"/></dt>
                            <dd>${sellDetail.symbol}</dd>
                        </dl>
                        <!--  <dl class="trade-pop-form-info-item">
                            <dt><spring:message code="sell.detail.cnt.title"/></dt>
                            <dd><span><fmt:formatNumber type="number" maxFractionDigits="3" value="${sellDetail.quantity}"/></span> <spring:message code="common.unit.count.title"/></dd>
                        </dl> -->
                       <!--  <dl class="trade-pop-form-info-item">
                            <dt><spring:message code="sell.detail.fee.title"/></dt>
                            <dd>${wallet.fee} <spring:message code="common.unit.count.title"/></dd>
                            <dd></dd>
                        </dl> -->
                         <dl class="trade-pop-form-info-item ex-height-auto">
                            <dt class="ex-height-auto"><spring:message code="history.table.total.quantity.title"/></dt>
                            <dd><span id="totalQuantity"><fmt:formatNumber type="number" maxFractionDigits="3" value="${sellDetail.quantity}"/></span> <spring:message code="common.unit.count.title"/></dd>
                        </dl>                        
                        <!-- <dl class="trade-pop-form-info-item">
                            <dt><spring:message code="sell.detail.unit.title"/></dt>
                            <dd class="price-one"><fmt:formatNumber type="number" maxFractionDigits="3" value="${sellDetail.unitPrice}"/> <spring:message code="common.unit.won.title"/></dd>
                        </dl>   -->
                        <dl class="trade-pop-form-info-item ex-height-auto">
                            <dt class="ex-height-auto"><spring:message code="sell.detail.price.title"/></dt>
                            <dd>
                                <fmt:formatNumber type="number" maxFractionDigits="3" value="${sellDetail.unitPrice}"/> <spring:message code="common.unit.won.title"/> 
                                <div class="space-mobile"></div>
                                <span>(<spring:message code="buy.detail.fee.title"/> <span id="fee-title"> <fmt:formatNumber type="number" maxFractionDigits="3" value="${sellDetail.totalPrice - sellDetail.unitPrice}"/> <spring:message code="common.unit.won.title"/>)</span>
                            </dd>
                        </dl>
                        <dl class="trade-pop-form-info-item ex-height-auto">
                            <dt class="ex-height-auto"><spring:message code="sell.detail.totalPrice.title"/></dt>
                            <dd class="price-total"><fmt:formatNumber type="number" maxFractionDigits="3" value="${sellDetail.totalPrice}"/> <spring:message code="common.unit.won.title"/></dd>
                        </dl>
                        <dl class="trade-pop-form-info-item ex-height-auto">
                            <dt class="ex-height-auto"><spring:message code="sell.detail.status.title"/></dt>
                            <dd>
                                <c:if test="${sellDetail.state == 1 || sellDetail.state == 2}"><div class="status-btn status-wait" field="state-name">${sellDetail.stateName} <img class="ico-loading-status" src="${_ctx}/resources/img/loading.gif" style="width: 15px; margin-left: 4px;"></div></c:if>
                                <c:if test="${sellDetail.state == 3}">
                                    <div class="status-btn status-ing" field="state-name">${sellDetail.stateName}
                                    </div>
                                </c:if>
                                <c:if test="${sellDetail.state == 4}"><div class="status-btn status-ing" field="state-name">${sellDetail.stateName} <img class="ico-loading-status" src="${_ctx}/resources/img/loading.gif" style="width: 15px; margin-left: 4px;"></div></c:if>
                                <c:if test="${sellDetail.state == 5}"><div class="status-btn status-ing" field="state-name">Cancel</div></c:if>
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

                    <!-- ROLE = USER -->
                    <c:if test="${(wallet.role == 'USER')}">
                        <c:if test="${wallet.wallets.size() > 0
                            && fn:containsIgnoreCase(wallet.wallets, sellDetail.sellerWalletAddress)
                            && sellDetail.state == 1}">
                            <!-- IS OWNER ORDER + order<1> -->
                            <a href="${_ctx}/sellCancel?sellId=${sellDetail.sellId}&type=ex">
                                <div class="btn btn-primary">
                                    <spring:message code="common.button.cancel.title"/>
                                </div>
                            </a>
                        </c:if>
                       
                        <c:if test="${wallet.wallets.size() > 0
                            && fn:containsIgnoreCase(wallet.wallets, sellDetail.buyerWalletAddress)
                            && sellDetail.state == 2                         
                            && sellDetail.sellType == 2}">
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

                           <!--  <a href="${_ctx}/sell/confirmCashDeposit?sellId=${sellDetail.sellId}&sellTradeHistoryId=${sellDetail.sellTradeHistoryId}">
                                <div class="btn btn-primary">
                                    <spring:message code="common.button.cashDeposit.title"/>
                                </div>
                            </a> -->
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
                            <dl class="trade-pop-form-info-item ex-height-auto">
                                <dt class="ex-height-auto"><spring:message code="sell.detail.transaction.txid.title"/></dt>
                                <dd>${sellDetail.txid}</dd>
                            </dl>
                            <dl class="trade-pop-form-info-item ex-height-auto">
                                <dt class="ex-height-auto"><spring:message code="sell.detail.transaction.tradeAddress.title"/></dt>
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
    </div>
</body>
<%@ include file="/WEB-INF/layout/web-new/modals/feedbackModal.jsp"%>
<%@ include file="/WEB-INF/layout/web-new/modals/feedbackRequestModal.jsp"%>
<script>
     $(document).ready(function(){
        $(".walletSelect").change();
        $('#fee-title').html ='${sellDetail.totalPrice - sellDetail.unitPrice}';
    });
    $(".walletSelect").change(async function(){
        
        var valWallet = $(this).find("option:selected").val();        
        $(this).find(".my-balance").attr("wallet-address", valWallet);        
        loadBalanceWeb({walletAddress: valWallet, symbol: '${sellDetail.symbol}'});
    });
    
    $("#modal-sell-detail").find(".btn-deposit").click(function(){
        var isNN = checkFieldNotNull("#tradeDepositForm");
        if(isNN){
            return;
        }
        $('#tradeDepositForm').submit();
    })

    $(".bnt-close").click(function(){
        window.close();
    })
    window.setInterval(' $(".walletSelect").change()', 5000);
    window.setInterval('loadDetail()', 3000);
    async function loadDetail(){
        var api = "/api/sell/detail";
        var param = {sellId: "${sellDetail.sellId}"};
        var res = await $.when(rest.get(api, param));       
         if( res.tradeState != null && res.tradeState != '${sellDetail.tradeState}'){          
            location.reload();
        }

       
    }
</script>
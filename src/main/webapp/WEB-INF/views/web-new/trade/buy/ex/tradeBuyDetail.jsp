<%--
  Created by IntelliJ IDEA.
  User: ntt.dev
  The page trade buy detail
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- head -->
<%@ include file="/WEB-INF/layout/web-new/include/head.jsp"%>
<!-- #head -->
<c:if test="${not empty mess}">
  <script>    
      alert('<c:out value="${mess}" />');
  </script>
</c:if>
<body class="pace-done">
    <div class="mask"></div>
    <div class="wrapper ex-wrapper">
        <!-- Buy detail infor -->
        <section class="wrap trade-wrap">
           <article class="sub-title sub-title--trade">
                <h2><spring:message code="buy.detail.page.title"/></h2>
                <p><spring:message code="buy.detail.page.content"/></p>
           </article>

            <div class="container" id="modal-buy-detail">
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
                         <spring:message code="common.message.balances.title"/>: <label class="my-balance" wallet-address="${wallet.walletAddress}">N/A</label> ${buyDetail.symbol}      
                          <br>  <br>                    
                            <div class="form-wrap form-full">
                               <!-- <spring:message code="buy.request.choose.your.wallet"/>:  -->
                               <select name="buyerWalletAddress" class="walletSelect">
                                    <c:forEach items="${wallet.wallets}" var="item" varStatus="loop">
                                        <c:choose>
                                            <c:when test="${item.walletAddress == buyDetail.sellerWalletAddress}">
                                                <option value="${item.walletAddress}" fee="${item.fee}" selected>${item.walletAddress}</option>
                                            </c:when>
                                            <c:otherwise>
                                                <option value="${item.walletAddress}" fee="${item.fee}">${item.walletAddress}</option>
                                            </c:otherwise>
                                        </c:choose>
                                    </c:forEach>
                                </select>
                            </div>  
                                  

                        <c:choose>
                            <c:when test="${wallet.wallets[0].walletAddress != null
                                && fn:containsIgnoreCase(wallet.wallets[0].walletAddress, buyDetail.buyerWalletAddress)}">
                                <c:if test="${buyDetail.sellerWalletAddress !=null}">
                                    <spring:message code="search.name.keywordType.option.seller.wallet.title"/>                                
                                    <div class="form-wrap-txt form-wrap-txt2" data-clipboard-text="${buyDetail.sellerWalletAddress}" onclick='alert(`<spring:message code="common.copy.toast.title"/>`)'>${buyDetail.sellerWalletAddress}
                                    </div>    
                                </c:if>
                                
                            </c:when>
                            <c:otherwise>
                                <spring:message code="search.name.keywordType.option.buyer.wallet.title"/>
                                    <div class="form-wrap-txt form-wrap-txt2" data-clipboard-text="${buyDetail.buyerWalletAddress}" onclick='alert(`<spring:message code="common.copy.toast.title"/>`)'>${buyDetail.buyerWalletAddress}
                                    </div>
                            </c:otherwise>
                        </c:choose>
                    </div>
                     <br>
                    <div class="trade-pop-form-btn" style="margin-top: 6px">
                        <div class="btn btn-primary" onclick="location.reload();"><i class="fas fa-sync"></i> <spring:message code="trade.status.order.refresh.title"/></div>
                    </div>

                    <div class="trade-pop-form-info">
                        <dl class="trade-pop-form-info-item ex-height-auto">
                            <dt class="ex-height-auto"><spring:message code="buy.detail.orderNumber.title"/></dt>
                            <dd>${buyDetail.symbol}<fmt:formatDate value="${buyDetail.buyRegDate}" pattern="yyyyMMddHHmmss"/>${buyDetail.buyId}</dd>
                        </dl>
                        <dl class="trade-pop-form-info-item">
                            <dt><spring:message code="buy.detail.symbol.title"/></dt>
                            <dd>${buyDetail.symbol}</dd>
                        </dl>
                        <dl class="trade-pop-form-info-item ex-height-auto">
                            <dt class="ex-height-auto"><spring:message code="buy.detail.cnt.title"/></dt>
                            <dd><span><fmt:formatNumber type="number" maxFractionDigits="3" value="${buyDetail.quantity}"/></span> <spring:message code="common.unit.count.title"/></dd>
                        </dl>
                       <!--  <dl class="trade-pop-form-info-item">
                            <dt><spring:message code="buy.detail.unit.title"/></dt>
                            <dd class="price-one"><fmt:formatNumber type="number" maxFractionDigits="3" value="${buyDetail.unitPrice}"/> <spring:message code="common.unit.won.title"/></dd>
                        </dl> -->
                       <!--  <dl class="trade-pop-form-info-item">
                            <dt><spring:message code="buy.detail.fee.title"/></dt>
                            <dd id="price-fee">1000 <spring:message code="common.unit.won.title"/></dd>
                        </dl> -->
                        <dl class="trade-pop-form-info-item ex-height-auto">
                            <dt class="ex-height-auto"><spring:message code="buy.detail.price.title"/></dt>
                            <dd>
                                <fmt:formatNumber type="number" maxFractionDigits="3" value="${buyDetail.unitPrice}"/> <spring:message code="common.unit.won.title"/> 
                                <div class="space-mobile"></div>
                                (<spring:message code="buy.detail.fee.title"/>  <span id="fee-title"></span> <spring:message code="common.unit.won.title"/>)</span>
                            </dd>
                        </dl>
                        <dl class="trade-pop-form-info-item ex-height-auto">
                            <dt class="ex-height-auto"><spring:message code="buy.detail.totalPrice.title"/></dt>
                            <dd class="price-total"><fmt:formatNumber type="number" maxFractionDigits="3" value="${buyDetail.totalPrice}"/> <spring:message code="common.unit.won.title"/></dd>
                        </dl>
                        <dl class="trade-pop-form-info-item ex-height-auto">
                            <dt class="ex-height-auto"><spring:message code="buy.detail.status.title"/></dt>
                            <dd>
                                <c:if test="${buyDetail.state == 1 || buyDetail.state == 2}">
                                    <div class="status-btn status-wait">${buyDetail.stateName} <img src="${_ctx}/resources/img/loading.gif" style="width: 15px; margin-left: 4px;">
                                    </div>
                                </c:if>
                                <c:if test="${buyDetail.state == 3}"><div class="status-btn status-ing">${buyDetail.stateName}</div></c:if>
                                <c:if test="${buyDetail.state == 4}"><div class="status-btn status-ing">${buyDetail.stateName} <img src="${_ctx}/resources/img/loading.gif" style="width: 15px; margin-left: 4px;"></div></c:if>
                                <c:if test="${buyDetail.state == 5}"><div class="status-btn status-ing">Cancel</div></c:if>
                            </dd>
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
                    <!-- ROLE = USER -->
                    <c:if test="${(wallet.role == 'USER' ||buyDetail.buyType == 2)}">                         
                        <c:if test="${wallet.wallets.size() > 0
                            && fn:containsIgnoreCase(wallet.wallets, buyDetail.buyerWalletAddress)
                            && buyDetail.state == 1}">
                            <!-- IS OWNER ORDER + order<1> -->
                            <a href="${_ctx}/buyCancel?buyId=${buyDetail.buyId}&type=ex">
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
                            <form id="tradeDepositForm" method="POST" action="${_ctx}/confirmTxId" cssClass="mb-1">

                                 <!-- TxID -->
                                <label for="txId" class="input-label" field="NN"><spring:message code="trade.input.txid.title"/></label>
                                <div class="form-wrap form-full">
                                    <input name="txId" type="text" placeholder="Please enter TxID"/>
                                    <label for="txId" class="input-label-error"><spring:message code="trade.input.txid.message"/></label>
                                </div>
                                <!-- * Wallet password -->

                                <input hidden name="buyId" value="${buyDetail.buyId}"/>
                                <input hidden name="buyTradeHistoryId" value="${buyDetail.buyTradeHistoryId}"/>
                            </form>

                            <div class="btn btn-primary btn-deposit">
                                <spring:message code="common.button.deposit.title"/>
                            </div>                           
                        </c:if>

                        <!-- DEPOSIT - STEP 2 SHOW BANK INFO WHEN INPUT TXID -->
                        <c:if test="${wallet.wallets.size() > 0
                            && fn:containsIgnoreCase(wallet.wallets, buyDetail.buyerWalletAddress)
                            && buyDetail.state == 2
                            && buyDetail.tradeState == 2}">
                            <!-- IS OWNER s + order<2> + orderTrade<2>-->

                                <div class="trade-pop-form-info">
                                    <dl class="trade-pop-form-info-item ex-height-auto">
                                        <dd><spring:message code="buy.detail.bank.info.title"/></dd>
                                    </dl>
                                    <dl class="trade-pop-form-info-item ex-height-auto">
                                        <dt class="ex-height-auto"><spring:message code="buy.detail.bank.owner.title"/></dt>
                                        <dd>${buyDetail.bankOwner}</dd>
                                    </dl>
                                    <dl class="trade-pop-form-info-item ex-height-auto">
                                        <dt class="ex-height-auto"><spring:message code="buy.detail.bank.name.title"/></dt>
                                        <dd>${buyDetail.bankName}</dd>
                                    </dl>
                                    <dl class="trade-pop-form-info-item ex-height-auto">
                                        <dt class="ex-height-auto"><spring:message code="buy.detail.bank.account.title"/></dt>
                                        <dd>${buyDetail.bankAccount}</dd>
                                    </dl>
                                    <dl class="trade-pop-form-info-item ex-height-auto">
                                        <dt class="ex-height-auto"><spring:message code="buy.detail.bank.totalPrice.title"/></dt>
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
                            <dl class="trade-pop-form-info-item ex-height-auto">
                                <dt class="ex-height-auto"><spring:message code="buy.detail.transaction.txid.title"/></dt>
                                <dd>${buyDetail.txid}</dd>
                            </dl>
                            <dl class="trade-pop-form-info-item ex-height-auto">
                                <dt class="ex-height-auto"><spring:message code="buy.detail.transaction.tradeAddress.title"/></dt>
                                <dd>${buyDetail.sellerWalletAddress}</dd>
                            </dl>
                        </div>
                    </c:if>

                        <div class="btn secondary bnt-close"><spring:message code="common.button.close.title"/></div>
                    </div>
                </div>
            </div>
        <!-- * Buy detail infor -->
        </div>
    </div>
</body>
<%@ include file="/WEB-INF/layout/web-new/modals/feedbackModal.jsp"%>
<%@ include file="/WEB-INF/layout/web-new/modals/feedbackRequestModal.jsp"%>
<script>
    $(document).ready(function(){
        $(".walletSelect").change();
        $('#fee-title').html('<fmt:formatNumber type="number" maxFractionDigits="3" value="${buyDetail.totalPrice - buyDetail.unitPrice}"/>');

        // loadBalanceWeb({walletAddress: valWallet, symbol: '${buyDetail.symbol}'});

    });
    $(".walletSelect").change(async function(){
        
        var valWallet = $(this).find("option:selected").val();        
        $(this).find(".my-balance").attr("wallet-address", valWallet);        
        loadBalanceWeb({walletAddress: valWallet, symbol: '${buyDetail.symbol}'});
    });
   
    $("#modal-buy-detail").find(".btn-deposit").click(function(){
        var isNN = checkFieldNotNull("#tradeDepositForm");
        if(isNN){
            return;
        }

        $('#tradeDepositForm').submit();
    })
    $(".bnt-close").click(function(){
        window.close();
    })

    window.setInterval('$(".walletSelect").change()', 5000);
    window.setInterval('loadDetail()', 3000);
    async function loadDetail(){
        var api = "/api/buy/detail";
        var param = {buyId: "${buyDetail.buyId}"};
        var res = await $.when(rest.get(api, param));        
        if(res.tradeState != null && res.tradeState != '${buyDetail.tradeState}'){
           
            location.reload()
        }
    }
</script>
<%--
  Created by IntelliJ IDEA.
  User: ntt.dev
  The page trade buy detail
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- head -->
<%@ include file="/WEB-INF/layout/web-new/include/head.jsp"%>
<!-- #head -->

<body class="pace-done">
    <div class="wrapper">
        <!-- Buy detail infor -->
        <section class="wrap trade-wrap">

                <!-- header -->
                <%@ include file="/WEB-INF/layout/web-new/include/header.jsp"%>
                <!-- #header -->
              <!--   <article class="sub-title sub-title--trade">
                    <h2><spring:message code="buy.detail.page.title"/></h2>
                    <p><spring:message code="buy.detail.page.content"/></p>
                </article> -->

                <div class="container" id="modal-buy-detail">
                    <div class="trade-pop-form">  
                        <c:if test="${buyDetail.symbol eq 'BANI' || buyDetail.symbol eq 'EGG'}">                        
                            <div class="form-full" id="balance-trade">
                                <spring:message code="common.message.balances.title"/>: <label class="my-balance" wallet-address="${wallet_current.walletAddress}"></label> ${buyDetail.symbol}
                                <input type="hidden" class="m-test"/>
                            </div>

                        </c:if>
                     
                        <div class="form-wrap form-full">
                          <!--  <spring:message code="buy.request.choose.your.wallet"/>: --> <select name="buyerWalletAddress" class="walletSelect">
                                <c:forEach items="${wallet.wallets}" var="item" varStatus="loop">
                                    <c:choose>
                                        <c:when test="${item.walletAddress == walletCurrent.walletAddress}">
                                            <option value="${item.walletAddress}" fee="${item.fee}" selected='selected'>${item.walletAddress}</option>
                                        </c:when>
                                        <c:otherwise>
                                            <option value="${item.walletAddress}" fee="${item.fee}">${item.walletAddress}</option>
                                        </c:otherwise>
                                    </c:choose>
                                </c:forEach>
                            </select>
                        </div>   
                                            
                      
                            <c:choose>
                                <c:when test="${walletCurrent.walletAddress != null
                                    && fn:containsIgnoreCase(walletCurrent.walletAddress, buyDetail.buyerWalletAddress) && buyDetail.sellerWalletAddress != null}">
                                    <br>
                                      <div class="form-wrap form-full">
                                        <spring:message code="search.name.keywordType.option.seller.wallet.title"/>
                                        <div class="form-wrap-txt form-wrap-txt2" data-clipboard-text="${buyDetail.sellerWalletAddress}" onclick='alert(`<spring:message code="common.copy.toast.title"/>`)'>${buyDetail.sellerWalletAddress}
                                        </div>
                                      </div>
                                      <br>
                                </c:when>
                                <c:otherwise>
                                        <c:if test="${buyDetail.buyerWalletAddress != walletCurrent.walletAddress}">
                                            <spring:message code="search.name.keywordType.option.buyer.wallet.title"/>
                                            <div class="form-wrap-txt form-wrap-txt2" data-clipboard-text="${buyDetail.buyerWalletAddress}" onclick='alert(`<spring:message code="common.copy.toast.title"/>`)'>${buyDetail.buyerWalletAddress}
                                             </div>
                                             <br>
                                     </c:if>

                                </c:otherwise>
                            </c:choose>
                        
                        <c:if test="${null != userChat.userId && buyDetail.state != 1}">
                             <div class="trade-pop-form-btn" style="margin-top: 6px">
                                <div class="btn btn-primary btn-show-chat"><i class="fas fa-sync"></i> <spring:message code="trade.send.messages.to.user.title"/></div>
                            </div>   
                             <br>
                        </c:if>
                         
                       
                        <!--
                        <div class="trade-pop-form-btn">
                            <div class="btn btn-primary" data-clipboard-text="${buyDetail.buyerWalletAddress}" onclick='alert(`<spring:message code="common.copy.toast.title"/>`)'><spring:message code="common.copy.title"/></div>
                        </div>
                        -->                       
                        <div class="trade-pop-form-btn" style="margin-top: 6px">
                            <div class="btn btn-primary" onclick="location.reload();"><i class="bi bi-arrow-repeat"></i> <spring:message code="trade.status.order.refresh.title"/></div>
                        </div>


                        <div class="trade-pop-form-info">
                            <dl class="trade-pop-form-info-item ex-height-auto">
                                <dt class="ex-height-auto"><spring:message code="buy.detail.orderNumber.title"/></dt>
                                <dd class="ex-height-auto">${buyDetail.symbol}<fmt:formatDate value="${buyDetail.buyRegDate}" pattern="yyyyMMddHHmmss"/>${buyDetail.buyId}</dd>
                            </dl>
                            <dl class="trade-pop-form-info-item ex-height-auto">
                                <dt class="ex-height-auto"><spring:message code="buy.detail.symbol.title"/></dt>
                                <dd>${buyDetail.symbol}</dd>
                            </dl>
                            <dl class="trade-pop-form-info-item ex-height-auto">
                                <dt class="ex-height-auto"><spring:message code="history.table.total.quantity.title"/></dt>
                                <dd><span><fmt:formatNumber type="number" maxFractionDigits="3" value="${buyDetail.quantity}"/> </span><spring:message code="common.unit.count.title"/></dd>
                            </dl>
                            <dl class="trade-pop-form-info-item ex-height-auto">
                                <dt class="ex-height-auto"><spring:message code="buy.detail.unit.title"/></dt>
                                <dd class="price-one"><fmt:formatNumber type="number" maxFractionDigits="3" value="${buyDetail.unitPrice}"/> <spring:message code="common.unit.won.title"/></dd>
                            </dl>
                           <!--  <dl class="trade-pop-form-info-item">
                                <dt><spring:message code="buy.detail.fee.title"/></dt>
                                <dd>0.1<spring:message code="common.unit.count.title"/></dd>
                                <dd></dd>
                            </dl> -->
                            <dl class="trade-pop-form-info-item ex-height-auto">
                                <dt class="ex-height-auto"><spring:message code="buy.detail.price.title"/></dt>
                                <dd><fmt:formatNumber type="number" maxFractionDigits="3" value="${buyDetail.unitPrice}"/><spring:message code="common.unit.won.title"/> 
                                    <c:if test="${buyDetail.symbol == 'BANI' || buyDetail.symbol == 'EGG' }">
                                            <div class="space-mobile"></div>
                                            <span>(<spring:message code="buy.detail.fee.title"/> +<fmt:formatNumber type="number" maxFractionDigits="3" value="${buyDetail.totalPrice - buyDetail.unitPrice}"/> <spring:message code="common.unit.won.title"/>)
                                        </span>
                                    </c:if>
                                </dd>
                            </dl>
                            <dl class="trade-pop-form-info-item ex-height-auto">
                                <dt class="ex-height-auto"><spring:message code="buy.detail.totalPrice.title"/></dt>
                                <dd class="price-total"><fmt:formatNumber type="number" maxFractionDigits="3" value="${buyDetail.totalPrice}"/> <spring:message code="common.unit.won.title"/></dd>
                            </dl>
                            <dl class="trade-pop-form-info-item ex-height-auto">
                                <dt class="ex-height-auto"><spring:message code="buy.detail.status.title"/></dt>
                                <dd>
                                    <c:if test="${buyDetail.state == 1 || buyDetail.state == 2}"><div class="status-btn status-wait">${buyDetail.stateName} <img src="${_ctx}/resources/img/loading.gif" style="width: 15px; margin-left: 4px;"></div></c:if>
                                    <c:if test="${buyDetail.state == 3}"><div class="status-btn status-ing">${buyDetail.stateName}</div></c:if>
                                     <c:if test="${buyDetail.state == 4}"><div class="status-btn status-ing">${buyDetail.stateName} <img src="${_ctx}/resources/img/loading.gif" style="width: 15px; margin-left: 4px;"></div></c:if>
                                    <c:if test="${buyDetail.state == 5}"><div class="status-btn status-ing"><spring:message code="common.button.cancel.title"/></div></c:if>
                                </dd>
                            </dl>
                              <c:if test="${buyDetail.viewRole == 'OWNER_SAFE'}" >
                                <dl class="trade-pop-form-info-item ex-height-auto">
                                    <dt class="ex-height-auto"><spring:message code="common.admin.field.type.title"/></dt>
                                    <dd>SAFE</dd>
                                </dl>
                            </c:if>
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
                            <!-- ROLE = TRADER, CLIENT_TRADER and buyType = 2(API) [popup]-->
                            <c:if test="${buyDetail.viewRole == 'TRADER'
                                        && walletCurrent.role == 'TRADER'
                                        && buyDetail.state == 2
                                        && buyDetail.tradeState == 2}">

                                <a href="${_ctx}/buy/applyWithTransfer?buyId=${buyDetail.buyId}">
                                    <div class="btn btn-primary">
                                        <spring:message code="common.button.finish.title"/>
                                    </div>
                                </a>
                            </c:if>

                            <c:if test="${(walletCurrent.role == 'TRADER' || walletCurrent.role == 'CLIENT_TRADER')
                                                && buyDetail.buyType == 2}">

                                <!-- WHEN ROLE = CLIENT_TRADER THEN SHOW OPTION SELECT/INPUT BANK INFO  -->
                                <c:if test="${walletCurrent.walletAddress != null
                                    && (!fn:containsIgnoreCase(walletCurrent.walletAddress, buyDetail.buyerWalletAddress)
                                        || !fn:containsIgnoreCase(walletCurrent.walletAddress, buyDetail.regWalletAddress))
                                    && buyDetail.state == 1
                                    && buyDetail.viewRole == 'CLIENT_TRADER'
                                    && walletCurrent.role == 'CLIENT_TRADER'}">
                                    <!-- IS OWNER s + order<2> + orderTrade<2>-->
                                        <div class="trade-pop-form-info">
                                            <dl class="trade-pop-form-info-item ex-height-auto">
                                                <dd><spring:message code="buy.detail.bank.info.title"/></dd>
                                            </dl>
                                            <dl class="trade-pop-form-info-item ex-height-auto">
                                                <dt class="ex-height-auto"><spring:message code="buy.detail.bank.owner.title"/></dt>
                                                <dd><input type="text" id="bankOwner" name="bankOwner" value="${walletCurrent.bankOwner}"></dd>
                                            </dl>
                                            <dl class="trade-pop-form-info-item ex-height-auto">
                                                <dt class="ex-height-auto"><spring:message code="buy.detail.bank.name.title"/></dt>
                                                <dd><input type="text" id="bankName" name="bankName" value="${walletCurrent.bankName}"></dd>
                                            </dl>
                                            <dl class="trade-pop-form-info-item ex-height-auto">
                                                <dt class="ex-height-auto"><spring:message code="buy.detail.bank.account.title"/></dt>
                                                <dd><input type="text" id="bankAccount" name="bankAccount" value="${walletCurrent.bankAccount}"></dd>
                                            </dl>
                                            <dl class="trade-pop-form-info-item ex-height-auto">
                                                <dt class="ex-height-auto"><spring:message code="buy.detail.bank.totalPrice.title"/></dt>
                                                <dd><fmt:formatNumber type="number" maxFractionDigits="3" value="${buyDetail.totalPrice}"/></dd>
                                            </dl>
                                        </div>
                                        <c:if test="${buyDetail.buyType != 2 && buyDetail.viewRole != 'API' && buyDetail.viewRole != 'CLIENT_TRADER'}">
                                            <a href="${_ctx}/buy/confirmCashDeposit?buyId=${buyDetail.buyId}">
                                                <div class="btn btn-primary">
                                                    <spring:message code="common.button.cashDeposit.title"/>
                                                </div>
                                            </a>
                                        </c:if>
                                    <br>
                                </c:if>
                                <!-- END SHOW BANK INFO -->

                                 <!-- CHECK STATE TOKEN_BUY, WHEN STATE == 1 AND BUYER_WALLET_ADDRESS != BUYER_WALLET_ADDRESS (NOT APPLY YOUR BUY REQUEST)-->
                                <c:if test="${walletCurrent.walletAddress != null
                                    && !fn:containsIgnoreCase(walletCurrent.walletAddress, buyDetail.buyerWalletAddress)
                                    && buyDetail.state == 1}">
                                    <!-- role<USER_ROLE> + order<1> -->
                                    
                                    <a id="buyTradeApply" onclick="buyTradeApplyClick(true)">
                                        <div class="btn btn-primary">
                                            <spring:message code="common.button.applyTrade.title"/>
                                        </div>
                                    </a>
                                </c:if>

                                <!-- BUY_TYPE = 1 (GENERAL), ONLY TRADER MAYBE APPLY WHEN STATE = 2, NOT APPLY YOUR BUY REQUEST -->
                                <c:if test="${walletCurrent.walletAddress != null
                                    && fn:containsIgnoreCase(walletCurrent.walletAddress, buyDetail.sellerWalletAddress) 
                                    && buyDetail.state == 2 
                                    && (buyDetail.viewRole == 'API'
                                    || buyDetail.viewRole == 'CLIENT_TRADER')}">

                                    <a href="${_ctx}/buy/applyWithTransfer?buyId=${buyDetail.buyId}">
                                        <div class="btn btn-primary">
                                            <spring:message code="common.button.finish.title"/>
                                        </div>
                                    </a>
                                </c:if>                             
                            </c:if>
                            <!-- * ROLE = TRADER -->  

                            <!-- ROLE = USER, IF ROLE = TRADE NEED BUY_TYPE = 1, MAYBE CANCEL WHEN STATE == 1-->
                            <c:if test="${(walletCurrent.role == 'USER' || walletCurrent.role == 'TRADER') && buyDetail.buyType == 1}">

                                <c:if test="${walletCurrent.walletAddress != null 
                                    && (fn:containsIgnoreCase(walletCurrent.walletAddress, buyDetail.buyerWalletAddress) 
                                        || fn:containsIgnoreCase(walletCurrent.walletAddress, buyDetail.regWalletAddress))
                                    && buyDetail.state == 1}">
                                    <!-- IS OWNER ORDER + order<1> -->
                                    <a onclick="return questionAlert('<spring:message code="common.button.cancel.title"/>','${_ctx}/buyCancel?buyId=${buyDetail.buyId}');">
                                        <div class="btn btn-primary">
                                            <spring:message code="common.button.cancel.title"/>
                                        </div>
                                    </a>

                                </c:if>
                                <!-- THIS ORDER IS NOT YOUR ORDER, YOU CAN APPLY-->
                                <c:if test="${walletCurrent.walletAddress != null 
                                    && !fn:containsIgnoreCase(walletCurrent.walletAddress, buyDetail.buyerWalletAddress) 
                                    && !fn:containsIgnoreCase(walletCurrent.walletAddress, buyDetail.regWalletAddress) 
                                    && buyDetail.state == 1}">
                                    <!-- role<USER_ROLE> + order<1> -->
                                    <a id="buyTradeApply" onclick="buyTradeApplyClick(false)">
                                        <div class="btn btn-primary">
                                            <spring:message code="common.button.apply.title"/>
                                        </div>
                                    </a>
                                </c:if>

                                <!-- DEPOSIT - STEP 1, WHEN STATE = 2 AND TRADE_STATE = 1 -->
                                <c:if test="${walletCurrent.walletAddress != null 
                                    && fn:containsIgnoreCase(walletCurrent.walletAddress, buyDetail.sellerWalletAddress) 
                                    && buyDetail.state == 2 
                                    && buyDetail.tradeState == 1}">
                                    <!-- order<2> + orderTrade<1> + is trader -->
                                    <form id="tradeDepositForm" method="POST" action="${_ctx}/confirmTxId" class="mb-1">

                                         <!-- TxID -->
                                        <c:if test="buyDetail.viewRole == 'USER_SAFE'">
                                            <div class="trade-pop-form-info">
                                                <dl class="trade-pop-form-info-item ex-height-auto">
                                                    <dt class="ex-height-auto"><spring:message code="login.input.wallet.address.title"/></dt>
                                                    <dd class="ex-height-auto">${buyChildDetail.regWalletAddress}</dd>
                                                </dl>
                                                <dl class="trade-pop-form-info-item ex-height-auto">
                                                    <dt class="ex-height-auto"><spring:message code="history.table.total.quantity.title"/></dt>
                                                    <dd class="ex-height-auto"><fmt:formatNumber type="number" maxFractionDigits="3" value="${buyDetail.quantity}"/></dd>
                                                </dl>
                                            </div>
                                        </c:if>
                                        
                                        <div class="form-wrap form-full">
                                            <input name="txId" type="text" placeholder="Please enter TxID"/>
                                            <label for="txId" class="input-label-error"><spring:message code="trade.input.txid.message"/></label>
                                        </div>
                                        <!-- * Wallet password -->
                                        
                                        <input hidden name="buyId" value="${buyDetail.buyId}"/>
                                        <input hidden name="buyTradeHistoryId" value="${buyDetail.buyTradeHistoryId}"/>
                                    </form>
                                    <div class="btn btn-primary btn-deposit"><spring:message code="common.button.deposit.title"/></div>

                                </c:if>

                                <!-- DEPOSIT - STEP 2 SHOW BANK INFO WHEN INPUT TXID -->
                                <c:if test="${walletCurrent.walletAddress != null
                                    && (fn:containsIgnoreCase(walletCurrent.walletAddress, buyDetail.buyerWalletAddress) 
                                        || fn:containsIgnoreCase(walletCurrent.walletAddress, buyDetail.regWalletAddress)) 
                                    && buyDetail.state == 2 
                                    && buyDetail.tradeState == 2}">
                                    <!-- IS OWNER s + order<2> + orderTrade<2>-->
                                    <div class="trade-pop-form-info">
                                        <dl class="trade-pop-form-info-item">
                                            <dd><spring:message code="buy.detail.transaction.title"/></dd>
                                        </dl>
                                        <dl class="trade-pop-form-info-item ex-height-auto">
                                            <dt class="ex-height-auto"><spring:message code="buy.detail.transaction.txid.title"/></dt>
                                            <dd>${buyDetail.txid}</dd>
                                        </dl>
                                      <!--   <dl class="trade-pop-form-info-item ex-height-auto">
                                            <dt class="ex-height-auto"><spring:message code="buy.detail.transaction.tradeAddress.title"/></dt>
                                            <dd>${buyDetail.sellerWalletAddress}</dd>
                                        </dl> -->
                                    </div>

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
                                </c:if>
                                <!-- End DEPOSIT--> 
                                <!-- FINISH -->
                                <c:if test="${walletCurrent.walletAddress != null
                                    && fn:containsIgnoreCase(walletCurrent.walletAddress, buyDetail.sellerWalletAddress) 
                                    && buyDetail.state == 2 && buyDetail.tradeState == 3}">
                                    <!-- role<USER_ROLE> + order<2> + orderTrade<3> -->
                                    <a href="${_ctx}/tradeConfirmFinish?buyId=${buyDetail.buyId}&buyTradeHistoryId=${buyDetail.buyTradeHistoryId}">
                                        <div class="btn btn-primary">
                                            <spring:message code="common.button.finish.title"/>
                                        </div>
                                    </a>
                                </c:if>
                            </c:if>
                        <!-- * ROLE = USER -->

                            <c:if test="${walletCurrent.walletAddress != null
                                && (fn:containsIgnoreCase(walletCurrent.walletAddress, buyDetail.sellerWalletAddress) 
                                    || fn:containsIgnoreCase(walletCurrent.walletAddress, buyDetail.buyerWalletAddress)
                                    || fn:containsIgnoreCase(walletCurrent.walletAddress, buyDetail.regWalletAddress))
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
                            <a class="btn secondary" onclick="btnBuyBack()"><spring:message code="common.button.goList.title"/></a>
                        </div>
                    </div>
                </div>
            <!-- * Buy detail infor -->
            </div>
            <!-- footer -->
            <%@ include file="/WEB-INF/layout/web-new/modals/transfer.jsp"%>
            <%@ include file="/WEB-INF/layout/web-new/include/footer.jsp"%>
            <!-- #footer -->
    </section>
    </div>
</body>
<script>
    window.setInterval('loadDetail()', 3000);
    async function loadDetail(){
        var api = "/api/buy/detail";
        var param = {buyId: "${buyDetail.buyId}"};
        var res = await $.when(rest.get(api, param));        
        if(res.tradeState != null && (res.tradeState != '${buyDetail.tradeState}' || res.state != '${buyDetail.state}')){
           
            location.reload()
        }
    }
    $(document).ready(function(){    
        
        var valWallet = '${walletCurrent.walletAddress}';     
        $('.walletSelect option[value='+valWallet+']').attr('selected','selected');       
        $(this).find(".my-balance").attr("wallet-address", valWallet); 
        new ClipboardJS("[data-clipboard-text]")        
        loadBalanceWeb({walletAddress: valWallet, symbol: '${buyDetail.symbol}'});
    })
     $(".walletSelect").change(async function(){
        
        var url = changeSearchParam({walletAddress: $(this).find("option:selected").val()})
        document.location.href = url;
         
    });
    $("#modal-buy-detail").find(".btn-deposit").click(function(){
        var isNN = checkFieldNotNull("#tradeDepositForm");
        if(isNN){
            return;
        }

        $('#tradeDepositForm').submit();       
    });

    $(".btn-show-modal-transfer").click(function(){
        const from = $(this).data('from')
        const to = $(this).data('to')
        const amount = $(this).data('amount') * 1
        $(".modal-transfer-from").html(from)
        $(".modal-transfer-ip-from").val(from)
        $(".modal-transfer-to").html(to)
        $(".modal-transfer-ip-to").val(to)
        $(".modal-transfer-amount").html(amount)
        $(".modal-transfer-ip-amount").val(amount)
        showModal('#modal-transfer', false)
    })

    function buyTradeApplyClick(tradeType){
            if (${walletCurrent.role == 'TRADER'}
                && myWalletBalance < ${buyDetail.quantity}) {
                 alert("<spring:message code="common.not.enough.token"/>");                 
            } else {
                let strHref;
                if(tradeType){
                    strHref ='${_ctx}/buyTradeApply?buyId=${buyDetail.buyId}&sellerWalletAddress=${walletCurrent.walletAddress}&bankOwner=${walletCurrent.bankOwner}&bankName=${walletCurrent.bankName}&bankAccount=${walletCurrent.bankAccount}'
                }
                else{
                    strHref = "${_ctx}/buyTradeApply?buyId=${buyDetail.buyId}&sellerWalletAddress=${walletCurrent.walletAddress}"+"&bankOwner="+$('#bankOwner').val()+"&bankName="+$('#bankName').val()+"&bankAccount="+$('#bankAccount').val();
                }  

              $('#buyTradeApply').prop("href", strHref);    
            } 
            

    };
    function btnBuyBack(){        
        if (history.length > 1 && !document.referrer.includes('tradeBuyDetail')){                
            history.go(-1);     
            return;
        }
        window.location.href="${_ctx}/trade?targetView=%23buy-order";
    }   
    function questionAlert(messAlert, urlRedirect){
        if (window.confirm(messAlert+'?'))
            {
               window.location.href= urlRedirect;
            }
    };

    
   
</script>
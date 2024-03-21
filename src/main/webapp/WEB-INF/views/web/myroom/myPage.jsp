<%--
  Created by IntelliJ IDEA.
  User: ntt.dev
  The page MyRoom
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- head -->
<%@ include file="/WEB-INF/layout/web/head.jsp"%>



<style>
    .btn-play-audio:hover{
        cursor: pointer;
        color: green;
    }
</style>

<!-- Main -->
<section class="wrap element-main-top">
<!-- header -->
  <%@ include file="/WEB-INF/layout/web/header.jsp"%>
    <div class="sub-title trade-title">
        <h2><spring:message code="myroom.title"/></h2>
        <p><spring:message code="myroom.description"/></p>
    </div>
    <div class="sub-snb-wrap trade-snb">
        <div class="sub-snb-container">
            <ul class="sub-snb-menu" trade-tab="${buySearch.targetView}">
                <li class="sub-snb-menu-item" tab-target="#buy-order"><spring:message code="myroom.buylist.title"/></li>
                <li class="sub-snb-menu-item" tab-target="#sell-order"><spring:message code="myroom.selllist.title"/></li>
                <li class="sub-snb-menu-item" tab-target="#information"><spring:message code="myroom.myinfo.title"/></li>
                <li class="sub-snb-menu-item" tab-target="#setting"><spring:message code="myroom.alarms.setup.title"/></li>
            </ul>
            <div class="sub-snb-btn bt-1-70">
                <c:if test="${buySearch.targetView eq '#buy-order' || buySearch.targetView eq '#sell-order' || buySearch.targetView eq null}">
                <ul class="list-select" trade-status="${buySearch.idOrderStatus}">
                    <li class="list-select-item order-status" data-status=""><spring:message code="trade.status.order.all.title"/></li>
                    <li class="list-select-item order-status" data-status="1"><spring:message code="trade.status.order.wait.title"/></li>
                    <li class="list-select-item order-status" data-status="2"><spring:message code="trade.status.order.trade.title"/></li>
                    <li class="list-select-item order-status" data-status="3"><spring:message code="trade.status.order.finish.title"/></li>
                </ul>
                <div class="btn refresh-btn order-status" data-status=""><spring:message code="trade.status.order.refresh.title"/></div>
                </c:if>
            </div>
        </div>
    </div>

    <div class="container">
        <div class="container-trade">

            <div class="trade-btn-wrap">
                <select class="tokenSelect">
                    <c:forEach items="${tokens}" var="item" varStatus="loop">
                        <option value="${item.symbol}">${item.symbol}</option>
                    </c:forEach>
                </select>
                <select class="walletSelect">           
                        <option value="${wallet.walletAddress}" path='' repeat="${wallet.repeatSeconds}">${wallet.walletAddress}</option>
                  
                </select>
            </div>

            <div class="list-wrap trade-list-wrap hide" id="buy-order">
                <div class="trade-list-wrap">
                    <div class="trade-list-head">
                        <div class="trade-list-th"><spring:message code="trade.buy.orderNumber.title"/></div>
                        <div class="trade-list-th"><spring:message code="trade.buy.coin.title"/></div>
                        <div class="trade-list-th"><spring:message code="trade.buy.orderKind.title"/></div>
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
                      
                      <div class="trade-list-tr">
                          <div class="trade-list-td other-num">${item.symbol}<fmt:formatDate value="${item.buyRegDate}" pattern="yyyyMMddHHmmss"/>${item.buyId}</div>
                          <div class="trade-list-td coin-name">${item.symbol}</div>
                          <div class="trade-list-td category">${item.buyType}</div>
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
                                      <c:if test="${item.state == 1}"><div class="status-btn status-wait" redirect="${_ctx}/login">${item.stateName}</div></c:if>
                                      <c:if test="${item.state == 2}"><div class="status-btn status-ing" redirect="${_ctx}/login">${item.stateName}</div></c:if>
                                      <c:if test="${item.state == 3}"><div class="status-btn status-end" redirect="${_ctx}/login">${item.stateName}</div></c:if>
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
                        <div class="trade-list-th"><spring:message code="trade.buy.orderKind.title"/></div>
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
                   
                    <div class="trade-list-tr">
                        <div class="trade-list-td other-num">${item.symbol}<fmt:formatDate value="${item.sellRegDate}" pattern="yyyyMMddHHmmss"/>${item.sellId}</div>
                        <div class="trade-list-td coin-name">${item.symbol}</div>
                        <div class="trade-list-td category">${item.sellType}</div>
                        <div class="trade-list-td ea"><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.quantity}"/><spring:message code="common.unit.count.title"/></div>
                        <div class="trade-list- td price-one"><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.unitPrice}"/><spring:message code="common.unit.won.title"/></div>
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
                                    <c:if test="${item.state == 1}"><div class="status-btn status-wait" redirect="${_ctx}/login">${item.stateName}</div></c:if>
                                    <c:if test="${item.state == 2}"><div class="status-btn status-ing" redirect="${_ctx}/login">${item.stateName}</div></c:if>
                                    <c:if test="${item.state == 3}"><div class="status-btn status-end" redirect="${_ctx}/login">${item.stateName}</div></c:if>
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

            <div class="list-wrap trade-list-wrap hide" id="information">
                
                

                <div class="trade-pop-form-info">
                    <dl class="trade-pop-form-info-item">
                        <dd><b><spring:message code="myroom.information.wallet.title"/></b></dd>
                    </dl>
                    <form:form modelAttribute="walletForm" action="${_ctx}/wallet/update" method="POST">
                    <dl class="trade-pop-form-info-item">
                        <dt><spring:message code="myroom.information.wallet.address.title"/></dt>
                        <dd>${walletInfo.walletAddress}</dd>
                        <dd><form:input path="walletAddress" type="hidden" name="" /></dd>
                    </dl>
                    <dl class="trade-pop-form-info-item">
                        <dt><spring:message code="myroom.information.wallet.fee.title"/></dt>
                        <dd>${walletInfo.fee}</dd>
                        <dd></dd>
                    </dl>
                    <dl class="trade-pop-form-info-item">
                        <dt><spring:message code="buy.detail.bank.owner.title"/></dt>
                        <dd><form:input path="bankName" type="text" name="" /></dd>
                        <dd></dd>
                    </dl>
                    <dl class="trade-pop-form-info-item">
                        <dt><spring:message code="buy.detail.bank.name.title"/></dt>
                        <dd><form:input path="bankOwner" type="text" name="" /></dd>
                        <dd></dd>
                    </dl>
                    <dl class="trade-pop-form-info-item">
                        <dt><spring:message code="buy.detail.bank.account.title"/></dt>
                        <dd><form:input path="bankAccount" type="text" name="" /></dd>
                        <dd></dd>
                    </dl>
                    <dl class="trade-pop-form-info-item">
                        <dd><button class="status-btn status-ing"><spring:message code="common.button.submit.title"/></button></dd>
                    </dl>    
                    </form:form>
                    
                </div>
            </div>

            <div class="list-wrap trade-list-wrap hide" id="setting">
                <div class="trade-pop-form-info">
                    <dl class="trade-pop-form-info-item">
                        <dd><spring:message code="myroom.setting.title"/></dd>
                    </dl>
                    <form:form modelAttribute="alarmForm" method="POST" action="${_ctx}/alarm/update" enctype="multipart/form-data">
                        <dl class="trade-pop-form-info-item">
                            <dt><spring:message code="myroom.setting.filePath.title"/></dt>
                            <dd>
                                <i class="fas fa-play-circle btn-play-audio" for="audio-src"></i>
                                <audio id="audio-src" controls hidden>
                                    <source src="${_ctx}/" type="audio/mpeg">
                                </audio>
                                <label for="fileSource"></label>

                                <form:input path="fileSource" type="file" accept="audio/*" style="border: none;" />
                            </dd>
                            <dd></dd>
                        </dl>
                        <dl class="trade-pop-form-info-item">
                            <dt><spring:message code="myroom.setting.alarmRepeat.title"/></dt>
                            <dd><form:input path="alarmRepeat" type="text" name="" value="${walletInfo.repeatSeconds}" cssClass="onlynum" /> <label><spring:message code="common.unit.second.title"/></label></dd>
                            <dd></dd>
                        </dl>
                        <dl class="trade-pop-form-info-item">
                            <dd><button class="status-btn status-ing"><spring:message code="common.button.submit.title"/></button></dd>
                        </dl>
                    </form:form>
                </div>
            </div>

        </div>
    </div>
   
</section>
<!-- * Main -->
 <!-- footer -->
    <%@ include file="/WEB-INF/layout/web/footer.jsp"%>
<!-- * footer -->
<script>

    var walletTarget = '#buy-order';

    $(document).ready(function(){
        init();
    })

    function init(){
        // $(".walletSelect").val(walletTarget);
        // $(".walletSelect").change();


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

    $(".order-status").click(function(){
        console.log("click");
        var status = $(this).attr("data-status");
        var url = changeSearchParam({idOrderStatus: status, sellPage: 1, buyPage: 1})
        document.location.href = url;
    })

    $(".sub-snb-menu-item:not(.acitve)").click(function(){
        var target = $(this).attr("tab-target");
        var url = changeSearchParam({targetView: target})
        document.location.href = url;
    })

    $(".btn-play-audio").click(async function(){
        var target = $(this).attr("for");
        var audio = document.getElementById(target);
        audio.currentTime = 0;
        if(audio.pause){
            audio.play().catch((e)=>{
               console.log("------"+e)
            });
            await timer(2000);
        }
        audio.pause();
    })

    function goSellPage(mPage){
        var url = changeSearchParam({sellPage: mPage})
        document.location.href = url;
    }
    
    function goBuyPage(mPage){
        var url = changeSearchParam({buyPage: mPage})
        document.location.href = url;
    }
</script>
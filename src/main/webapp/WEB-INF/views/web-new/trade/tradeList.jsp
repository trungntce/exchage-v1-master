<%--
  Created by IntelliJ IDEA.
  User: ntt.dev
  The page MyRoom
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- head -->
<%@ include file="/WEB-INF/layout/web-new/include/head.jsp"%>
<!-- #head -->

<body class="pace-done">
  <div class="wrapper">
    <!-- header -->
      <%@ include file="/WEB-INF/layout/web-new/include/header.jsp"%>
    <!-- #header -->
    <div class="trade-pop-wrap modal">      
      <div class="trade-pop-container">
        <div class="title">
          <h2><spring:message code="buy.register.page.title"/></h2>
          
        </div>      

          <div class="start-login">
            <div class="btn btn-primary">거래종료</div>
            <div class="btn secondary">취소</div>
          </div>
        </div>
      </div>
    </div>

    <section class="dim"></section>

    <section class="container">

      <!-- <article class="sub-title sub-title--trade">
        <h2><spring:message code="trade.page.title"/></h2>
        <p><spring:message code="trade.page.content.fist.title"/><br><spring:message code="trade.page.content.second.title"/></p>
      </article> -->

      <article class="trade-wrap">
        <div class="trade__control marin-top-30px">
          <div class="trade__control__inner">
            <ul class="nav nav-pills trade__control__list" trade-tab="${buySearch.targetView}">
              <li class="nav-item" tab-target="#buy-order">
                <a class="nav-link" id="tab-buy-order" aria-current="page"><spring:message code="trade.tab.buy.title"/></a>
              </li>
              <li class="nav-item" tab-target="#sell-order">
                <a class="nav-link" id="tab-sell-order"><spring:message code="trade.tab.sell.title"/></a>
              </li>
            </ul>
            <ul class="nav nav-pills me-4" trade-status="${buySearch.idOrderStatus}">            
                <li class="nav-item order-status" data-status=""><a class="nav-link"><spring:message code="trade.status.order.all.title"/></a></li>
                <li class="nav-item order-status" data-status="1"><a class="nav-link"><spring:message code="trade.status.order.wait.title"/></a></li>
                <li class="nav-item order-status" data-status="2"><a class="nav-link"><spring:message code="trade.status.order.trade.title"/></a></li>
                <li class="nav-item order-status" data-status="3"><a class="nav-link"><spring:message code="trade.status.order.finish.title"/></a></li>
            </ul>
          </div>
        </div>
        <div class="article-inner">
          <div class="tabs">
             <div class="trade-btn-wrap form-wrap form-full" style="margin:20px 0 20px;">
              <select class="symbol tokenSelect" symbol-value="${buySearch.symbol}">
                     <option value=""><spring:message code="common.message.all.title"/></option>
                    <c:forEach items="${tokens}" var="item" varStatus="loop">
                        <c:choose>
                            <c:when test="${buySearch.symbol == item.symbol}">
                                 <option value="${item.symbol}" selected>${item.symbol}</option>
                            </c:when>                               
                            <c:otherwise>
                                <option value="${item.symbol}">${item.symbol}</option>
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                </select>
              </div>
            <!-- <ul>
              <c:choose>
                  <c:when test= "${empty buySearch.symbol}">
                    <li class="trade-symbol is-current" data-symbol=""><a><spring:message code="trade.token.all.title"/></a></li>
                  </c:when>
                  <c:otherwise>
                     <li class="trade-symbol" data-symbol=""><a><spring:message code="trade.token.all.title"/></a></li>
                  </c:otherwise>
                </c:choose>
                <c:forEach items="${tokens}" var="item" varStatus="loop">    
                  <c:choose>

                    <c:when test ="${buySearch.symbol == item.symbol}">
                      <li class="trade-symbol is-current" data-symbol="${item.symbol}"><a>${item.symbol}</a></li>  
                    </c:when>

                    <c:otherwise>                        
                      <li class="trade-symbol" data-symbol="${item.symbol}"><a>${item.symbol}</a></li>                
                    </c:otherwise>  

                  </c:choose> 
                </c:forEach>                          
            </ul> -->
          </div>
          <div class="trade__cont">
              <c:if test="${fn:length(wallet.wallets) > 1}">

                   <spring:message code="buy.request.choose.your.wallet"/>:

                <div class="trade-btn-wrap form-wrap form-full" style="margin-top: 30px;margin-bottom:40px;">
                <!-- <spring:message code="buy.request.choose.your.wallet"/>: -->
                    <select class="symbol walletSelect">
                        <c:forEach items="${wallet.wallets}" var="item" varStatus="loop">
                             <c:choose>
                                <c:when test="${buySearch.walletAddress == item.walletAddress}">
                                     <option value="${item.walletAddress}" path='' repeat="${item.repeatSeconds}" selected>${item.walletAddress}</option>
                                </c:when>                               
                                <c:otherwise>
                                     <option value="${item.walletAddress}" path='' repeat="${item.repeatSeconds}">${item.walletAddress}</option>
                                </c:otherwise>
                            </c:choose>
                           
                        </c:forEach>
                      
                    </select>
                </div>
            </c:if>
            <div class="d-flex justify-content-end mt-4">
            <c:choose>
              <c:when test="${not empty wallet && wallet.wallets.size() > 0 && (wallet.role == 'USER'
                                                                                    || wallet.role == 'TRADER'
                                                                                    || wallet.role == 'CLIENT'
                                                                                    || wallet.role == 'CLIENT_TRADER')}">
                <button class="btn btn-dark mb-4 hide" trade-register="#buy-order" redirect="${_ctx}/buyRegister?buyerWalletAddress=${buySearch.walletAddress}&symbol=${buySearch.symbol}&walletAddress=${wallet_current.walletAddress}"><spring:message code="common.button.buy.register.title"/>
                </button>
                <button class="btn btn-dark mb-4 hide" trade-register="#sell-order" redirect="${_ctx}/sellRegister?sellerWalletAddress=${buySearch.walletAddress}&symbol=${buySearch.symbol}&walletAddress=${wallet_current.walletAddress}"><spring:message code="common.button.sell.register.title"/>
                </button>                 
              </c:when>
              <c:otherwise>                    
                <button class="btn btn-dark mb-4 btn-question-login hide" trade-register="#buy-order"><spring:message code="common.button.buy.register.title"/>
                </button>
                <button class="btn btn-dark mb-4 btn-question-login hide" trade-register="#sell-order"><spring:message code="common.button.sell.register.title"/>
                </button>  
              </c:otherwise>
            </c:choose>
            </div>
            <div class="d-flex justify-content-end mt-4">
                <button class="btn btn-secondary order-status" data-status=""><i class="bi bi-arrow-repeat"></i><spring:message code="trade.status.order.refresh.title"/></button>
            </div>
              <div id="buy-order" class="hide">
                <div class="list-wrap trade-list-wrap hide">
                  <div class="trade-list-wrap">
                    <div class="trade-list-head">                    
                        <div class="trade-list-th"><spring:message code="trade.buy.coin.title"/></div>
                        <!-- <div class="trade-list-th"><spring:message code="trade.buy.orderKind.title"/></div> -->
                        <div class="trade-list-th"><spring:message code="trade.buy.tokenCnt.title"/></div>
                        <div class="trade-list-th"><spring:message code="trade.buy.price.title"/></div>
                        <div class="trade-list-th"><spring:message code="trade.buy.totalAmount.title"/></div>
                        <div class="trade-list-th"><spring:message code="trade.buy.createDate.title"/></div>
                        <div class="trade-list-th"><spring:message code="trade.buy.orderNumber.title"/></div>
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
                          <div class="trade-list-td coin-name">${item.symbol}</div>
                          <div class="trade-list-td ea"><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.quantity}"/> <spring:message code="common.unit.count.title"/></div>
                          <div class="trade-list-td price-one"><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.unitPrice}"/> <spring:message code="common.unit.won.title"/></div>
                          <div class="trade-list-td price-total"><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.totalPrice}"/> <spring:message code="common.unit.won.title"/></div>
                          <div class="trade-list-td date"><fmt:formatDate value="${item.buyRegDate}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
                          <!-- <div class="trade-list-td category">API</div> -->
                          <div class="trade-list-td other-num">${item.symbol}<fmt:formatDate value="${item.buyRegDate}" pattern="yyyyMMddHHmmss"/>${item.buyId}</div>
                          <div class="trade-list-td status">
                            <c:choose>
                              <c:when test="${(item.state == 1
                              || fn:containsIgnoreCase(wallet.wallets, item.sellerWalletAddress)
                              || fn:containsIgnoreCase(wallet.wallets, item.buyerWalletAddress)
                              || fn:containsIgnoreCase(wallet.wallets, item.regWalletAddress))
                              && not empty wallet }">
                                  <c:if test="${item.state == 1}"><div class="status-btn status-wait" data-id="" redirect="${_ctx}/tradeBuyDetail?buyId=${item.buyId}&walletAddress=${walletCurrent.walletAddress}">${item.stateName}</div></c:if>
                                  <c:if test="${item.state == 2}"><div class="status-btn status-ing" data-id="" redirect="${_ctx}/tradeBuyDetail?buyId=${item.buyId}&walletAddress=${walletCurrent.walletAddress}">${item.stateName}</div></c:if>
                                  <c:if test="${item.state == 3}"><div class="status-btn status-end" data-id="" redirect="${_ctx}/tradeBuyDetail?buyId=${item.buyId}&walletAddress=${walletCurrent.walletAddress}">${item.stateName}</div></c:if>
                                  <c:if test="${item.state == 4}"><div class="status-btn status-ing" data-id="" redirect="${_ctx}/tradeBuyDetail?buyId=${item.buyId}&walletAddress=${walletCurrent.walletAddress}">${item.stateName}</div></c:if>
                              </c:when>
                              <c:when test="${empty wallet}">
                                  <c:if test="${item.state == 1}"><div class="status-btn status-wait btn-question-login">${item.stateName}</div></c:if>
                                  <c:if test="${item.state == 2}"><div class="status-btn status-ing btn-question-login">${item.stateName}</div></c:if>
                                  <c:if test="${item.state == 3}"><div class="status-btn status-end btn-question-login">${item.stateName}</div></c:if>
                                  <c:if test="${item.state == 4}"><div class="status-btn status-ing btn-question-login">${item.stateName}</div></c:if>
                              </c:when>
                              <c:otherwise>
                                  <c:if test="${item.state == 1}"><div class="status-btn status-wait">${item.stateName}</div></c:if>
                                  <c:if test="${item.state == 2}"><div class="status-btn status-ing">${item.stateName}</div></c:if>
                                  <c:if test="${item.state == 3}"><div class="status-btn status-end">${item.stateName}</div></c:if>
                                  <c:if test="${item.state == 4}"><div class="status-btn status-ing">${item.stateName}</div></c:if>
                              </c:otherwise>
                          </c:choose>

                          </div> <!-- status-wait , status-ing , status-end -->
                        </div>
                    </c:forEach>
                  </div>                 
                </div>     
               <pg:webpaging page="${buySearch}" script="goBuyPage"/>   
              </div>                  
          </div>         
            <!-- end trade__cont -->
        <!--   </div>    -->
          <div id="sell-order" class="hide">
            <div class="list-wrap trade-list-wrap hide" >
              <div class="trade-list-wrap">
                <div class="trade-list-head">                 
                     <div class="trade-list-th"><spring:message code="trade.buy.coin.title"/></div>
                    <!-- <div class="trade-list-th"><spring:message code="trade.buy.orderKind.title"/></div> -->
                    <div class="trade-list-th"><spring:message code="trade.buy.tokenCnt.title"/></div>
                    <div class="trade-list-th"><spring:message code="trade.buy.price.title"/></div>
                    <div class="trade-list-th"><spring:message code="trade.buy.totalAmount.title"/></div>
                    <div class="trade-list-th"><spring:message code="trade.buy.createDate.title"/></div>
                    <div class="trade-list-th"><spring:message code="trade.buy.orderNumber.title"/></div>
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
                      <div class="trade-list-td coin-name">${item.symbol}</div>
                      <div class="trade-list-td ea"><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.quantity}"/> <spring:message code="common.unit.count.title"/></div>
                      <div class="trade-list-td price-one"><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.unitPrice}"/> <spring:message code="common.unit.won.title"/></div>
                      <div class="trade-list-td price-total"><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.totalPrice}"/> <spring:message code="common.unit.won.title"/></div>
                      <div class="trade-list-td date"><fmt:formatDate value="${item.sellRegDate}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
                      <!-- <div class="trade-list-td category">API</div> -->
                      <div class="trade-list-td other-num">${item.symbol}<fmt:formatDate value="${item.sellRegDate}" pattern="yyyyMMddHHmmss"/>${item.sellId}</div>
                      <div class="trade-list-td status">
                        <c:choose>
                          <c:when test="${(item.state == 1
                          || fn:containsIgnoreCase(wallet.wallets, item.buyerWalletAddress)
                          || fn:containsIgnoreCase(wallet.wallets, item.sellerWalletAddress)
                          || fn:containsIgnoreCase(wallet.wallets, item.regWalletAddress))
                          && not empty wallet }">
                              <c:if test="${item.state == 1}"><div class="status-btn status-wait" data-id="" redirect="${_ctx}/tradeSellDetail?sellId=${item.sellId}&walletAddress=${walletCurrent.walletAddress}">${item.stateName}</div></c:if>
                              <c:if test="${item.state == 2}"><div class="status-btn status-ing" data-id="" redirect="${_ctx}/tradeSellDetail?sellId=${item.sellId}&walletAddress=${walletCurrent.walletAddress}">${item.stateName}</div></c:if>
                              <c:if test="${item.state == 3}"><div class="status-btn status-end" data-id="" redirect="${_ctx}/tradeSellDetail?sellId=${item.sellId}&walletAddress=${walletCurrent.walletAddress}">${item.stateName}</div></c:if>
                              <c:if test="${item.state == 4}"><div class="status-btn status-ing" data-id="" redirect="${_ctx}/tradeSellDetail?sellId=${item.sellId}&walletAddress=${walletCurrent.walletAddress}">${item.stateName}</div></c:if>
                          </c:when>
                          <c:when test="${empty wallet}">
                              <c:if test="${item.state == 1}"><div class="status-btn status-wait btn-question-login">${item.stateName}</div></c:if>
                              <c:if test="${item.state == 2}"><div class="status-btn status-ing btn-question-login">${item.stateName}</div></c:if>
                              <c:if test="${item.state == 3}"><div class="status-btn status-end btn-question-login">${item.stateName}</div></c:if>
                              <c:if test="${item.state == 4}"><div class="status-btn status-ing btn-question-login">${item.stateName}</div></c:if>
                          </c:when>
                          <c:otherwise>
                              <c:if test="${item.state == 1}"><div class="status-btn status-wait">${item.stateName}</div></c:if>
                              <c:if test="${item.state == 2}"><div class="status-btn status-ing">${item.stateName}</div></c:if>
                              <c:if test="${item.state == 3}"><div class="status-btn status-end">${item.stateName}</div></c:if>
                               <c:if test="${item.state == 4}"><div class="status-btn status-ing">${item.stateName}</div></c:if>
                          </c:otherwise>
                      </c:choose>

                      </div> <!-- status-wait , status-ing , status-end -->
                    </div>
                </c:forEach>
              </div>                       
            </div>
             <pg:webpaging page="${sellSearch}" script="goSellPage"/>  
          </div>
        </div>
        </div>
      </article>
    </section>

    <!-- footer -->
  <%@ include file="/WEB-INF/layout/web-new/include/footer.jsp"%>
  <!-- #footer -->
  </div>
</body>

<script>
    $(document).ready(function(){
        init();        
    })

    function init(){

        //Tab target
        var tradeTab = $("[trade-tab]").attr("trade-tab");
        tradeTab = (tradeTab == "" || tradeTab == null) ? "#buy-order" : tradeTab;
        $(".nav-item[tab-target='"+tradeTab+"']").children().addClass("active");        
        $(tradeTab).removeClass("hide");   
        $(tradeTab).children().removeClass("hide");  
        $("[trade-register='"+tradeTab+"']").removeClass("hide");

        //Status target
        var tradeStatus = $("[trade-status]").attr("trade-status");
        tradeStatus = (tradeStatus == "" || tradeStatus == null) ? "" : tradeStatus;
        $(".order-status[data-status='"+tradeStatus+"']").children().addClass("active");        
        //console.log(tradeStatus);

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
     $(".tokenSelect").change(function(){   
        let token = $(this).find("option:selected").val();
       console.log(token);
        var url = changeSearchParam({symbol: token})
        document.location.href = url;
       
    })

    $(".order-status").click(function(){
        var status = $(this).attr("data-status");
        var url = changeSearchParam({idOrderStatus: status, sellPage: 1, buyPage: 1})
        document.location.href = url;
    })

    // $(".sub-snb-menu-item:not(.acitve)").click(function(){
    //     var target = $(this).attr("tab-target");
    //     var url = changeSearchParam({targetView: target})
    //     document.location.href = url;
    // })

     $("#tab-buy-order").click(function(){
        var target = $(this).parent().attr("tab-target");
        console.log(target);
        var url = changeSearchParam({targetView: target})
        document.location.href = url;
    })
      $("#tab-sell-order").click(function(){
        var target = $(this).parent().attr("tab-target");
        var url = changeSearchParam({targetView: target})
        document.location.href = url;
    })
    $(".btn-question-login").click(function(){

          if (confirm("<spring:message code="trade.question.login.message"/>") == true) {                       
            document.location.href= "${_ctx}/login";
          }
    });
    $(".walletSelect").change(async function(){
     let wallet = $(this).find("option:selected").val();
       console.log(wallet);
        var url = changeSearchParam({walletAddress: wallet})
        document.location.href = url;
    })
    
</script>
<%--
  Created by IntelliJ IDEA.
  User: ntt.dev
  The page sell register
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
<c:set var="roleCode">${wallet.role}</c:set>
<body class="pace-done">
    <div class="mask"></div>
    <div class="wrapper ex-wrapper">
        <!-- Sell form -->
        <section class="wrap trade-wrap">
             <!-- <article class="sub-title sub-title--trade">
                <h2><spring:message code="sell.register.page.title"/></h2>
                <p><spring:message code="sell.register.page.content"/></p>
            </article> -->

            <div class="container">
                <div class="language-list">
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
                </div>
                 <br>
                <button href="" id="feedback-web" title='<spring:message code="feedback.title.create"/>' onclick="javascript:showModal('#feedbackRequestModal', false)" style="float: right;">
                            <i class="ci ci-feedback"></i><b><spring:message code="feedback.title.create"/></b>
                </button>    
                <br>
                <form id="formSellRequest" method="post" action="${baseUrl}/sellRequest">
                <div class="trade-pop-form">                    
                    <div class="form-full">
                        <spring:message code="common.message.balances.title"/>: <label class="my-balance" id="myBalance" wallet-address="${wallet.walletAddress}"></label> ${tokenSymbol}
                    </div>
                    <div class="form-wrap form-full">
                        <select name="sellerWalletAddress" class="walletSelect" target="#sellRequest">
                            <c:forEach items="${wallet.wallets}" var="item" varStatus="loop">
                                <option value="${item.walletAddress}" fee="${item.fee}">${item.walletAddress}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="form-wrap form-full">
                        <select name="symbol" class="symbol">
                            <c:forEach items="${tokens}" var="item" varStatus="loop">
                                 <c:if test="${item.symbol == tokenSymbol}">
                                    <option value="${item.symbol}" unitPrice="${item.unitPrice}" >${item.symbol}</option>
                                </c:if>
                            </c:forEach>
                        </select>
                    </div>


                    <div class="form-wrap form-full">
                        <spring:message code="sell.register.form.tokenNum.hint" var="tokenNumHint"/>
                        <input name="quantity" placeholder="${tokenNumHint}" class="tokenNum" type="number" target="#sellRequest" min="1"/>
                    </div>
                    <div class="trade-pop-form-info">
                        <dl class="trade-pop-form-info-item">
                            <dt><spring:message code="sell.register.form.price.title"/></dt>
                              <dd class="price-one">
                               <c:forEach items="${tokens}" var="item" varStatus="loop">
                                     <c:if test="${item.symbol == tokenSymbol}">
                                        <fmt:formatNumber type="number" maxFractionDigits="3" value="${item.unitPrice}"/> <spring:message code="common.unit.won.title"/>
                                    </c:if>
                                </c:forEach>    
                              </dd>
                        </dl>                      
                        <dl class="trade-pop-form-info-item ex-height-auto">
                            <dt class="ex-height-auto"><spring:message code="sell.register.form.tokenCnt.title"/></dt>
                            <dd><label class="lb-token-cnt">0</label> <spring:message code="common.unit.count.title"/></dd>
                        </dl>
                          <dl class="trade-pop-form-info-item ex-height-auto">
                            <dt class="ex-height-auto"><spring:message code="sell.register.form.fee.title"/></dt>
                            <dd><label class="lb-fee">0</label> </dd>
                        </dl>
                        <dl class="trade-pop-form-info-item ex-height-auto">
                            <dt class="ex-height-auto"><spring:message code="sell.register.form.amount.title"/></dt>
                            <dd>
                                <label class="lb-amount"></label>
                                <spring:message code="common.unit.won.title"/>
                                <div class="space-mobile"></div>
                                <span>(<spring:message code="sell.detail.fee.title"/> -<label class="lb-amount-fee">0 </label> <spring:message code="common.unit.won.title"/>)</span>
                            </dd>
                        </dl>
                        <dl class="trade-pop-form-info-item ex-height-auto">
                            <dt class="ex-height-auto"><spring:message code="sell.register.form.totalPrice.title"/></dt>
                            <dd class="price-total"><label class="lb-total-price">0 </label> <spring:message code="common.unit.won.title"/></dd>
                        </dl>
                    </div>

                    <div class="join-terms">
                        <div class="title"><input type="checkbox" id="cb-term-all"><spring:message code="sell.register.form.termAll.title"/></div>
                        <div class="title"><input type="checkbox" class="cb-term"><label onclick="javascript:showModal('.modal-otc-1', false)"><spring:message code="sell.register.form.term1.title"/></label></div>
                        <div class="title"><input type="checkbox" class="cb-term"><label onclick="javascript:showModal('.modal-otc-2', false)"><spring:message code="sell.register.form.term2.title"/></label></div>
                    </div>

                    <div class="start-login">
                        <div class="btn btn-primary btn-submit" target="#sellRequest" style="pointer-events: none; background-color: #6a4d78"><spring:message code="common.button.submit.title"/></div>
                        <div class="btn secondary bnt-close"><spring:message code="common.button.close.title"/></div>
                    </div>
                </div>
                 <input type="hidden" name="viewRole" value="API" />
                <input type="hidden" name="type" value="ex" />
                <input type="hidden" name="clientId" value="${sellRequest.clientId}" />
                </form>
            </div>
        </section>
        <!-- * Sell form -->
        </div>

        <div class="join-terms-wrap modal-otc-1">
            <div class="close" onclick="closeTap(this, true)"></div>
            <h2><spring:message code="common.register.agree.terms"/></h2>
            <div class="agreement-document">
                <spring:message code="common.register.agreement.document1"/><br>
                <spring:message code="common.register.agreement.document2"/><br>
                <spring:message code="common.register.agreement.document3"/>
            </div>
        </div>

        <div class="join-terms-wrap modal-otc-2">
            <div class="close" onclick="closeTap(this, true)"></div>
            <h2><spring:message code="common.register.agreement.document4"/></h2>
            <div class="agreement-document">
                <spring:message code="common.register.agreement.document5"/><br>
                <spring:message code="common.register.agreement.document6"/>
            </div>
        </div>
    </div>
</body>
<%@ include file="/WEB-INF/layout/web-new/modals/feedbackModal.jsp"%>
<%@ include file="/WEB-INF/layout/web-new/modals/feedbackRequestModal.jsp"%>
<script>
    console.log($(".symbol").find("option:selected").attr("unitPrice"));
    var dataset = {
        unitPrice: $(".symbol").find("option:selected").attr("unitPrice"),
        // fee: $(".symbol").find("option:selected").attr("fee")
        fee: 1
    }
    var totalToken = 0.0;

    $(document).ready(function(){
        $(".walletSelect").change();
    })

    function loadBalancesInList(address){
        var param = {listAddress: []};
        if(address == null){
            $("#tbl-wallets").find(".my-balance[wallet-address]").each(function(){
                param.listAddress.push($(this).attr("wallet-address"))
            })    
        }else{
            param.listAddress.push(address);
        }
        loadBalanceWeb({walletAddress: valWallet, symbol: ${tokenSymbol}});
    }

    $(".btn-submit").click(function(){
        
        var val = $(".tokenNum").val();                
        // console.log(myWalletBalance);
        // console.log(val);
        if((val.length > 0 && (val * 1 > 0) && val <= myWalletBalance)){
            if(confirm("<spring:message code="order.agree.confirm.message"/>")){
               $('#formSellRequest').submit();
            } 
        }
        else{
            if (val > myWalletBalance) {
                     alert("<spring:message code="common.not.enough.token"/>");
            }else
            {
             $('.tokenNum').focus();
            setTimeout(function(){
             alert("<spring:message code="order.token.count.check.message"/>");     
            },300);  
        }
    }
})

    $(".walletSelect").change(async function(){
        
        var valWallet = $(this).find("option:selected").val();
        dataset.fee = $(this).find("option:selected").attr("fee");
        $(".lb-fee").html(dataset.fee);
        $(this).find(".my-balance").attr("wallet-address", valWallet);        
        loadBalanceWeb({walletAddress: $(".walletSelect").find("option:selected").val(), symbol: $(".symbol").find("option:selected").val()});
    })

    $(".tokenNum").keyup(function(){
        
        var val = $(this).val() * 1;
        if(val.length == 0) val = 0;
        var checkAmount = (val * dataset.unitPrice);
        var amountFee = 0;
        if (checkAmount> 100000 ) {
            //FEE = 1 % 
            amountFee = (val * dataset.fee * dataset.unitPrice)/100;
        }else{
            // FEE = 1 TOKEN (1,000WON)               
            amountFee = dataset.unitPrice;
        }
        
        var amount = val * dataset.unitPrice;
        var totalPrice = amount - amountFee;

        var tokenFee = val * dataset.fee;        
        
        $(".lb-amount").html(amount.toLocaleString());
        if (amount > 100000) {
            $('.lb-fee').html('1%');
        }else{
            $('.lb-fee').html("1.000" + '<spring:message code="common.unit.won.title"/>')
        }
        $(".lb-amount-fee").html(amountFee.toLocaleString());
        $(".lb-token-cnt").html(val.toLocaleString() + " ");
        $(".lb-total-price").html(totalPrice.toLocaleString());
    });

    $(".symbol").change(async function(){            
      var valUnitPrice = $(this).find("option:selected").attr("unitPrice") * 1;
      dataset.unitPrice =  valUnitPrice;
      $(".price-one").html(valUnitPrice.toLocaleString('en-US')+'원');              
      // Reset fee, total price              
      var val =$(".tokenNum").val() * 1;
      if(val.length == 0) val = 0;
      var amountFee = 0;
      if (val > 0) {
            var checkAmount = (val * dataset.unitPrice);   
             if (checkAmount > 100000 ) {
            //FEE = 1 % 
                amountFee = (val * dataset.fee * dataset.unitPrice)/100;                  
           
            }else {
                // FEE = 1 TOKEN (1,000WON)

                amountFee = dataset.unitPrice;
            }    
        }  
      var amount = val * dataset.unitPrice;
      var totalPrice = amount - amountFee;
      $(".lb-amount").html(amount.toLocaleString());
      $(".lb-amount-fee").html(amountFee.toLocaleString());
      $(".lb-token-cnt").html(val.toLocaleString());
      $(".lb-total-price").html(totalPrice.toLocaleString());
          
    });

    $("#cb-term-all").change(function(){
        $(".cb-term").prop('checked', $(this).prop("checked"));
        if($(this).is(":checked")){
            $(".btn-submit").css({"pointer-events": "unset", "background-color": "#b17acc"});
        }else{
            $(".btn-submit").css({"pointer-events": "none", "background-color": "#6a4d78"});
        } 
    })

    $(".cb-term").change(function(){
        var c = $(".cb-term:not(:checked)").length;
        if(c !== 0){
            $("#cb-term-all").prop('checked', false);
            $(".btn-submit").css({"pointer-events": "none", "background-color": "#6a4d78"});
        }else{
            $("#cb-term-all").prop('checked', true);
            $(".btn-submit").css({"pointer-events": "unset", "background-color": "#b17acc"});
        }
    })
    $(".bnt-close").click(function(){
        window.close();
    })
</script>
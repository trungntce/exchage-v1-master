<%--
  Created by IntelliJ IDEA.
  User: ntt.dev
  The page sell register
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- head -->
<%@ include file="/WEB-INF/layout/web-new/include/head.jsp"%>
<!-- #head -->
<c:set var="roleCode">${wallet.role}</c:set>
<c:set var = "ownerSymbol" scope = "session" value = "none"/>
<c:set var = "otherSymbol" scope = "session" value = ""/>
<c:if test="${sellRequest.symbol == 'BANI' || sellRequest.symbol == 'EGG'}">
    <c:set var = "ownerSymbol" scope = "session" value = ""/>
    <c:set var = "otherSymbol" scope = "session" value = "none"/>
</c:if>

<body class="pace-done">
<div class="wrapper">
<!-- Sell form -->
    <section class="wrap trade-wrap">
      <!-- header -->
        <%@ include file="/WEB-INF/layout/web-new/include/header.jsp"%>
      <!-- #header -->
        <!-- <article class="sub-title sub-title--trade">
            <h2><spring:message code="sell.register.page.title"/></h2>
            <p><spring:message code="sell.register.page.content"/></p>
        </article> -->

        <div class="container">
            <form id="formSellRequest"  method="post" action="${baseUrl}/sellRequest">
            <div class="trade-pop-form">
                <div class="form-full">
                   <!--  <spring:message code="common.message.balances.title"/>: <label class="my-balance" wallet-address="${wallet.walletAddress}"></label>  -->
               <div class="form-full" id="balance-trade">
                <spring:message code="common.message.balances.title"/>: <label class="my-balance" wallet-address="${wallet_current.walletAddress}"></label>
                <input type="hidden" class="m-test"/>
                </div>
                </div>
                <div class="form-wrap form-full">
                    <select name="symbol" class="symbol">
                        <c:forEach items="${tokens}" var="item" varStatus="loop">
                            <c:choose>
                                <c:when test="${not empty sellRequest.symbol && item.symbol == sellRequest.symbol}">
                                    <option value="${item.symbol}" unitPrice="${item.unitPrice}" selected>
                                        ${item.symbol}
                                    </option>
                                </c:when>
                                <c:otherwise>
                                    <option value="${item.symbol}" unitPrice="${item.unitPrice}">${item.symbol}</option>
                                </c:otherwise>
                            </c:choose>
                            
                        </c:forEach>
                    </select>
                </div>
                <div class="form-wrap form-full">
                    <select id="walletAddress" name="sellerWalletAddress" class="walletSelect" target="#sellRequest" style="display:${ownerSymbol}">
                        <c:forEach items="${wallet.wallets}" var="item" varStatus="loop">
                            <c:choose>
                                <c:when test="${not empty wallet_current.walletAddress && item.walletAddress == wallet_current.walletAddress}">
                                    <option value="${item.walletAddress}" fee="${item.fee}" selected>
                                        ${item.walletAddress}
                                    </option>
                                </c:when>
                                <c:otherwise>
                                    <option value="${item.walletAddress}" fee="${item.fee}">
                                        ${item.walletAddress}
                                    </option>
                                </c:otherwise>
                            </c:choose>
                                    
                        </c:forEach>
                    </select>
                    <spring:message code="trade.enter.wallet" var="enterWalletHint"/>
                    <input id="otherWallet" name="otherWallet" placeholder="${enterWalletHint}" class="" type="text" maxlength="100" target="#buyRequest"  style="display:${otherSymbol}">
                </div>

                <c:if test="${wallet != null && fn:containsIgnoreCase('CLIENT', roleCode)}">
                    <div class="form-wrap form-full">
                        <select name="type">
                            <option value="TRADER"><spring:message code="sell.register.form.orderKind.trader.title"/></option>
                        </select>
                    </div>
                </c:if>

                <div class="form-wrap form-full">
                    <spring:message code="sell.register.form.tokenNum.hint" var="tokenNumHint"/>
                    <input name="quantity" placeholder="${tokenNumHint}" class="tokenNum" type="number" target="#sellRequest" min="1"/>
                </div>
                <c:if test="${wallet.role == 'USER' && (buyRequest.symbol != 'BANI' && buyRequest.symbol != 'EGG')}">
                    <dd class="radio-trade-type" style="display:${otherSymbol}">
                        <input type="radio" id="tradeType" name="tradeType" value="1" checked><label for="normal" class="ms-1 me-3"><spring:message code="trade.title.normal"/></label>
                        <input type="radio" id="tradeType" name="tradeType" value="2"><label for="safe" class="ms-1 me-3"><spring:message code="trade.title.safe"/></label>
                    </dd>
                </c:if>
                
                <div class="trade-pop-form-info">
                    <dl class="trade-pop-form-info-item">
                        <dt><spring:message code="sell.register.form.price.title"/></dt>
                          <dd class="price-one" style="display:${ownerSymbol}">
                            <c:forEach items="${tokens}" var="item" varStatus="loop" end="0">
                               <fmt:formatNumber type="number" maxFractionDigits="3" value="${item.unitPrice}"/> <spring:message code="common.unit.won.title"/>
                            </c:forEach>
                        </dd>
                        <dd class="other-price-one" style="display: ${otherSymbol}">
                            <spring:message code="trade.enter.price" var="enterPriceHint"/>
                            <input name="unitPrice" class="input-other-price onlynum" type="text" maxFractionDigits="3" placeholder="${enterPriceHint}" class="tokenNum onlynum" maxlength="32"/> <spring:message code="common.unit.won.title"/>
                        </dd>                       
                    </dl>
                    <dl class="trade-pop-form-info-item ex-height-auto">
                        <dt class="ex-height-auto"><spring:message code="sell.register.form.tokenCnt.title"/></dt>
                        <dd><label class="lb-token-cnt">0 </label> <spring:message code="common.unit.count.title"/></dd>
                    </dl>
                      <dl class="trade-pop-form-info-item ex-height-auto">
                        <dt class="ex-height-auto"><spring:message code="sell.register.form.fee.title"/></dt>
                        <dd><label class="lb-fee">0 </label></dd>
                    </dl>
                    <dl class="trade-pop-form-info-item ex-height-auto">
                        <dt class="ex-height-auto"><spring:message code="sell.register.form.amount.title"/></dt>
                        <dd>
                            <label class="lb-amount"></label>
                            <spring:message code="common.unit.won.title"/>
                        </dd>
                    </dl>
                    <dl class="trade-pop-form-info-item ex-height-auto">
                        <dt class="ex-height-auto"><spring:message code="sell.register.form.totalPrice.title"/></dt>
                        <dd class="price-total"><label class="lb-total-price">0 </label> <spring:message code="common.unit.won.title"/></dd>
                    </dl>
                    <dl class="trade-pop-form-info-item ex-height-auto trade-warning-title-other" style="display:${otherSymbol}">
                        <dd style="width: 100% !important;"><font color="red"><spring:message code="common.trade.warning.title"/></font></dd>
                    </dl>
                </div>
                
                <div class="join-terms">
                    <div class="title"><input type="checkbox" id="cb-term-all"><spring:message code="sell.register.form.termAll.title"/></div>
                    <div class="title"><input type="checkbox" class="cb-term"><label onclick="javascript:showModal('.modal-otc-1', false)"><spring:message code="sell.register.form.term1.title"/></label></div>
                    <div class="title"><input type="checkbox" class="cb-term"><label onclick="javascript:showModal('.modal-otc-2', false)"><spring:message code="sell.register.form.term2.title"/></label></div>
                </div>

                <div class="start-login">
                    <div class="btn btn-primary btn-submit" target="#sellRequest" style="pointer-events: none; background-color: #6a4d78"><spring:message code="common.button.submit.title"/></div>
                    <div class="btn secondary" onclick="btnSellBack()"><spring:message code="common.button.goList.title"/></div>
                </div>
            </div>

            <c:if test="${wallet.role == 'CLIENT'}">
                <input type="hidden" name="viewRole" value="TRADER" />
            </c:if>
            </form>
        </div>
    </section>
</div>
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
    <!-- footer -->
      <%@ include file="/WEB-INF/layout/web-new/include/footer.jsp"%>
    <!-- #footer -->
</body>
<script>    
    var dataset = {
        unitPrice: $(".symbol").find("option:selected").attr("unitPrice"),
        // fee:  $("#walletAddress").find("option:selected").attr("fee")
        fee:  1
    }

    $(document).ready(function(){
        // $(".walletSelect").change();
        $(".symbol").change();

        console.log($('.my-balance').text())

    })    

    $(".btn-submit").click(function(){

        let tokenSelect = $(".symbol").find("option:selected").val();
        if ($(".tokenNum").val().length <= 0) {
            alert("<spring:message code="order.token.count.check.message"/>");
            $(".tokenNum").focus();
            return;
        }
        if (tokenSelect === 'BANI' || tokenSelect == 'EGG') { 
            if(confirm("<spring:message code="order.agree.confirm.message"/>")){
                if ($('.my-balance').text() < $(".tokenNum").val()) {                    
                    alert("<spring:message code="common.not.enough.token"/>");  
                    return;
                }
                    $('#formSellRequest').submit();
                
            }
             
        }else {
            if ($('#otherWallet').val().length <= 0) {
                 alert("<spring:message code="common.input.wallet.incorrect"/>");
                 $('#otherWallet').focus();    
                 return; 

            }else if ($('.input-other-price').val().length <= 0){
                alert("<spring:message code="common.input.UnitPrice.incorrect"/>");   
                $('.input-other-price').focus(); 
                return;
            }
            if(confirm("<spring:message code="order.agree.confirm.message"/>")){                
                $('#formSellRequest').submit();
            }
        }        
        
    })

    $(".walletSelect").change(async function(){
        
        // var valWallet = $(this).find("option:selected").val();
        // dataset.fee = $(this).find("option:selected").attr("fee");
        // $(".lb-fee").html(dataset.fee);
        // $(this).find(".my-balance").attr("wallet-address", valWallet);        
        //  loadBalanceWeb({walletAddress: $(".walletSelect").find("option:selected").val(), symbol: $(".symbol").find("option:selected").val()});
        let wallet = $(this).find("option:selected").val();       
        var url = changeSearchParam({sellerWalletAddress: wallet, walletAddress: wallet})
        document.location.href = url;
    })
var amountFee = 0;
    $(".tokenNum").keyup(function(){        
    
        let tokenSelect = $(".symbol").find("option:selected").val();
        if (tokenSelect === 'BANI' || tokenSelect == 'EGG') { 

            var val = $(".tokenNum").val() * 1;        
            if(val.length == 0) val = 0;        
             var checkAmount = (val * dataset.unitPrice);
            
            if (checkAmount > 100000 ) {
            //FEE = 1 % 
                amountFee = (val * dataset.fee * dataset.unitPrice)/100;   

                
            }else{                
                // FEE = 1 TOKEN (1,000WON)               
                amountFee = dataset.unitPrice;


            }
            var amount = val * dataset.unitPrice;                         
            var totalPrice = amount - amountFee;
            
            ownerFeeDisplay(val, amountFee, amount, totalPrice)
            
        }else {
            var val = $(".tokenNum").val() * 1;
            if(val.length == 0) val = 0; 

            var inputOtherPrice = $(".input-other-price").val() *1;        
            var totalPrice = val * inputOtherPrice;
            otherFeeDisplay(val, totalPrice);
        }

    });

    $(".input-other-price").keyup(function(){

        var val = $(".tokenNum").val()  * 1;
        if(val.length == 0) val = 0; 

        var otherUnitPrice = $(".input-other-price").val() *1;        
        var totalPrice = val * otherUnitPrice;
        otherFeeDisplay(val, totalPrice);
    })

    $(".symbol").change(async function(){           
     
        let tokenSelect = $(".symbol").find("option:selected").val();
        elementDisplay(tokenSelect);      

        if (tokenSelect === 'BANI' || tokenSelect == 'EGG') {

            var valUnitPrice = $(".symbol").find("option:selected").attr("unitPrice") * 1;
            dataset.unitPrice =  valUnitPrice;
            $(".price-one").html(valUnitPrice.toLocaleString('en-US')+' <spring:message code="common.unit.won.title"/>');              
            // Reset fee, total price              
            var val =$(".tokenNum").val() * 1;
            if(val.length == 0) val = 0; 
            if (val> 0) {
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
            var totalPrice = (val * dataset.unitPrice )- (amountFee * 1);
            ownerFeeDisplay(val, amountFee, amount, totalPrice)
            loadBalanceWeb({walletAddress: $(".walletSelect").find("option:selected").val(), symbol: $(".symbol").find("option:selected").val()});
             $('#balance-trade').css("display","block");
        }else{
            
            var valUnitPrice = $(".symbol").find("option:selected").attr("unitPrice") * 1;
            dataset.unitPrice =  valUnitPrice;
            $(".price-one").html(valUnitPrice.toLocaleString('en-US')+' <spring:message code="common.unit.won.title"/>');              
            // Reset fee, total price              
            var val =$(".tokenNum").val() * 1;
            if(val.length == 0) val = 0;                   
            var totalPrice = ($('.input-other-price').val()*1 ) * val;
            otherFeeDisplay(val, totalPrice);
            $('#balance-trade').css("display","none");
        }     

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

    function btnSellBack(){
            if (history.length > 1 && document.referrer.includes('trade')){                
                history.go(-1);      
                return;
            }
            window.location.href="${_ctx}/trade?targetView=%23sell-order";
    }
    
    function elementDisplay(tokenSelect){    

        if (tokenSelect === 'BANI' || tokenSelect == 'EGG') {       
            $('#walletAddress').css("display","");
            $('#otherWallet').css("display","none");
            $('.radio-trade-type').css("display","none");
            $('.price-one').css("display","");
            $('.other-price-one').css("display","none");
            $('.trade-warning-title-other').css("display","none !important");
            $('.trade-warning-title-owner').css("display","");
        }else{
            $('#walletAddress').css("display","none");
            $('#otherWallet').css("display","");
            $('.radio-trade-type').css("display","");
            $('.price-one').css("display","none");
            $('.other-price-one').css("display","");
            $('.trade-warning-title-other').css("display","");
            $('.trade-warning-title-owner').css("display","none !important");
        }
    }

    function ownerFeeDisplay(tokenNum, amountFee, amount, totalPrice) {

        $(".lb-amount-fee").html(amountFee.toLocaleString());
        $(".lb-amount").html(amount.toLocaleString());
        if (amount > 100000) {
            $(".lb-fee").html('1%');        
        }else{
             $(".lb-fee").html(amountFee.toLocaleString()+'<spring:message code="common.unit.won.title"/>');         
        }
        $(".lb-token-cnt").html(tokenNum.toLocaleString());
        $(".lb-total-price").html(totalPrice.toLocaleString());
    }

    function otherFeeDisplay(tokenNum, totalPrice) {
        $(".lb-amount").html(totalPrice.toLocaleString());
        $(".lb-amount-fee").html(0);
        $(".lb-fee").html(0);
        $(".lb-token-cnt").html(tokenNum.toLocaleString());
        $(".lb-total-price").html(totalPrice.toLocaleString());
    }
</script>
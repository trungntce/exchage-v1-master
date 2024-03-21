<%--
  Created by IntelliJ IDEA.
  User: ntt.dev
  The page sell register
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- head -->
<%@ include file="/WEB-INF/layout/web/head.jsp"%>
<c:set var="roleCode">${wallet.role}</c:set>
<style>
    .form-wrap{
        height: 50px;
        margin-bottom: 20px;
        padding: 0;
        position: unset;
    }
    .form-wrap select{
        position: unset;
    }
    .start-login{
        margin-top: 10px;
    }

    .trade-pop-form{
        margin-top: 10px;
    }
</style>
<!-- Sell form -->
<section class="wrap trade-wrap">
  <!-- header -->
  <%@ include file="/WEB-INF/layout/web/header.jsp"%>
    <div class="sub-title trade-title">
        <h2><spring:message code="sell.register.page.title"/></h2>
        <p><spring:message code="sell.register.page.content"/></p>
    </div>

    <div class="container">
        <form:form modelAttribute="sellRequest" method="post" action="${baseUrl}/sellRequest">
        <div class="trade-pop-form">
            <div class="form-full">
                <spring:message code="common.message.balances.title"/>: <label class="my-balance" wallet-address=""></label> BANI
            </div>
            <div class="form-wrap form-full">
                <form:select path="sellerWalletAddress" cssClass="walletSelect" target="#sellRequest">
                    <c:forEach items="${wallet.wallets}" var="item" varStatus="loop">
                        <form:option value="${item.walletAddress}" fee="${item.fee}">${item.walletAddress}</form:option>
                    </c:forEach>
                </form:select>
            </div>

            <div class="form-wrap form-full">
                <form:select path="symbol" cssClass="symbol">
                    <c:forEach items="${tokens}" var="item" varStatus="loop">
                        <form:option value="${item.symbol}" unitPrice="${item.unitPrice}">${item.symbol}</form:option>
                    </c:forEach>
                </form:select>
            </div>
           
            
            <div class="form-wrap form-full">
                <spring:message code="sell.register.form.tokenNum.hint" var="tokenNumHint"/>
                <form:input path="quantity"  placeholder="${tokenNumHint}" cssClass="tokenNum onlynum" type="text" maxlength="32" target="#sellRequest"/>
            </div>           
            <div class="trade-pop-form-info">
                <dl class="trade-pop-form-info-item">
                    <dt><spring:message code="sell.register.form.price.title"/></dt>
                      <dd class="price-one">
                        <c:forEach items="${tokens}" var="item" varStatus="loop" end="0">
                               <fmt:formatNumber type="number" maxFractionDigits="3" value="${item.unitPrice}"/>원
                            </c:forEach>   
                      </dd>
                    <dd></dd>
                </dl>
                <dl class="trade-pop-form-info-item">
                    <dt><spring:message code="sell.register.form.fee.title"/></dt>
                    <dd><label class="lb-fee">0</label><spring:message code="common.unit.count.title"/></dd>
                    <dd></dd>
                </dl>
                <dl class="trade-pop-form-info-item">
                    <dt><spring:message code="sell.register.form.tokenCnt.title"/></dt>
                    <dd><label class="lb-token-cnt">0</label><spring:message code="common.unit.count.title"/></dd>
                    <dd></dd>
                </dl>
                <dl class="trade-pop-form-info-item">
                    <dt><spring:message code="sell.register.form.amount.title"/></dt>
                    <dd><label class="lb-amount"></label><spring:message code="common.unit.won.title"/> <span>(<spring:message code="sell.detail.fee.title"/> +<label class="lb-amount-fee">0</label><spring:message code="common.unit.won.title"/>)</span></dd>
                    <dd></dd>
                </dl>
                <dl class="trade-pop-form-info-item">
                    <dt><spring:message code="sell.register.form.totalPrice.title"/></dt>
                    <dd class="price-total"><label class="lb-total-price">0</label><spring:message code="common.unit.won.title"/></dd>
                    <dd><font color="red"></font></dd>
                </dl>
                <dl class="trade-pop-form-info-item">
                    <dd><font color="red"><spring:message code="sell.register.form.content.title"/></font></dd>
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
         <form:input type="hidden" path="viewRole" value="API" />
        <form:input type="hidden" path="type" value="ex" />
        </form:form>
    </div>
<!-- * Sell form -->
</div>

<div class="join-terms-wrap modal-otc-1">
    <div class="close" onclick="closeTap(this, true)"></div>
    <h2>이용약관 전체에 동의합니다.</h2>
    <div class="agreement-document">
        1, OTC 판매 등록 및 OTC 판매 거래 이용시 이용자의 은행계좌 정보 공유는 필수 입니다.<br>
        2, 이용자의 개인정보(이름, 계좌은행, 계좌번호)를 공유하지 않으시면 OTC 서비스를 이용하실 수 없습니다.<br>
        3, 해당 정보공유는 거래 이용자 상호간 자산 이동을 위한 안내를 위해 각 거래자를 위해 제공됩니다.
    </div>
</div>

<div class="join-terms-wrap modal-otc-2">
    <div class="close" onclick="closeTap(this, true)"></div>
    <h2>OTC 거래시 개인정보공유 항목</h2>
    <div class="agreement-document">
        1, 코인판매자 : 이름, 계좌정보<br>
        2, 코인구매자 : 이름
    </div>
</div>
<!-- footer -->
    <%@ include file="/WEB-INF/layout/web/footer.jsp"%>
<!-- * footer -->
<script>
    console.log($(".symbol").find("option:selected").attr("unitPrice"));
    var dataset = {
        unitPrice: $(".symbol").find("option:selected").attr("unitPrice"),
        fee:  $(".symbol").find("option:selected").attr("fee")
    }

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
        loadBalance(param);
    }

    $(".btn-submit").click(function(){
        var target = $(this).attr("target");
        var val = $(target).find(".tokenNum").val();
        console.log(target);
        if(val.length > 0 && (val * 1 > 0)){
            if(confirm("<spring:message code="order.agree.confirm.message"/>")){
                submitForm(target)  
                
            } 
        }else{
            alert("<spring:message code="order.token.count.check.message"/>");
        }
    })

    $(".walletSelect").change(async function(){
        var target = $(this).attr("target");
        var valWallet = $(this).find("option:selected").val();
        dataset.fee = $(this).find("option:selected").attr("fee");
        $(target+" .lb-fee").html(dataset.fee);
        $(target).find(".my-balance").attr("wallet-address", valWallet);
        //await loadBalancesInList(valWallet);
        loadBalance({walletAddress: valWallet})
    })

    $(".tokenNum").keyup(function(){
        var target = $(this).attr("target");
        var val = $(this).val() * 1;
        if(val.length == 0) val = 0;

        console.log(val);
        console.log(dataset.fee);
        console.log(dataset.unitPrice);
        var amountFee = val * dataset.fee * dataset.unitPrice;
        var amount = val * dataset.unitPrice;
        var totalPrice = amountFee * 1 + val * dataset.unitPrice;
        $(target+" .lb-amount").html(amount.toLocaleString());
        $(target+" .lb-amount-fee").html(amountFee.toLocaleString());
        $(target+" .lb-token-cnt").html(val.toLocaleString());
        $(target+" .lb-total-price").html(totalPrice.toLocaleString());
    });

    $(".symbol").change(async function(){            
      var valUnitPrice = $(this).find("option:selected").attr("unitPrice") * 1;
      dataset.unitPrice =  valUnitPrice;
      $(".price-one").html(valUnitPrice.toLocaleString('en-US')+'원');              
      // Reset fee, total price        
      var target = $(".tokenNum").attr("target");
      var val =$(".tokenNum").val() * 1;
      if(val.length == 0) val = 0;

      var amountFee = val * dataset.fee * dataset.unitPrice;
      var amount = val * dataset.unitPrice;
      var totalPrice = amountFee * 1 + val * dataset.unitPrice;
      $(target+" .lb-amount").html(amount.toLocaleString());
      $(target+" .lb-amount-fee").html(amountFee.toLocaleString());
      $(target+" .lb-token-cnt").html(val.toLocaleString());
      $(target+" .lb-total-price").html(totalPrice.toLocaleString());
          
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
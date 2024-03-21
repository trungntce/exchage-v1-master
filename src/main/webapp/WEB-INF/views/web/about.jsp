<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- head -->
<%@ include file="/WEB-INF/layout/web/head.jsp"%>
<!-- Main -->
<section class="wrap element-main-top">
<div>
	<form name="popupWalletForm" id="popupWalletForm" method="post" action="${_ctx}/login" target="exchangePopup">
		<input type="text" name="apiKey" id="apiKey" value="04ed810d-c571-4052-92e2-a9a3a0dc1efb">
		<input type="text" name="clientCode" id="clientCode" value="TEST_CODE">
		<input type="text" name="walletAddress" id="walletAddress" value="0x01f1bac212ec31bfd8c00f551da2ba482c35fb50">
		<input type="text" name="password" id="password" value="123456">
		<input type="text" name="tokenSymbol" value="BANI">
		<input type="text" name="tradeType" value="BUY">
		<input type="text" name="buyType" value="2">
		<!-- <label>symbol</label> -->
		<!-- <select name="tokenSymbol" id="tokenSymbol">
			<option value="BANI">BANI</option>
			<option value="EGG">EGG</option>
		</select> -->
		<!-- <label>tradeType</label> -->
		<!-- <select name="tradeType" id="tradeType">
			<option value="BUY">BUY</option>
			<option value="SELL">SELL</option>
		</select> -->
		<button type="button" onclick="javascript:popupExchange();"><font style="vertical-align: inherit;"><font style="vertical-align: inherit;">Kiểm tra mua / bán đăng nhập cửa sổ mới</font></font></button>
	</form>
	<script type="text/javascript">
    $(function(){
    	$(".loginBtn").click(function(){
    		$("#loginFrm").submit();
    	});

    	$(".loginEmptyBtn").click(function(){
    		$("#loginEmptyFrm").submit();
    	});

    	$("#btnApiCheck").click(function(){
    		location.href="/token/site.php";
    	});
    });

    function popupExchange(){
    	var myForm = document.getElementById('popupWalletForm');

    	myForm.onsubmit = function() {
        var w = window.open('about:blank','exchangePopup','menubar=1,status=1,resizable=1,width=450,height=675');
        this.target = 'exchangePopup';
    	};

    	$("#popupWalletForm").submit();
    }
    </script>


</div>
    <!-- header -->
  <%@ include file="/WEB-INF/layout/web/header.jsp"%>
    <div class="container">
        <div class="container-main-top t_center">
            <img src="${_ctx}/resources/skin/dist/blank.png">
        </div>
    </div>
</section>
<!-- * Main -->
 <!-- footer -->
    <%@ include file="/WEB-INF/layout/web/footer.jsp"%>
<!-- * footer -->
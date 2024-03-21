<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="join-terms-wrap modal-wallets" id="modal-wallets" style="top: 50vh">
    <div class="close" id="closeTap-alert" onclick="closeTap(this, true)"></div>
    <h2><spring:message code="wallet.table.wallet.address.title"/></h2>
    <div class="agreement-document">
        <c:forEach items="${wallet.wallets}" var="item" varStatus="loop">
            <!-- <div class="copy-area" data-clipboard-text="${item.walletAddress}" onclick='alert(`<spring:message code="common.copy.toast.title"/>`)'>${item.walletAddress}</div> -->
            <div class="copy-area" id="id-copy-wallet" data-clipboard-text="${item.walletAddress}" onclick='onClickCopy(this, "${item.walletAddress}")'>${item.walletAddress}</div>
        </c:forEach>
    </div>
</div>
<script>
    
    function onClickCopy(obj, walletAddress){   


        new ClipboardJS('[data-clipboard-text]');        
        alert(`<spring:message code="common.copy.toast.title"/>`);        
        closeTap(obj.parentNode, true);    

        // var url = changeSearchParam({walletAddress: walletAddress.toString()})
        //  document.location.href = url;
    }
</script>
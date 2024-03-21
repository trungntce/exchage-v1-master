<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="join-terms-wrap modal-wallets" id="walletSelectModal" style="top: 50vh">
    <div class="close" id="closeTap-alert-select" onclick="closeTap(this, true)"></div>
    <h2><spring:message code="wallet.table.wallet.address.title"/></h2>
    <div class="agreement-document">
        <c:forEach items="${wallet.wallets}" var="item" varStatus="loop">
              <c:choose>
                    <c:when test="${item.walletAddress == wallet_current.walletAddress}">
                       <div class="select-wallet-icon active-wallet-modal" style="margin-top: auto"  data-clipboard-text="${item.walletAddress}" onclick='onClickSelect("${item.walletAddress}")'>
                            <p><i class="bi bi-coin"></i> <span class="top_count_token" id="bani_balance_web">0</span> BANI</a></p>
                            <p><i class="bi bi-coin"></i> <span class="top_count_token" id="egg_balance_web">0</span> EGG</p>    
                            <p>
                            ${item.walletAddress}
                        </div>        
                    </c:when>
                     <c:otherwise>
                        <div class="select-wallet-icon" style="margin-top: auto"  data-clipboard-text="${item.walletAddress}" onclick='onClickSelect("${item.walletAddress}")'>
                        <p><i class="bi bi-coin"></i> <span class="top_count_token" id="bani_balance_web">0</span> BANI</a></p>
                        <p><i class="bi bi-coin"></i> <span class="top_count_token" id="egg_balance_web">0</span> EGG</p>    
                        <p>
                        ${item.walletAddress}
                    </div>        
                    </c:otherwise> 
                </c:choose>
            <br>            
        </c:forEach>
    </div>
</div>
<script>
    
    function onClickSelect(walletAddress){   
        var url = changeSearchParam({walletAddress: walletAddress.toString()})
         document.location.href = url;
    }
    function onClickCopy(obj, walletAddress){   


        new ClipboardJS('[data-clipboard-text]');        
        alert(`<spring:message code="common.copy.toast.title"/>`);        
        // closeTap(obj.parentNode, true);    

        // var url = changeSearchParam({walletAddress: walletAddress.toString()})
        //  document.location.href = url;
    }
</script>
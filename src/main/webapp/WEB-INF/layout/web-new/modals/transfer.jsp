<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="join-terms-wrap modal-transfer" id="modal-transfer" style="top: 50vh">
    <div class="close" id="closeTap-alert" onclick="closeTap(this, true)"></div>
    <div class="agreement-document">
        <spring:message code="common.admin.field.from.wallet.title"/>
        <div class="form-wrap-txt form-wrap-txt2 mt-2 modal-transfer-from" style="background: unset;"></div>
    </div>
    <div class="agreement-document">
        <spring:message code="common.admin.field.to.wallet.title"/>
        <div class="form-wrap-txt form-wrap-txt2 mt-2 modal-transfer-to" style="background: unset;"></div>
    </div>
    <div class="agreement-document">
        <spring:message code="trade.buy.totalAmount.title"/>
        <div class="form-wrap-txt form-wrap-txt2 mt-2 modal-transfer-amount" style="background: unset;"></div>
    </div>
    <input type="hidden" class="modal-transfer-ip-from">
    <input type="hidden" class="modal-transfer-ip-to">
    <input type="hidden" class="modal-transfer-ip-amount">
    <button class="btn btn-primary mt-3 w-100 modal-transfer-btn-transfer" type="button"><spring:message code="common.button.transfer.title"/></button>
</div>
<script>
    $(".modal-transfer-btn-transfer").click(async function(){
        const from = $(".modal-transfer-ip-from").val()
        const to = $(".modal-transfer-ip-to").val()
        const amount = $(".modal-transfer-ip-amount").val()
        var res = await token.transferFee({fromWalletAddress: from, toWalletAddress: to, quantity: amount})
        if($(`[name="txId"]`).length > 0 && res !== undefined) $(`[name="txId"]`).val(res)
        hideModal("#modal-transfer")
    })
</script>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- Modal Transfer -->
<div class="modal fade" id="modal-transfer">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header bg-blue text-white">
        <h5 class="modal-title"><spring:message code="common.button.transfer.title"/></h5>
        <button type="button" class="btn-close text-danger " data-bs-dismiss="modal" aria-hidden="true"></button>
      </div>
      <div class="modal-body">
        <form id="transfer-form" action="${_ctx}/admin/token/transfer" method="POST">
          <table class="table table-bordered table-hover text-nowrap align-middle mb-0 table-sm">
            <tbody>
              <tr>
                <td class="dev-form-title"><label>Token</label></td>
                <td class="dev-form-content form-group text-start">
                  <select class="dev-form-input" id="symbol" name="symbol">
                    <c:forEach items="${tokenList}" var="item" varStatus="loop">
                      <option value="${item.symbol}" data-symbol="${item.symbol}"> ${item.symbol}</option>
                    </c:forEach>
                  </select>
                </td>
              </tr>
              <tr>
                <td class="dev-form-title"><label>From</label></td>
                <td class="dev-form-content form-group text-start">
                  <input name="fromWalletAddress" class="dev-form-input" placeholder="From address" value="${wallet.walletAddress}"/>
                </td>
              </tr>
              <tr>
                <td class="dev-form-title"><label>To</label></td>
                <td class="dev-form-content form-group text-start">
                  <input name="toWalletAddress" class="dev-form-input" placeholder="To address" />
                </td>
              </tr>
              <tr>
                <td class="dev-form-title"><label>Amount</label></td>
                <td class="dev-form-content form-group text-start">
                  <input name="quantity" class="dev-form-input" type="number" placeholder="Token Num" min="1"/>
                </td>
              </tr>
              <tr>
                <td colspan="2">
                <button type="button" class="btn btn-success btn-submit"><spring:message code="common.button.transfer.title"/></button>
                </td>
              </tr>
            </tbody>
          </table>
        </form>
      </div>
    </div>
  </div>
</div>
<!-- * Modal Transfer -->
<script>
  $("#modal-transfer .btn-submit").click(function(){
       var from = $(`#modal-transfer [name="fromWalletAddress"]`).val().trim()
       var to = $(`#modal-transfer [name="toWalletAddress"]`).val().trim()
       var quantity = $(`#modal-transfer [name="quantity"]`).val() * 1
       if(from.length > 0 && to.length > 0 && quantity > 0){
           $("#modal-transfer").modal("hide")
           var strMessage = `<spring:message code="common.admin.message.transfer.confirm.title"/>`;
           if(confirm(strMessage) == true){
               //transfer
               $("#loader").removeClass("loaded");
               $("#transfer-form").submit()
           }else{
               return false;
           }
           $("#loader").addClass("loaded");
       }else{
           alert(`<spring:message code="register.input.mess.please.check.title"/>`)
       }
  })
</script>
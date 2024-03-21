<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<!-- Modal Transfer -->
<div class="modal fade" id="modal-buy-confirm-txid">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header bg-blue text-white">
        <h5 class="modal-title"><spring:message code="common.confirm.transaction.title"/></h5>
        <button type="button" class="btn-close text-danger" data-bs-dismiss="modal" aria-hidden="true"></button>
      </div>
      <div class="modal-body">
        <form id="buy-confirm-txid-form" action="${_ctx}/admin/buy/safe/confirm" method="POST">
          <table class="table table-bordered table-hover text-nowrap align-middle mb-0 table-sm">
            <tbody>
              <tr>
                <td class="dev-form-title"><label><spring:message code="trade.input.txid.title"/></label></td>
                <td class="dev-form-content form-group text-start">
                  <input type="hidden" name="buyId">
                  <input name="txid" class="dev-form-input" placeholder='<spring:message code="trade.input.txid.message"/>'/>
                </td>
              </tr>
              <tr>
                <td colspan="2">
                  <button type="submit" class="btn btn-success" data-bs-dismiss="modal"><spring:message code="common.button.confirm.title"/></button>
                </td>
              </tr>
            </tbody>
          </table>
        </form>
      </div>
    </div>
  </div>
</div>

<div class="modal fade" id="modal-sell-confirm-txid">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header bg-blue text-white">
        <h5 class="modal-title"><spring:message code="common.confirm.transaction.title"/></h5>
        <button type="button" class="btn-close text-danger " data-bs-dismiss="modal" aria-hidden="true"></button>
      </div>
      <div class="modal-body">
        <form id="sell-confirm-txid-form" action="${_ctx}/admin/sell/safe/confirm" method="POST">
          <table class="table table-bordered table-hover text-nowrap align-middle mb-0 table-sm">
            <tbody>
              <tr>
                <td class="dev-form-title"><label><spring:message code="trade.input.txid.title"/></label></td>
                <td class="dev-form-content form-group text-start">
                  <input type="hidden" name="sellId">
                  <input name="txid" class="dev-form-input" placeholder='<spring:message code="trade.input.txid.message"/>'/>
                </td>
              </tr>
              <tr>
                <td colspan="2">
                  <button type="submit" class="btn btn-success" data-bs-dismiss="modal"q><spring:message code="common.button.confirm.title"/></button>
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
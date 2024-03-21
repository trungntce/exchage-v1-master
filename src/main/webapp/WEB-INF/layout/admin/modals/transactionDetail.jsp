<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- Modal Transaction History -->
<div class="modal fade" id="modal-transaction-detail">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header bg-blue text-white">
        <h5 class="modal-title">Transaction Detail</h5>
        <button type="button" class="btn-close text-danger " data-bs-dismiss="modal" aria-hidden="true"></button>
      </div>
      <div class="modal-body">
        <div>
          <table class="table table-bordered table-hover text-nowrap align-middle mb-0 table-sm">
            <tbody>
              <tr>
                <th style="width: 70px">TxID</th>
                <td class="text-start transaction-id"></td>
              </tr>
              <tr>
                <th>From</th>
                <td class="text-start from"></td>
              </tr>
              <tr>
                <th>To</th>
                <td class="text-start to"></td>
              </tr>
              <tr>
                <th>Value</th>
                <td class="text-start value"></td>
              </tr>
              <tr>
                <th>Date</th>
                <td class="text-start time"></td>
              </tr>
            </tbody>
          </table>
        </div>
      </div>
    </div>
  </div>
</div>
<!-- * Modal Transaction History -->
<script>
  $(document).ready(function(){
    $('[hash="transaction-hash"]').click(function(){
      var txId = $(this).html();
      var cnt = $(this).attr("count");
      loadDetail(txId, cnt);
      $("#modal-transaction-detail").modal("show");
    })
  })

  async function loadDetail(txId, cnt){
    var api = "/api/transaction";
    var param = {
        "txId": txId
    }
    var res = await $.when(rest.post(api, rest.type.JSON, param));
    if(res === undefined) return;
    var txData = res.result.transaction;

    $("#modal-transaction-detail").find(".transaction-id").html('N/A');
    $("#modal-transaction-detail").find(".from").html('N/A');
    $("#modal-transaction-detail").find(".to").html('N/A');
    $("#modal-transaction-detail").find(".value").html('N/A');
    $("#modal-transaction-detail").find(".time").html('N/A');

    $("#modal-transaction-detail").find(".transaction-id").html(txData.hash);
    $("#modal-transaction-detail").find(".from").html(txData.from);
    $("#modal-transaction-detail").find(".to").html(txData.to);
    $("#modal-transaction-detail").find(".value").html(cnt.toLocaleString());
    $("#modal-transaction-detail").find(".time").html(new Date(txData.timestamp * 1000).toStringByType("yyyy-MM-dd HH:mm:ss"));
  }
</script>
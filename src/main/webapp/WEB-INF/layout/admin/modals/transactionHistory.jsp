<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<!-- Modal Transaction History -->
<div class="modal fade" id="modal-transaction-history">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header bg-blue text-white">
        <h5 class="modal-title">History for: <b class="wallet-address"></b></h5>
        <button type="button" class="btn-close text-danger " data-bs-dismiss="modal" aria-hidden="true"></button>
      </div>
      <div class="modal-body">

        <ul id="transaction-page" class="pagination" style=" float: right; margin: 12px; ">
          <div class="numPN over right paginate_button page-item pre-page">
            <span class="page-link">&lt;</span>
          </div>
          <div class="numPN over right paginate_button page-item next-page">
            <span class="page-link">&gt;</span>
          </div>
        </ul>

        <div style="min-height: 360px">
          <table id="transaction-history" class="table table-bordered table-hover text-nowrap align-middle mb-0 table-sm">
            <thead>
              <tr>
                <th style="width: 35px;">NO</th>
                <th style="width: 180px;">TxID</th>
                <th style="width: 180px;">From</th>
                <th style="width: 180px;">To</th>
                <th>Value</th>
                <th style="width: 133px;">Time</th>
              </tr>
            </thead>
            <tbody>
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
    $('[hash="wallet-address"]').click(function(){
      var address = $(this).html();
      if(dataset.page.walletAddress != address){
        dataset.page = {
            txId: null,
            limit: 10,
            after: "",
            before: "",
            walletAddress: address,
            currentPage: 0
        }
      }
      $("#modal-transaction-history").find(".wallet-address").html(address);
      loadTransactionHistory(dataset.page.before, "");
      $("#modal-transaction-history").modal("show");
    })
    
    $("#modal-transaction-history").find(".next-page:not(.disabled)").click(function(){
      if(dataset.page.after == null) return;
      dataset.page.currentPage++;
      loadTransactionHistory("", dataset.page.after);
    })
    
    $("#modal-transaction-history").find(".pre-page:not(.disabled)").click(function(){
      if(dataset.page.before == null) return;
      dataset.page.currentPage--;
      loadTransactionHistory(dataset.page.before, "");
    })
  })

  async function loadTransactionHistory(pageBefore, pageAfter){
      dataset.isLoad = true;
      $("#transaction-history tbody").html("")
      // $("#list-transaction").append(itemLoading());

      var api = "/api/transactions";
      var param = {
          "txId": dataset.page.txId,
          "limit": dataset.page.limit,
          "after": pageAfter,
          "walletAddress": dataset.page.walletAddress,
          "before": pageBefore
      }
      var res = await $.when(rest.post(api, rest.type.JSON, param));
      if(res.result == null){
          // if($("#list-transaction .item-group").length == 0) $(".item-no-data").removeAttr("hidden");
          // $(".item-loading").remove();
          return;
      }
      var paging = res.result.transferEvents.paging.cursors;
      if(dataset.page.after == paging.after || paging.after == null){
          dataset.isEnd = true;
          // $(".item-loading").remove();
      }

      dataset.page.after = paging.after;
      if(dataset.page.after == null) $("#modal-transaction-history").find(".next-page").addClass("disabled"); else $("#modal-transaction-history").find(".next-page").removeClass("disabled")
      dataset.page.before = paging.before;
      if(dataset.page.before == null) $("#modal-transaction-history").find(".pre-page").addClass("disabled"); else $("#modal-transaction-history").find(".pre-page").removeClass("disabled")


      var data = res.result.transferEvents.items;
      var address = res.result.address;
      if(data.length > 0){
          $(".item-no-data").attr("hidden", "");
          for(var i = 0; i < data.length; i++){
            var mTime = new Date(data[i]['timestamp'] * 1000);
            var timeId = mTime.toStringByType("yyyyMMdd");
            var timeView = mTime.toStringByType("yyyy-MM-dd");
            var txId = data[i]['txHash'];
            dataset.txData[txId] = data[i];
            $("#transaction-history tbody").append(htmlItemTransaction(i, data[i]));
          }
      }else{
        $("#transaction-history tbody").append(htmlItemNoData());
      }

      dataset.isLoad = false;
      // $(".item-loading").remove();
  }

  function itemLoading(){
      return `<div class="section mt-05 item-loading">
          <div class="section-title">
              <img src="/resources/img/loading.gif" class="imaged w24">
          </div>
      </div>`;
  }

  function htmlItemNoData(){
    return `<tr>
              <td class="text-center" colspan="6"><spring:message code="common.message.noData.title"/></td>
            </tr>`;
  }

  function htmlItemTransaction(index, txData){
    // var type = (address == txData["from"]) ? "<i class='far fa-arrow-alt-circle-up tx-type-icon text-danger'></i>" : "<i class='far fa-arrow-alt-circle-down tx-type-icon text-info'></i>";
    var amount = Web3.utils.fromWei(txData.value, "ether") * 1;
    var i = (dataset.page.currentPage * dataset.page.limit) + index + 1;
    return `<tr>
      <td>`+i+`</td>
      <td><label class="tx-hash">`+txData.txHash+`</label></td>
      <td><label class="tx-hash">`+txData.from+`</label></td>
      <td><label class="tx-hash">`+txData.to+`</label></td>
      <td>`+amount.toLocaleString()+`</td>
      <td>`+new Date(txData.timestamp * 1000).toStringByType("yyyy-MM-dd HH:mm:ss")+`</td>
    </tr>`
  }
</script>
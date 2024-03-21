<%@ page contentType="text/html;charset=UTF-8" language="java"%>

<!-- Modal Transaction History -->
<div class="modal fade" id="modal-transfer">
  <div class="modal-dialog modal-lg">
    <div class="modal-content">
      <div class="modal-header bg-blue text-white">
        <h5 class="modal-title">Transfer</h5>
        <button type="button" class="btn-close text-danger " data-bs-dismiss="modal" aria-hidden="true"></button>
      </div>
      <div class="modal-body">
        <div>

        </div>
      </div>
    </div>
  </div>
</div>
<!-- * Modal Transaction History -->
<script>
  $("#modal-transfer .btn-submit").click(function(){
      var wallet = $("#modal-transfer").find("#to").val();
      var amount = $("#modal-transfer").find("#amount").val();
      transfer("", wallet, amount, "BANI");
  })
</script>
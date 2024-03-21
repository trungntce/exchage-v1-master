<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<div id="header" class="app-header">
    <div class="navbar-header">
        <a href="/admin/index" class="navbar-brand">
            <span class="navbar-logo"></span><b><spring:message code="admin.exchange.title"/></b>
        </a>
        <button type="button" class="navbar-mobile-toggler" data-toggle="app-sidebar-mobile">
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
            <span class="icon-bar"></span>
        </button>
    </div>

    <!-- BEGIN header-nav -->
    <div class="navbar-nav">
        <div class="navbar-item navbar-alarm">
            <div class="btn-group">
                <c:if test="${wallet.role == 'CENTRAL_BANK'}">
                    <a href="${_ctx}/admin/buy/mytrade/list?viewRole=MASTER&state=2" class="btn btn-white position-relative m-w110px">
                        BUY (OP)<span class="position-absolute top-0 start-50 translate-middle badge rounded-pill bg-purple alarm-buyOp">${alarmStatistic.buyOp}</span>
                    </a>
                    <a href="${_ctx}/admin/sell/mytrade/list?viewRole=MASTER&state=2" class="btn btn-white position-relative m-w110px">
                        SELL (OP)<span class="position-absolute top-0 start-50 translate-middle badge rounded-pill bg-orange alarm-sellOp">${alarmStatistic.sellOp}</span>
                    </a>
                </c:if>
                <c:if test="${wallet.role == 'OPERATOR'}">
                    <a href="${_ctx}/admin/buy/mytrade/list?viewRole=MASTER&state=2" class="btn btn-white position-relative m-w110px">
                        BUY (Banker)<span class="position-absolute top-0 start-50 translate-middle badge rounded-pill bg-black alarm-buyBanker">${alarmStatistic.buyBanker}</span>
                    </a>
                    <a href="${_ctx}/admin/sell/mytrade/list?viewRole=MASTER&state=2" class="btn btn-white position-relative m-w110px">
                        SELL (Banker)<span class="position-absolute top-0 start-50 translate-middle badge rounded-pill bg-orange alarm-sellBanker">${alarmStatistic.sellBanker}</span>
                    </a>
                    <a href="${_ctx}/admin/buy/mytrade/list?viewRole=SITE_ADMIN&state=2" class="btn btn-white position-relative m-w110px">
                        BUY (Client)<span class="position-absolute top-0 start-50 translate-middle badge rounded-pill bg-gradient-blue-indigo alarm-buyClient">${alarmStatistic.buyClient}</span>
                    </a>
                    <a href="${_ctx}/admin/sell/mytrade/list?viewRole=SITE_ADMIN&state=2" class="btn btn-white position-relative m-w110px">
                        SELL (Client)<span class="position-absolute top-0 start-50 translate-middle badge rounded-pill bg-green alarm-sellClient">${alarmStatistic.sellClient}</span>
                    </a>
                    <a href="${_ctx}/admin/buy/mytrade/list?viewRole=TRADER&state=2" class="btn btn-white position-relative m-w110px">
                        BUY (Trader)<span class="position-absolute top-0 start-50 translate-middle badge rounded-pill bg-danger alarm-buyTrader">${alarmStatistic.buyTrader}</span>
                    </a>
                    <a href="${_ctx}/admin/sell/mytrade/list?viewRole=TRADER&state=2" class="btn btn-white position-relative m-w110px">
                        SELL (Trader)<span class="position-absolute top-0 start-50 translate-middle badge rounded-pill bg-gradient-gray alarm-sellTrader">${alarmStatistic.sellTrader}</span>
                    </a>
                    <a href="${_ctx}/admin/buy/safe/list" class="btn btn-white position-relative m-w110px">
                        BUY (Safe)<span class="position-absolute top-0 start-50 translate-middle badge rounded-pill bg-danger alarm-buyTrader">${alarmStatistic.buySafe}</span>
                    </a>
                    <a href="${_ctx}/admin/sell/safe/list" class="btn btn-white position-relative m-w110px">
                        SELL (Safe)<span class="position-absolute top-0 start-50 translate-middle badge rounded-pill bg-gradient-gray alarm-sellTrader">${alarmStatistic.sellSafe}</span>
                    </a>
                </c:if>
                <c:if test="${wallet.role == 'CLIENT'}">
                    <a href="${_ctx}/admin/buy/mytrade/list?viewRole=SITE_ADMIN&state=2" class="btn btn-white position-relative m-w110px">
                        BUY (OP)<span class="position-absolute top-0 start-50 translate-middle badge rounded-pill bg-purple alarm-buyOp">${alarmStatistic.buyOp}</span>
                    </a>
                    <a href="${_ctx}/admin/sell/mytrade/list?viewRole=SITE_ADMIN&state=2" class="btn btn-white position-relative m-w110px">
                        SELL (OP)<span class="position-absolute top-0 start-50 translate-middle badge rounded-pill bg-orange alarm-sellOp">${alarmStatistic.sellOp}</span>
                    </a>
                </c:if>
            </div>
        </div>

        <div class="navbar-item navbar-user dropdown">
            <a href="#" class="navbar-link dropdown-toggle d-flex align-items-center" data-bs-toggle="dropdown">
				<span>
                    <c:set var = "length" value = "${fn:length(wallet.walletAddress)}"/>
					<span class="d-none d-md-inline">${wallet.name}[${wallet.walletAddress}](${wallet.role})</span>
					<b class="caret"></b>
				</span>
            </a>
            <div class="dropdown-menu dropdown-menu-end me-1">
                <div class="dropdown-divider d-none"></div>
                <a class="dropdown-item" data-bs-toggle="modal" data-bs-target="#modal-logout"><i class="fa fa-lg fa-fw me-10px fa-sign-out"></i> <spring:message code="button.logout.title"/></a>
            </div>
        </div>
    </div>
</div>

<div class="modal modal-message fade" data-bs-backdrop="static" id="modal-logout" style="z-index: 999999">
    <div class="modal-dialog">
        <div class="modal-content" style="background-color: rgba(0,0,0,.8);margin-top: 250px;">
            <div class="modal-header">
                <h4 class="modal-title"><i class="fa fa-sign-out text-orange-900"></i>
                    <span class="text-white"><spring:message code="button.logout.title"/></span>
                    <span class="text-orange-900"><strong>${wallet.walletAddress}</strong></span>
                    <span class="text-white">?</span>
                </h4>
            </div>
            <div class="modal-footer">
                <a href="javascript:;" class="btn btn-white" data-bs-dismiss="modal"><spring:message code="button.no.title"/></a>
                <a href="${_ctx}/logout" class="btn btn-primary"><spring:message code="button.yes.title"/></a>
            </div>
        </div>
    </div>
</div>
<audio id="sound-1" controls hidden>
    <source src="${_ctx}/resources/dist/audio/sound-1.mp3" type="audio/mpeg">
</audio>
<audio id="sound-2" controls hidden>
    <source src="${_ctx}/resources/dist/audio/sound-2.mp3" type="audio/mpeg">
</audio>
<c:if test="${not empty mess}">
<script>
    alert("${mess}")
</script>
</c:if>
<script>
    $(document).ready(function(){
        window.setInterval('loadAlarmOrder()', 20000);
    })
    
    async function loadAlarmOrder(){
        var data = await analysis.alarmAdmin(null)
        if(data == null) return
        for(var key in data){
            var view = $(`.alarm-`+key)
            if(view.html()*1 < data[key]*1){
                //sound
                notifySoundAdmin(true)
            }
            view.html(data[key])
        }
    }

    async function notifySoundAdmin(isFristAlarm){
        //console.log('sound');
        var audio;
        if(isFristAlarm) audio = document.getElementById('sound-1');
        else audio = document.getElementById('sound-2');

        if(audio == null) return;

        audio.currentTime = 0;
        if(audio.pause && permission.audio){
            audio.play().catch((e)=>{
               permission.audio = false;
            });
            await timer(2000);
        }
        audio.pause();
    }

</script>
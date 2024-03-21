<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!-- loader -->
<div id="loader" class="loaded">
    <img src="${_ctx}/resources/dist/img/loading-icon.png" alt="icon" class="loading-icon">
</div>
<!-- * loader -->

<section class="top-banner">
      <div class="top-banner__inner">
        <div class="top-banner__hera-app-link">
          <div class="img-box"><img src="${_ctx}/resources/skinWeb/images/simbol2.png" alt=""></div>
          <div class="txt-box">
            <b>HERA APP DOWNLOAD</b>
            <p>Secure, fast and elegant.</p>
          </div>
          <button class="top-banner__hera-app-link__download-btn">
            <i class="ci ci-download"></i>
          </button>
        </div>
        <button class="top-banner__close-btn" type="button"><i class="bi bi-x-lg"></i></button>
      </div>
</section>

<header>
	<div class="header__inner">		
		<h1 class="header__logo"><a href="/"><img src="${_ctx}/resources/skinWeb/images/logo.png" alt="Hera Cryptocurrency Market"></a></h1>
		<c:choose>
	<c:when test="${wallet != null}">
	<div class="header-in-member-before mem_before"><!-- 로그인 후 -->	
		<a class="btn btn-light logout-id"><i class="ci ci-logout"></i><spring:message code="header.logout.text"/></a>

		<a href="#" id="alarm-mobile" title='<spring:message code="alarm.page.title"/>'>
			<i class="ci ci-bell"></i><span class="member-menu__badge alarm-cnt">0</span></a>
		<div class="member-menu__pop pop-reminder mobile-pop">
			<div class="member-menu__pop__inner">
				<button class="btn-close"></button>
				<a title='<spring:message code="myroom.setting.title"/>' onclick="javascript:showModal('#alarmSettings', false)" id="link-settings"><i class="ci ci-settings"></i> <spring:message code="myroom.setting.title"/></a>	
								<br><br>
				<div class="pop-reminder__head">
					<p><strong class="alarm-cnt">0</strong><spring:message code="header.in.pop.alarm"/></p>
					<!-- Only User show all remove -->
					<c:if test="${wallet.role == 'USER'}">
						<button onclick="removeAllAlarm()" class="btn btn-ghost btn-sm"><i class="bi bi-trash-fill me-2"></i><spring:message code="header.in.pop.alarm.allremove"/></button>
					</c:if>

				</div>
				<div class="pop-reminder__cont" style="overflow: auto;max-height: 800px;height: auto;">
					<div class="pop-reminder__item">

					</div>
				</div>
			</div>
		</div>
		<div id="alarm-id-user" class="member-menu__pop pop-reminder">
			<div class="member-menu__pop__inner">
				<button class="btn-close"></button>
				<div class="pop-reminder__head">
					<p><strong class="alarm-cnt">0</strong><spring:message code="header.in.pop.alarm"/></p>
					<!-- Only User show all remove -->
					<c:if test="${wallet.role == 'USER'}">
						<button onclick="removeAllAlarm()" class="btn btn-ghost btn-sm"><i class="bi bi-trash-fill me-2"></i><spring:message code="header.in.pop.alarm.allremove"/></button>
					</c:if>

				</div>
				<div class="pop-reminder__cont" style="overflow: auto;max-height: 800px;height: auto;">
					<div class="pop-reminder__item">

					</div>
				</div>
			</div>
		</div>
		
	</div>
	</c:when>
	<c:otherwise>

	<div class="header-in-member-before mem_before"><!-- 로그인 전 -->
		<div class="btn login-btn-mobile"><a href="${baseUrl}/login"><spring:message code="common.button.login.title"/></a></div>
		<div class="btn login-btn-mobile"><a href="${baseUrl}/join/user"><spring:message code="common.button.register.title"/></a></div>
	</div>
	<!-- add div login/register -->
	</c:otherwise>
</c:choose>
		<div class="header__mobile-toggle pc--hide">
			<i class="header__mobile-toggle__bar"></i>
			<i class="header__mobile-toggle__bar"></i>
			<i class="header__mobile-toggle__bar"></i>
		</div>
		<div class="mobile-sidebar header__top">
			<ul class="gnb">
				<li><a href="${baseUrl}/trade?walletAddress=${wallet_current.walletAddress}">P2P Market<span class="gnb__badge">KRW</span></a></li>
				<c:choose>
	              <c:when test="${not empty wallet && wallet.wallets.size() > 0 && (wallet.role == 'USER'
	                                                                                    || wallet.role == 'TRADER'
	                                                                                    || wallet.role == 'CLIENT'
	                                                                                    || wallet.role == 'CLIENT_TRADER')}">

	                <li><a href="${_ctx}/buyRegister?buyerWalletAddress=${wallet_current.walletAddress}&walletAddress=${wallet_current.walletAddress}"><spring:message code="common.button.buy.register.title"/></a></li>

	                <li><a href="${_ctx}/sellRegister?sellerWalletAddress=${wallet_current.walletAddress}&walletAddress=${wallet_current.walletAddress}"><spring:message code="common.button.sell.register.title"/></a></li>
	              </c:when>
	              <c:otherwise>                    
	                <button class="btn btn-dark mb-4 btn-question-login hide" trade-register="#buy-order"><spring:message code="common.button.buy.register.title"/>
	                </button>
	                <button class="btn btn-dark mb-4 btn-question-login hide" trade-register="#sell-order"><spring:message code="common.button.sell.register.title"/>
	                </button>  
	              </c:otherwise>
            	</c:choose>
				<li><a href="${baseUrl}/walletInstall"><spring:message code="navigator.wallet.installation.title"/></a></li>
				<li><a href="${baseUrl}/manual"><spring:message code="navigator.exchange.manual.title"/></a></li>
				<li><a href="${baseUrl}/information"><spring:message code="navigator.exchange.information.title"/></a></li>
				<li><a href="${baseUrl}/faq"><spring:message code="navigator.exchange.faq.title"/></a></li>
				<li><a href="${baseUrl}/about"><spring:message code="navigator.exchange.about.title"/></a></li>		


			</ul>
			<!-- Check Authentication -->
			<c:choose>
		  	<c:when test="${wallet != null}">
			<ul class="member-menu" style="z-index: 60;">
				<div class="member-menu__pop2 pop-myinfo">
					<div class="member-menu__pop__inner">
						<!-- Only User and Trader show all -->
						<c:set var="breakFor" value="false"/>
						<c:forEach items="${wallet.wallets}" var="item" varStatus="loop">

							<c:if test="${breakFor eq false && (item.role == 'USER' || item.role == 'TRADER'
																				|| item.role == 'CLIENT_TRADER') }">
								<c:set var="breakFor" value="true"/>
								<p><strong>${wallet.name} </strong><spring:message code="header.visit.text"/></p>
								<!-- <a href="" redirect="${baseUrl}/myRoom" class="btn btn-light me-2 mt-2"><spring:message code="header.myroom.text"/></a> -->
							</c:if>

						</c:forEach>
						<a onclick="javascript:showModal('#modal-wallets', false)"><i class="bi bi-coin"></i> <span class="top_count_token" id="bani_balance">0</span> BANI</a><br/>
						<a onclick="javascript:showModal('#modal-wallets', false)"><i class="bi bi-coin"></i> <span class="top_count_token" id="egg_balance">0</span> EGG</a>

					</div>
				</div>				
				<ul class="member-menu">				
						
					
					<li>
						<a onclick="javascript:showModal('#walletSelectModal', false)"><p><strong>${wallet.name}</strong> <!-- <spring:message code="header.visit.text"/> --></p></a>
					</li>
					
					<li>
						<a title='<spring:message code="header.mywallet"/>' id="link-wallet"><i class="ci ci-wallet"></i><b><spring:message code="header.mywallet"/></b></a>

					</li>
					<li>
						<a href="" title='<spring:message code="header.myroom.text"/>' redirect="${baseUrl}/myRoom?walletAddress=${wallet_current.walletAddress}" class=""><i class="ci ci-man"></i><b><spring:message code="myroom.myinfo.title"/></b></a>
					</li>

					<li>
						<a href="" id="alarm-web" title='<spring:message code="alarm.page.title"/>'>
							<i class="ci ci-bell"></i><span class="member-menu__badge alarm-cnt">0</span><b><spring:message code="header.in.pop.alarm"/></b></a>
						<div id="alarm-id-trader" class="member-menu__pop pop-reminder">
							<div class="member-menu__pop__inner">
								<button class="btn-close"></button>								
								<a title='<spring:message code="myroom.setting.title"/>' onclick="javascript:showModal('#alarmSettings', false)" id="link-settings"><i class="ci ci-settings"></i> <spring:message code="myroom.setting.title"/></a>	
								<br><br>						

								<div class="pop-reminder__head">
									<p><strong class="alarm-cnt">0</strong><spring:message code="header.in.pop.alarm"/></p>
									<!-- Only User show all remove -->
									<c:if test="${wallet.role == 'USER'}">
										<button onclick="removeAllAlarm()" class="btn btn-ghost btn-sm"><i class="bi bi-trash-fill me-2"></i><spring:message code="header.in.pop.alarm.allremove"/></button>
									</c:if>


								</div>
								<div class="pop-reminder__cont" style="overflow: auto;max-height: 800px;height: auto;">
									<div class="pop-reminder__item">

									</div>
								</div>
							</div>
						</div>
					</li>
					<li>
						<a href="" id="feedback-web" title='<spring:message code="feedback.title.create"/>' onclick="javascript:showModal('#feedbackRequestModal', false)">
							<i class="ci ci-feedback"></i><b><spring:message code="feedback.title.create"/></b>
						</a>							
					</li>

					<li class="mob">
						<a href="#" class="logout-id"><i class="ci ci-logout"></i><b><spring:message code="header.logout.text"/></b><spring:message code="header.logout.text"/></a>
					</li>
				</ul>
				</c:when>
				<c:otherwise>
					<!-- not authentication -->
					<div class="header-in-member-before"><!-- 로그인 전 -->
	                    <div class="btn login-btn"><a href="${baseUrl}/login"><spring:message code="common.button.login.title"/></a></div>
	                    <div class="btn login-btn"><a href="${baseUrl}/join/user"><spring:message code="common.button.register.title"/></a></div>
	                </div>
					<!-- add div login/register -->
				</c:otherwise>
			</c:choose>
			<!-- #Check Authentication -->

			<div class="language-list">
				<div class="language-list__inner">
					<c:choose>

						<c:when test="${_lang eq 'en_US'}">
							<a class="language-list__item language-list__item--en is-current" onclick="changeLanguage('en_US')" href="">
								<img src="${_ctx}/resources/skinWeb/images/lang_en.svg" alt="영어">
								<b><spring:message code="header.language.en"/></b>
							</a>
							<a class="language-list__item language-list__item--ko" onclick="changeLanguage('ko_KR')" href="">
								<img src="${_ctx}/resources/skinWeb/images/lang_ko.svg" alt="한국어">
								<b><spring:message code="header.language.ko"/></b>
							</a>
						</c:when>
						<c:otherwise>
							<a class="language-list__item language-list__item--ko is-current" onclick="changeLanguage('ko_KR')" href="">
								<img src="${_ctx}/resources/skinWeb/images/lang_ko.svg" alt="한국어">
								<b><spring:message code="header.language.ko"/></b>
							</a>	
							<a class="language-list__item language-list__item--en" onclick="changeLanguage('en_US')" href="">
								<img src="${_ctx}/resources/skinWeb/images/lang_en.svg" alt="영어">
								<b><spring:message code="header.language.en"/></b>
							</a>
						</c:otherwise>
					</c:choose>
				</div>
			</div>
		</div>
	</div>
	<form id="loginWallet" method="POST" action="http://101.101.209.212:9006/security/login">
		<input type="text" name="loginId" id="id" hidden>
		<input type="text" name="loginPw" id="pw" hidden>
		<input type="text" name="loginType" id="type" hidden>
		<input type="text" name="langCode" id="langCode" hidden>
	</form>
</header>
    <div class="mask">
    </div>
	<section class="top-notice">
		<p><spring:message code="header.hera.crypto.market"/></p>
	</section>
	<audio id="sound-3" controls hidden>
		<c:if test="${wallet.wallets[0].path != null}">
			<source src="${_ctx}${wallet.wallets[0].path}" type="audio/mpeg">
		</c:if>
		<c:if test="${wallet.wallets[0].path == null}">
			<source src="${_ctx}/resources/dist/audio/sound-3.mp3" type="audio/mpeg">
		</c:if>
	</audio>
	<section class="dim"></section>
<!-- model.addAttribute response mess  -->
<c:if test="${not empty mess}">
    <script>    
        alert('<c:out value="${mess}" />');
    </script>
</c:if>
<!-- #model.addAttribute response mess  -->
<!-- Java script -->
<script type="text/javascript">
	
function removeAllAlarm(){
	if(confirm('<spring:message code='common.deleteyn.title'/>')){
		updateReadYn();
        $(".alarm-cnt").html("0");
        $(".alarm-lst").html("");
        $(".pop-reminder__cont").html("");
	}        
}
	
var firtSeconds = 0;
var finishAudio =  false;
var aud = document.getElementById('sound-3');
aud.onended = function() {
  finishAudio =  true;
};
	const headerJs = {

		// Check focus langCode
		langFocus : function lang_Focus(){
			
			// let langCode = '${_lang}';
			console.log('${_lang}')			
			// if(langCode !== 'ko_KR'){
				$('.language-list__item.is-current').css({"order":"2"});
			// }
		},

		// Get parameter url and show message alert
		getError: function function_name() {
			const urlParams = new URLSearchParams((window.location.search));
     			switch(urlParams.get('error')){
                   case "1":
                       alert("<spring:message code='login.message.fail.wallet.not.exist'/>");
                       break;                  
                   case "2":
                       alert("<spring:message code='login.message.fail.user.not.exist'/>");
                       break;    
                   case "3":
                        alert("<spring:message code='the.user.password.input.not.valid'/>");
                   break;                  
       			}
       		},

		// Copy text
		copyData : function copyData(walletAddress) {
			 navigator.clipboard.writeText(walletAddress);
			 alert(`<spring:message code="common.copy.toast.title"/>`)			 
		},

		// Get repeatSeconds by WalletAddress
		loadRepeatSeconds : function loadRepeatSeconds(repeatSeconds) {
			if(repeatSeconds > 0){				
				return repeatSeconds * 1000;
			}
			return 10000;
		},

		// Get alarmOrder for Tradder
		alarmOrder : async function alarmOrder() {			
			if ($('#alarm-id-trader').css('display') == 'block') {
				return;
			}
            // let countAlarm = 0;
            var resUser = await $.when(rest.get("/alarm", {lastedId: 0, checkYn: "N", delYn: "N"}));
            countAlarm = resUser.length;

            $(".pop-reminder__cont").html("");
            $(".alarm-lst").html("");

			// console.log(${fn:contains( wallet.wallets, 'TRADER' )})
			// Only role Trader	
			if (${fn:contains(wallet.wallets, 'TRADER' )} == true 
				|| ${fn:contains(wallet.wallets, 'CLIENT_TRADER' )} == true){

			    var res = await $.when(rest.get("/alarm/order", {}));
			    if(res.length > 0) countAlarm += res[0];

			    for(var i = 0; i < res.length; i++){
			    	headerJs.itemAlarmOrder(res[i]);
			    }
			    var lastAlarm = res[0];
	            var mil = new Date() - new Date(lastAlarm.regDate);
	            var isFristAlarm = false;
	            if(mil < 300000) isFristAlarm = true;	         
	          
				// count_alarm = countAlarm;
        	}

            $(".alarm-cnt").html(countAlarm);
            $(".alarm-cnt").html((countAlarm > 99) ? "99+" : countAlarm) ;
	
            for(var i = 0; i < resUser.length; i++){

            	var newAlarmDate = new Date(resUser[i].regDate);
				newAlarmDate.setMinutes(newAlarmDate.getMinutes()+1);
				console.log(newAlarmDate.getMinutes())
				var dateTimeNow = new Date();

            	if (newAlarmDate.getTime() > new Date().getTime()) {	

					// newAlarmDate.setSeconds(newAlarmDate.getSeconds()+60)
					
					dateTimeNow.setSeconds(dateTimeNow.getSeconds()+60)
					var seconds_run = dateTimeNow.getSeconds() - newAlarmDate.getSeconds();	

						$(".pop-reminder__cont").append(`
			                <div class="pop-reminder__item">
			                    <i class="bi bi-envelope"></i>
			                    <a href=${_ctx}/alarm/updateById?walletAlarmId=`+resUser[i].walletAlarmId+`&contents=`+resUser[i].contents+`>`+resUser[i].title +`</p>
			                    <small class="ageSeconds"></small>
			                    </a>
			                </div>`);
						
							setInterval(() => {
							 seconds_run = seconds_run + 1;
							  $('.ageSeconds').html('');
							  $('.ageSeconds').append(seconds_run +` <spring:message code="date.age.second.title"/>` +` <spring:message code="date.age.ago.title"/>` );
								// if (seconds_run >= 60) {
								// 	return;
								// }

							}, 1000);			
						

				}else{
					const age = new Date(resUser[i].regDate).age({
					year: `<spring:message code="date.age.year.title"/>`,
					day: `<spring:message code="date.age.day.title"/>`,
					hour: `<spring:message code="date.age.hour.title"/>`,
					minute: `<spring:message code="date.age.minute.title"/>`,
					second: `<spring:message code="date.age.second.title"/>`,
					ago: `<spring:message code="date.age.ago.title"/>`
					})

	                $(".pop-reminder__cont").append(`
	                <div class="pop-reminder__item">
	                    <i class="bi bi-envelope"></i>
	                    <a href=${_ctx}/alarm/updateById?walletAlarmId=`+resUser[i].walletAlarmId+`&contents=`+resUser[i].contents+`>`+resUser[i].title +`</p>
	                    <small>`+ age +`</small>
	                    </a>
	                </div>`);
				}
 	
				
            }
			if(${wallet_current.useYn != null && wallet_current.useYn == 'Y'})
	          { 								
				notifySound(isFristAlarm);         	
	          } 
		},

		// Generate item alarmOrder
		itemAlarmOrder : function itemAlarmOrder(mData) {
			
			let reqDate;
			for(var i = 0; i < mData.length; i++){	
				var path, title, content;
				if(mData[i].sellId == null){
					path = "/tradeBuyDetail?buyId="+mData[i].buyId;
					title = `<spring:message code="buy.table.buy.id"/>  [`+ mData[i].buyId +`]`;
					content = mData[i].symbol;
					reqDate = mData[i].buyRegDate;
				}else{
					path = "/tradeSellDetail?sellId="+mData[i].sellId;
					title = `<spring:message code="sell.table.sell.id"/> [`+mData[i].sellId+`]`;
					content = mData[i].symbol;
					reqDate = mData[i].sellRegDate;
				}				

				var newAlarmDate = new Date(reqDate);
				newAlarmDate.setMinutes(newAlarmDate.getMinutes()+1);
				console.log(newAlarmDate.getMinutes())
				var dateTimeNow = new Date();
				if (newAlarmDate.getTime() > new Date().getTime()) {	

					// newAlarmDate.setSeconds(newAlarmDate.getSeconds()+60)
					
					dateTimeNow.setSeconds(dateTimeNow.getSeconds()+60)
					var seconds_run = dateTimeNow.getSeconds() - newAlarmDate.getSeconds();
					// seconds_run = seconds_run*1;
					console.log('---------------------------');
					console.log(seconds_run);	
					
						$(".pop-reminder__cont").append(`
							<div class="pop-reminder__item">										
								<i class="bi bi-envelope"></i>					
								<a href="`+path+`"><spring:message code="alarm.order.title.new.coin.sale.has.been.registered"/>
								<p><spring:message code="alarm.order.check.right.now"/> `+title+ content +`</p>
								<small class="ageSeconds"> <spring:message code="date.age.second.title"/>` +` <spring:message code="date.age.ago.title"/>` +` </small>
								</a>
							</div>`);
						
							setInterval(() => {
							 seconds_run = seconds_run + 1;
							  $('.ageSeconds').html('');
							  $('.ageSeconds').append(seconds_run +` <spring:message code="date.age.second.title"/>` +` <spring:message code="date.age.ago.title"/>` );
								// if (seconds_run >= 60) {
								// 	return;
								// }

							}, 1000);
						
						
					

				}else{			

					const age = new Date(reqDate).age({
						year: `<spring:message code="date.age.year.title"/>`,
						day: `<spring:message code="date.age.day.title"/>`,
						hour: `<spring:message code="date.age.hour.title"/>`,
						minute: `<spring:message code="date.age.minute.title"/>`,
						second: `<spring:message code="date.age.second.title"/>`,
						ago: `<spring:message code="date.age.ago.title"/>`
					})
					$(".pop-reminder__cont").append(`
						<div class="pop-reminder__item">										
							<i class="bi bi-envelope"></i>					
							<a href="`+path+`"><spring:message code="alarm.order.title.new.coin.sale.has.been.registered"/>
							<p><spring:message code="alarm.order.check.right.now"/> `+title+ content +`</p>
							<small>`+ age +` </small>
							</a>
						</div>`);
					}	
					return;
				}			

		},

		// Load loadAlarmUser for user
		loadAlarmUser : async function loadAlarmUser(mParams, type){

			// Only role User
			if (${fn:contains(wallet.wallets, 'USER' )} == true){
				
			    let api = "/alarm";
			    let alarmTotal = 0;
			    let param = (mParams == null) ? {lastedId: 0, checkYn: "N", delYn: "N"} : mParams;
			    
			    var res = await $.when(rest.get(api, param));
			    // console.log(res);
			    if(res.length == 0 && $(".alarm-cnt").html() == "0") {
			    	$(".alarm-cnt").html("0");
			    	return;
			    };
			    $(".pop-reminder__cont").html("");
			    $(".alarm-lst").html("");
		    	$(".alarm-cnt").html((res.length > 99) ? "99+" : res.length) ;

			    for(var i = 0; i < res.length; i++){

				const age = new Date(res[i].regDate).age({
					year: `<spring:message code="date.age.year.title"/>`,
					day: `<spring:message code="date.age.day.title"/>`,
					hour: `<spring:message code="date.age.hour.title"/>`,
					minute: `<spring:message code="date.age.minute.title"/>`,
					second: `<spring:message code="date.age.second.title"/>`,
					ago: `<spring:message code="date.age.ago.title"/>`
				})
			    	$(".pop-reminder__cont").append(`
					<div class="pop-reminder__item">
						<i class="bi bi-envelope"></i>
						<a href=${_ctx}/alarm/updateById?walletAlarmId=`+res[i].walletAlarmId+`&contents=`+res[i].contents+`>`+res[i].title +`</p>
						 <small>`+ age +`</small>
						</a>
					</div>`);
			    }
			    var lastAlarm = res[0];
			    if(lastAlarm == null) return
	            var mil = new Date() - new Date(lastAlarm.regDate);
	            var isFristAlarm = false;
	            if(mil < 300000) isFristAlarm = true;
				
	             if(${wallet_current.useYn != null && wallet_current.useYn == 'Y'})
	          	{ 
	            	notifySound(isFristAlarm);
	        	}
		  	}
	  },  
	  loadBalanceHeader : async function loadBalanceHeader() {
  		const queryString = window.location.search;
		const urlParams = new URLSearchParams(queryString);
		var api = "/balance";
	  	if (urlParams.get('walletAddress') == null) {		  	
		  	var paramBani = {walletAddress: '${wallet.wallets[0].walletAddress}', symbol: 'BANI'};
		  	var paramEGG = {walletAddress: '${wallet.wallets[0].walletAddress}', symbol: 'EGG'};
	  	}else{
			var paramBani = {walletAddress:  urlParams.get('walletAddress'), symbol: 'BANI'};
			var paramEGG = {walletAddress:  urlParams.get('walletAddress'), symbol: 'EGG'};
	  	}
	  	var resBani = await $.when(rest.get(api, paramBani));
	  	$('#bani_balance').html((resBani*1).toLocaleString());
	  	$('#bani_balance_web').html((resBani*1).toLocaleString());

	  	
	  	var resEGG = await $.when(rest.get(api, paramEGG));
	  	$('#egg_balance').html((resEGG*1).toLocaleString());
	  	$('#egg_balance_web').html((resEGG*1).toLocaleString());
	  	
	  },
	  loadDataAlarmView : async function loadDataAlarmView(mData){
			$(".alarm-normal .alarm-lst").html("");
			var alarmTotal = 0;
			mData.forEach(function (element) {
				var cssClass = "";
				if(element.checkYn == 'N')
				{
					cssClass = 'li-content-read"';
					alarmTotal++;
				}
				$(".alarm-normal .alarm-lst").append(itemAlarmOrder(element, cssClass));
			});

				$(".alarm-normal .alarm-cnt").html(alarmTotal);
			}	 

	}	

	var seconds = 5;
	var step_play_sound = 0;
	var countAlarmFirst = 0;
	var countAlarm = 0;
	var firstLoad = true
	var firtIos = 0;
	$(document).ready(function (){	
		
		// Call Function
		headerJs.langFocus();
		headerJs.getError();
  		headerJs.loadBalanceHeader();		
		// console(getParams('walletAddress',${wallet.wallets[0].walletAddress}));
		const queryString = window.location.search;
		const urlParams = new URLSearchParams(queryString);
		 var walletCurrent = "";

		 // if (${wallet_current != null} && ${wallet_current.useYn != null && wallet_current.useYn == 'Y'}) {	
		 var isSafari = /^((?!chrome|android).)*safari/i.test(navigator.userAgent);
		 	if (${wallet_current != null}) {	
				seconds = '${wallet_current.repeatSeconds}';
				if(!isSafari){
					headerJs.alarmOrder();	 
					window.setInterval('headerJs.alarmOrder()', headerJs.loadRepeatSeconds(5));
				}
				
			
		    // Auto load balance for user exchage header
			window.setInterval('headerJs.loadBalanceHeader()', 5000);
			//window.setInterval('loadSoundAlarm()', 1000);
		 }



		// Check device
        var broswerInfo = navigator.userAgent;
        if(broswerInfo.indexOf("Apollo")>-1){
            if(${login.username != null}){
                $.cookie('appData', '${android}', { expires: 7 });
                //$.cookie('appData_2', '${android_2}', { expires: 7 });
                window.Apollo.loginSuccess();
            }
        }
    })
    
    $('.btn-close').click(function(){
		event.stopPropagation();
		$('.member-menu__pop').css("display", "none");
	});
    
	$('.pop-reminder').click(
		function(){	
			$('.member-menu li').stop().removeClass('is-active');					
		} );

 	$('li').click(function(){
 		event.stopPropagation(); 		
 		$(this).find('.member-menu__pop').css("display", "block");
 	});

	$('li').hover(
		function(){	
			$(this).find(".member-menu__pop").css("display", "block");
		} ,
		function(){				
			$(this).find(".member-menu__pop").css("display", "none");
	});
	$('body').click(function(){
		$(this).find(".member-menu__pop").css("display", "none");
	});

	$('#alarm-mobile').click(function(){
		event.preventDefault();
		event.stopPropagation(); 		
 		$('.mobile-pop').css("display", "block");
 		$('.mobile-pop').css("top", "auto");
 		// $(this).find(".member-menu__pop").css("display", "block");
	});

	$('#link-wallet').click(function(){
		if(confirm('<spring:message code='go.common.siteWallet.msg'/>')){			
			$('#id').val('${login.username}');
			$('#pw').val('${login.password}');
			$('#type').val('${loginType}');
			$('#langCode').val('${_lang}');
			
			$('#loginWallet').submit();
		}
	});
    $('.logout-id').click(function(){
        if(confirm('<spring:message code='go.common.logout.msg'/>')){
			// Check device
			var broswerInfo = navigator.userAgent;
			if(broswerInfo.indexOf("Apollo")>-1){
				if(${login.username != null}){
					$.cookie('appData',  null);
					window.Apollo.logout();
				}
			}
			window.location.href = "${baseUrl}/logout";
		}
    });  

	

	
  window.addEventListener('touchstart', () => {	    
	  var isSafari = /^((?!chrome|android).)*safari/i.test(navigator.userAgent);
	  if(isSafari && firtIos == 0 && ${wallet_current.useYn == 'Y'}){		
		let au = document.getElementById('sound-3');		
		au.muted = true;
		au.volume = 0.0;	
		au.play();		
		//au.volume = 1.0;	
		//au.muted = false;
		headerJs.alarmOrder();
		window.setInterval('headerJs.alarmOrder()', headerJs.loadRepeatSeconds(5));
		firtIos = 1;		
	  }
  })


</script>

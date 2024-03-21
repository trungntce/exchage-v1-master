<%--
  Created by IntelliJ IDEA.
  User: ntt.dev
  The template header common.
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>

<style>
	.navi-alarm{
		position: absolute;
		z-index: 2;
		top: 13px;
		right: 40px;
		display: none;
	}

	.header-in-pop-content.alarm-lst{
		max-height: 300px;
		overflow-y: scroll;
	}

	.header-in-pop.alarm-content-pop .close{
		top: 6px;
	}

	@media screen and (max-width: 768px){
		.navi-alarm{
			display: block;
			width: 170px;
		}

		body:not(.banner-app-view) .navi-alarm .header-in-pop.alarm-content-pop{
			position: fixed;
			top: 60px;
		}

		body.banner-app-view .navi-alarm .header-in-pop.alarm-content-pop{
			position: fixed;
			top: 120px;
		}
	}
</style>
	
	<div class="banner-app-down-wrap">
		<div class="banner-app-down-logo logo"></div>
		<div class="banner-app-down-txt">
			<p>HERA APP DOWN</p>
			<span>Secure, fast and elegant.</span>
		</div>
		<div class="banner-app-down-down"></div>
		<div class="close"></div>
	</div>

    <!-- Header -->
    <header class="header" id="site-header">
    	<h2 class="header-logo logo" onclick="location.href='${baseUrl}/index'">Hera Cryptocurrency Market</h2>

		<div class="navi-alarm header-in-member">

            <div class="language">
				<div class="dropdown">
				  <button class="dropbtn"><spring:message code="header.language"/></button>
				  <div class="dropdown-content">
					  <div class="lang-item" value="ko_KR">
					  	<img src="${_ctx}/resources/colorAdmin/plugins/flag-icon-css/flags/4x3/kr.svg" width="20px" style="margin-right: 4px;">
					  	<label><spring:message code="header.language.ko"/></label>
					  </div>
					  <div class="lang-item" value="en_US">
					  	<img src="${_ctx}/resources/colorAdmin/plugins/flag-icon-css/flags/4x3/lr.svg" width="20px" style="margin-right: 4px;">
					  	<label><spring:message code="header.language.en"/></label>
					  </div>
				  </div>
				</div>
            </div>
            <script>            	
            	$(".language").click(function(){
            		var display = $(this).find(".dropdown-content").css("display");
            		if(display != "block"){
            			$(this).find(".dropdown-content").css({display: "block"})
            		}else{

            			$(this).find(".dropdown-content").css({display: "none"})
            		}

            	})
            </script>
    	<c:if test="${null != wallet}">
	        <!-- ALARM IS USER -->
	        <c:if test="${wallet.role != 'TRADER'}">
				<div class=" header-in-member-after">
					<div class="header-in-icon header-in-reminder alarm-normal">
						<span class="header-in-reminder-item alarm-cnt">0</span>
						<div class="header-in-pop alarm-content-pop">
							<div class="close" onclick="hideParent(this)"></div>
							<div class="header-in-pop-backgroud"></div>
							<div class="header-in-pop-title header-in-pop-alarm">
								<p><strong class="alarm-cnt">0</strong><spring:message code="header.in.pop.alarm"/> <span class="read-all-alarm-btn"><spring:message code="header.in.pop.alarm.allremove"/></span></p>
							</div>
							<div class="header-in-pop-content header-in-pop-content-alarm alarm-lst">

							</div>
						</div>
					</div>
				</div>
				</div>
			</c:if>
			<!-- * ALARM IS USER -->

        	<!-- ALARM IS TRADER -->
    		<c:if test="${wallet.role == 'TRADER'}">
				<div class=" header-in-member-after">
					<div class="header-in-icon header-in-reminder alarm-order">
						<span class="header-in-reminder-item alarm-cnt">0</span>
						<div class="header-in-pop alarm-content-pop">
							<div class="close" onclick="hideParent(this)"></div>
							<div class="header-in-pop-backgroud"></div>
							<div class="header-in-pop-title header-in-pop-alarm">
								<p><strong class="alarm-cnt"></strong><spring:message code="header.in.pop.alarm"/></p>
							</div>
							<div class="header-in-pop-content header-in-pop-content-alarm alarm-lst">

							</div>
						</div>
					</div>
				</div>
			</c:if>
	        <!-- * ALARM IS TRADER -->

		</c:if>
		</div>


		<div class="navi-open"></div>

		<div class="hader-container">

			<div class="close"></div>

            <div class="header-in-member header-desktop">
                <div class="header-in-member-after"> <!-- 로그인 후 -->
                    <c:if test="${wallet != null}">
                        <!-- begin -->
                        <div class="header-in-icon header-in-wallet"><spring:message code="header.mywallet"/>
                            <div class="header-in-pop">
                                <div class="close"></div>
                                <div class="box-selector wallet-box-selector">
                                	<c:set var="countWallets" value="0" />
                                    <c:forEach items="${wallet.wallets}" var="item" varStatus="loop">
                                        <input type="radio" id="login-selector${loop.index}" class="dev-wallet-item-select" wallet-address="${item.walletAddress}" name="login-selector">
                                        <label for="login-selector${loop.index}">${item.walletAddress} </label>
                                    </c:forEach>                                   
                                </div>

                                <div class="header-in-pop-content">
                                    <div class="header-in-pop-content-btn">
                                        <span><spring:message code="header.wallet.copy.description"/></span>
                                        <div class="btn btn-primary" data-clipboard-text="" for=".dev-wallet-item-select" onclick='alert(`<spring:message code="common.copy.toast.title"/>`)'><spring:message code="header.wallet.copy.text"/></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <div class="header-in-icon header-in-user">
                            <div class="header-in-pop">
                                <div class="header-in-pop-title">
                                    <p><strong>${wallet.name} </strong><spring:message code="header.visit.text"/></p>
                                </div>
                                <div class="header-in-pop-content">
                                    <div class="header-in-pop-content-item" redirect="${baseUrl}/myRoom">
                                        <p><spring:message code="header.myroom.text"/></p>
                                    </div>
                                    <div class="header-in-pop-content-item logout-btn" redirect="${baseUrl}/logout">
                                        <p><spring:message code="header.logout.text"/></p>
                                    </div>
                                </div>
                            </div>
                        </div>
						<script>
                        	var timeRepeat = ${wallet.wallets[0].repeatSeconds} * 1000;
                        </script>
                       
                        <!-- ALARM IS USER -->

                        <c:if test="${wallet.role != 'TRADER' && wallet.role != 'TRADER'}">
	                        <div class="header-in-icon header-in-reminder alarm-order">	                        	
	                            <span class="header-in-reminder-item alarm-cnt">0</span>
	                            <div class="header-in-pop alarm-content-pop">

									<div class="close" onclick="hideParent(this)"></div>
	                                <div class="header-in-pop-backgroud"></div>
	                                <div class="header-in-pop-title header-in-pop-alarm">
	                                    <p><strong class="alarm-cnt">0</strong><spring:message code="header.in.pop.alarm"/></p>
	                                </div>
	                                <div class="header-in-pop-content header-in-pop-content-alarm alarm-lst">

	                                </div>
	                            </div>
	                        </div>
	                        <script>

	                        	$(document).ready(function (){
									alarmOrder();
	                                window.setInterval('alarmUser()', timeRepeat);	                              
	                            })

								async function alarmUser(){
								    /*var api = "/alarm";
								    var param = {};
								    var res = await $.when(rest.get(api, param));

								    if(res.length == 0 && $(".alarm-order .alarm-cnt").html() == "0") {
								    	$(".alarm-order .alarm-cnt").html("0");
								    	return;
								    };
								    $(".alarm-order .alarm-lst").html("");
							    	$(".alarm-order .alarm-cnt").html((res[0] > 99) ? "99+" : res[0]) ;
						    		
								    for(var i = 0; i < res.length; i++){	

								    	itemAlarmOrder(res[i]);
								    }
								    var lastAlarm = res[0];								    
						            var mil = new Date() - new Date(lastAlarm.regDate);
						            var isFristAlarm = false;
						            if(mil < 300000) isFristAlarm = true;
						            notifySound(isFristAlarm);*/
								}
	                        </script>
                    	</c:if>
                       
                        <!-- end -->
                        <!-- * ALARM IS USER -->

                        <!-- ALARM IS TRADER -->
                        <c:if test="${wallet.role == 'TRADER'}">
	                        <div class="header-in-icon header-in-reminder alarm-order">	                        	
	                            <span class="header-in-reminder-item alarm-cnt">0</span>
	                            <div class="header-in-pop alarm-content-pop">

									<div class="close" onclick="hideParent(this)"></div>
	                                <div class="header-in-pop-backgroud"></div>
	                                <div class="header-in-pop-title header-in-pop-alarm">
	                                    <p><strong class="alarm-cnt">0</strong><spring:message code="header.in.pop.alarm"/></p>
	                                </div>
	                                <div class="header-in-pop-content header-in-pop-content-alarm alarm-lst">

	                                </div>
	                            </div>
	                        </div>
	                        <script>

	                        	$(document).ready(function (){
									alarmOrder();
	                                window.setInterval('alarmOrder()', timeRepeat);
	                            })

								async function alarmOrder(){
								    var api = "/alarm/order";
								    var param = {};
								    var res = await $.when(rest.get(api, param));
								    //console.log(res[0]);
								    if(res.length == 0 && $(".alarm-order .alarm-cnt").html() == "0") {
								    	$(".alarm-order .alarm-cnt").html("0");
								    	return;
								    };
								    $(".alarm-order .alarm-lst").html("");
							    	$(".alarm-order .alarm-cnt").html((res[0] > 99) ? "99+" : res[0]) ;
						    		
								    for(var i = 0; i < res.length; i++){	

								    	itemAlarmOrder(res[i]);
								    }
								    var lastAlarm = res[0];								    
						            var mil = new Date() - new Date(lastAlarm.regDate);
						            var isFristAlarm = false;
						            if(mil < 300000) isFristAlarm = true;
						            notifySound(isFristAlarm);
								}
	                        </script>
                        </c:if>
                        <!-- * ALARM IS TRADER -->
                    </c:if>

                    <c:if test="${wallet == null}">
                        <div class="header-in-member-before"><!-- 로그인 전 -->
                            <div class="btn login-btn"><a href="${baseUrl}/login"><spring:message code="common.button.login.title"/></a></div>
                            <div class="btn btn-primary register-user-btn"><a href="${baseUrl}/registerUser"><spring:message code="common.button.register.title"/></a></div>
                        </div>
                    </c:if>
	                <div class="language">
						<div class="dropdown">
						  <button class="dropbtn"><spring:message code="header.language"/></button>
						  <div class="dropdown-content">
							  <div class="lang-item" value="ko_KR">
							  	<img src="${_ctx}/resources/colorAdmin/plugins/flag-icon-css/flags/4x3/kr.svg" width="20px" style="margin-right: 4px;">
							  	<label><spring:message code="header.language.ko"/></label>
							  </div>
							  <div class="lang-item" value="en_US">
							  	<img src="${_ctx}/resources/colorAdmin/plugins/flag-icon-css/flags/4x3/lr.svg" width="20px" style="margin-right: 4px;">
							  	<label><spring:message code="header.language.en"/></label>
							  </div>
						  </div>
						</div>
		            </div>
                </div>
            </div>

            <nav class="navi-wrap">
                <a class="navi-item p2p-market-btn" href="${baseUrl}/trade">
                    P2P Market
                    <div class="navi-item-hot">KRW</div>
                </a>
                <a class="navi-item" href="${baseUrl}/walletInstall"><spring:message code="navigator.wallet.installation.title"/></a>
                <a class="navi-item" href="${baseUrl}/manual"><spring:message code="navigator.exchange.manual.title"/></a>
                <a class="navi-item" href="${baseUrl}/information"><spring:message code="navigator.exchange.information.title"/></a>
                <a class="navi-item" href="${baseUrl}/faq"><spring:message code="navigator.exchange.faq.title"/></a>
                <a class="navi-item" href="${baseUrl}/about"><spring:message code="navigator.exchange.about.title"/></a>
            </nav>

		</div>

		<audio id="sound-1" controls hidden>
		    <source src="${_ctx}/resources/dist/audio/sound-1.mp3" type="audio/mpeg">
		</audio>
		<audio id="sound-2" controls hidden>
		    <source src="${_ctx}/resources/dist/audio/sound-2.mp3" type="audio/mpeg">
		</audio>
		<script>
			$(document).ready(function (){
				var bannerApp = (store.get("showBanner") == null) ? true : false;

				if(!bannerApp){
					$(".banner-app-view").removeClass("banner-app-view");
					$(".banner-app-down-wrap").hide();
				}

				var tmpWallet = [];
				// $(".my-balance[wallet-address]").each(function(i){
				// 	var itemWallet = $(this).attr("wallet-address");
				// 	if(tmpWallet.indexOf(itemWallet) == -1) loadBalance({walletAddress: itemWallet})
				// })

			})

			function hideParent(obj){
				obj.parentNode.display = "none";
			}

			$(".header-in-icon").click(function(){
				var display = $(this).find(".header-in-pop").css("display");
				
				if(display == "block"){
					$(this).find(".header-in-pop").css({"display": "none"})
				}else{
					$(this).find(".header-in-pop").css({"display": "block"})
				}
			})

			$(".dev-wallet-item-select").change(function(){
				var add = $(this).attr("wallet-address");
				$(".header-in-pop-content").find(`[for=".dev-wallet-item-select"]`).attr("data-clipboard-text", add);
			})

			$(".banner-app-down-wrap").find(".close").click(function(){
				$(".banner-app-down-wrap").hide();
				store.set("showBanner", 0);
				$(".banner-app-view").removeClass("banner-app-view");
			})

			$(".alarm-normal .read-all-alarm-btn").click(function(){
				updateReadYn();
				loadAlarmTotal(null, "user");
				$(".alarm-normal .alarm-cnt").html("0");
				$(".alarm-normal .alarm-lst").html("");
			});
			$(".navi-open").click(function(){
				$(".hader-container").show();
			})

			$(".hader-container").find(".close").click(function(){
				$(".hader-container").hide();
			})

			$(".lang-item").click(function(){
				var lang = $(this).attr("value");
				var url = changeSearchParam({langCode: lang})
        		document.location.href = url;
			})

			var count = 1;
			function hideShowInfor(){
				document.getElementById('aboutInfor').classList.toggle("show");
			}

			function loadDataAlarm(){
				document.getElementById('dropdownAlarm').classList.toggle("show");
			}


            function loadDataAlarmView(mData){
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

			function itemAlarmNormal(mData, cssClass){

				return `<div class="header-in-pop-content-item reminder `+cssClass+`" onclick="readAlarmUser(`+mData.walletAlarmId+`,'`+mData.title+`','`+mData.contents+`')">
							<p>`+mData.title+`</p>
							<span>`+mData.contents+`</span>
							<i>`+ new Date(mData.regDate).age() +` 시간 전</i>
						</div>`;
			}

			function itemAlarmOrder(mData){
				// console.log(mData);			
				let reqDate;
				for(var i = 0; i < mData.length; i++){	
					var path, title, content;
					if(mData[i].sellId == null){
						path = "/tradeBuyDetail?buyId="+mData[i].buyId;
						title = `BUY ID [`+ mData[i].buyId +`]`;
						content = mData[i].symbol;
						reqDate = mData[i].buyRegDate;
					}else{
						path = "/tradeSellDetail?sellId="+mData[i].sellId;
						title = `SELL ID [`+mData[i].sellId+`]`;
						content = mData[i].symbol;
						reqDate = mData[i].sellRegDate;
					}
					$(".alarm-order .alarm-lst").append(`<a href="`+path+`"><div class="header-in-pop-content-item reminder">
							<p>`+title+`</p>
							<span>`+content+`</span>
							<i>`+ new Date(reqDate).age() +` 시간 전</i>
						</div></a>`);
					}	
					return;
				}

			async function readAlarmUser(id, title, content){
				var api = "/alarm/update";
				var param = {'walletAlarmId': id};
				var res = await $.when(rest.post(api, rest.type.JSON, param));

				loadAlarmTotal(null, 'user');

				$("#titleAlarm").html(title);
				$("#contentAlarm").html(content);
			}

		</script>
    </header>
    <div class="mask"></div>
	<div class="notice-main">
		<img src="${baseUrl}/resources/skin/dist/ic_fav2.png" class="notice-img"><p><spring:message code="exchange.use.warning.statement.1"/></p>
	</div>

	<div class="join-terms-wrap modal-term-1">
		<div class="close" onclick="closeTap(this, true)"></div>
		<h2>거래소 이용약관</h2>
		<div class="agreement-document">
			<b>제1조(목적)</b>
			<br><br>
			1. 이 약관은 회사가 온라인으로 제공하는 디지털콘텐츠(이하 "콘텐츠"라고 한다) 및 제반 서비스의 이용과 관련하여 회사와 이용자와의
			권리, 의무 및 책임사항 등을 규정함을 목적으로 합니다.
			<br><br>
			2. 이용자가 되고자 하는 자가 "거래소"에서 정한 소정의 절차를 거쳐서 "약관동의" 단추를 누르면 본 약관에 동의하는 것으로 간주합니다.
			<br><br>
			본 약관에 정하는 이외의 이용자와 "거래소"의 권리, 의무 및 책임사항에 관해서는 전기통신사업법 기타 대한민국의 관련 법령과 상관습에 의합니다.
			<br><br>
			<br><br>
			<b>제2조(정의)</b>
			<br><br>
			이 약관에서 사용하는 용어의 정의는 다음과 같습니다.
			<br><br>
			1. "거래소"라 함은 "콘텐츠" 산업과 관련된 경제활동을 영위하는 자로서 콘텐츠 및 제반서비스를 제공하는 자를 말합니다.
		</div>
	</div>

	<div class="join-terms-wrap modal-term-2">
		<div class="close" onclick="closeTap(this, true)"></div>
		<h2>개인정보 수집 및 이용</h2>
		<div class="agreement-document">
			<b>제1조(목적)</b>
		</div>
	</div>
<c:if test="${not empty mess}">
    <script>    
        alert('<c:out value="${mess}" />');
    </script>
</c:if>
<script>
    new ClipboardJS('[data-clipboard-text]');
</script>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!-- https://cdnjs.com/libraries/sockjs-client -->
  <script src="https://cdnjs.cloudflare.com/ajax/libs/sockjs-client/1.1.4/sockjs.min.js"></script>
  <!-- https://cdnjs.com/libraries/stomp.js/ -->
  <script  src="https://cdnjs.cloudflare.com/ajax/libs/stomp.js/2.3.3/stomp.min.js"></script>
<c:if test="${wallet != null}">
<jsp:useBean id="now" class="java.util.Date" />
<fmt:formatDate var="timeNow" value="${now}" pattern="yyyy-MM-dd" />
<fmt:formatDate var="timeNowMin" value="${now}" pattern="HH:mm:ss" />
<fmt:formatDate var="timeNowMilli" value="${now}" pattern="HH:mm:ss.SSS" />
	<div id="maskChat" class="maskChat minimize">
	    <div id="containerChat" class="containerChat list--active">
	        <section class="list" aria-hidden="true">
	            <headerChat class="headerChat list__headerChat">
	                <span class="headerChat__name"><spring:message code="title.chats"/></span>
	                <button class="btnChatClose btnChat--close" tabindex="0" title="Close chat">
                        <svg  class="btnChat__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
                    </button>
	            </headerChat>	              
	            <div class="chatlist">
            	 	<c:forEach items="${chatByUser}" var="item" varStatus="loop">
		                			                
                			<input type="text" class="listFromId" hidden name="fromId" value="${item.fromId}">
		                	<input type="text" class="listToId" hidden name="toId" value="${item.toId}">
		                	<c:choose>
		                		<c:when test="${userCurrent.userId == item.createId}">		                			
            						<button class="chat" tabindex="-1" data-chat-id="${item.chatId}" onclick="showMessage('${item.chatId}', '${item.toName}' , '${item.toId}',false)">
		                			<span class="chat__user__id" hidden>${item.toId}</span>
		                			<span class="chat__user">${item.toName}</span>
		                    		<span class="chat__message">
	                    			<span class="chat__sent">
			                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"></polyline></svg>
			                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"></polyline></svg>
			                        </span>
		                    		${item.message}
		                    	</span>
		                		</c:when>
		                		<c:otherwise>
		                			<button class="chat" tabindex="-1" data-chat-id="${item.chatId}" onclick="showMessage('${item.chatId}', '${item.fromName}' , '${item.fromId}',false)">
		                			<span class="chat__user__id" hidden>${item.fromId}</span>
		                			<span class="chat__user">${item.fromName}</span>
		                    		<span class="chat__message">
		                    			<span class="chat__sent">
				                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"></polyline></svg>
				                            <svg viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"></polyline></svg>
			                        	</span>
		                    			${item.message}
		                    		</span>
		                		</c:otherwise>
		                	</c:choose>

		                    
		                </button>
	                </c:forEach>
	            </div>
	        </section>
	        <section class="conversationChat" aria-hidden="false">	        	
	            <headerChat class="headerChat">
	                <button class="btnChat btnChat--list" title="Show chat list" tabindex="0">
	                    <svg class="btnChat__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="8" y1="6" x2="21" y2="6"></line><line x1="8" y1="12" x2="21" y2="12"></line><line x1="8" y1="18" x2="21" y2="18"></line><line x1="3" y1="6" x2="3.01" y2="6"></line><line x1="3" y1="12" x2="3.01" y2="12"></line><line x1="3" y1="18" x2="3.01" y2="18"></line></svg>
	                </button>
	                <div class="headerChat__info">
	                    <span class="headerChat__status"></span>
	                    <span id="headerChatName" class="headerChat__name"></span>
	                    <span id="headerChatUserId" hidden></span>
	                </div>
	                <div class="headerChat__actions">
	                   <!--  <button class="btnChat btnChat--camera" tabindex="0" title="Start videocall">
	                        <svg class="btnChat__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polygon points="23 7 16 12 23 17 23 7"></polygon><rect x="1" y="5" width="15" height="14" rx="2" ry="2"></rect></svg>
	                    </button> -->
	                    <button class="btnChatClose btnChat--close" tabindex="0" title="Close chat">
	                        <svg  class="btnChat__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="18" y1="6" x2="6" y2="18"></line><line x1="6" y1="6" x2="18" y2="18"></line></svg>
	                    </button>
	                </div>
	            </headerChat>
            	<div class="messages">
            		<c:forEach items="${chatByLineUser}" var="item" varStatus="loop"> 
             				<c:if test="${item.createId != userCurrent.userId }">            				

								 <div class="messages__bubble messages__bubble--left" data-chatId="${item.chatId}" data-chatLineId="${item.chatLineId}" data-chatLineId="${item.chatLineId}"  hidden>
			                     	<span class="messages__text">${item.message}</span>
			                     	<span class="chat__sent style_date_time">
				                     	<span>
				                     		<svg viewBox="0 0 24 24" style="margin-left: 2px;" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"></polyline></svg>
					                  		<fmt:formatDate var="lineDateTime" value="${item.regDateLine}" pattern="yyyy-MM-dd"/>
					                  		<c:choose>
					                  			<c:when test="${lineDateTime >= timeNow}">
					                  				<fmt:formatDate value="${item.regDateLine}" pattern="HH:mm:ss"/>
					                  			</c:when>
					                  			<c:otherwise>
					                  				<fmt:formatDate value="${item.regDateLine}" pattern="yyyy-MM-dd HH:mm:ss"/>
					                  			</c:otherwise>
					                  		</c:choose>					                  	
				                  		</span>			                           
		                        	</span>	
				                 </div>
				                 <input type="text" class="chat_message" data-chat-line-id="${item.chatLineId}" data-chat-line-yn="${item.checkYn}" data-createId="${item.fromId}" id="chatId" fromId="${item.fromId}" toId="${item.toId}" hidden name="chatId" value="${item.chatId}">		                 		
             				</c:if>
             				<c:if test="${item.createId == userCurrent.userId }">
         						<div class="messages__bubble messages__bubble--right" data-chatId="${item.chatId}"  data-chatLineId="${item.chatLineId}" data-regDateLine="${item.regDateLine}" hidden>
			                    	<span class="messages__text">${item.message}</span>
		                     		<span class="chat__sent style_date_time">
				                     	<span style="">
			                     		 	<svg viewBox="0 0 24 24" style="margin-left: 2px;" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"></polyline></svg>
					                  		<fmt:formatDate var="lineDateTime" value="${item.regDateLine}" pattern="yyyy-MM-dd"/>
					                  		<c:choose>
					                  			<c:when test="${lineDateTime >= timeNow}">
					                  				<fmt:formatDate value="${item.regDateLine}" pattern="HH:mm:ss"/>
					                  			</c:when>
					                  			<c:otherwise>
					                  				<fmt:formatDate value="${item.regDateLine}" pattern="yyyy-MM-dd HH:mm:ss"/>
					                  			</c:otherwise>
					                  		</c:choose>					                  	
					                  	</span>			                           
		                        	</span>		
				                 </div>
				                  <input type="text" class="chat_message" data-chat-line-id="${item.chatLineId}" data-chat-line-yn="" data-createId="${item.toId}" id="chatId" fromId="${item.fromId}" toId="${item.toId}" hidden name="chatId" value="${item.chatId}">
             				</c:if>	             		
                 	</c:forEach>            		
            	</div>
	            <footerChat class="footerChat">
	                <input type="text" class="footerChat__input" placeholder="Write a message..." tabindex="0" autocomplete="off">
	                <button class="btnChat btnChat--send" title="Send message" tabindex="0">
	                    <svg class="btnChat__icon" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><line x1="22" y1="2" x2="11" y2="13"></line><polygon points="22 2 15 22 11 13 2 9 22 2"></polygon></svg>
	                </button>
	            </footerChat>
	        </section>
	    </div>
	</div>

<script type="text/javascript">	

    var stompClient = null;
    var username = null;
    var userId = '${userCurrent.userId}';
    connect(); 
    loadDefautNewMessage();
	window.setInterval('loadSound()', 5000);
	function connect() {

        $.post('/rest/user-connect',
            { username: userId }, 
            function(remoteAddr, status, xhr) {
                var socket = new SockJS('/chat');
                stompClient = Stomp.over(socket);
                stompClient.connect({username: userId}, function () {              
                    stompClient.subscribe('/topic/active', function () {
                        //updateUsers(userName);
                    });
                    
                    stompClient.subscribe('/user/queue/messages', function (output) {
                        // showMessage(createTextNode(JSON.parse(output.body)));
                        var objSocket = JSON.parse(output.body);                        
                        console.log(JSON.parse(output.body));    
                        var timeCurrent = getCurentTime();
                        if (objSocket.type == 'SEND') {                       	
                        
	                        	if ($('#headerChatUserId').text() == objSocket.to) {

	                        		document.querySelector('.messages').insertAdjacentHTML('beforeend', 
	                        			`<div class="messages__bubble messages__bubble--right" data-chatid=`+objSocket.chatId+` data-chatLineId=`+objSocket.chatLineId+` >
	                        				<span class="messages__text">`+objSocket.content+`</span>
	                        				<span class="chat__sent style_date_time">
						                     	<span style="">
					                     		 	<svg viewBox="0 0 24 24" style="margin-left: 2px;" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"></polyline></svg>							                  		
							                  		`+timeCurrent+`
						                  		</span>			                           
				                        	</span>	
	                        			</div>
	                        			<input type="text" class="chat_message" data-chat-line-id="`+objSocket.chatLineId+`" data-createId="`+objSocket.to+`" id="chatId" fromId="" toId="" data-chat-line-yn="" hidden name="chatId" value="`+objSocket.chatId+`">`);	                        		
	                        	}else{
	                        		document.querySelector('.messages').insertAdjacentHTML('beforeend', 
	                        			`<div class="messages__bubble messages__bubble--right" data-chatid=`+objSocket.chatId+` data-chatLineId=`+objSocket.chatLineId+` hidden>
	                        				<span class="messages__text">`+objSocket.content+`</span>
	                        				<span class="chat__sent style_date_time">
						                     	<span style="">
					                     		 	<svg viewBox="0 0 24 24" style="margin-left: 2px;" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"></polyline></svg>							                  		
							                  		`+timeCurrent+`
						                  		</span>			                           
				                        	</span>	
                        				</div>
                        				<input type="text" class="chat_message" data-chat-line-id="`+objSocket.chatLineId+`" data-createId="`+objSocket.to+`" id="chatId" fromId="" toId="" data-chat-line-yn="" hidden name="chatId" value="`+objSocket.chatId+`">`);
	                        	}                 
                        		
	                    		if (objSocket.isUpdate != 'Y') {

		                    		var chatListSender = objSocket.chatListSender;
		                    		var senderHtml='';
		                    		$('.chatlist').remove();
		                    		for (var i = 0; i < chatListSender.length; i++) {
		                    			senderHtml += 
			                    			`<input type="text" class="listFromId" hidden name="fromId" value=`+chatListSender[i].fromId+`">`
			                    			+ `<input type="text" class="listToId" hidden name="toId" value="`+chatListSender[i].toId+`">`
			                    			+ `<button class="chat" data-chat-id="`+chatListSender[i].chatId+`" tabindex="-1" onclick="showMessage('`+chatListSender[i].chatId+`', '`+chatListSender[i].toName+`' , '`+chatListSender[i].toId+`',true)">`
			                    			+ `<span class="chat__user__id" hidden>`+chatListSender[i].toId+`</span>`
			                    			+ `<span class="chat__user">`+chatListSender[i].toName+`</span>`
			                    			+ `<span class="chat__message">`+chatListSender[i].message+`</span>`;		                    		
		                    		}		                    		
                    				$('.list').append(`<div class="chatlist">`+senderHtml+`</div>`);
                        		}
								
                        }else if(objSocket.type == 'RECIPIENT'){
                        		
                        	if ($('#headerChatUserId').text() == objSocket.from) {
                        		if ($('#containerChat').hasClass('list--active') == true || $('#maskChat').hasClass('minimize') == true) {
                        			document.querySelector('.messages').insertAdjacentHTML('beforeend', 
                        				`<div class="messages__bubble messages__bubble--left" data-chatid=`+objSocket.chatId+` data-chatLineId=`+objSocket.chatLineId+`>
                        					<span class="messages__text">`+objSocket.content+`</span>
                        					<span class="chat__sent style_date_time">
						                     	<span style="">
					                     		 	<svg viewBox="0 0 24 24" style="margin-left: 2px;" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"></polyline></svg>							                  		
							                  		`+timeCurrent+`
						                  		</span>			                           
				                        	</span>	
                    					</div>
                    					<input type="text" class="chat_message" data-chat-line-id="`+objSocket.chatLineId+`" data-createId="`+objSocket.from+`" id="chatId" fromId="" toId="" data-chat-line-yn="N" hidden name="chatId" value="`+objSocket.chatId+`">`);
                        				loadStyleNewMessage(objSocket.chatId);		
                        		}else{
                        			document.querySelector('.messages').insertAdjacentHTML('beforeend', 
                        				`<div class="messages__bubble messages__bubble--left" data-chatid=`+objSocket.chatId+` data-chatLineId=`+objSocket.chatLineId+`>
                        					<span class="messages__text">`+objSocket.content+`</span>
                        					<span class="chat__sent style_date_time">
						                     	<span style="">
					                     		 	<svg viewBox="0 0 24 24" style="margin-left: 2px;" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"></polyline></svg>							                  		
							                  		`+timeCurrent+`
						                  		</span>			                           
				                        	</span>	
                    					</div>
                    					<input type="text" class="chat_message" data-chat-line-id="`+objSocket.chatLineId+`" data-createId="`+objSocket.from+`" id="chatId" fromId="" toId="" data-chat-line-yn="Y" hidden name="chatId" value="`+objSocket.chatId+`">`);
									updateCheckLine(objSocket.chatLineId);
                        		}

								
                        	}else{	   

	                        	document.querySelector('.messages').insertAdjacentHTML('beforeend', 
	                        		`<div class="messages__bubble messages__bubble--left" data-chatid=`+objSocket.chatId+` data-chatLineId=`+objSocket.chatLineId+` hidden>
	                        			<p class="messages__text">`+objSocket.content+`</p>
	                        			<span class="chat__sent style_date_time">
					                     	<span style="">
				                     		 	<svg viewBox="0 0 24 24" style="margin-left: 2px;" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round"><polyline points="20 6 9 17 4 12"></polyline></svg>
						                  		`+timeCurrent+`
					                  		</span>			                           
			                        	</span>	
                        			</div>
                        			<input type="text" class="chat_message" data-chat-line-id="`+objSocket.chatLineId+`" data-createId="`+objSocket.from+`" id="chatId" fromId="" toId="" data-chat-line-yn="N" hidden name="chatId" value="`+objSocket.chatId+`">`);	
	                        	loadStyleNewMessage(objSocket.chatId);								
                        	}
                        	if (objSocket.isUpdate != 'Y') {
								var styleCheckLine = '';
                        		var chatListRecipient = objSocket.chatListRecipient;
                        		var recipentHtml='';
                        		$('.chatlist').remove();
                        		for (var i = 0; i < chatListRecipient.length; i++) {

									if(chatListRecipient[i].checkYn == 'N'){
										styleCheckLine = `style_Check_Line`;
									}else{
										var styleCheckLine = '';
									}
									
                        			if (chatListRecipient[i].createId == userId) {
                        				recipentHtml += 
                        					`<input type="text" class="listFromId" hidden name="fromId" value=`+chatListRecipient[i].fromId+`">`
		                        			+ `<input type="text" class="listToId" hidden name="toId" value="`+chatListRecipient[i].toId+`">`
		                        			+ `<button class="chat `+styleCheckLine+`" data-chat-id="`+chatListRecipient[i].chatId+`" tabindex="-1" onclick="showMessage('`+chatListRecipient[i].chatId+`', '`+chatListRecipient[i].toName+`' , '`+chatListRecipient[i].toId+`',true)">`
		                        			+ `<span class="chat__user__id" hidden>`+chatListRecipient[i].toId+`</span>`
		                        			+ `<span class="chat__user">`+chatListRecipient[i].toName+`</span>`
		                        			+ `<span class="chat__message">`+chatListRecipient[i].message+`</span>`;    
                        			}else{
                        				recipentHtml += 
                        					`<input type="text" class="listFromId" hidden name="fromId" value=`+chatListRecipient[i].fromId+`">`
		                        			+ `<input type="text" class="listToId" hidden name="toId" value="`+chatListRecipient[i].toId+`">`
		                        			+ `<button class="chat `+styleCheckLine+`" data-chat-id="`+chatListRecipient[i].chatId+`" tabindex="-1" onclick="showMessage('`+chatListRecipient[i].chatId+`', '`+chatListRecipient[i].fromName+`' , '`+chatListRecipient[i].fromId+`',true)">`
		                        			+ `<span class="chat__user__id" hidden>`+chatListRecipient[i].fromId+`</span>`
		                        			+ `<span class="chat__user">`+chatListRecipient[i].fromName+`</span>`
		                        			+ `<span class="chat__message">`+chatListRecipient[i].message+`</span>`;    
                        			}
                        			                    			
                        		}                        		
                        		
                    			$('.list').append(`<div class="chatlist">`+recipentHtml+`</div>`);
                    			$('.headerChat').addClass('style_Check_Line');
                        	}
                        }                        
                         $('.messages').scrollTop($('.messages')[0].scrollHeight);
                    });

                }, function (err) {                    
                });  

            }).done(function() { 
                // alert('Request done!');                 
            }).fail(function(jqxhr, settings, ex) {
                console.log('failed, ' + ex); 
            }
        );         
    }

    function getCurentTime(){
    	var today = new Date();
		var date = today.getFullYear()+'-'+(today.getMonth()+1)+'-'+today.getDate();
		return today.getHours() + ":" + today.getMinutes() + ":" + today.getSeconds() + ":" + today.getMilliseconds();

    }




	var isClickShowChat = false;
	$('.btn-show-chat').click(function(){
        // if (document.querySelector('.list--active') !== null && ${userChat.loginId != null}) {      
        	if (${userChat.loginId != null}) {      
			$('.chat').click();
            $('#maskChat').removeClass('minimize');  
        	var userChatUid = '${userChat.userId}';
            $('#headerChatName').text('${userChat.loginId}');
            $('#headerChatUserId').text(userChatUid);   
            
         	$('.listFromId').each(function(){         		
         		if ($(this).val() == userChatUid) {isClickShowChat = true}

         	});
         	$('.listToId').each(function(){         		
         		if ($(this).val() == userChatUid) {isClickShowChat = true}

         	});
         	// console.log(isClickShowChat);
         	$('.chat_message').each(function(){		 	
							 	
			 	if (!isClickShowChat) {
			 		$('.messages__bubble').each(function(){	 	
			 			$(this).attr('hidden','');
	 			 	});
			 	}
			 	if (userChatUid == $( this ).attr('fromid') || userChatUid == $( this ).attr('toid')) {
			 		var getChat_id =  $(this).val();
				$('.messages__bubble').each(function(){
						
					 	var dataChatId =  $( this ).attr('data-chatid');
					 	if (dataChatId == getChat_id) {
					 		// $('#headerChatName').text(login_id);
				    //         $('#headerChatUserId').text(user_id);
					 		$(this).removeAttr('hidden');
					 	}else {
					 		$(this).attr('hidden','');
					 	}
					 });
			 	}
			 });

            $('#containerChat').removeClass('list--active');
            $('.messages').scrollTop($('.messages')[0].scrollHeight);
            
        }else if (document.querySelector('.minimize') !== null){
			 
             $('#maskChat').removeClass('minimize');
            
        }           
	setTimeout(() => {
		document.querySelector('.footerChat__input').focus();
	}, 350);
    });

function showMessage(chat_id, login_id, user_id, isHtml) {		
	
	 $('.messages__bubble').each(function(){
	 	var dataChatId =  $( this ).attr('data-chatid');	 	
	 	if (dataChatId == chat_id) {	 		
	 		$('#headerChatName').text(login_id);
            $('#headerChatUserId').text(user_id);
	 		$(this).removeAttr('hidden');	
	 		$('.chat_message').each(function(){				
		 		if($(this).attr('data-chat-line-yn') == 'N' && $(this).val() == chat_id){
		 			updateCheckLine($(this).attr('data-chat-line-id'));		
		 			$('.headerChat').removeClass('style_Check_Line'); 
		 			$('.chat').each(function(){
		 				if (chat_id == $(this).attr('data-chat-id')) {
		 					$(this).removeClass('style_Check_Line'); 			
		 				}
		 			});	
		 			
		 		}
			 });
	 	}else {
	 		$(this).attr('hidden','');	 		
	 	}
	 });	
	 
	 if (isHtml) {
	 	showconversationChat();	
	 }
	 $('.messages').scrollTop($('.messages')[0].scrollHeight);	
}

function loadDefautNewMessage(){
	var isNewId;
	$('.chat_message').each(function(){				
 		if($(this).attr('data-chat-line-yn') == 'N'){	
 			$('.headerChat').addClass('style_Check_Line');
 			isNewId = $(this).val();
 		}
	 });
	loadStyleNewMessage(isNewId);
}
function loadStyleNewMessage(chat_id_style) {
	 $('.chat').each(function(){
	 	if (chat_id_style == $(this).attr('data-chat-id')) {
	 		$(this).addClass('style_Check_Line');
	 		$('.headerChat').addClass('style_Check_Line');
	 		// add sound
	 		document.getElementById('sound-3').play().catch((e)=>{});
	 	}
	 	
	 });
}

function updateCheckLine(chatLineId){
	console.log('update');
	var settings = {
					  "url": "/chat/updateCheckLine",
					  "method": "POST",
					  "timeout": 0,
					  "headers": {
					    "Content-Type": "application/json"			   
					  },
					  "data": JSON.stringify({
					  	"chatLineId": chatLineId,
					    "checkYn": 'Y'
					  }),
					};	
		$.ajax(settings).done(function (response) {
							
		});
				
}
	
// load sound
function loadSound(){
	if ($(".style_Check_Line")[0]){
	    document.getElementById('sound-3').play().catch((e)=>{});	    
	}
}

</script>
</c:if>

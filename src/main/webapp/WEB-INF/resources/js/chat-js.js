function addMessageToconversationChat () {

	// Save written message from input.
	let messageText = document.querySelector('.footerChat__input').value;

	// If message is empty...
	if (messageText.trim().length == 0) {

		return false;

	} else {

		// Add the message with the bubble to the conversationChat.
		// document.querySelector('.messages').insertAdjacentHTML('beforeend', `<div class="messages__bubble messages__bubble--right"><p class="messages__text">${messageText}</p></div>`);
		

		// Clear the input.
		document.querySelector('.footerChat__input').value = '';

		// Return focus to input.
		document.querySelector('.footerChat__input').focus();
		
		
		var headerChatUserId = $('#headerChatUserId').text();
	  	var data_chat_id = 0;
  		$('.chat_message').each(function(){
  			if (headerChatUserId == $(this).attr('data-createId')) {
				data_chat_id = $(this).val();
				console.log(data_chat_id);					
  			}
  		});
        stompClient.send("/app/chat", {'sender': userId},
                JSON.stringify({'chatId': data_chat_id, 'from': userId, 'content': messageText, 'to': $('#headerChatUserId').text(),'toName': $('#headerChatName').text()}));     
   

			$('.messages').scrollTop($('.messages')[0].scrollHeight);
		
	}
}



function showChatList () {

	document.querySelector('.containerChat').classList.toggle('list--active');

	// Disable keyboard navigation for the conversationChat view.
	document.querySelectorAll('.conversationChat [tabindex="0"]').forEach((element) => {

		element.setAttribute('tabindex', '-1');

	});

	// Enable the keyboard navigation for the chat list.
	document.querySelectorAll('.list [tabindex="-1"]').forEach((element) => {

		element.setAttribute('tabindex', '0');

	});

	// Toggle aria-hidden in each section
	document.querySelector('.list').setAttribute('aria-hidden', false)
	document.querySelector('.conversationChat').setAttribute('aria-hidden', true)

	// Focus on first chat.
	//	setTimeout(() => {
	//		document.querySelector('#chat1').focus();
	//	}, 350);

}



function showconversationChat () {	
	
	document.querySelector('.containerChat').classList.toggle('list--active');

	// Enable the keyboard navigation for the conversationChat view.
	document.querySelectorAll('.conversationChat [tabindex="-1"]').forEach((element) => {

		element.setAttribute('tabindex', '0');

	});

	// Disable keyboard navigation for the chat list.
	document.querySelectorAll('.list [tabindex="0"]').forEach((element) => {

		element.setAttribute('tabindex', '-1');

	});

	

	// Toggle aria-hidden in each section
	document.querySelector('.list').setAttribute('aria-hidden', true)
	document.querySelector('.conversationChat').setAttribute('aria-hidden', false)

	/* Focus to input with timeout because otherwise the focus happens so fast that it breaks the transition and the conversationChat view goes out of the containerChat. */
	setTimeout(() => {
		document.querySelector('.footerChat__input').focus();
	}, 350);
}



function minimizeChat () {

	document.querySelector('.maskChat').classList.toggle('minimize');
	// document.querySelector('.headerChat__info').classList.toggle('minimize');


}

function removeMinimize(){
	$('.maskChat').removeClass('minimize');
}


// Event listeners.
document.querySelector('.btnChat--list').addEventListener('click', showChatList);
document.querySelectorAll('.chat')
	.forEach((element) => element.addEventListener('click', showconversationChat));

document.querySelectorAll('.headerChat__info, .list__headerChat, .headerChat__actions')
	.forEach((element) => element.addEventListener('click', minimizeChat));

document.querySelector('.btnChat--send').addEventListener('click', addMessageToconversationChat);

// Send message with enter key.
document.querySelector('.footerChat__input').addEventListener('keydown', (e) => {

	if (e.key == 'Enter') {

		addMessageToconversationChat();

	} else {

		return false;

	}
});

document.querySelector('.btnChat--list').addEventListener('click', removeMinimize);



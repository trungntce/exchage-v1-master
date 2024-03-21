$(document).ready(function(){

	deviceSizeCheck();
	scrCheck();

	$('.header__mobile-toggle').click(function(){
		event.preventDefault();
		$('html').stop().toggleClass('mobile-menu-open');
		$('.member-menu li').stop().removeClass('is-active');
	});

	$('.dim').click(function(){
		event.preventDefault();
		$('html').stop().removeClass('mobile-menu-open').removeClass('modal-open');
		$('.modal').stop().removeClass('is-active');
	});

	$('.modal-close-btn').click(function(){
		event.preventDefault();
		$('html').stop().removeClass('modal-open');
		$('.modal').stop().removeClass('is-active');
	});

	$('.member-menu li a').click(function(){
		event.preventDefault();
		$('.member-menu li').stop().removeClass('is-active');
		$(this).parent().addClass('is-active');
	});

});

$(window).resize(function(){
	deviceSizeCheck();
});

$(window).scroll(function(){
	scrCheck();
	$('.member-menu li').stop().removeClass('is-active');
});

// pc 사이즈로 커질때 모바일 메뉴 감춤
var deviceSizeCheck = function(){
	var width_size = window.innerWidth;

	if (width_size > 1024) {
		$('html').removeClass('mobile-menu-open');
		$('.member-menu li').stop().removeClass('is-active');
	}
}

var scrCheck = function(){
	if ($(window).scrollTop() > 0) {
		$('html').addClass('scroll');
	} else {
		$('html').removeClass('scroll');
	}
}
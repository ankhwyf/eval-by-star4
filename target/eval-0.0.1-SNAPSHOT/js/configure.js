$(document).ready(function() {
	// 鼠标悬停和离开
	$(".container .content .col-md-4 .configure table tr").hover(function(){
	    $(this).css('background', '#f5f5f5');
	    $(this).find('.pull-right').show();
	},function(){
		$(this).css('background', '#ffffff');
	    $(this).find('.pull-right').hide();
	})

	
});
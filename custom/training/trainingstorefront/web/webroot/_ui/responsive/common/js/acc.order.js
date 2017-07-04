ACC.order = {

	_autoload: [
	    "backToOrderHistory",
	    "backToOrders",
	    "bindMultidProduct"
	],

	backToOrderHistory: function(){
		$(".orderBackBtn").on("click", function(){
			var sUrl = $(this).data("backToOrders");
			window.location = sUrl;
		});
	},
	backToOrders: function(){
		$(".orderTopBackBtn").on("click", function(){
			var sUrl = $(this).data("backToOrders");
			window.location = sUrl;
		});
	},
	
	bindMultidProduct: function ()
	{
		// link to display the multi-d grid in read-only mode
		$(document).on("click",'.showMultiDGridInOrder', function (event){
			ACC.order.populateAndShowGrid(this, event, true);
			return false;
		});

		// link to display the multi-d grid in read-only mode
		$(document).on("click",'.showMultiDGridInOrderOverlay', function (event){
			ACC.order.populateAndShowCheckoutGridOverlay(this, event);
		});

	},

	populateAndShowGrid: function(element, event, readOnly)
	{
		var itemIndex = $(element).data("index");
		grid = $("#ajaxGrid" + itemIndex);
		var gridEntries = $('#grid' + itemIndex);
		
		$(element).toggleClass('open');
		
		if (!grid.is(":hidden")) {
        	grid.slideUp();
        	return;
        }

		if(grid.html() != "") {
			grid.slideToggle("slow");
			return;
		}

		var strSubEntries = gridEntries.data("sub-entries");
		var arrSubEntries= strSubEntries.split(',');
		var firstVariantCode = arrSubEntries[0].split(':')[0];

		var targetUrl = gridEntries.data("target-url");
		if (targetUrl == '') {
			targetUrl = ACC.config.contextPath + '/my-account/order/'+ gridEntries.data("order-code")  +'/getReadOnlyProductVariantMatrix';
		}

		var method = "GET";
		$.ajax({
			url: targetUrl,
			data: {productCode: firstVariantCode},
			type: method,
			success: function(data)
			{
				grid.html(data);
				grid.slideDown("slow");
			},
			error: function(xht, textStatus, ex)
			{
				alert("Failed to get variant matrix. Error details [" + xht + ", " + textStatus + ", " + ex + "]");
			}

		});
	},

	populateAndShowCheckoutGridOverlay: function(element, event )
	{
		event.preventDefault();

		var itemIndex = $(element).data("index");
		var gridEntries = $('#grid' + itemIndex);

		var strSubEntries = gridEntries.data("sub-entries");
		var productName = gridEntries.data("product-name");
		var arrSubEntries= strSubEntries.split(',');
		var firstVariantCode = arrSubEntries[0].split(':')[0];
		var orderCode = gridEntries.data("order-code");

		var targetUrl = ACC.config.contextPath + '/my-account/order/'+ orderCode +'/getReadOnlyProductVariantMatrix?productCode=' + firstVariantCode;

		$.colorbox({
			href:   targetUrl,
			title:  productName,
			className: 'read-only-grid',
			close:'<span class="glyphicon glyphicon-remove"></span>',
			width: window.innerWidth > parseInt(cboxOptions.maxWidth) ? cboxOptions.maxWidth : cboxOptions.width,
			height: window.innerHeight > parseInt(cboxOptions.maxHeight) ? cboxOptions.maxHeight : cboxOptions.height,
			onComplete: function() {

				var cTitle = $('#cboxTitle').clone();
				$('#cboxTitle').remove();
				cTitle.insertBefore('#cboxLoadedContent');
				$('body').addClass('offcanvas');
				var oH = $('#cboxLoadedContent').height();
				$('#cboxLoadedContent').height((oH - $('#cboxTitle').height()) +'px');

			},

			onClosed: function() {
				$('body').removeClass('offcanvas');
			}

		});
	}
};
ACC.cart = {

    _autoload: [
        "bindHelp",
        "cartRestoration",
        "bindCartPage",
        "bindMultiDEntryRemoval",
        "bindMultidCartProduct"
    ],

    bindHelp: function () {
        $(document).on("click", ".js-cart-help", function (e) {
            e.preventDefault();
            var title = $(this).data("help");
            ACC.colorbox.open(title, {
                html: $(".js-help-popup-content").html(),
                width: "300px"
            });
        })
    },

    cartRestoration: function () {
        $('.cartRestoration').click(function () {
            var sCartUrl = $(this).data("cartUrl");
            window.location = sCartUrl;
        });
    },

    bindCartPage: function () {
        // link to display the multi-d grid in read-only mode
        $(document).on("click", '.showEditableGrid', function (event) {
            ACC.cart.populateAndShowEditableGrid(this, event);
        });
    },

    bindMultiDEntryRemoval: function () {
        $(document).on("click", '.submitRemoveProductMultiD', function () {
            var itemIndex = $(this).data("index");
            var $form = $('#updateCartForm' + itemIndex);
            var initialCartQuantity = $form.find('input[name=initialQuantity]');
            var cartQuantity = $form.find('input[name=quantity]');
            var entryNumber = $form.find('input[name=entryNumber]').val();
            var productCode = $form.find('input[name=productCode]').val();

            cartQuantity.val(0);
            initialCartQuantity.val(0);

            ACC.track.trackRemoveFromCart(productCode, initialCartQuantity, cartQuantity.val());

            var method = $form.attr("method") ? $form.attr("method").toUpperCase() : "GET";
            $.ajax({
                url: $form.attr("action"),
                data: $form.serialize(),
                type: method,
                success: function (data) {
                    location.reload();
                },
                error: function () {
                    alert("Failed to remove quantity. Error details [" + xht + ", " + textStatus + ", " + ex + "]");
                }

            });

        });
    },


    populateAndShowEditableGrid: function (element, event) {
        var readOnly = $(element).data("readOnlyMultidGrid");
        var itemIndex = $(element).data("index");
        grid = $("#ajaxGrid" + itemIndex);

        var gridEntries = $('#grid' + itemIndex);

        var strSubEntries = gridEntries.data("sub-entries");
        var arrSubEntries = strSubEntries.split(',');
        var firstVariantCode = arrSubEntries[0].split(':')[0];

        $(element).toggleClass('open');

        var targetUrl = ACC.config.contextPath;
        targetUrl = targetUrl + "/cart/getProductVariantMatrix";

        var mapCodeQuantity = new Object();
        for (var i = 0; i < arrSubEntries.length; i++) {
            var arrValue = arrSubEntries[i].split(":");
            mapCodeQuantity[arrValue[0]] = arrValue[1];
        }

        if (grid.children('#cartOrderGridForm').length > 0) {
            grid.slideToggle("slow");
        }
        else {
            var method = "GET";
            $.ajax({
                url: targetUrl,
                data: {productCode: firstVariantCode, readOnly: readOnly},
                type: method,
                success: function (data) {
                    grid.html(data);
                    $("#ajaxGrid").removeAttr('id');
                    var $gridContainer = grid.find(".product-grid-container");
                    var numGrids = $gridContainer.length;
                    for (var i = 0; i < numGrids; i++) {
                        ACC.cart.getProductQuantity($gridContainer.eq(i), mapCodeQuantity, i);
                    }
                    grid.slideDown("slow");
                    ACC.cart.coreCartGridTableActions(element, mapCodeQuantity);
                    ACC.productorderform.coreTableScrollActions(grid.children('#cartOrderGridForm'));
                },
                error: function (xht, textStatus, ex) {
                    alert("Failed to get variant matrix. Error details [" + xht + ", " + textStatus + ", " + ex + "]");
                }

            });
        }
    },


    coreCartGridTableActions: function (element, mapCodeQuantity) {
        ACC.productorderform.bindUpdateFutureStockButton(".update_future_stock_button");
        ACC.productorderform.bindVariantSelect($(".variant-select-btn"), 'cartOrderGridForm');
        var itemIndex = $(element).data("index");
        var skuQuantityClass = '.sku-quantity';

        var quantityBefore = 0;
        var grid = $('#ajaxGrid' + itemIndex + " .product-grid-container");

        grid.on('focusin', skuQuantityClass, function (event) {
            quantityBefore = jQuery.trim(this.value);

            $(this).parents('tr').next('.variant-summary').remove();
            if($(this).parents('table').data(ACC.productorderform.selectedVariantData)){
                ACC.productorderform.selectedVariants = $(this).parents('table').data(ACC.productorderform.selectedVariantData);
            } else {
                ACC.productorderform.selectedVariants = [];
            }

            if (quantityBefore == "") {
                quantityBefore = 0;
                this.value = 0;
            }
        });

        grid.on('focusout', skuQuantityClass, function (event) {
            var quantityAfter = 0;
            var gridLevelTotalPrice = "";

            var indexPattern = "[0-9]+";
            var currentIndex = parseInt($(this).attr("id").match(indexPattern));

            this.value = ACC.productorderform.filterSkuEntry(this.value);

            quantityAfter = jQuery.trim(this.value);
            var variantCode = $("input[id='cartEntries[" + currentIndex + "].sku']").val();

            if (isNaN(jQuery.trim(this.value))) {
                this.value = 0;
            }

            if (quantityAfter == "") {
                quantityAfter = 0;
                this.value = 0;
            }

            var $gridTotalValue = grid.find("[data-grid-total-id=" + 'total_value_' + currentIndex + "]");
            var currentPrice = $("input[id='productPrice[" + currentIndex + "]']").val();

            if (quantityAfter > 0) {
                gridLevelTotalPrice = ACC.productorderform.formatTotalsCurrency(parseFloat(currentPrice) * parseInt(quantityAfter));
            }

            $gridTotalValue.html(gridLevelTotalPrice);

            var _this = this;
            var priceSibling = $(this).siblings('.price');
            var propSibling = $(this).siblings('.variant-prop');
            var currentSkuId = $(this).next('.td_stock').data('sku-id');
            var currentBaseTotal = $(this).siblings('.data-grid-total');

            if (this.value != quantityBefore) {
                var newVariant = true;
                ACC.productorderform.selectedVariants.forEach(function(item, index) {
                    if(item.id === currentSkuId){
                        newVariant = false;

                        if(_this.value === '0' || _this.value === 0){
                            ACC.productorderform.selectedVariants.splice(index, 1);
                        } else {
                            ACC.productorderform.selectedVariants[index].quantity = _this.value;
                            ACC.productorderform.selectedVariants[index].total = ACC.productorderform.updateVariantTotal(priceSibling, _this.value, currentBaseTotal);
                        }
                    }
                });

                if(newVariant && this.value > 0){
                    // update variantData
                    ACC.productorderform.selectedVariants.push({
                        id: currentSkuId,
                        size: propSibling.data('variant-prop'),
                        quantity: _this.value,
                        total: ACC.productorderform.updateVariantTotal(priceSibling, _this.value,  currentBaseTotal)
                    });
                }
            }
            ACC.productorderform.showSelectedVariant($(this).parents('table'));
            if (this.value > 0 && this.value != quantityBefore) {
                $(this).parents('table').addClass('selected');
            } else {
                if (ACC.productorderform.selectedVariants.length === 0) {
                    $(this).parents('table').removeClass('selected').find('.variant-summary').remove();

                }
            }

            if (quantityBefore != quantityAfter) {
                var method = "POST";
                $.ajax({
                    url: ACC.config.contextPath + '/cart/updateMultiD',
                    data: {productCode: variantCode, quantity: quantityAfter, entryNumber: -1},
                    type: method,
                    success: function (data, textStatus, xhr) {
                        ACC.cart.refreshCartData(data, -1, quantityAfter, itemIndex);
                        mapCodeQuantity[variantCode] = quantityAfter;
                    },
                    error: function (xhr, textStatus, error) {
                        var redirectUrl = xhr.getResponseHeader("redirectUrl");
                        var connection = xhr.getResponseHeader("Connection");
                        // check if error leads to a redirect
                        if (redirectUrl !== null) {
                            window.location = redirectUrl;
                            // check if error is caused by a closed connection
                        } else if (connection === "close") {
                            window.location.reload();
                        }
                    }
                });
            }
        });
    },

    refreshCartData: function (cartData, entryNum, quantity, itemIndex) {
        // if cart is empty, we need to reload the whole page
        if (cartData.entries.length == 0) {
            location.reload();
        }
        else {
            var form;

            if (entryNum == -1) // grouped item
            {
                var editLink = $('#QuantityProduct' + itemIndex);
                form = editLink.closest('form');
                var productCode = form.find('input[name=productCode]').val();

                var quantity = 0;
                var entryPrice = 0;
                for (var i = 0; i < cartData.entries.length; i++) {
                    var entry = cartData.entries[i];
                    if (entry.product.code == productCode) {
                        quantity = entry.quantity;
                        entryPrice = entry.totalPrice;
                        break;
                    }
                }

                if (quantity == 0) {
                    location.reload();
                }
                else {
                    form.find(".qtyValue").html(quantity);
                    form.parent().parent().find(".item-price").html(entryPrice.formattedValue);
                }
            }

            // refresh mini cart
            ACC.minicart.updateMiniCartDisplay();
            $('.cart-top-totals').html("");
            $('.cart-top-totals').html($("#cartTopTotalSectionTemplate").tmpl(cartData));
            $('div .cartpotproline').remove();
            $('div .cartproline').remove();
            $('.cart-totals').remove();
            $('#ajaxCartPotentialPromotionSection').html($("#cartPotentialPromotionSectionTemplate").tmpl(cartData));
            $('#ajaxCartPromotionSection').html($("#cartPromotionSectionTemplate").tmpl(cartData));
            $('#ajaxCart').html($("#cartTotalsTemplate").tmpl(cartData));
        }
    },

    getProductQuantity: function (gridContainer, mapData, i) {
        var tables = gridContainer.find("table");

        $.each(tables, function (index, currentTable) {
            var skus = jQuery.map($(currentTable).find("input[type='hidden'].sku"), function (o) {
                return o.value
            });
            var quantities = jQuery.map($(currentTable).find("input[type='textbox'].sku-quantity"), function (o) {
                return o
            });
            var selectedVariants = [];

            $.each(skus, function (index, skuId) {
                var quantity = mapData[skuId];
                if (quantity != undefined) {
                    quantities[index].value = quantity;

                    var indexPattern = "[0-9]+";
                    var currentIndex = parseInt(quantities[index].id.match(indexPattern));
                    var gridTotalValue = gridContainer.find("[data-grid-total-id=" + 'total_value_' + currentIndex + "]");
                    var gridLevelTotalPrice = "";
                    var currentPrice = $("input[id='productPrice[" + currentIndex + "]']").val();
                    if (quantity > 0) {
                        gridLevelTotalPrice = ACC.productorderform.formatTotalsCurrency(parseFloat(currentPrice) * parseInt(quantity));
                    }
                    gridTotalValue.html(gridLevelTotalPrice);

                    selectedVariants.push({
                        id: skuId,
                        size: $(quantities[index]).siblings('.variant-prop').data('variant-prop'),
                        quantity: quantity,
                        total: gridLevelTotalPrice
                    });
                }
            });

            if (selectedVariants.length != 0) {
                $.tmpl(ACC.productorderform.$variantSummaryTemplate, {
                    variants: selectedVariants
                }).appendTo($(currentTable).addClass('selected'));
                $(currentTable).find('.variant-summary .variant-property').html($(currentTable).find('.variant-detail').data('variant-property'));
                $(currentTable).data(ACC.productorderform.selectedVariantData, selectedVariants);
            }
        });

    },

    bindMultidCartProduct: function ()
    {
        // link to display the multi-d grid in read-only mode
        $(document).on("click",'.showQuantityProduct', function (event){
            ACC.cart.populateAndShowGrid(this, event, true);
        });

        // link to display the multi-d grid in read-only mode
        $(document).on("click",'.showQuantityProductOverlay', function (event){
            ACC.cart.populateAndShowCheckoutGridOverlay(this, event);
        });

    },

    populateAndShowGrid: function(element, event, readOnly)
    {
        var itemIndex = $(element).data("index");
        grid = $("#ajaxGrid" + itemIndex);
        var gridEntries = $('#grid' + itemIndex);

        var strSubEntries = gridEntries.data("sub-entries");
        var arrSubEntries= strSubEntries.split(',');
        var firstVariantCode = arrSubEntries[0].split(':')[0];

        grid.slideDown("slow");

        $("#QuantityProductToggle" + itemIndex).html("-");

        var targetUrl = ACC.config.contextPath;

        targetUrl = targetUrl + "/checkout/multi/getReadOnlyProductVariantMatrix";

        var method = "GET";
        $.ajax({
            url: targetUrl,
            data: {productCode: firstVariantCode},
            type: method,
            success: function(data)
            {
                grid.html(data);
                $("#ajaxGrid").removeAttr('id');
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

        var targetUrl = ACC.config.contextPath + '/checkout/multi/getReadOnlyProductVariantMatrix?productCode=' + firstVariantCode;

        ACC.colorbox.open(productName, {
            href:   targetUrl,
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
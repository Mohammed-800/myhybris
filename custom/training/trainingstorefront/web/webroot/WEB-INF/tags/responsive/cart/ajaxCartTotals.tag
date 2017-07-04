<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ attribute name="showTax" required="false" type="java.lang.Boolean" %>

<script id="cartTotalsTemplate" type="text/x-jquery-tmpl">

<div class="cart-totals">
    <div class="row">
        <div class="col-xs-8 col-sm-9 col-md-10 col-lg-11"><spring:theme code="basket.page.totals.subtotal"/></div>
        <div class="col-xs-4 col-sm-3 col-md-2 col-lg-1">
        <ycommerce:testId code="Order_Totals_Subtotal">
		{{if net}}
			{{= totalPriceWithTax.formattedValue}}
		{{else}}
			{{= totalPrice.formattedValue}}
		{{/if}}
		</ycommerce:testId></div>


		{{if deliveryCost}}
			<div class="col-xs-8 col-sm-9 col-md-10 col-lg-11"><spring:theme code="basket.page.totals.delivery"/></div>
			<div class="col-xs-4 col-sm-3 col-md-2 col-lg-1">
				{{if deliveryCost.value > 0}}
					{{= deliveryCost.formattedValue}}
				{{else}}
					<spring:theme code="basket.page.free"/>
				{{/if}}
			</div>
         {{/if}}


        {{if net && totalTax.value > 0}}
            <div class="col-xs-8 col-sm-9 col-md-10 col-lg-11"><spring:theme code="basket.page.totals.netTax"/></div>
            <div class="col-xs-4 col-sm-3 col-md-2 col-lg-1">{{= totalTax.formattedValue}}</div>
		{{/if}}



        {{if totalDiscounts.value > 0}}
            <div class="col-xs-8 col-sm-9 col-md-10 col-lg-11 discount"><spring:theme code="basket.page.totals.savings"/></div>
            <div class="col-xs-4 col-sm-3 col-md-2 col-lg-1 discount">
                -<ycommerce:testId code="Order_Totals_Savings">{{= totalDiscounts.formattedValue}}</ycommerce:testId>
            </div>
        {{/if}}

        <div class="col-xs-8 col-sm-9 col-md-10 col-lg-11 grand-total"><spring:theme code="basket.page.totals.total"/></div>
        <div class="col-xs-4 col-sm-3 col-md-2 col-lg-1 grand-total">
            <ycommerce:testId code="cart_totalPrice_label">
			{{if net}}
				{{= totalPriceWithTax.formattedValue}}
			{{else}}
				{{= totalPrice.formattedValue}}
			{{/if}}
			</ycommerce:testId>
        </div>


       {{if !net}}
            <div class="">
                <ycommerce:testId code="cart_taxes_label"><spring:theme code="basket.page.totals.grossTax" arguments="{{= totalTax.formattedValue}}" argumentSeparator="!!!!" /></ycommerce:testId>
             </div>
        {{/if}}


       {{if net && totalTax.value <= 0}}
            <div class="">
                <ycommerce:testId code="cart_taxes_label"><spring:theme code="basket.page.totals.noNetTax"/></ycommerce:testId>
            </div>
        {{/if}}

    </div>
</div>

</script>

<div id="ajaxCart">
</div>

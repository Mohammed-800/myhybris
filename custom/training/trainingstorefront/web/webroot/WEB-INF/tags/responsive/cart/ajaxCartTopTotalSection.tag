<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ attribute name="showTax" required="false" type="java.lang.Boolean" %>

<script id="cartTopTotalSectionTemplate" type="text/x-jquery-tmpl">
    <div class="cart-top-totals">
        {{if totalItems > 1}}
             <spring:theme code="basket.page.totals.total.items" arguments="{{= totalItems}}"/>
        {{else}}
             <spring:theme code="basket.page.totals.total.items.one" arguments="{{= totalItems}}"/>
        {{/if}}
        <ycommerce:testId code="cart_totalPrice_label">
        {{if net}}
            {{= totalPriceWithTax.formattedValue}}
        {{else}}
            {{= totalPrice.formattedValue}}
         {{/if}}
        </ycommerce:testId>
    </div>
</script>

<div id="ajaxCartTopTotalSection">
</div>



<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="product" required="true" type="de.hybris.platform.commercefacades.product.data.ProductData" %>
<%@ attribute name="showViewDetails" required="false" type="java.lang.Boolean"%>
<%@ attribute name="addToCartBtnId" required="false" type="java.lang.String"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product" %>

<div id="addToCartTitle" style="display:none"><spring:theme code="basket.added.to.basket"/></div>

<li>
    <spring:theme code="text.addToCart" var="addToCartText"/>
    <button  id="${(empty addToCartBtnId) ? 'addToCartBtn' : addToCartBtnId}" type="button" class="btn btn-primary" disabled="disabled">
        <spring:theme code="text.addToCart" var="addToCartText"/>
        <spring:theme code="basket.add.to.basket" />
    </button>
</li>

<li class="hidden-xs">
    <spring:theme code="order.form.subtotal"/>&nbsp;
    <span class="left" id="total-price"><spring:theme code="order.form.currency"/>0.00</span>
    <input type="hidden" id="total-price-value" value="0">
</li>






  
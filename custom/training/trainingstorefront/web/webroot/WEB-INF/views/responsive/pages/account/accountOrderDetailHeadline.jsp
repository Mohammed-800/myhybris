<%@ page trimDirectiveWhitespaces="true" %>

<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<div class="back-link">
	<spring:url value="/my-account/orders" var="orderHistoryUrl"/>
	<button type="button" class="orderTopBackBtn" data-back-to-orders="${orderHistoryUrl}">
		<span class="glyphicon glyphicon-chevron-left"></span>
	</button>
    <span class="label"><spring:theme code="text.account.order.title.details" text="Order Details" /></span>
</div>

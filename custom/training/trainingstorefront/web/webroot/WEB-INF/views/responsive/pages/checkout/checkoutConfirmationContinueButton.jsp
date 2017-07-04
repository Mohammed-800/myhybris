<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>

<spring:htmlEscape defaultHtmlEscape="true" />

<spring:url value="${continueUrl}" var="continueShoppingUrl" scope="session" htmlEscape="false"/>

<div class="pull-right col-xs-12 col-sm-6 col-md-5 col-lg-4">
	<button class="btn btn-primary btn-block continueShoppingButton" data-continue-shopping-url="${continueShoppingUrl}">
		<spring:theme code="checkout.orderConfirmation.continueShopping" />
	</button>
</div>
<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="order" tagdir="/WEB-INF/tags/responsive/order" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<c:if test="${not empty orderData}">
	<div class="account-orderdetail">
		<div class="account-orderdetail-item-section-footer">
			<order:receivedPromotions order="${orderData}" />
			<order:orderTotalsItem order="${orderData}" />
		</div>
	</div>
</c:if>
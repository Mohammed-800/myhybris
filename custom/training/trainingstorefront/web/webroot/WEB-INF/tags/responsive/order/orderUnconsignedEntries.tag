<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="order" required="true" type="de.hybris.platform.commercefacades.order.data.OrderData" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="order" tagdir="/WEB-INF/tags/responsive/order" %>


<c:forEach items="${order.unconsignedEntries}" var="entry" varStatus="loop">
    <div class="well well-tertiary">
        <div class="well-headline orderPending">
            <spring:theme code="text.account.order.unconsignedEntry.status.pending" />
        </div>

        <c:choose>
            <c:when test="${entry.deliveryPointOfService ne null}">
                <div class="well-content col-sm-12 col-md-9">
                    <order:storeAddressItem deliveryPointOfService="${entry.deliveryPointOfService}" />
                </div>
            </c:when>
            <c:otherwise>
                <div class="well-content col-md-5 order-ship-to">
                    <div class="label-order"><spring:theme code="text.account.order.shipto" text="Ship To" /></div>
                    <div class="value-order"><order:addressItem address="${orderData.deliveryAddress}"/></div>
                </div>
            </c:otherwise>
        </c:choose>
    </div>

    <ul class="product-list">
        <order:orderEntryDetails orderEntry="${entry}" order="${order}" itemIndex="${loop.index}"/>
    </ul>
</c:forEach>


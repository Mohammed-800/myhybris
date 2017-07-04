<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="order" required="true" type="de.hybris.platform.commercefacades.order.data.AbstractOrderData" %>
<%@ attribute name="orderEntry" required="true" type="de.hybris.platform.commercefacades.order.data.OrderEntryData" %>
<%@ attribute name="consignmentEntry" required="false"
              type="de.hybris.platform.commercefacades.order.data.ConsignmentEntryData" %>
<%@ attribute name="itemIndex" required="true" type="java.lang.Integer" %>
<%@ attribute name="targetUrl" required="false" type="java.lang.String" %>

<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<c:url value="${orderEntry.product.url}" var="productUrl"/>
<c:set var="entryStock" value="${orderEntry.product.stock.stockLevelStatus.code}"/>
<li class="product-item">
    <div class="row">
        <div class="col-md-12">
            <div class="thumb">
                <ycommerce:testId code="orderDetail_productThumbnail_link">
                    <a href="${productUrl}">
                        <product:productPrimaryImage product="${orderEntry.product}" format="thumbnail"/>
                    </a>
                </ycommerce:testId>
            </div>

            <div class="details">
                <div class="name">
                    <ycommerce:testId code="orderDetails_productName_link">
                        <a href="${orderEntry.product.purchasable ? productUrl : ''}">${fn:escapeXml(orderEntry.product.name)}</a>
                    </ycommerce:testId>
                </div>
                <div class="itemId">
                    <ycommerce:testId code="orderDetails_productCode">
                        ${fn:escapeXml(orderEntry.product.code)}
                    </ycommerce:testId>
                </div>

                <c:if test="${not empty order.appliedProductPromotions}">
                    <div class="promo">
                        <ul>
                            <c:forEach items="${order.appliedProductPromotions}" var="promotion">
                                <c:set var="displayed" value="false"/>
                                <c:forEach items="${promotion.consumedEntries}" var="consumedEntry">
                                    <c:if test="${not displayed and consumedEntry.orderEntryNumber == orderEntry.entryNumber}">
                                        <c:set var="displayed" value="true"/>
                                        <li>
                                            <ycommerce:testId code="orderDetail_productPromotion_label">
                                                ${promotion.description}
                                            </ycommerce:testId>
                                        </li>
                                    </c:if>
                                </c:forEach>
                            </c:forEach>
                        </ul>
                    </div>
                </c:if>

                <div>
                    <ycommerce:testId code="orderDetail_productStock_label">
                        <c:choose>
                            <c:when test="${orderEntry.product.multidimensional}">
                                <spring:theme code="basket.page.availability"/>: <span class="stock"><spring:theme
                                    code="product.variants.in.stock"/></span>
                            </c:when>
                            <c:when test="${not empty entryStock and entryStock ne 'outOfStock'}">
                                <spring:theme code="basket.page.availability"/>: <span class="stock"><spring:theme
                                    code="product.variants.in.stock"/></span>
                            </c:when>
                            <c:when test="${orderEntry.deliveryPointOfService eq null}">
                                <spring:theme code="basket.page.availability"/>: <span class="stock"><spring:theme
                                    code="product.variants.out.of.stock"/></span>
                            </c:when>
                        </c:choose>
                    </ycommerce:testId>
                </div>

                <div>
                    <spring:theme code="basket.page.itemPrice"/>:
                        <span class="price">
                            <ycommerce:testId code="orderDetails_productItemPrice_label">
                                <c:choose>
                                    <c:when test="${not orderEntry.product.multidimensional or (orderEntry.product.priceRange.minPrice.value eq orderEntry.product.priceRange.maxPrice.value)}">
                                        <format:price priceData="${orderEntry.basePrice}" displayFreeForZero="true"/>
                                    </c:when>
                                    <c:otherwise>
                                        <format:price priceData="${orderEntry.product.priceRange.minPrice}"
                                                      displayFreeForZero="true"/>
                                        -
                                        <format:price priceData="${orderEntry.product.priceRange.maxPrice}"
                                                      displayFreeForZero="true"/>
                                    </c:otherwise>
                                </c:choose>
                            </ycommerce:testId>
                        </span>
                </div>
                <c:forEach items="${orderEntry.product.baseOptions}" var="option">
                    <c:if test="${not empty option.selected and option.selected.url eq orderEntry.product.url}">
                        <c:forEach items="${option.selected.variantOptionQualifiers}" var="selectedOption">
                            <div>
                                <ycommerce:testId code="orderDetail_variantOption_label">
                                    <span>${fn:escapeXml(selectedOption.name)}:</span>
                                    <span>${fn:escapeXml(selectedOption.value)}</span>
                                </ycommerce:testId>
                            </div>
                            <c:set var="entryStock" value="${option.selected.stock.stockLevelStatus.code}"/>
                        </c:forEach>
                    </c:if>
                </c:forEach>
            </div>
        </div>

        <c:set var="showEditableGridClass" value=""/>
        <c:if test="${orderEntry.product.multidimensional}">
            <c:set var="showEditableGridClass"
                   value="with-editable-grid showMultiDGridInOrder updateQuantityProduct-toggle"/>
        </c:if>

        <div class="col-md-12">
            <div class="details ${showEditableGridClass}" data-index="${itemIndex}">
                <div class="qty">
                    <ycommerce:testId code="orderDetails_productQuantity_label">
                        <label><spring:theme code="text.account.order.qty"/>:</label>
                            <span class="qtyValue">
                                <c:choose>
                                    <c:when test="${consignmentEntry ne null }">
                                        ${fn:escapeXml(consignmentEntry.quantity)}
                                    </c:when>
                                    <c:otherwise>
                                        ${fn:escapeXml(orderEntry.quantity)}
                                    </c:otherwise>
                                </c:choose>
                            </span>
                    </ycommerce:testId>

                    <div class="item-price">
                        <ycommerce:testId code="orderDetails_productTotalPrice_label">
                            <format:price priceData="${orderEntry.totalPrice}" displayFreeForZero="true"/>
                        </ycommerce:testId>
                    </div>
                </div>
            </div>
        </div>
    </div>
</li>
<div id="ajaxGrid${itemIndex}" style="display: none" class="order-grid"></div>
<c:if test="${orderEntry.product.multidimensional}">
    <c:forEach items="${orderEntry.entries}" var="currentEntry" varStatus="stat">
        <c:set var="subEntries"
               value="${stat.first ? '' : subEntries}${currentEntry.product.code}:${currentEntry.quantity},"/>
    </c:forEach>

    <div style="display:none" id="grid${itemIndex}" data-sub-entries="${subEntries}"
         data-order-code="${fn:escapeXml(order.code)}" data-target-url="${targetUrl}">
    </div>
</c:if>
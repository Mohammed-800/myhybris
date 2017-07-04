<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="cartData" required="true" type="de.hybris.platform.commercefacades.order.data.CartData" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="form" uri="http://www.springframework.org/tags/form" %>
<%@ taglib prefix="product" tagdir="/WEB-INF/tags/responsive/product" %>
<%@ taglib prefix="storepickup" tagdir="/WEB-INF/tags/responsive/storepickup" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>

<ul class="product-list">
    <c:forEach items="${cartData.entries}" var="entry" varStatus="loop">
        <c:set var="showEditableGridClass" value=""/>
        <c:url value="${entry.product.url}" var="productUrl"/>
    
        <li class="product-item">
            <c:if test="${entry.updateable}" >
                <ycommerce:testId code="cart_product_removeProduct">
                    <c:choose>
                        <c:when test="${not entry.product.multidimensional}" >
                            <button class="btn  remove-item remove-entry-button" id="removeEntry_${loop.index}">
                                <span class="glyphicon glyphicon-remove"></span>
                            </button>
                        </c:when>
                        <c:otherwise>
                            <button class="btn  remove-item submitRemoveProductMultiD" data-index="${loop.index}"  id="removeEntry_${loop.index}">
                                <span class="glyphicon glyphicon-remove"></span>
                            </button>
                        </c:otherwise>
                    </c:choose>
                </ycommerce:testId>
            </c:if>

            <div class="row">
                <div class="col-md-6">
                    <div class="thumb">
                        <a href="${productUrl}"><product:productPrimaryImage product="${entry.product}" format="thumbnail"/></a>
                    </div>
			        
                    <div class="details">                   
                        <ycommerce:testId code="cart_product_name">
                            <a href="${productUrl}"><div class="name">${entry.product.name}</div></a>
                        </ycommerce:testId>
                        <div class="item-sku">${entry.product.code}</div>

                        <c:if test="${ycommerce:doesPotentialPromotionExistForOrderEntry(cartData, entry.entryNumber)}">
	                        <c:forEach items="${cartData.potentialProductPromotions}" var="promotion">
	                            <c:set var="displayed" value="false"/>
	                            <c:forEach items="${promotion.consumedEntries}" var="consumedEntry">
	                                <c:if test="${not displayed && consumedEntry.orderEntryNumber == entry.entryNumber && not empty promotion.description}">
	                                    <c:set var="displayed" value="true"/>
	                                    
	                                        <div class="promo">
		                                         <ycommerce:testId code="cart_potentialPromotion_label">
		                                             ${promotion.description}
		                                         </ycommerce:testId>
	                                        </div>
	                                </c:if>
	                            </c:forEach>
	                        </c:forEach>
                        </c:if>
                        <c:if test="${ycommerce:doesAppliedPromotionExistForOrderEntry(cartData, entry.entryNumber)}">
	                        <c:forEach items="${cartData.appliedProductPromotions}" var="promotion">
	                            <c:set var="displayed" value="false"/>
	                            <c:forEach items="${promotion.consumedEntries}" var="consumedEntry">
	                                <c:if test="${not displayed && consumedEntry.orderEntryNumber == entry.entryNumber}">
	                                    <c:set var="displayed" value="true"/>
	                                    <div class="promo">
	                                        <ycommerce:testId code="cart_appliedPromotion_label">
	                                            ${promotion.description}
	                                        </ycommerce:testId>
	                                    </div>
	                                </c:if>
	                            </c:forEach>
	                        </c:forEach>
                        </c:if>

		                <c:set var="entryStock" value="${entry.product.stock.stockLevelStatus.code}"/>

		                <c:forEach items="${entry.product.baseOptions}" var="option">
		                    <c:if test="${not empty option.selected and option.selected.url eq entry.product.url}">
		                        <c:forEach items="${option.selected.variantOptionQualifiers}" var="selectedOption">
		                            <div>
		                                <strong>${selectedOption.name}:</strong>
		                                <span>${selectedOption.value}</span>
		                            </div>
		                            <c:set var="entryStock" value="${option.selected.stock.stockLevelStatus.code}"/>
		                        </c:forEach>
		                    </c:if>
		                </c:forEach>
                        
                        <div>
                            <c:choose>
                                <c:when test="${not empty entryStock and entryStock ne 'outOfStock' or entry.product.multidimensional}">
                                    <spring:theme code="basket.page.availability"/>: <span class="stock"><spring:theme code="product.variants.in.stock"/></span>
                                </c:when>
                                <c:otherwise>
                                    <spring:theme code="basket.page.availability"/>: <span class="stock"><spring:theme code="product.variants.out.of.stock"/></span>
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div>
						    <spring:theme code="basket.page.itemPrice"/>: 
                            <span class="price">
                                <ins>
                                    <format:price priceData="${entry.basePrice}" displayFreeForZero="true"/>
                                </ins>
                            </span>
                        </div>
                    </div>
                </div>

                <div class="col-md-6 pickup-wrap">
                    <div class="pickup">
                        <c:choose>
                             <c:when test="${entry.product.purchasable}">
                             	<div class="radio-column">
                           			<c:if test="${not empty entryStock and entryStock ne 'outOfStock'}">
                                        <c:if test="${entry.deliveryPointOfService eq null or not entry.product.availableForPickup}">
									   		<label for="pick0_${entry.entryNumber}">
									   		<span class="glyphicon glyphicon-gift text-gray"></span> 
									   		<span class="name"><spring:theme code="basket.page.shipping.ship"/></span>
									   		</label>
							    		</c:if>
									</c:if>
								    <c:if test="${not empty entry.deliveryPointOfService.name}">
                                        <label for="pick1_${entry.entryNumber}"> 
                                            <span class="glyphicon glyphicon-home"></span> 
                                            <span class="name"><spring:theme code="basket.page.shipping.pickup"/></span>
                                        </label>
								    </c:if>
                                </div>                
                                
                                <div class="store-column">
                                    <c:choose>
                                        <c:when test="${entry.product.availableForPickup}">
                                            <c:choose>
                                             <c:when test="${not empty entry.deliveryPointOfService.name}">
                                                <div class="store-name">${entry.deliveryPointOfService.name}</div>
                                             </c:when>
                                             <c:otherwise>
                                                 <div class="store-name"></div>
                                             </c:otherwise>
                                            </c:choose>
                                        </c:when>
                                        <c:otherwise>
                                        </c:otherwise>
                                    </c:choose>
                                </div>
                            </c:when>
                        </c:choose>
                    </div>
                </div>
                <div class="col-md-12">
                    <c:if test="${entry.product.multidimensional}" >
                        <ycommerce:testId code="cart_product_updateQuantity">
                            <%--<a href="#" id="QuantityProductToggle" data-index="${loop.index}" class="showEditableGrid "> > </a>--%>
                            <c:set var="showEditableGridClass" value="with-editable-grid showEditableGrid"/>
                        </ycommerce:testId>
                    </c:if>
                    <div class="details ${showEditableGridClass}" data-index="${loop.index}" data-read-only-multid-grid="${not entry.updateable}">
                        <div class="qty">
                            <c:choose>
                                <c:when test="${not entry.product.multidimensional}" >
                                    <c:url value="/cart/update" var="cartUpdateFormAction" />
                                    <form:form id="updateCartForm${loop.index}" action="${cartUpdateFormAction}" method="post" commandName="updateQuantityForm${entry.entryNumber}"
                                            data-cart='{"cartCode" : "${cartData.code}","productPostPrice":"${entry.basePrice.value}","productName":"${entry.product.name}"}'>
                                        <input type="hidden" name="entryNumber" value="${entry.entryNumber}"/>
                                        <input type="hidden" name="productCode" value="${entry.product.code}"/>
                                        <input type="hidden" name="initialQuantity" value="${entry.quantity}"/>
                                        <ycommerce:testId code="cart_product_quantity">
                                            <form:label cssClass="" path="quantity" for="quantity${entry.entryNumber}"><spring:theme code="basket.page.qty"/>:</form:label>
                                            <form:input cssClass="form-control update-entry-quantity-input" disabled="${not entry.updateable}" type="text" size="1" id="quantity_${loop.index}" path="quantity" />
                                        </ycommerce:testId>
                                    </form:form>
                                </c:when>
                                <c:otherwise>
                                    <c:url value="/cart/updateMultiD" var="cartUpdateMultiDFormAction" />
                                    <form:form id="updateCartForm${loop.index}" action="${cartUpdateMultiDFormAction}" method="post" commandName="updateQuantityForm${loop.index}">
                                        <input type="hidden" name="entryNumber" value="${entry.entryNumber}"/>
                                        <input type="hidden" name="productCode" value="${entry.product.code}"/>
                                        <input type="hidden" name="initialQuantity" value="${entry.quantity}"/>
                                        <label><spring:theme code="basket.page.qty"/>:</label>
                                        <span class="qtyValue"><c:out value="${entry.quantity}" /></span>
                                        <%--<input type="text" value="${entry.quantity}" class="form-control qtyValue" name="quantity" readonly>--%>
                                        <input type="hidden" name="quantity" value="0"/>
                                        <ycommerce:testId code="cart_product_updateQuantity">
                                            <div id="QuantityProduct${loop.index}" class="updateQuantityProduct"></div>
                                        </ycommerce:testId>
                                    </form:form>
                                </c:otherwise>
                            </c:choose>
                            <ycommerce:testId code="cart_totalProductPrice_label">
                                <div class="item-price">
                                    <format:price priceData="${entry.totalPrice}" displayFreeForZero="true"/>
                                </div>
                            </ycommerce:testId>
                        </div>
                    </div>
                </div>
            </div>
        </li>

        <div id="ajaxGrid${loop.index}" class="add-to-cart-order-form-wrap cartOrderGridFormWrapper" style="display: none"></div>
        <c:if test="${entry.product.multidimensional}" >
                <c:forEach items="${entry.entries}" var="currentEntry" varStatus="stat">
                    <c:set var="subEntries" value="${stat.first ? '' : subEntries}${currentEntry.product.code}:${currentEntry.quantity},"/>
                </c:forEach>

                <div style="display:none" id="grid${loop.index}" data-sub-entries="${subEntries}"> </div>
        </c:if>
    </c:forEach>
</ul>

<product:productOrderFormJQueryTemplates />
<storepickup:pickupStorePopup />

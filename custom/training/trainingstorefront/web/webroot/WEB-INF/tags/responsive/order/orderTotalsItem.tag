<%@ tag body-content="empty" trimDirectiveWhitespaces="true" %>
<%@ attribute name="order" required="true" type="de.hybris.platform.commercefacades.order.data.AbstractOrderData" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags" %>
<%@ taglib prefix="ycommerce" uri="http://hybris.com/tld/ycommercetags" %>
<%@ taglib prefix="format" tagdir="/WEB-INF/tags/shared/format" %>

<%@ attribute name="containerCSS" required="false" type="java.lang.String" %>

<div class="col-sm-6 col-sm-offset-6 col-md-5 col-md-offset-7 col-lg-4 col-lg-offset-8">
    <div class="orderTotal">
        <div class="subtotal row">
            <div class="col-xs-6"><spring:theme code="text.account.order.subtotal"/></div>
            <div class="col-xs-6 text-right">
                <ycommerce:testId code="orderTotal_subTotalWithDiscounts_label">
                    <format:price priceData="${order.subTotalWithDiscounts}"/>
                </ycommerce:testId>
            </div>
        </div>
        <div class="shipping row">
            <div class="col-xs-6"><spring:theme code="text.account.order.shipping"/></div>
            <div class="col-xs-6 text-right">
                <ycommerce:testId code="orderTotal_devlieryCost_label">
                    <format:price priceData="${order.deliveryCost}" displayFreeForZero="true"/>
                </ycommerce:testId>
            </div>
        </div>
        <c:if test="${order.net}">
            <div class="tax row">
                <div class="col-xs-6"><spring:theme code="text.account.order.netTax"/></div>
                <div class="col-xs-6 text-right">
                    <format:price priceData="${order.totalTax}"/>
                </div>
            </div>
        </c:if>
        <div class="totals row">
            <div class="col-xs-6">
                <spring:theme code="text.account.order.orderTotals"/>
            </div>

            <c:choose>
                <c:when test="${order.net}">
                    <div class="col-xs-6 text-right">
                        <format:price priceData="${order.totalPriceWithTax}"/>
                    </div>
                </c:when>
                <c:otherwise>
                    <div class="col-xs-6 text-right">
                        <ycommerce:testId code="orderTotal_totalPrice_label">
                            <format:price priceData="${order.totalPrice}"/>
                        </ycommerce:testId>
                    </div>
                </c:otherwise>
            </c:choose>
        </div>
    </div>
</div>


<c:if test="${order.totalDiscounts.value > 0}">
    <div class="account-orderdetail-orderTotalDiscount-section">
        <c:if test="${not order.net}">
            <div class="order-total-taxes">
                <ycommerce:testId code="orderTotal_includesTax_label">
                    <spring:theme code="text.account.order.total.includesTax" argumentSeparator=";"
                                  arguments="${order.totalTax.formattedValue}"/>
                </ycommerce:testId>
            </div>
            <br/>
        </c:if>
        <ycommerce:testId code="order_totalDiscount_label">
            <div class="order-savings">
                <spring:theme code="text.account.order.totalSavings" argumentSeparator=";"
                              arguments="${order.totalDiscounts.formattedValue}"/>
            </div>
        </ycommerce:testId>
    </div>
</c:if>

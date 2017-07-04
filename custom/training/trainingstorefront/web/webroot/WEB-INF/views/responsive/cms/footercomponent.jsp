<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>
<%@ taglib prefix="footer" tagdir="/WEB-INF/tags/responsive/common/footer"  %>

<div class="container">
    <div class="footer-left col-xs-12 col-sm-12 col-md-9 col-lg-9">
         <div class="row">
            <c:forEach items="${navigationNodes}" var="node">
                <c:if test="${node.visible}">
                    <c:forEach items="${node.links}" step="${component.wrapAfter}"
                               varStatus="i">

                        <div class="links col-sm-12 col-sm-4 col-md-4">
                            <c:if test="${component.wrapAfter > i.index}">
                                <div class="title">${node.title}</div>
                            </c:if>
                            <ul>
                                <c:forEach items="${node.links}" var="childlink"
                                           begin="${i.index}" end="${i.index + component.wrapAfter - 1}">
                                    <cms:component component="${childlink}"
                                                   evaluateRestriction="true" element="li" />
                                </c:forEach>
                            </ul>
                        </div>
                    </c:forEach>
                </c:if>
            </c:forEach>
        </div>
    </div>
    <div class="footer-right col-xs-12 col-sm-12 col-md-3 col-lg-3">
        <div class="row">
            <div class="col-md-12 col-sm-12 col-xs-12">
                <c:if test="${showLanguageCurrency}">
                    <div class="col-xs-12 col-sm-5 col-md-12 pull-right footer-dropdown">
                        <footer:languageSelector languages="${languages}"
                                                 currentLanguage="${currentLanguage}" />
                        <footer:currencySelector currencies="${currencies}"
                                                 currentCurrency="${currentCurrency}" />
                    </div>
                </c:if>
            </div>
        </div>
    </div>
</div>

<div class="copyright">
	<div class="container">${notice}</div>
</div>
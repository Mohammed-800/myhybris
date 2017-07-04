<%@ page trimDirectiveWhitespaces="true" %>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/responsive/template" %>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags" %>
<%@ taglib prefix="common" tagdir="/WEB-INF/tags/responsive/common" %>
<%@ taglib prefix="storepickup" tagdir="/WEB-INF/tags/responsive/storepickup" %>

<template:page pageTitle="${pageTitle}">
	<div class="row">
		<cms:pageSlot position="Section1" var="feature">
			<cms:component component="${feature}" element="div" class="col-xs-12 yComponentWrapper"/>
		</cms:pageSlot>
	</div>
	
	<div class="row">
		<div class="col-xs-3">
			<div class="row">
				<cms:pageSlot position="ProductLeftRefinements" var="feature">
					<cms:component component="${feature}" element="div" class="col-xs-12 yComponentWrapper"/>
				</cms:pageSlot>
			</div>
		</div>
		<div class="col-sm-12 col-md-9">
			<div class="row">
				<cms:pageSlot position="ProductGridSlot" var="feature">
					<cms:component component="${feature}" element="div" class="col-xs-12 product-list-wrapper yComponentWrapper"/>
				</cms:pageSlot>
			</div>
		</div>

	</div>
	<storepickup:pickupStorePopup />
</template:page>

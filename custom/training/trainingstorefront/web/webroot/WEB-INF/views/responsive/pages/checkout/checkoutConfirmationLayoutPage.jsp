<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/responsive/template"%>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>

<template:page pageTitle="${pageTitle}">
	<div class="row">
		<cms:pageSlot position="SideContent" var="feature" class="accountPageSideContent">
			<cms:component component="${feature}" />
		</cms:pageSlot>
		<div class="col-md-12 col-lg-12">
			<cms:pageSlot position="TopContent" var="feature" element="div" class="accountPageTopContent">
				<cms:component component="${feature}" />
			</cms:pageSlot>
			<div class="account-section">
				<cms:pageSlot position="BodyContent" var="feature" element="div" class="account-section-content checkout-confirmation-content">
					<cms:component component="${feature}" />
				</cms:pageSlot>
			</div>
			<cms:pageSlot position="BottomContent" var="feature" element="div" class="accountPageBottomContent">
				<cms:component component="${feature}" />
			</cms:pageSlot>
		</div>
	</div>
</template:page>
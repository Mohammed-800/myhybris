<%@ page trimDirectiveWhitespaces="true"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="template" tagdir="/WEB-INF/tags/responsive/template"%>
<%@ taglib prefix="theme" tagdir="/WEB-INF/tags/shared/theme" %>
<%@ taglib prefix="cms" uri="http://hybris.com/tld/cmstags"%>
<%@ taglib prefix="spring" uri="http://www.springframework.org/tags"%>

<template:page pageTitle="${pageTitle}">

	<c:url value="/" var="homePageUrl" />
	<div class="row">
		<div class="col-xs-12">
			<cms:pageSlot position="SideContent" var="feature" element="div" class="span-6 side-content-slot cms_disp-img_slot">
				<cms:component component="${feature}" element="div" class="no-space yComponentWrapper"/>
			</cms:pageSlot>
		</div>
	</div>
	<div class="search-empty">
		<div class="headline">
			<spring:theme code="search.no.results" arguments="${searchPageData.freeTextSearch}"/> 
		</div>
		<a class="btn btn-default  js-shopping-button" href="${homePageUrl}">
			<spring:theme code="general.continue.shopping" text="Continue Shopping"/>
		</a>
	</div>
	<div class="row">
		<div class="col-xs-12">
			<cms:pageSlot position="MiddleContent" var="comp" element="div" class="searchEmptyPageMiddle">
				<cms:component component="${comp}" element="div" class="no-space yComponentWrapper"/>
			</cms:pageSlot>
		</div>
	</div>


	<div class="row">
		<div class="col-xs-12">
			<cms:pageSlot position="BottomContent" var="comp" element="div" class="searchEmptyPageBottom">
				<cms:component component="${comp}" element="div" class="no-space yComponentWrapper"/>
			</cms:pageSlot>
		</div>
	</div>
	
</template:page>
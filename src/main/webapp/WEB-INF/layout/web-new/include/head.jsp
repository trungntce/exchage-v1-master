<%--
  Created by IntelliJ IDEA.
  User: ntt.dev
  The template head common.
--%>

<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page isELIgnored="false" %>
<%@ include file="/WEB-INF/layout/web/tags/commonTags.jspf"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="security" uri="http://www.springframework.org/security/tags" %>

<c:set var="req" value="${pageContext.request}" />
<c:set var="baseUrl">${req.scheme}://${req.serverName}:${req.serverPort}</c:set>
<c:set var="_ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath }" scope="application"/>
<c:set var="_lang" value="${pageContext.response.locale}" scope="session"/>
<c:set var="_translationOption" value="Y" scope="session"/>
<c:set var="_userInfo" value="${sessionScope.user_info}" scope="session"/>

<!DOCTYPE html>
<html lang="en">
<head>
	<meta charset="UTF-8">
	<meta name="viewport" content="width=device-width, initial-scale=1.0">
	<meta name="apple-mobile-web-app-capable" content="yes"/>
	<meta name="apple-mobile-web-app-status-bar-style" content="black-translucent">
	<meta name="description" content="가상자산 투자, 체인링크, 실시간 거래">
	<meta name="keywords" content="heraMarket, heracoin"/>
	<meta property="og:locale" content="ko_KR">
	<meta property="og:url" content="">
	<meta property="og:title" content="No.1 가상 자산 투자, 헤라 코인 거래소">
	<meta property="og:type" content="website">
	<meta property="og:image" content="${_ctx}/resources/skinWeb/main.jpg">
	<meta property="og:description" content="가상자산 투자, 체인링크, 실시간 거래">
	<meta property="og:site_name" content="No.1 가상 자산 투자, 헤라 코인 거래소">
	<meta name="twitter:card" content="summary">
	<meta name="twitter:description" content="가상자산 투자, 체인링크, 실시간 거래">
	<meta name="twitter:title" content="No.1 가상 자산 투자, 헤라 코인 거래소">
	<meta name="format-detection" content="telephone=no">
	<link rel="shortcut icon" href="${_ctx}/resources/skinWeb/mobile/favicon.ico" type="image/x-icon">
	<link rel="icon" href="${_ctx}/resources/skinWeb/mobile/favicon.ico" type="image/x-icon">
	<link rel="apple-touch-icon" sizes="57x57" href="${_ctx}/resources/skinWeb/mobile/apple-icon-57x57.png">
	<link rel="apple-touch-icon" sizes="60x60" href="${_ctx}/resources/skinWeb/mobile/apple-icon-60x60.png">
	<link rel="apple-touch-icon" sizes="72x72" href="${_ctx}/resources/skinWeb/mobile/apple-icon-72x72.png">
	<link rel="apple-touch-icon" sizes="76x76" href="${_ctx}/resources/skinWeb/mobile/apple-icon-76x76.png">
	<link rel="apple-touch-icon" sizes="114x114" href="${_ctx}/resources/skinWeb/mobile/apple-icon-114x114.png">
	<link rel="apple-touch-icon" sizes="120x120" href="${_ctx}/resources/skinWeb/mobile/apple-icon-120x120.png">
	<link rel="apple-touch-icon" sizes="144x144" href="${_ctx}/resources/skinWeb/mobile/apple-icon-144x144.png">
	<link rel="apple-touch-icon" sizes="152x152" href="${_ctx}/resources/skinWeb/mobile/apple-icon-152x152.png">
	<link rel="apple-touch-icon" sizes="180x180" href="${_ctx}/resources/skinWeb/mobile/apple-icon-180x180.png">
	<link rel="icon" type="image/png" sizes="192x192" href="${_ctx}/resources/skinWeb/mobile/android-icon-192x192.png">
	<link rel="icon" type="image/png" sizes="32x32" href="${_ctx}/resources/skinWeb/mobile/favicon-32x32.png">
	<link rel="icon" type="image/png" sizes="96x96" href="${_ctx}/resources/skinWeb/mobile/favicon-96x96.png">
	<link rel="icon" type="image/png" sizes="16x16" href="${_ctx}/resources/skinWeb/mobile/favicon-16x16.png">
	<link rel="manifest" href="${_ctx}/resources/skinWeb/manifest.json">
	<meta name="msapplication-TileColor" content="#ffffff">
	<meta name="msapplication-TileImage" content="${_ctx}/resources/skinWeb/mobile/ms-icon-144x144.png">
	<meta name="theme-color" content="#ffffff">
	<title>No.1 가상 자산 투자, 헤라 코인 거래소</title>
	
	<link rel="stylesheet" href="${_ctx}/resources/skinWeb/css/bootstrap.min.css">
	<link rel="stylesheet" href="${_ctx}/resources/skinWeb/css/base.css">
	<link rel="stylesheet" href="${_ctx}/resources/skinWeb/css/bootstrap-icons.css">
	<link rel="stylesheet" href="${_ctx}/resources/skinWeb/css/style.css">
	<link rel="stylesheet" href="${_ctx}/resources/skinWeb/css/style1_mobile.css">
	<!-- chat -->
	<link rel="stylesheet" href="${_ctx}/resources/skinWeb/css/chat-style.css">

	<!-- link old style -->
	<link rel="stylesheet" href="${_ctx}/resources/skinWeb/css/style1.css">
	<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.0/jquery.min.js"></script>
	<script src="${_ctx}/resources/skinWeb/js/layout.js"></script>


	<title><spring:message code="head.title"/></title>	
	<link rel="stylesheet" href="${_ctx}/resources/css/validator.css">
	<%@ include file="/WEB-INF/layout/web/assets/js.jspf"%>
  <script type="text/javascript" src="https://cdnjs.cloudflare.com/ajax/libs/jquery-cookie/1.4.1/jquery.cookie.min.js"></script>
</head>
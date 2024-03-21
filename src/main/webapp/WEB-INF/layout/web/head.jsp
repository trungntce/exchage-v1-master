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
<!DOCTYPE HTML>
<head>
<meta charset="UTF-8">
	<meta http-equiv="Content-Type" content="text/html; charset=utf-8">
	<meta name="naver-site-verification" content="c63e776334b0da933f9bd66483d594fa6543feb4">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<meta name="viewport" content="width=device-width, initial-scale=1, maximum-scale=1">
	<meta name="description" content="가상자산 투자, 체인링크, 실시간 거래">
	<meta property="og:locale" content="ko_KR">
	<meta property="og:type" content="website">
	<meta property="og:title" content="No.1 가상 자산 투자, 헤라 코인 거래소">
	<!-- <meta property="og:description" content="가상자산 투자, 체인링크, 실시간 거래"> -->
	<meta property="og:url" content="https://www.coinvesting.com">
	<meta property="og:site_name" content="No.1 가상 자산 투자, 헤라 코인 거래소">
	<meta name="twitter:card" content="summary">
	<meta name="twitter:description" content="가상자산 투자, 체인링크, 실시간 거래">
	<!-- <meta name="twitter:title" content="No.1 가상 자산 투자, 헤라 코인 거래소"> -->
	<meta name="format-detection" content="telephone=no">

	<title><spring:message code="head.title"/></title>
	<%@ include file="/WEB-INF/layout/web/assets/css.jspf"%>
	<%@ include file="/WEB-INF/layout/web/assets/js.jspf"%>
	<%@ include file="/WEB-INF/layout/web/tags/commonJS.jspf"%>

</head>

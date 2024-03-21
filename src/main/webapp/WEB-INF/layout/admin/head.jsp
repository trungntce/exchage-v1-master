<%@ page  contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ include file="/WEB-INF/layout/common/tags/commonTags.jspf"%>

<c:set var="_ctx" value="${pageContext.request.contextPath == '/' ? '' : pageContext.request.contextPath}" scope="session"/>

<head>
  <title><spring:message code="admin.head.title"/></title>
  <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
  <meta http-equiv="X-UA-Compatible" content="IE=edge">
  <meta content="width=device-width, initial-scale=1.0, maximum-scale=1.0, user-scalable=no" name="viewport" />

  <%@ include file="/WEB-INF/layout/admin/tags/adminCSS.jspf"%>
  <%@ include file="/WEB-INF/layout/admin/tags/adminJS.jspf"%>
  <%@ include file="/WEB-INF/layout/admin/tags/tableResponsive.jspf"%>
</head>
<%--
  Created by IntelliJ IDEA.
  User: ntt.dev
  The home page
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- head -->
<%@ include file="/WEB-INF/layout/web-new/include/head.jsp"%>
<link href='${_ctx}/resources/js/plugins/springfox-swagger/webjars/springfox-swagger-ui/css/typography.css' media='screen' rel='stylesheet' type='text/css'/>
<link href='${_ctx}/resources/js/plugins/springfox-swagger/webjars/springfox-swagger-ui/css/reset.css' media='screen' rel='stylesheet' type='text/css'/>
<link href='${_ctx}/resources/js/plugins/springfox-swagger/webjars/springfox-swagger-ui/css/screen.css' media='screen' rel='stylesheet' type='text/css'/>
<link href='${_ctx}/resources/js/plugins/springfox-swagger/webjars/springfox-swagger-ui/css/reset.css' media='print' rel='stylesheet' type='text/css'/>
<link href='${_ctx}/resources/js/plugins/springfox-swagger/webjars/springfox-swagger-ui/css/print.css' media='print' rel='stylesheet' type='text/css'/>
<script src='${_ctx}/resources/js/plugins/springfox-swagger/webjars/springfox-swagger-ui/lib/jquery-1.8.0.min.js' type='text/javascript'></script>
<script src='${_ctx}/resources/js/plugins/springfox-swagger/webjars/springfox-swagger-ui/lib/jquery.slideto.min.js' type='text/javascript'></script>
<script src='${_ctx}/resources/js/plugins/springfox-swagger/webjars/springfox-swagger-ui/lib/jquery.wiggle.min.js' type='text/javascript'></script>
<script src='${_ctx}/resources/js/plugins/springfox-swagger/webjars/springfox-swagger-ui/lib/jquery.ba-bbq.min.js' type='text/javascript'></script>
<script src='${_ctx}/resources/js/plugins/springfox-swagger/webjars/springfox-swagger-ui/lib/handlebars-2.0.0.js' type='text/javascript'></script>
<script src='${_ctx}/resources/js/plugins/springfox-swagger/webjars/springfox-swagger-ui/lib/underscore-min.js' type='text/javascript'></script>
<script src='${_ctx}/resources/js/plugins/springfox-swagger/webjars/springfox-swagger-ui/lib/backbone-min.js' type='text/javascript'></script>
<script src='${_ctx}/resources/js/plugins/springfox-swagger/webjars/springfox-swagger-ui/swagger-ui.min.js' type='text/javascript'></script>
<script src='${_ctx}/resources/js/plugins/springfox-swagger/webjars/springfox-swagger-ui/lib/highlight.7.3.pack.js' type='text/javascript'></script>
<script src='${_ctx}/resources/js/plugins/springfox-swagger/webjars/springfox-swagger-ui/lib/jsoneditor.min.js' type='text/javascript'></script>
<script src='${_ctx}/resources/js/plugins/springfox-swagger/webjars/springfox-swagger-ui/lib/marked.js' type='text/javascript'></script>
<script src='${_ctx}/resources/js/plugins/springfox-swagger/webjars/springfox-swagger-ui/lib/swagger-oauth.js' type='text/javascript'></script>
<script src='${_ctx}/resources/js/plugins/springfox-swagger/webjars/springfox-swagger-ui/springfox.js' type='text/javascript'></script>

<script src="${_ctx}/resources/js/plugins/springfox-swagger/webjars/springfox-swagger-ui/lang/translator.js" type="text/javascript"></script>
<script src="${_ctx}/resources/js/plugins/springfox-swagger/webjars/springfox-swagger-ui/lang/${_lang}.js" type="text/javascript"></script>
<!-- #head -->

<body class="pace-done">
	<div class="wrapper">
		<section class="top-banner">
			<div class="top-banner__inner">
				<div class="top-banner__hera-app-link">
					<div class="img-box"><img src="${_ctx}/resources/skinWeb/images/simbol2.png" alt=""></div>
					<div class="txt-box">
						<b>HERA APP DOWNLOAD</b>
						<p>Secure, fast and elegant.</p>
					</div>
					<button class="top-banner__hera-app-link__download-btn">
						<i class="ci ci-download"></i>
					</button>
				</div>
				<button class="top-banner__close-btn" type="button"><i class="bi bi-x-lg"></i></button>
			</div>
		</section>

		<!-- header -->
		<%@ include file="/WEB-INF/layout/web-new/include/header.jsp"%>
		<!-- #header -->
	  <section class="swagger-section">
		  <form id='api_selector' style="display: none;">
		    <div class='input'>
		      <select id="select_baseUrl" name="select_baseUrl"/>
		    </div>
		    <div class='input'><input placeholder="http://example.com/api" id="input_baseUrl" name="baseUrl" type="text"/>
		    </div>
		    <div class='input'><input placeholder="api_key" id="input_apiKey" name="apiKey" type="text"/></div>
		    <div class='input'><a id="explore" href="#" data-sw-translate>Explore</a></div>
		  </form>

		  <div id="message-bar" class="swagger-ui-wrap" data-sw-translate>&nbsp;</div>
		  <div id="swagger-ui-container" class="swagger-ui-wrap"></div>
	  </section>

		<!-- footer -->
		<%@ include file="/WEB-INF/layout/web-new/include/footer.jsp"%>
		<!-- #footer -->

	</div>
</body>
</html>
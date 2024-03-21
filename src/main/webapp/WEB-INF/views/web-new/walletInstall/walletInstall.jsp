
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- head -->
<%@ include file="/WEB-INF/layout/web-new/include/head.jsp"%>
<!-- #head -->
<body class="pace-done">
<!-- Main -->
<section class="wrap element-main-top">
        <!-- header -->
          <%@ include file="/WEB-INF/layout/web-new/include/header.jsp"%>
        <!-- #header -->
    <section class="dim"></section>


    <section class="container">
        <article class="wallet-info-wrap">
            <div class="wallet-info__visual">
                <div class="inner">
                    <div class="wallet-info__visual__logo"><img src="${_ctx}/resources/skinWeb/images/wallet_logo_w.png" alt="HERA COIN WALLET"></div>
                    <div class="wallet-info__visual__txt-box"><b><spring:message code="page.install.title"/></b></div>
                    <div class="wallet-info__visual__cta">
                        <p>Download now!</p>
                        <div class="flex-box">
                            <button type="button" onclick="javascript:download('apple');" class="btn btn-light"><i class="ci ci-store-apple"></i><spring:message code="page.install.button.apple.store"/></button>
                            <button type="button" onclick="javascript:download('android');" class="btn btn-light"><i class="ci ci-store-google"></i><spring:message code="page.install.button.google.play"/></button>
                            <button type="button" onclick="javascript:download('android_apk');" class="btn btn-light"><i class="ci ci-store-android"></i><spring:message code="page.install.button.android.apk"/></button>
                        </div>
                    </div>
                    <div class="wallet-info__visual__img-box">
                        <div class="phone"></div>
                        <div class="hand"></div>
                    </div>
                </div>
            </div>
            <div class="article-inner">
                <div class="wallet-info__feature--1">
                    <div class="txt-box">
                        <h2><spring:message code="page.install.first.block.title"/></h2>
                        <p>
                            <spring:message code="page.install.first.block.body"/>
                       </p>

                    </div>
                    <div class="img-box">
                        <img src="${_ctx}/resources/skinWeb/images/sample/screen_03.png" alt="">
                        <img src="${_ctx}/resources/skinWeb/images/sample/screen_03.png" alt="">
                        <img src="${_ctx}/resources/skinWeb/mages/sample/screen_03.png" alt="">
                    </div>
                </div>
                <div class="wallet-info__feature--2">
                    <div class="txt-box">
                        <h2><spring:message code="page.install.second.block.title"/></h2>
                        <p>
                            <spring:message code="page.install.second.block.body"/>
                        </p>
                    </div>
                    <div class="img-box">
                        <img src="${_ctx}/resources/skinWeb/images/wallet_info_01.png" alt="">
                    </div>
                </div>
                <div class="wallet-info__feature--3">
                    <div class="txt-box">
                        <h2><spring:message code="page.install.third.block.title"/></h2>
                        <p>
                            <spring:message code="page.install.third.block.body"/>
                        </p>
                    </div>
                    <div class="img-box">
                        <img src="${_ctx}/resources/skinWeb/images/wallet_info_02.png" alt="">
                    </div>
                </div>
                <div class="wallet-info__link">
                    <div class="wallet-info__link__app-icon"></div>
                    <img src="${_ctx}/resources/skinWeb/images/wallet_logo_p.png" alt="" class="wallet-logo">
                    <div class="flex-box">
                        <button type="button" onclick="javascript:download('apple');" class="btn btn-light"><i class="ci ci-store-apple"></i><spring:message code="page.install.button.apple.store"/></button>
                        <button type="button" onclick="javascript:download('android');" class="btn btn-light"><i class="ci ci-store-google"></i><spring:message code="page.install.button.google.play"/></button>
                        <button type="button" onclick="javascript:download('android_apk');" class="btn btn-light"><i class="ci ci-store-android"></i><spring:message code="page.install.button.android.apk"/></button>
                    </div>
                </div>

            </div>
        </article>
    </section>
</section>
<!-- * Main -->
<script>
$(function(){

});
function download(target){
    switch (target){
        case "apple" :
            alert('Not Support Apple');
            break;
        case "android" :
            alert('Not Yet Register Google Play');
            break;
        case "android_apk" :            
            event.preventDefault();
            window.location = '${_ctx}/resources/apk/android/app-debug.apk';
            break;
    }
}
</script>
<!-- footer -->
    <%@ include file="/WEB-INF/layout/web-new/include/footer.jsp"%>
<!-- #footer -->
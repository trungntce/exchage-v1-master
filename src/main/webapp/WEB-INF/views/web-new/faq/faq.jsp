<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- head -->
<%@ include file="/WEB-INF/layout/web-new/include/head.jsp"%>
<!-- #head -->
<section class="wrap element-main-top">
    <!-- header -->
     <%@ include file="/WEB-INF/layout/web-new/include/header.jsp"%>
   <!-- #header -->

    <section class="dim"></section>

    <section class="container">
        <article class="faq-wrap">
            <div class="article-inner">
                <div class="faq__sidebar">
                    <ul class="dev_faq__sidebar">
                        <c:forEach var="list" items="${boardTitleList}" varStatus="loop">
                        <li class="dev_tap"><a href="/faq?tap=${list.sort}">${list.title}</a></li>
                        </c:forEach>
                    </ul>
                </div>
                <div class="main-content dev_tap0 d-none">
                    <div class="faq__head">
                        <div class="txt-box">
                            <h3><spring:message code="page.faq.main.0.main.title"/></h3>
                            <p><spring:message code="page.faq.main.0.main.subtitle"/></p>
                            <div class="search-box">
                                <form name="searchForm" id="searchForm" method="get" action="/faq">
                                    <input type="hidden" name="searchType" id="searchType" value="TITLE">
                                    <input type="hidden" name="tap" id="tap" value="0">
                                    <input type="text" name="keyword" id="keyword" class="form-control" placeholder="<spring:message code="page.faq.main.0.main.search"/>">
                                    <button type="button" onclick="javascript:search();"><i class="bi bi-search"></i></button>
                                </form>
                            </div>
                        </div>
                        <div class="img-box">
                            <img src="images/faq_img_01.jpg" alt="">
                        </div>
                    </div>
                    <div class="faq__cont">
                        <c:set var="i" value="0"/>
                        <c:set var="icon" value="${['bi-binoculars','bi-person-circle','bi-arrow-left-right','bi-cash-stack','bi-arrow-left-right','bi-cash-stack']}" scope="application" />
                        <c:forEach var="list" items="${boardTitleList}" varStatus="loop">
                        <c:if test="${list.sort != 0}">
                        <dl class="w50">
                            <dt><i class="bi ${icon[i]}"></i>${list.title}</dt>
                            <dd>
                                <ul>
                                    <c:set var="j" value="0"/>
                                    <c:forEach var="sublist" items="${boardList}" varStatus="subloop">
                                        <c:if test="${list.sort == sublist.boardKind}">
                                        <li><a href="/faq?tap=${sublist.boardKind}&menu=${sublist.sort-1}">${sublist.title}</a></li>
                                        <c:set var="j" value="${j+1}"/>
                                        </c:if>
                                    </c:forEach>
                                    <c:if test="${j==0}">
                                        <li><spring:message code="common.no_data.title"/></li>
                                    </c:if>
                                </ul>
                            </dd>
                        </dl>
                        <c:set var="i" value="${i+1}"/>
                        </c:if>
                        </c:forEach>
                    </div>
                </div>
               <c:forEach var="list" items="${boardTitleList}" varStatus="loop">
               <c:if test="${list.sort != 0}">
                <div class="main-content dev_tap${list.sort} d-none">
                    <div class="faq__head">
                        <div class="txt-box">
                            <h3>${list.title}</h3>
                        </div>
                    </div>
                    <div class="faq__cont">
                        <dl class="faq__accordion-list">
                            <c:forEach var="sublist" items="${boardList}" varStatus="subloop">
                                <c:if test="${list.sort == sublist.boardKind}">
                                    <dt><b><span class="text-primary">${sublist.sort}</span>${sublist.title}</b><i class="bi bi-chevron-down"></i></dt>
                                    <dd>
                                        <ul>
                                            <li>
                                                <p>
                                                    ${sublist.contents}
                                                </p>
                                            </li>
                                        </ul>
                                    </dd>
                                </c:if>
                            </c:forEach>
                        </dl>
                    </div>
                </div>
                </c:if>
                </c:forEach>
            </div>
        </article>
    </section>
</section>
<script>
$(document).ready(function(){

    const URLSearch = new URLSearchParams(location.search);
    let tap = (URLSearch.get("tap")) ? URLSearch.get("tap") : 0;
    let menu = (URLSearch.get("menu")) ? URLSearch.get("menu") : 0;;
    $(".dev_tap"+tap).find('.faq__accordion-list dt').eq(menu).addClass('is-active').next('dd').slideDown(menu);

    $('.faq__cont .faq__accordion-list dt').click(function(){
        $(this).toggleClass('is-active').next('dd').stop().slideToggle();
    });

    $(".dev_tap").each(function(index, item){
        $(this).removeClass("is-current");
        if(!$(".dev_tap"+index).hasClass("d-none")){
            $(".dev_tap"+index).addClass("d-none");
        }
        if(tap == index){
            $(".dev_tap"+index).removeClass("d-none");
            $(this).addClass("is-current");
        }
    });
});

function search(){
    $("#searchForm").submit();
}
</script>
<!-- * Main -->
    <!-- footer -->
      <%@ include file="/WEB-INF/layout/web-new/include/footer.jsp"%>
    <!-- #footer -->
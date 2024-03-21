<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- head -->
<%@ include file="/WEB-INF/layout/web-new/include/head.jsp"%>
<!-- #head -->
<!-- Main -->
<section class="wrap element-main-top">
    <!-- header -->
    <%@ include file="/WEB-INF/layout/web-new/include/header.jsp"%>
    <!-- #header -->
    <section class="dim"></section>


    <section class="container">
        <article class="gallery-view-wrap">
            <div class="article-inner">
                <div class="btn-box">
                    <button class="btn btn-outline-primary goListBtn" type="button"><i class="bi bi-arrow-left-short me-2"></i><spring:message code="common.button.goList.title"/></button>
                </div>
                <div class="gallery-view__head">
                    <div class="txt-box">
                        <h3>${boardDTO.title}</h3>
                        <p class="date"><fmt:formatDate value="${boardDTO.regDate}" pattern="yyyy-MM-dd HH:mm:ss" />
                        </p>
                    </div>
                </div>
                <div class="gallery-view__cont">
                    <p class="text-center mb-4"><img src="${_ctx}${boardDTO.imgSrc}" alt=""></p>
                    <p class="text-center mb-4">${boardDTO.contents}</p>

                </div>
                <div class="btn-box">
                    <button type="button" class="btn btn-outline-primary goListBtn"><i class="bi bi-arrow-left-short me-2"></i><spring:message code="common.button.goList.title"/></button>
                    <div class="right">
                        <c:choose>
                            <c:when test="${boardDTO.prevPage != null}">
                                <button type="button" class="btn btn-primary" onclick="javascript:pageMove('${boardDTO.prevPage}')"><spring:message code="common.button.goList.prev.title"/></button>
                            </c:when>
                            <c:otherwise>
                                <button type="button" class="btn btn-primary" disabled><spring:message code="common.button.goList.prev.title"/></button>
                            </c:otherwise>
                        </c:choose>
                        <c:choose>
                            <c:when test="${boardDTO.nextPage != null}">
                                <button type="button" class="btn btn-primary" onclick="javascript:pageMove('${boardDTO.nextPage}')"><spring:message code="common.button.goList.next.title"/></button>
                            </c:when>
                            <c:otherwise>
                                <button type="button" class="btn btn-primary" disabled><spring:message code="common.button.goList.next.title"/></button>
                            </c:otherwise>
                        </c:choose>
                    </div>
                </div>
            </div>
        </article>
    </section>
</section>
<script>
$(function(){
    $(".goListBtn").click(function(){
        location.href="/information";
    });
});

function pageMove(board_id){
    location.href="/information/detail?boardId="+board_id;
}
</script>
<!-- * Main -->
<!-- footer -->
<%@ include file="/WEB-INF/layout/web-new/include/footer.jsp"%>
<!-- #footer -->
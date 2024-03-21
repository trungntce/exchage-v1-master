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
        <article class="gallery-wrap">
            <div class="article-inner">
                <div class="gallery__head">
                    <div class="txt-box">
                        <h3><spring:message code="page.information.title"/></h3>
                        <p><spring:message code="page.information.sub.title"/></p>
                    </div>
                </div>
                <div class="gallery__cont">
                    <div class="row mb-5">
                        <c:forEach var="list" items="${boardList}">
                            <div class="col-sm-4">
                                <div class="card">
                                    <a href="/information/detail?boardId=${list.boardId}">
										<span class="card-img-top-box card-img-top-box--5x3">
											<img src="${_ctx}${list.imgSrc}">
										</span>
                                        <div class="card-body">
                                            <h5 class="card-title">${list.title}</h5>
                                            <p class="card-text">${list.subTitle}</p>
                                            <p class="card-date"><fmt:formatDate value="${list.regDate}" pattern="yyyy-MM-dd HH:mm:ss" /></p>
                                        </div>
                                    </a>
                                </div>
                            </div>
                        </c:forEach>
                    </div>

                    <pg:webpaging page="${search}" script="goBuyPage"/>

                    <form name="searchForm" id="searchForm" method="get" action="/information">
                    <div class="board-search">
                        <select name="searchType" id="searchType" class="form-select">
                            <option value="TITLE"><spring:message code="page.information.search.title.title"/></option>
                            <option value="CONTENTS"><spring:message code="page.information.search.contents.title"/></option>
                        </select>
                        <input name="keyword" id="keyword" type="text" class="form-control" placeholder="<spring:message code="search.name.keyword.hint"/>">
                        <div onclick="javascript:search();" class="btn btn-primary"><spring:message code="common.button.search.title"/></div>

                    </div>
                    </form>
                </div>
            </div>
        </article>
    </section>
</section>
<!-- * Main -->
<script>
function search(){
    $("#searchForm").submit();
}
</script>
<!-- footer -->
<%@ include file="/WEB-INF/layout/web-new/include/footer.jsp"%>
<!-- #footer -->
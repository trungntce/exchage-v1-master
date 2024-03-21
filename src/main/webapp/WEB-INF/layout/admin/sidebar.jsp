<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri='http://java.sun.com/jsp/jstl/core' prefix='c'%>

<div id="sidebar" class="app-sidebar">
    <!-- begin sidebar scrollbar -->
    <!-- BEGIN scrollbar -->
    <div class="app-sidebar-content ps" data-height="100%" style="height: 100%;" data-init="true">
        <!-- begin sidebar user -->
        <div class="menu">
            <div class="menu-profile active">
                <a href="/admin/index" class="menu-profile-link">
                    <div class="menu-profile-cover with-shadow"></div>
                    <div class="menu-profile-info">
                        <div class="d-flex align-items-center">
                            <div class="flex-grow-1">
                                <spring:message code="admin.sidebar.dashboard.title"/>
                            </div>
                        </div>
                        <small onclick="location.href='/admin/index'"><spring:message code="admin.sidebar.dashboard.homepage.title"/></small>
                    </div>
                </a>
            </div>
            <div class="menu-header">BASE COIN</div>
            <div id="appSidebarProfileMenu" class="expand">
                <div class="menu-item">
                    <a href="javascript:;" class="menu-link" style="padding: 3px 10px 3px 10px">
                        <div class="menu-icon"><i class="fas fa-money-bill-1"></i></div>
                        <div class="menu-text text-white-100" data-bs-toggle="modal" data-bs-target="#modal-transfer">
                            ${wallet.name}
                            <br><span class="my-balance" wallet-address="${wallet.walletAddress}" data-symbol="EGG">0</span>
                            <span class="my-symbol">EGG</span>
                            <br><span class="my-balance" wallet-address="${wallet.walletAddress}" data-symbol="BANI">0</span>
                            <span class="my-symbol">BANI</span>
                        </div>
                    </a>
                </div>
                <div class="menu-divider"></div>
            </div>

            <!-- 권한별 메뉴 시작 -->
            <!-- OWNER_ROLE MENU START -->
            <div class="menu-header pt-0"><spring:message code="admin.menu.admin.menu.title"/></div>
                <!-- 회원 -->
                <c:if test="${wallet.role eq 'SYSTEM' || wallet.role eq 'CENTRAL_BANK' || wallet.role eq 'OPERATOR'}">
                <div id="admin-memu-member" class="menu-item has-sub">
                    <a href="javascript:;" class="menu-link">
                        <div class="menu-icon">
                            <i class="fa fa-user-check"></i>
                        </div>
                        <div class="menu-text"><spring:message code="admin.menu.admin.user.management.title"/></div>
                        <div class="menu-caret"></div>
                    </a>
                    <div class="menu-submenu">
                        <div class="menu-item">
                            <a href="/admin/user/list" class="menu-link">
                                <div class="menu-text">
                                    <spring:message code="admin.menu.admin.user.title"/>
                                </div>
                            </a>
                        </div>
                        <div class="menu-item">
                            <a href="/admin/wallet/list" class="menu-link">
                                <div class="menu-text">
                                    <spring:message code="admin.menu.admin.wallet.title"/>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
                </c:if>

                <!-- 회원 구매 관리 -->
                <div id="admin-memu-buy-management" class="menu-item has-sub">
                    <a href="javascript:;" class="menu-link">
                        <div class="menu-icon">
                            <i class="fa fa-money-bill"></i>
                        </div>
                        <div class="menu-text"><spring:message code="admin.menu.admin.buy.title"/></div>
                        <div class="menu-caret"></div>
                    </a>
                    <div class="menu-submenu">
                        <c:if test="${wallet.role eq 'SYSTEM' || wallet.role eq 'CENTRAL_BANK' || wallet.role eq 'OPERATOR'}">
                            <div class="menu-item">
                                <a href="/admin/buy/general/list" class="menu-link">
                                    <div class="menu-text">
                                        <spring:message code="admin.menu.admin.buy.general.title"/>
                                    </div>
                                </a>
                            </div>
                        </c:if>
                        <div class="menu-item">
                            <a href="/admin/buy/api/list" class="menu-link">
                                <div class="menu-text">
                                    <spring:message code="admin.menu.admin.buy.api.title"/>
                                </div>
                            </a>
                        </div>
                        <div class="menu-item">
                            <a href="/admin/buy/mytrade/list" class="menu-link">
                                <div class="menu-text">
                                    <spring:message code="admin.menu.admin.buy.mytrade.title"/>
                                </div>
                            </a>
                        </div>

                        <c:if test="${wallet.role eq 'OPERATOR'}">
                            <div class="menu-item">
                                <a href="/admin/buy/safe/list" class="menu-link">
                                    <div class="menu-text"><spring:message code="admin.menu.admin.buy.safe.title"/></div>
                                </a>
                            </div>
                        </c:if>
                    </div>
                </div>

                <!-- 회원 판매 관리 -->
                <div id="admin-memu-sell-management" class="menu-item has-sub">
                    <a href="javascript:;" class="menu-link">
                        <div class="menu-icon">
                            <i class="fa fa-money-bill"></i>
                        </div>
                        <div class="menu-text">
                            <spring:message code="admin.menu.admin.sell.title"/>
                        </div>
                        <div class="menu-caret"></div>
                    </a>
                    <div class="menu-submenu">

                        <c:if test="${wallet.role eq 'SYSTEM' || wallet.role eq 'CENTRAL_BANK' || wallet.role eq 'OPERATOR'}">
                            <div class="menu-item">
                                <a href="/admin/sell/general/list" class="menu-link">
                                    <div class="menu-text">
                                        <spring:message code="admin.menu.admin.sell.general.title"/>
                                    </div>
                                </a>
                            </div>
                        </c:if>

                        <div class="menu-item">
                            <a href="/admin/sell/api/list" class="menu-link">
                                <div class="menu-text">
                                    <spring:message code="admin.menu.admin.sell.api.title"/>
                                </div>
                            </a>
                        </div>
                        <div class="menu-item">
                            <a href="/admin/sell/mytrade/list" class="menu-link">
                                <div class="menu-text">
                                    <spring:message code="admin.menu.admin.sell.mytrade.title"/>
                                </div>
                            </a>
                        </div>

                        <c:if test="${wallet.role eq 'OPERATOR'}">
                            <div class="menu-item">
                                <a href="/admin/sell/safe/list" class="menu-link">
                                    <div class="menu-text"><spring:message code="admin.menu.admin.sell.safe.title"/></div>
                                </a>
                            </div>
                        </c:if>
                    </div>
                </div>
                <div id="admin-memu-feedback-management" class="menu-item has-sub">
                    <a href="javascript:;" class="menu-link">
                        <div class="menu-icon">
                            <i class="fa fa-money-bill"></i>
                        </div>
                        <div class="menu-text">
                            <spring:message code="admin.menu.admin.feedback.title"/>
                        </div>
                        <div class="menu-caret"></div>
                    </a>
                    <div class="menu-submenu">
                        <c:if test="${wallet.role eq 'SYSTEM' || wallet.role eq 'CENTRAL_BANK' || wallet.role eq 'OPERATOR'}">
                            <div class="menu-item">
                                <a href="/admin/feedback/list" class="menu-link">
                                    <div class="menu-text">
                                        <spring:message code="admin.menu.admin.feedback.list.title"/>
                                    </div>
                                </a>
                            </div>
                        </c:if>
                    </div>
                </div>
                <div class="menu-divider"></div>

                <c:if test="${wallet.role eq 'SYSTEM' || wallet.role eq 'CENTRAL_BANK'}">
                <div class="menu-header pt-0"><spring:message code="admin.menu.admin.setup.menu.title"/></div>
                <div id="admin-memu-token-management" class="menu-item has-sub">
                    <a href="javascript:;" class="menu-link">
                        <div class="menu-icon">
                            <i class="fa fa-coins"></i>
                        </div>
                        <div class="menu-text">
                            <spring:message code="admin.menu.admin.token.management.title"/>
                        </div>
                        <div class="menu-caret"></div>
                    </a>
                    <div class="menu-submenu">
                        <div class="menu-item">
                            <a href="/admin/token/list" class="menu-link">
                                <div class="menu-text">
                                    <spring:message code="admin.menu.admin.token.setup.title"/>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
                </c:if>

                <c:if test="${wallet.role eq 'SYSTEM' || wallet.role eq 'CENTRAL_BANK' || wallet.role eq 'OPERATOR'}">
                <!-- 클라이언트 관리 -->
                <div id="admin-memu-api-management" class="menu-item has-sub">
                    <a href="javascript:;" class="menu-link">
                        <div class="menu-icon">
                            <i class="fa  fa-network-wired"></i>
                        </div>
                        <div class="menu-text">
                            <spring:message code="admin.menu.admin.client.management.title"/>
                        </div>
                        <div class="menu-caret"></div>
                    </a>
                    <div class="menu-submenu">
                        <div class="menu-item">
                            <a href="/admin/client/list" class="menu-link">
                                <div class="menu-text">
                                    <spring:message code="admin.menu.admin.client.setup.title"/>
                                </div>
                            </a>
                        </div>
                    </div>
                </div>
                </c:if>
            <!-- 통계 분석 -->
            <div id="admin-memu-analysis" class="menu-item has-sub">
                <a href="${_ctx}/admin/analysis/list" class="menu-link">
                    <div class="menu-icon">
                        <i class="fa fa-chalkboard"></i>
                    </div>
                    <div class="menu-text">
                        <spring:message code="admin.menu.admin.analysis.title"/>
                    </div>
                    <!-- <div class="menu-caret"></div> -->
                </a>
                <div class="menu-submenu d-none">
                    <div class="menu-item">
                        <a href="/admin/analysis/list" class="menu-link">
                            <div class="menu-text">
                                <spring:message code="admin.menu.admin.analysis.buy.title"/>
                            </div>
                        </a>
                    </div>
                    <div class="menu-item">
                        <a href="/admin/analysis/sell/list" class="menu-link">
                            <div class="menu-text">
                                <spring:message code="admin.menu.admin.analysis.sell.title"/>
                            </div>
                        </a>
                    </div>
                </div>
            </div>
    </div>
    <!-- 권한별 메뉴 종료 -->
    <!-- BEGIN minify-button -->
    <div class="menu-item d-flex">
        <a href="javascript:;" class="app-sidebar-minify-btn ms-auto" data-toggle="app-sidebar-minify"><i class="fa fa-angle-double-left"></i></a>
    </div>
    <!-- END minify-button -->
    <!-- START LANGUAGE CHANGE MENU -->
    <div class="menu-divider m-0"></div>
    <div class="mt-10px text-center">
        <div class="flag-icon flag-icon-lr h1 rounded mb-0 hand lang-item" onclick="languageChange('en_US')"></div>
        <div class="flag-icon flag-icon-kr h1 rounded mb-0 hand lang-item" onclick="languageChange('ko_KR')"></div>
    </div>
    <!-- END LANGUAGE CHANGE MENU -->
    <!-- END menu -->
    <div class="ps__rail-x" style="left: 0px; bottom: 0px;"><div class="ps__thumb-x" tabindex="0" style="left: 0px; width: 0px;"></div></div><div class="ps__rail-y" style="top: 0px; right: 0px;"><div class="ps__thumb-y" tabindex="0" style="top: 0px; height: 0px;"></div></div></div>
<!-- END scrollbar -->
</div>
<div class="app-sidebar-mobile-backdrop">
  <a href="#" data-dismiss="app-sidebar-mobile" class="stretched-link"></a>
</div>
<c:if test="${wallet.role eq 'CENTRAL_BANK'}">
<%@ include file="/WEB-INF/layout/admin/modals/transfer.jsp"%>
</c:if>

<script type="text/javascript">
$(document).ready(function() {
    activeMenu(location.pathname);
});

function languageChange(lang){

    let queryString = window.location.search;
    let urlParams = new URLSearchParams(queryString);
    urlParams.delete("langCode");

    if(urlParams.toString().length > 0){
        location.href=window.location.origin+window.location.pathname+"?"+urlParams.toString()+"&langCode="+lang;
    } else {
        location.href=window.location.origin+window.location.pathname+"?langCode="+lang;
    }

}

function activeMenu(pathname) {
    if(pathname != "${_ctx}/admin/index"){
        $("#sidebar").find("a[href^='"+pathname+"']").parents(".menu-item").addClass("active");
    }
}
</script>
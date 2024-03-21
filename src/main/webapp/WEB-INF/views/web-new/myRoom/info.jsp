<%--
  Created by IntelliJ IDEA.
  User: ntt.dev
  The page MyRoom
--%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- head -->
<%@ include file="/WEB-INF/layout/web-new/include/head.jsp"%>
<!-- #head -->
<style>
    .btn-play-audio:hover{
        cursor: pointer;
        color: green;
    }
</style>
<body class="pace-done">
    <!-- Main -->
    <div class="wrapper">
    <!-- header -->
    <%@ include file="/WEB-INF/layout/web-new/include/header.jsp"%>
    <!-- #header -->
    <!-- topContent --> 
    <article class="sub-title sub-title--trade">
        <h2><spring:message code="myroom.title"/></h2>
        <p><spring:message code="myroom.description"/></p>
    </article>      
        <div class="article-inner">
            <div class="sub-snb-wrap trade-snb trade__control">
                <div class="sub-snb-container trade__control__inner">
                    <ul class="sub-snb-menu" trade-tab="${buySearch.targetView}">
                        <li class="width-100 sub-snb-menu-item" tab-target="#buy-order"><spring:message code="myroom.buylist.title"/></li>
                        <li class="width-100 sub-snb-menu-item" tab-target="#sell-order"><spring:message code="myroom.selllist.title"/></li>
                        <li class="width-100 sub-snb-menu-item" tab-target="#information"><spring:message code="myroom.myinfo.title"/></li>
                        <li class="width-100 sub-snb-menu-item" tab-target="#setting"><spring:message code="myroom.alarms.setup.title"/></li>
                        <li class="width-100 sub-snb-menu-item" tab-target="#feedback"><spring:message code="admin.menu.admin.feedback.list.title"/></li>
                    </ul>
                    <div class="sub-snb-btn bt-1-70">
                        <c:if test="${buySearch.targetView eq '#buy-order' || buySearch.targetView eq '#sell-order' || buySearch.targetView eq null}">
                        <ul class="list-select" trade-status="${buySearch.idOrderStatus}">
                            <li class="list-select-item order-status" data-status=""><spring:message code="trade.status.order.all.title"/></li>
                            <li class="list-select-item order-status" data-status="1"><spring:message code="trade.status.order.wait.title"/></li>
                            <li class="list-select-item order-status" data-status="2"><spring:message code="trade.status.order.trade.title"/></li>
                            <li class="list-select-item order-status" data-status="3"><spring:message code="trade.status.order.finish.title"/></li>
                        </ul>
                        <div class="btn refresh-btn order-status" data-status=""><spring:message code="trade.status.order.refresh.title"/></div>
                        </c:if>
                    </div>
                </div>
            </div>

            <section class="container">
               <article class="trade-wrap">
                <c:if test="${buySearch.targetView eq '#buy-order' || buySearch.targetView eq '#sell-order' || buySearch.targetView eq null}">
                    <div class="trade-btn-wrap form-wrap form-full" style="margin:20px 0 60px;">
                        <select class="symbol tokenSelect" symbol-value="${buySearch.symbol}">
                             <option value=""><spring:message code="common.message.all.title"/></option>
                            <c:forEach items="${tokens}" var="item" varStatus="loop">
                                <c:choose>
                                    <c:when test="${buySearch.symbol == item.symbol}">
                                         <option value="${item.symbol}" selected>${item.symbol}</option>
                                    </c:when>                               
                                    <c:otherwise>
                                        <option value="${item.symbol}">${item.symbol}</option>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </select>
                        <select class="symbol walletSelect">
                            <c:forEach items="${wallet.wallets}" var="item" varStatus="loop">
                                 <c:choose>
                                    <c:when test="${buySearch.walletAddress == item.walletAddress}">
                                         <option value="${item.walletAddress}" path='' repeat="${item.repeatSeconds}" selected>${item.walletAddress}</option>
                                    </c:when>                               
                                    <c:otherwise>
                                         <option value="${item.walletAddress}" path='' repeat="${item.repeatSeconds}">${item.walletAddress}</option>
                                    </c:otherwise>
                                </c:choose>
                               
                            </c:forEach>
                          
                        </select>
                    </div>
                </c:if>
                <c:if test="${buySearch.targetView eq '#feedback'}">
                    <div class="trade-btn-wrap form-wrap form-full" style="margin:20px 0 60px;">
                        <select class="feedback-state" symbol-value="${buySearch.state}">
                             <option value=""><spring:message code="common.message.all.title"/></option>
                            <c:forEach items="${feedbackState}" var="item" varStatus="loop">
                                <c:choose>
                                    <c:when test="${buySearch.state == item.codeValue}">
                                         <option value="${item.codeValue}" selected>${item.codeName}</option>
                                    </c:when>                               
                                    <c:otherwise>
                                        <option value="${item.codeValue}">${item.codeName}</option>
                                    </c:otherwise>
                                </c:choose>
                            </c:forEach>
                        </select>                        
                    </div>
                </c:if>
                    <div  id="buy-order" class="hide">
                        <div class="list-wrap trade-list-wrap hide">
                            <div class="trade-list-wrap">
                                <div class="trade-list-head">
                                    <div class="trade-list-th"><spring:message code="trade.buy.orderNumber.title"/></div>
                                    <div class="trade-list-th"><spring:message code="trade.buy.coin.title"/></div>
                                    <div class="trade-list-th"><spring:message code="trade.buy.orderKind.title"/></div>
                                    <div class="trade-list-th"><spring:message code="trade.buy.tokenCnt.title"/></div>
                                    <div class="trade-list-th"><spring:message code="trade.buy.price.title"/></div>
                                    <div class="trade-list-th"><spring:message code="trade.buy.totalAmount.title"/></div>
                                    <div class="trade-list-th"><spring:message code="trade.buy.createDate.title"/></div>
                                    <div class="trade-list-th"><spring:message code="trade.buy.status.title"/></div>
                                </div>

                                <c:if test="${buyList.size() == 0}">
                                    <div class="trade-list-tr">
                                      <div class="trade-list-td other-num"><spring:message code="common.message.noData.title"/></div>
                                    </div>
                                </c:if>

                                <c:forEach items="${buyList}" var="item" varStatus="loop">
                                  
                                  <div class="trade-list-tr">
                                      <div class="trade-list-td other-num">${item.symbol}<fmt:formatDate value="${item.buyRegDate}" pattern="yyyyMMddHHmmss"/>${item.buyId}</div>
                                      <div class="trade-list-td coin-name">${item.symbol}</div>
                                      <div class="trade-list-td category">${item.buyType}</div>
                                      <div class="trade-list-td ea"><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.quantity}"/><spring:message code="common.unit.count.title"/></div>
                                      <div class="trade-list-td price-one"><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.unitPrice}"/><spring:message code="common.unit.won.title"/></div>
                                      <div class="trade-list-td price-total"><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.totalPrice}"/><spring:message code="common.unit.won.title"/></div>
                                      <div class="trade-list-td date"><fmt:formatDate value="${item.buyRegDate}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
                                      <div class="trade-list-td status">
                                          <c:choose>
                                              <c:when test="${(item.state == 1
                                              || fn:containsIgnoreCase(wallet.wallets, item.sellerWalletAddress)
                                              || fn:containsIgnoreCase(wallet.wallets, item.buyerWalletAddress)
                                              || fn:containsIgnoreCase(wallet.wallets, item.regWalletAddress))
                                              && not empty wallet }">
                                                  <c:if test="${item.state == 1}"><div class="status-btn status-wait" data-id="" redirect="${_ctx}/tradeBuyDetail?buyId=${item.buyId}">${item.stateName}</div></c:if>
                                                  <c:if test="${item.state == 2}"><div class="status-btn status-ing" data-id="" redirect="${_ctx}/tradeBuyDetail?buyId=${item.buyId}">${item.stateName}</div></c:if>
                                                  <c:if test="${item.state == 3}"><div class="status-btn status-end" data-id="" redirect="${_ctx}/tradeBuyDetail?buyId=${item.buyId}">${item.stateName}</div></c:if>
                                                   <c:if test="${item.state == 4}"><div class="status-btn status-end" data-id="" redirect="${_ctx}/tradeBuyDetail?buyId=${item.buyId}">${item.stateName}</div></c:if>
                                              </c:when>
                                              <c:when test="${empty wallet}">
                                                  <c:if test="${item.state == 1}"><div class="status-btn status-wait" redirect="${_ctx}/login">${item.stateName}</div></c:if>
                                                  <c:if test="${item.state == 2}"><div class="status-btn status-ing" redirect="${_ctx}/login">${item.stateName}</div></c:if>
                                                  <c:if test="${item.state == 3}"><div class="status-btn status-end" redirect="${_ctx}/login">${item.stateName}</div></c:if>
                                                  <c:if test="${item.state == 4}"><div class="status-btn status-end" redirect="${_ctx}/login">${item.stateName}</div></c:if>
                                              </c:when>
                                              <c:otherwise>
                                                  <c:if test="${item.state == 1}"><div class="status-btn status-wait">${item.stateName}</div></c:if>
                                                  <c:if test="${item.state == 2}"><div class="status-btn status-ing">${item.stateName}</div></c:if>
                                                  <c:if test="${item.state == 3}"><div class="status-btn status-end">${item.stateName}</div></c:if>
                                                  <c:if test="${item.state == 4}"><div class="status-btn status-end">${item.stateName}</div></c:if>                                                  
                                              </c:otherwise>
                                          </c:choose>
                                      </div>
                                  </div>
                                </c:forEach>
                            </div>                           
                        </div>
                         <pg:webpaging page="${buySearch}" script="goBuyPage"/>
                    </div>

                    <div id="sell-order" class="hide">
                        <div class="list-wrap trade-list-wrap hide" >
                            <div class="trade-list-wrap">
                                <div class="trade-list-head">
                                    <div class="trade-list-th"><spring:message code="trade.buy.orderNumber.title"/></div>
                                    <div class="trade-list-th"><spring:message code="trade.buy.coin.title"/></div>
                                    <div class="trade-list-th"><spring:message code="trade.buy.orderKind.title"/></div>
                                    <div class="trade-list-th"><spring:message code="trade.buy.tokenCnt.title"/></div>
                                    <div class="trade-list-th"><spring:message code="trade.buy.price.title"/></div>
                                    <div class="trade-list-th"><spring:message code="trade.buy.totalAmount.title"/></div>
                                    <div class="trade-list-th"><spring:message code="trade.buy.createDate.title"/></div>
                                    <div class="trade-list-th"><spring:message code="trade.buy.status.title"/></div>
                                </div>

                                <c:if test="${sellList.size() == 0}">
                                    <div class="trade-list-tr">
                                      <div class="trade-list-td other-num"><spring:message code="common.message.noData.title"/></div>
                                    </div>
                                </c:if>

                                <c:forEach items="${sellList}" var="item" varStatus="loop">
                               
                                <div class="trade-list-tr">
                                    <div class="trade-list-td other-num">${item.symbol}<fmt:formatDate value="${item.sellRegDate}" pattern="yyyyMMddHHmmss"/>${item.sellId}</div>
                                    <div class="trade-list-td coin-name">${item.symbol}</div>
                                    <div class="trade-list-td category">${item.sellType}</div>
                                    <div class="trade-list-td ea"><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.quantity}"/><spring:message code="common.unit.count.title"/></div>
                                    <div class="trade-list- td price-one"><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.unitPrice}"/><spring:message code="common.unit.won.title"/></div>
                                    <div class="trade-list-td price-total"><fmt:formatNumber type="number" maxFractionDigits="3" value="${item.totalPrice}"/><spring:message code="common.unit.won.title"/></div>
                                    <div class="trade-list-td date"><fmt:formatDate value="${item.sellRegDate}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
                                    <div class="trade-list-td status">
                                        <c:choose>
                                            <c:when test="${(item.state == 1
                                            || fn:containsIgnoreCase(wallet.wallets, item.buyerWalletAddress)
                                            || fn:containsIgnoreCase(wallet.wallets, item.sellerWalletAddress)
                                            || fn:containsIgnoreCase(wallet.wallets, item.regWalletAddress))
                                            && not empty wallet }">
                                                <c:if test="${item.state == 1}"><div class="status-btn status-wait" data-id="" redirect="${_ctx}/tradeSellDetail?sellId=${item.sellId}">${item.stateName}</div></c:if>
                                                <c:if test="${item.state == 2}"><div class="status-btn status-ing" data-id="" redirect="${_ctx}/tradeSellDetail?sellId=${item.sellId}">${item.stateName}</div></c:if>
                                                <c:if test="${item.state == 3}"><div class="status-btn status-end" data-id="" redirect="${_ctx}/tradeSellDetail?sellId=${item.sellId}">${item.stateName}</div></c:if>
                                                <c:if test="${item.state == 4}"><div class="status-btn status-end" data-id="" redirect="${_ctx}/tradeSellDetail?sellId=${item.sellId}">${item.stateName}</div></c:if>
                                            </c:when>
                                            <c:when test="${empty wallet}">
                                                <c:if test="${item.state == 1}"><div class="status-btn status-wait" redirect="${_ctx}/login">${item.stateName}</div></c:if>
                                                <c:if test="${item.state == 2}"><div class="status-btn status-ing" redirect="${_ctx}/login">${item.stateName}</div></c:if>
                                                <c:if test="${item.state == 3}"><div class="status-btn status-end" redirect="${_ctx}/login">${item.stateName}</div></c:if>
                                                <c:if test="${item.state == 4}"><div class="status-btn status-end" data-id="" redirect="${_ctx}/tradeSellDetail?sellId=${item.sellId}">${item.stateName}</div></c:if>
                                            </c:when>
                                            <c:otherwise>
                                                <c:if test="${item.state == 1}"><div class="status-btn status-wait">${item.stateName}</div></c:if>
                                                <c:if test="${item.state == 2}"><div class="status-btn status-ing">${item.stateName}</div></c:if>
                                                <c:if test="${item.state == 3}"><div class="status-btn status-end">${item.stateName}</div></c:if>
                                                <c:if test="${item.state == 4}"><div class="status-btn status-end" data-id="" redirect="${_ctx}/tradeSellDetail?sellId=${item.sellId}">${item.stateName}</div></c:if>
                                            </c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                                </c:forEach>
                            </div>                           
                        </div>
                         <pg:webpaging page="${sellSearch}" script="goSellPage"/>
                    </div>
                    <div class="list-wrap trade-list-wrap hide" id="information">   

                        <div class="trade-pop-form-info">
                            <dl class="trade-pop-form-info-item">
                                <dd><b><spring:message code="myroom.information.wallet.title"/></b></dd>
                            </dl>
                            <form id="frmInfo" action="${_ctx}/myRoom/walletUpdate" method="POST">
                                <dl class="trade-pop-form-info-item">
                                    <dt><spring:message code="myroom.information.wallet.address.title"/></dt>
                                    <dd>${walletInfo.walletAddress}</dd>
                                    <dd style="display: none;"><input name="walletAddress" type="hidden" value="${walletInfo.walletAddress}" /></dd>
                                </dl>
                                <dl class="trade-pop-form-info-item">
                                    <dt><spring:message code="myroom.information.wallet.fee.title"/></dt>
                                    <dd>${walletInfo.fee}</dd>
                                    <!-- <dd></dd> -->
                                </dl>
                                <dl class="trade-pop-form-info-item">
                                    <dt><spring:message code="buy.detail.bank.name.title"/></dt>
                                    <dd class="form-group">                                     
                                        <input id="bankName" name="bankName" type="text" value="${walletInfo.bankName}" />
                                        <span class="form-message float-none-message text-red"></span>
                                     </dd>

                                    <!-- <dd></dd> -->
                                </dl>
                                <dl class="trade-pop-form-info-item">
                                    <dt><spring:message code="buy.detail.bank.owner.title"/></dt>
                                    <dd class="form-group">
                                        <input id="bankOwner" name="bankOwner" type="text" value="${walletInfo.bankOwner}"/>
                                        <span class="form-message float-none-message text-red"></span>
                                    </dd>
                                    <!-- <dd></dd> -->
                                </dl>
                                <dl class="trade-pop-form-info-item">
                                    <dt><spring:message code="buy.detail.bank.account.title"/></dt>
                                    <dd class="form-group">
                                        <input id="bankAccount" name="bankAccount" type="text" value="${walletInfo.bankAccount}"/>
                                      <span class="form-message float-none-message text-red"></span>
                                    </dd>
                                    <!-- <dd></dd> -->
                                </dl>
                                <!--
                                <dl class="trade-pop-form-info-item">
                                    <dd><button class="status-btn status-ing"><spring:message code="common.button.submit.title"/></button></dd>
                                </dl>
                                -->
                                <div class="submit_btn">
                                    <button class="status-btn status-ing submit_btn"><spring:message code="common.button.submit.title"/></button>
                                </div>
                            </form>
                            
                        </div>
                    </div>

                    <div class="list-wrap trade-list-wrap hide" id="setting">
                        <div class="trade-pop-form-info">
                            <dl class="trade-pop-form-info-item">
                                <dd><spring:message code="myroom.setting.title"/></dd>
                            </dl>
                            <form id="alarmForm" method="POST" action="${_ctx}/myRoom/alarmUpdate">
                                <dl class="trade-pop-form-info-item">
                                    <dt><spring:message code="myroom.information.wallet.address.title"/></dt>
                                    <dd>${walletInfo.walletAddress}</dd>
                                    <input name="walletAddress" id="walletAddress" type="hidden" value="${walletInfo.walletAddress}" />
                                </dl>
                                <dl class="trade-pop-form-info-item">
                                    <dt><spring:message code="alarm.field.useYn.title"/></dt>
                                    <dd>
                                        <input type="radio" id="useYn1" name="useYn" value="Y" <c:if test="${alarmForm.useYn eq 'Y'}">checked</c:if>><label for="useYn1" class="ms-1 me-3"><spring:message code="alarm.useYn.yes.title"/></label>
                                        <input type="radio" id="useYn2" name="useYn" value="N" <c:if test="${alarmForm.useYn eq 'N'}">checked</c:if>><label for="useYn2" class="ms-1 me-3"><spring:message code="alarm.useYn.no.title"/></label>
                                    </dd>
                                </dl>
                                <dl class="trade-pop-form-info-item">
                                    <dt><spring:message code="myroom.setting.filePath.title"/></dt>
                                    <dd>
                                        <input type="radio" id="path1" name="path" value="${_ctx}/resources/dist/audio/sound-1.mp3" <c:if test="${alarmForm.path eq '/resources/dist/audio/sound-1.mp3'}">checked</c:if>><label for="path1" class="ms-1 me-3"><spring:message code="alarm.sound.title"/> 1</label>
                                        <input type="radio" id="path2" name="path" value="${_ctx}/resources/dist/audio/sound-2.mp3" <c:if test="${alarmForm.path eq '/resources/dist/audio/sound-2.mp3'}">checked</c:if>><label for="path2" class="ms-1 me-3"><spring:message code="alarm.sound.title"/> 2</label>
                                        <input type="radio" id="path3" name="path" value="${_ctx}/resources/dist/audio/sound-3.mp3" <c:if test="${alarmForm.path eq '/resources/dist/audio/sound-3.mp3'}">checked</c:if>><label for="path3" class="ms-1 me-3"><spring:message code="alarm.sound.title"/> 3</label>
                                    </dd>
                                </dl>
                                <dl class="trade-pop-form-info-item">
                                    <dt><spring:message code="alarm.sound.title"/></dt>
                                    <dd>
                                        <button type="button" class="btn btn-success mb-3 btn-play-audio" for="audioFile"><spring:message code="alarm.play.title"/></button>
                                        <audio id="audioFile" controls hidden>
                                            <source src="${_ctx}/resources/dist/audio/sound-1.mp3" type="audio/mpeg">
                                        </audio>
                                    </dd>
                                </dl>
                                <dl class="trade-pop-form-info-item">
                                    <dt><spring:message code="myroom.setting.alarmRepeat.title"/></dt>
                                    <dd class="form-group">
                                        <input id="repeatSeconds" name="repeatSeconds" value="${alarmForm.repeatSeconds}" />
                                        <label><spring:message code="common.unit.second.title"/></label>
                                        <span class="form-message float-none-message text-red"></span>
                                    </dd>
                                    <!-- <dd></dd> -->
                                </dl>
                               <div class="submit_btn">
                                    <button class="status-btn status-ing" type="submit" style="width:30%"><spring:message code="common.button.submit.title"/></button>
                               </div>
                            </form>
                        </div>
                    </div>
                    <div class="list-wrap trade-list-wrap hide" id="feedback">
                       <div class="trade-list-wrap">
                                <div class="trade-list-head">
                                    <div class="trade-list-th"><spring:message code="search.name.orderByColumn.option.no.title"/></div>
                                    <div class="trade-list-th"><spring:message code="feedback.list.title"/></div>
                                    <div class="trade-list-th"><spring:message code="feedback.list.regWallet.title"/></div>
                                    <div class="trade-list-th"><spring:message code="feedback.list.regDate.title"/></div>
                                    <div class="trade-list-th"><spring:message code="feedback.list.ipAddress.title"/></div>
                                    <div class="trade-list-th"><spring:message code="feedback.list.state.title"/></div>
                                </div>

                                <c:if test="${feedbacks.size() == 0}">
                                    <div class="trade-list-tr">
                                      <div class="trade-list-td other-num"><spring:message code="common.message.noData.title"/></div>
                                    </div>
                                </c:if>

                                <c:forEach items="${feedbacks}" var="item" varStatus="loop">
                                  
                                  <div class="trade-list-tr">
                                      <div class="trade-list-td other-num">${item.rowNum}</div>
                                      <div class="trade-list-td coin-name">${item.title}</div>
                                      <div class="trade-list-td coin-name">${item.regUser}</div>                                      
                                      <div class="trade-list-td coin-name"><fmt:formatDate value="${item.regDate}" pattern="yyyy-MM-dd HH:mm:ss"/></div>
                                      <div class="trade-list-td coin-name">${item.ipAddress}</div>
                                      <div class="trade-list-td status">                                        
                                          <c:if test="${item.state == 1}"><div class="status-btn status-wait" onclick="goDetailFeedback(${item.feedbackId})">
                                            <spring:message code="feedback.list.state.request"/>
                                          </div></c:if>
                                          <c:if test="${item.state == 2}"><div class="status-btn status-ing" onclick="goDetailFeedback(${item.feedbackId})">
                                            <spring:message code="feedback.list.state.checking"/>
                                          </div></c:if>
                                          <c:if test="${item.state == 3}"><div class="status-btn status-ing" onclick="goDetailFeedback(${item.feedbackId})">
                                            <spring:message code="feedback.list.state.processing"/>
                                          </div></c:if>
                                          <c:if test="${item.state == 4}"><div class="status-btn status-end" onclick="goDetailFeedback(${item.feedbackId})">
                                            <spring:message code="feedback.list.state.finished"/>
                                          </div></c:if>
                                      </div>
                                  </div>
                                </c:forEach>
                            </div> 
                             <pg:webpaging page="${feedbackSearch}" script="goFeedbackPage"/>   
                    </div>
                </div>
            </section>
        </div>       
    </div>
    <!-- * Main -->
</body>
<!-- footer -->
<%@ include file="/WEB-INF/layout/web-new/include/footer.jsp"%>
<!-- #footer -->
<script>
    //form input validate
    document.addEventListener('DOMContentLoaded', function () {
        //valid input
        Validator({
            form: '#frmInfo',
            formGroupSelector: '.form-group',
            errorSelector: '.form-message',
            rules: [

                // Check null                                
                Validator.isRequired('#bankName', "<spring:message code='the.input.not.valid'/>"),
                Validator.isRequired('#bankOwner', "<spring:message code='the.input.not.valid'/>"),
                Validator.isRequired('#bankAccount', "<spring:message code='the.input.not.valid'/>"),                


                // Check minimum input                              
                Validator.minLength('#bankName', 3, "<spring:message code='login.minimum.length'/>"),
                Validator.minLength('#bankOwner', 3, "<spring:message code='login.minimum.length'/>"),
                Validator.minLength('#bankAccount', 3, "<spring:message code='login.minimum.length'/>"),

                // Check maximum                
                Validator.maxLength('#bankName', 32, "<spring:message code='login.maximum.length'/>"),
                Validator.maxLength('#bankOwner', 32, "<spring:message code='login.maximum.length'/>"),
                Validator.maxLength('#bankAccount', 32, "<spring:message code='login.maximum.length'/>"),

                // Validator regexPattern                                
                Validator.isRegexPattern('#bankName', "<spring:message code='the.input.not.valid'/>"),
                Validator.isRegexPattern('#bankOwner', "<spring:message code='the.input.not.valid'/>"),
                Validator.isRegexPattern('#bankAccount', "<spring:message code='the.input.not.valid'/>"),                

            ],
        });
        Validator({
            form: '#alarmForm',
            formGroupSelector: '.form-group',
            errorSelector: '.form-message',
            rules: [
                // Check null
                Validator.isRequired('#repeatSeconds', "<spring:message code='the.input.not.valid'/>"),
                Validator.isRegexPhoneNumber('#repeatSeconds', "<spring:message code='the.input.not.valid'/>"),
                Validator.isNotZero('#repeatSeconds', "<spring:message code='the.input.not.valid'/>"),
                
            ],
        });
    });


    var walletTarget = '#buy-order';

    $(document).ready(function(){
        init();

    })

    function init(){
        // $(".walletSelect").val(walletTarget);
        // $(".walletSelect").change();


        //Tab target
        var tradeTab = $("[trade-tab]").attr("trade-tab");
        tradeTab = (tradeTab == "" || tradeTab == null) ? "#buy-order" : tradeTab;
        $(".sub-snb-menu-item[tab-target='"+tradeTab+"']").addClass("active");
        $(tradeTab).removeClass("hide");
        $(tradeTab).children().removeClass("hide");
        $("[trade-register='"+tradeTab+"']").removeClass("hide");
       
        //Status target
        var tradeStatus = $("[trade-status]").attr("trade-status");
        tradeStatus = (tradeStatus == "" || tradeStatus == null) ? "" : tradeStatus;
        $(".order-status[data-status='"+tradeStatus+"']").addClass("active");
 
        //Symbol target
        // var tradeSymbol = $("[trade-symbol]").attr("trade-symbol");
        // tradeSymbol = (tradeSymbol == "" || tradeSymbol == null) ? "" : tradeSymbol;
        // $(".trade-symbol[data-symbol='"+tradeSymbol+"']").addClass("active");

        if(${feedbackSearch.showDetail == 'Y' && feedbackSearch.refId != null}){
            showModal('#feedbackModal', false);
        }
    }

    $(`[name="soundAlarm"]`).change(function(){
        var url = $(this).val()
        $(`#audioFile`).find("source").attr("src", url)
    })

    $(".order-status").click(function(){        
        var status = $(this).attr("data-status");
        var url = changeSearchParam({idOrderStatus: status, sellPage: 1, buyPage: 1})
        document.location.href = url;
    })

    $(".sub-snb-menu-item:not(.acitve)").click(function(){
        var target = $(this).attr("tab-target");
        var url = changeSearchParam({targetView: target})
        document.location.href = url;
    })

    $(".btn-play-audio").click(async function(){
        var target = $(this).attr("for");
        var audio = document.getElementById(target);
        audio.currentTime = 0;
        if(audio.pause){
            audio.play().catch((e)=>{
               console.log("------"+e)
            });
            await timer(2000);
        }
        audio.pause();
    })

    $(".tokenSelect").change(function(){   
        let token = $(this).find("option:selected").val();
       console.log(token);
        var url = changeSearchParam({symbol: token})
        document.location.href = url;
       
    })
     $(".feedback-state").change(function(){   
        let state = $(this).find("option:selected").val();       
        var url = changeSearchParam({state: state})
        document.location.href = url;
       
    })


     $(".walletSelect").change(async function(){
     let wallet = $(this).find("option:selected").val();
       console.log(wallet);
        var url = changeSearchParam({walletAddress: wallet})
        document.location.href = url;
    })

    function goSellPage(mPage){
        var url = changeSearchParam({sellPage: mPage})
        document.location.href = url;
    }
    
    function goBuyPage(mPage){
        var url = changeSearchParam({buyPage: mPage})
        document.location.href = url;
    }
     function goFeedbackPage(mPage){
        var url = changeSearchParam({page: mPage})
        document.location.href = url;
    }
    function goDetailFeedback(feedbackId){
        var url = changeSearchParam({refId: feedbackId,showDetail:'Y'})
        document.location.href = url;
    }

</script>

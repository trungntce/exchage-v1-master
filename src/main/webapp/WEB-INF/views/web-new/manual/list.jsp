<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!-- head -->
<%@ include file="/WEB-INF/layout/web-new/include/head.jsp"%>
<!-- #head -->
<!-- Main -->
<!-- jQuery library -->
<script src="https://ajax.googleapis.com/ajax/libs/jquery/1.12.4/jquery.min.js"></script>

<!-- Latest compiled JavaScript -->
<script src="http://maxcdn.bootstrapcdn.com/bootstrap/3.3.7/js/bootstrap.min.js"></script>
<section class="wrap element-main-top">
    <!-- header -->
      <%@ include file="/WEB-INF/layout/web-new/include/header.jsp"%>
    <!-- #header -->
    <section class="dim"></section>

    <section class="container">
        <article class="manual-wrap">
            <div class="article-inner ">                
                <div class="manual__head">
                    <div class="txt-box">
                        <h3><spring:message code="page.menual.title"/></h3>
                    </div>
                </div>
                <ul class="article-tab">
                    <li class="dev_tap"><a href="/manual?tap=0"><spring:message code="page.menual.sub.start.title"/></a></li>
                    <li class="dev_tap"><a href="/manual?tap=1"><spring:message code="page.menual.sub.trade.title"/></a></li>
                    <li class="dev_tap"><a href="/manual?tap=2"><spring:message code="page.menual.sub.wallet.title"/></a></li>
                    <li class="dev_tap"><a href="/manual?tap=3"><spring:message code="page.menual.sub.asset.title"/></a></li>
                </ul>
                <!-- tap0 -->
                <div class="manual__cont dev_tap0 d-none">
                    <div class="card mb-5">
                        <div class="image-hover thumbnail img-responsive">     
                            <a href="#">                     
                              <img src="${_ctx}/resources/img/manual/register-1.png" class="card-img-top" alt="Register">
                            </a>                            
                        </div>
                        
                        <div class="card-body card-body--order">
                            <div class="card-order">1</div>
                            <h5 class="card-title"><spring:message code="page.menual.sub.start.first.block.title"/></h5>
                            <p class="card-text"><spring:message code="page.menual.sub.start.first.block.body"/></p>
                        </div>
                    </div>
                    <div class="card mb-5">
                        <div class="image-hover thumbnail img-responsive">     
                            <a href="#">                     
                              <img src="${_ctx}/resources/img/manual/LoginType-1.png" class="card-img-top" alt="Register">
                            </a>                            
                        </div>
                        <div class="card-body card-body--order">
                            <div class="card-order">2</div>
                            <h5 class="card-title"><spring:message code="page.menual.sub.start.second.block.title"/></h5>
                            <p class="card-text">
                                <spring:message code="page.menual.sub.start.second.block.body"/>
                            </p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="card mb-5">
                                <div class="image-hover thumbnail img-responsive">     
                                    <a href="#">                     
                                      <img src="${_ctx}/resources/img/manual/joinUser-1.png" class="card-img-top" alt="Register">
                                    </a>                            
                                </div>
                                <div class="card-body card-body--order">
                                    <div class="card-order">3</div>
                                    <h5 class="card-title"><spring:message code="page.menual.sub.start.third.first.block.title"/></h5>
                                    <p class="card-text">
                                        <spring:message code="page.menual.sub.start.third.first.block.body"/>
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="card mb-5">
                                <div class="image-hover thumbnail img-responsive">     
                                    <a href="#">                     
                                      <img src="${_ctx}/resources/img/manual/joinWallet-1.png" class="card-img-top" alt="Register">
                                    </a>                            
                                </div>
                                <div class="card-body card-body--order">
                                    <div class="card-order">4</div>
                                    <h5 class="card-title"><spring:message code="page.menual.sub.start.third.second.block.title"/></h5>
                                    <p class="card-text">
                                        <spring:message code="page.menual.sub.start.third.second.block.body"/>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="manual__cont dev_tap0 d-none">
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="card mb-5">
                                <div class="image-hover thumbnail img-responsive">     
                                    <a href="#">                     
                                      <img src="${_ctx}/resources/img/manual/join-account-finish-1.png" class="card-img-top" alt="Register">
                                    </a>                            
                                </div>
                                <div class="card-body card-body--order">
                                    <div class="card-order">5</div>
                                    <h5 class="card-title"><spring:message code="page.menual.sub.start.four.first.block.title"/></h5>
                                    <p class="card-text">
                                        <spring:message code="page.menual.sub.start.four.first.block.body"/>
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="card mb-5">
                                <div class="image-hover thumbnail img-responsive">     
                                    <a href="#">                     
                                      <img src="${_ctx}/resources/img/manual/join-wallet-finish-1.png" class="card-img-top" alt="Register">
                                    </a>                            
                                </div>
                                <div class="card-body card-body--order">
                                    <div class="card-order">6</div>
                                    <h5 class="card-title"><spring:message code="page.menual.sub.start.four.second.block.title"/></h5>
                                    <p class="card-text">
                                        <spring:message code="page.menual.sub.start.four.second.block.body"/>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- // tap0 -->
                <!-- tap1 -->
                <div class="manual__cont dev_tap1 d-none">
                    <div class="card mb-5">
                        <div class="image-hover thumbnail img-responsive">     
                            <a href="#">                     
                              <img src="${_ctx}/resources/img/manual/trade-p2p.png" class="card-img-top" alt="Register">
                            </a>                            
                        </div>
                        <div class="card-body card-body--order">
                            <div class="card-order">1</div>
                            <h5 class="card-title"><spring:message code="page.menual.sub.trade.first.block.title"/></h5>
                            <p class="card-text">
                                <spring:message code="page.menual.sub.trade.first.block.body"/>
                            </p>
                        </div>
                    </div>
                    <div class="card mb-5">
                        <div class="image-hover thumbnail img-responsive">     
                                    <a href="#">                     
                                      <img src="${_ctx}/resources/img/manual/trade-p2p-register.png" class="card-img-top" alt="Register">
                                    </a>                            
                                </div>
                        <div class="card-body card-body--order">
                            <div class="card-order">2</div>
                            <h5 class="card-title"><spring:message code="page.menual.sub.trade.second.block.title"/></h5>
                            <p class="card-text">
                                <spring:message code="page.menual.sub.trade.second.block.body"/>
                            </p>
                        </div>
                    </div>
                    <div class="card mb-5">
                        <div class="image-hover thumbnail img-responsive">     
                                    <a href="#">                     
                                      <img src="${_ctx}/resources/img/manual/register-buy-1.png" class="card-img-top" alt="Register">
                                    </a>                            
                                </div>
                        <div class="card-body card-body--order">
                            <div class="card-order">3</div>
                            <h5 class="card-title"><spring:message code="page.menual.sub.trade.third.block.title"/></h5>
                            <p class="card-text">
                                <spring:message code="page.menual.sub.trade.third.block.body"/>
                            </p>
                        </div>
                    </div>
                    <div class="card mb-5">
                        <div class="image-hover thumbnail img-responsive">     
                                    <a href="#">                     
                                      <img src="${_ctx}/resources/img/manual/sell-register-1.png" class="card-img-top" alt="Register">
                                    </a>                            
                                </div>
                        <div class="card-body card-body--order">
                            <div class="card-order">4</div>
                            <h5 class="card-title"><spring:message code="page.menual.sub.trade.four.block.title"/></h5>
                            <p class="card-text">
                                <spring:message code="page.menual.sub.trade.four.block.body"/>
                            </p>
                        </div>
                    </div>
                    <div class="card mb-5">
                        <div class="image-hover thumbnail img-responsive">     
                                    <a href="#">                     
                                      <img src="${_ctx}/resources/img/manual/register-buy-finish-1.png" class="card-img-top" alt="Register">
                                    </a>                            
                                </div>
                        <div class="card-body card-body--order">
                            <div class="card-order">5</div>
                            <h5 class="card-title"><spring:message code="page.menual.sub.trade.five.block.title"/></h5>
                            <p class="card-text">
                                <spring:message code="page.menual.sub.trade.five.block.body"/>
                            </p>
                        </div>
                    </div>
                    <div class="card mb-5">
                        <div class="image-hover thumbnail img-responsive">     
                                    <a href="#">                     
                                      <img src="${_ctx}/resources/img/manual/register-buy-2.png" class="card-img-top" alt="Register">
                                    </a>                            
                                </div>
                        <div class="card-body card-body--order">
                            <div class="card-order">6</div>
                            <h5 class="card-title"><spring:message code="page.menual.sub.trade.six.block.title"/></h5>
                            <p class="card-text">
                                <spring:message code="page.menual.sub.trade.six.block.body"/>
                            </p>
                        </div>
                    </div>
                    <div class="card mb-5">
                        <div class="image-hover thumbnail img-responsive">     
                                    <a href="#">                     
                                      <img src="${_ctx}/resources/img/manual/transfer-finish-1.png" class="card-img-top" alt="Register">
                                    </a>                            
                                </div>
                        <div class="card-body card-body--order">
                            <div class="card-order">7</div>
                            <h5 class="card-title"><spring:message code="page.menual.sub.trade.seven.block.title"/></h5>
                            <p class="card-text">
                                <spring:message code="page.menual.sub.trade.seven.block.body"/>
                            </p>
                        </div>
                    </div>
                </div>
                <!-- // tap1 -->
                <!-- tap2 -->
                <div class="manual__cont dev_tap2 d-none">
                    <div class="card mb-5">
                        <div class="image-hover thumbnail img-responsive">     
                                    <a href="#">                     
                                      <img src="${_ctx}/resources/img/manual/login-by-wallet.png" class="card-img-top" alt="Register">
                                    </a>                            
                                </div>
                        <div class="card-body card-body--order">
                            <div class="card-order">1</div>
                            <h5 class="card-title"><spring:message code="page.menual.sub.wallet.first.block.title"/></h5>
                            <p class="card-text">
                                <spring:message code="page.menual.sub.wallet.first.block.body"/>
                            </p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="card mb-5">
                                <div class="image-hover thumbnail img-responsive">     
                                    <a href="#">                     
                                      <img src="${_ctx}/resources/img/manual/login-by-user.png" class="card-img-top" alt="Register">
                                    </a>                            
                                </div>
                                <div class="card-body card-body--order">
                                    <div class="card-order">2</div>
                                    <h5 class="card-title"><spring:message code="page.menual.sub.wallet.second.first.block.title"/></h5>
                                    <p class="card-text">
                                        <spring:message code="page.menual.sub.wallet.second.first.block.body"/>
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="card mb-5">
                                <div class="image-hover thumbnail img-responsive">     
                                    <a href="#">                     
                                      <img src="${_ctx}/resources/img/manual/login-by-wallet.png" class="card-img-top" alt="Register">
                                    </a>                            
                                </div>
                                <div class="card-body card-body--order">
                                    <div class="card-order">2</div>
                                    <h5 class="card-title"><spring:message code="page.menual.sub.wallet.second.second.block.title"/></h5>
                                    <p class="card-text">
                                        <spring:message code="page.menual.sub.wallet.second.second.block.body"/>
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="card mb-5">
                                <div class="image-hover thumbnail img-responsive">     
                                    <a href="#">                     
                                      <img src="${_ctx}/resources/img/manual/login-success.png" class="card-img-top" alt="Register">
                                    </a>                            
                                </div>
                                <div class="card-body card-body--order">
                                    <div class="card-order">3</div>
                                    <h5 class="card-title"><spring:message code="page.menual.sub.wallet.third.first.block.title"/></h5>
                                    <p class="card-text">
                                        <spring:message code="page.menual.sub.wallet.third.first.block.body"/>
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="card mb-5">
                                <div class="image-hover thumbnail img-responsive">     
                                    <a href="#">                     
                                      <img src="${_ctx}/resources/img/manual/wallet-login-success.png" class="card-img-top" alt="Register">
                                    </a>                            
                                </div>
                                <div class="card-body card-body--order">
                                    <div class="card-order">3</div>
                                    <h5 class="card-title"><spring:message code="page.menual.sub.wallet.third.second.block.title"/></h5>
                                    <p class="card-text">
                                        <spring:message code="page.menual.sub.wallet.third.second.block.body"/>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card mb-5">
                        <div class="image-hover thumbnail img-responsive">     
                                    <a href="#">                     
                                      <img src="${_ctx}/resources/img/manual/wallet-user.png" class="card-img-top" alt="Register">
                                    </a>                            
                                </div>
                        <div class="card-body card-body--order">
                            <div class="card-order">4</div>
                            <h5 class="card-title"><spring:message code="page.menual.sub.wallet.four.block.title"/></h5>
                            <p class="card-text"><spring:message code="page.menual.sub.wallet.four.block.body"/></p>
                        </div>
                    </div>
                </div>
                <!-- // tap2 end -->
                <!-- tap3 -->
                <div class="manual__cont dev_tap3 d-none">
                    <div class="card mb-5">
                        <div class="image-hover thumbnail img-responsive">     
                                    <a href="#">                     
                                      <img src="${_ctx}/resources/img/manual/my-room-1.png" class="card-img-top" alt="Register">
                                    </a>                            
                                </div>
                        <div class="card-body card-body--order">
                            <div class="card-order">1</div>
                            <h5 class="card-title"><spring:message code="page.menual.sub.asset.first.block.title"/></h5>
                            <p class="card-text">
                                <spring:message code="page.menual.sub.asset.first.block.body"/>
                            </p>
                        </div>
                    </div>
                    <div class="row">
                        <div class="col-sm-6">
                            <div class="card mb-5">
                                <div class="image-hover thumbnail img-responsive">     
                                    <a href="#">                     
                                      <img src="${_ctx}/resources/img/manual/buy-history.png" class="card-img-top" alt="Register">
                                    </a>                            
                                </div>
                                <div class="card-body card-body--order">
                                    <div class="card-order">2</div>
                                    <h5 class="card-title"><spring:message code="page.menual.sub.asset.second.block.title"/></h5>
                                    <p class="card-text">
                                        <spring:message code="page.menual.sub.asset.second.block.body"/>
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="card mb-5">
                                <div class="image-hover thumbnail img-responsive">     
                                    <a href="#">                     
                                      <img src="${_ctx}/resources/img/manual/sell-history.png" class="card-img-top" alt="Register">
                                    </a>                            
                                </div>
                                <div class="card-body card-body--order">
                                    <div class="card-order">3</div>
                                    <h5 class="card-title"><spring:message code="page.menual.sub.asset.third.block.title"/></h5>
                                    <p class="card-text">
                                        <spring:message code="page.menual.sub.asset.third.block.body"/>
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="card mb-5">
                                <div class="image-hover thumbnail img-responsive">     
                                    <a href="#">                     
                                      <img src="${_ctx}/resources/img/manual/my-info.png" class="card-img-top" alt="Register">
                                    </a>                            
                                </div>
                                <div class="card-body card-body--order">
                                    <div class="card-order">4</div>
                                    <h5 class="card-title"><spring:message code="page.menual.sub.asset.four.block.title"/></h5>
                                    <p class="card-text">
                                        <spring:message code="page.menual.sub.asset.four.block.body"/>
                                    </p>
                                </div>
                            </div>
                        </div>
                        <div class="col-sm-6">
                            <div class="card mb-5">
                                <div class="image-hover thumbnail img-responsive">     
                                    <a href="#">                     
                                      <img src="${_ctx}/resources/img/manual/alarm-setting.png" class="card-img-top" alt="Register">
                                    </a>                            
                                </div>
                                <div class="card-body card-body--order">
                                    <div class="card-order">5</div>
                                    <h5 class="card-title"><spring:message code="page.menual.sub.asset.five.block.title"/></h5>
                                    <p class="card-text">
                                        <spring:message code="page.menual.sub.asset.five.block.body"/>
                                    </p>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <!-- // tap3 end -->
                <!-- modal image -->
                <div id="modal" class="modal fade modal-dialog-centered" tabindex="-1" role="dialog" style="display: none;">
                    <div class="modal-dialog modal-xl">
                        <div class="modal-content">
                            <div class="modal-header">
                                <!-- <button type="button" class="close" data-dismiss="modal"><i class="fa fa-times"></i></button> -->
                            </div>
                            <div class="modal-body">
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </article>
    </section>
</section>

<script>
$(function(){
    const URLSearch = new URLSearchParams(location.search);
    let tap = (URLSearch.get("tap")) ? URLSearch.get("tap") : 0;
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
$('.thumbnail').click(function(){
    $('.modal-body').empty();    
    $($(this).html()).appendTo('.modal-body');    
    $('#modal').modal('show');
});
$('#modal').on('show.bs.modal', function () {
   $('.thumbnail').addClass('blur');
});
$('#modal').blur(function(){ 
    console.log('abc');
   $('.thumbnail').removeClass('blur');
   $('#modal').modal('hide');
});
</script>
<!-- * Main -->
    <!-- footer -->
      <%@ include file="/WEB-INF/layout/web-new/include/footer.jsp"%>
    <!-- #footer -->
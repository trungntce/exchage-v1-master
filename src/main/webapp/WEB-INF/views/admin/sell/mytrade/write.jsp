<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/layout/admin/head.jsp"%>
<body class="pace-done">
<%@ include file="/WEB-INF/layout/admin/loader.jsp"%>

<div id="app" class="app app-header-fixed app-sidebar-fixed">
    <%@ include file="/WEB-INF/layout/admin/header.jsp"%>
    <%@ include file="/WEB-INF/layout/admin/sidebar.jsp"%>

    <div id="content" class="app-content app-wrapper">
        <!-- MAIN PANEL -->
        <div id="main" class="panel panel-inverse">
            <div class="panel-heading panel-top">
                <h4 class="panel-title">
                    <spring:message code="admin.subtitle.sell.mytrade.list.title"/>
                </h4>
                <!-- RIBBON -->
                <div class="panel-heading-btn">
                    <ol class="breadcrumb float-xl-end">
                        <li class="breadcrumb-item"><spring:message code="admin.subtitle.sell.management.title"/></li>
                        <li class="breadcrumb-item active">
                            <a href="javascript:window.location.reload();">
                                <spring:message code="admin.subtitle.sell.mytrade.list.title"/>
                            </a>
                        </li>
                    </ol>
                </div>
                <!-- END RIBBON -->
            </div>

            <!-- MAIN CONTENT -->
            <div class="panel-body">
                <!-- 총 기간 별 대쉬 보드 시작 -->
                <table style="width: 100%">
                    <!-- Form Sell -->
                    <form id="sellForm" method="POST">
                    <tr>
                        <td class="dev-form-title" field="NN"><label><spring:message code="common.admin.field.tokenName.title"/></label></td>
                        <td class="dev-form-content form-group">
                            <select id="symbol" name="symbol" class="form-select dev-form-input">
                                <c:forEach items="${tokens}" var="item" varStatus="loop">
                                    <option value="${item.symbol}" data-wallet-address="${item.walletAddress}" data-client-id="1" data-unit-price="${item.unitPrice}">${item.symbol}</option>
                                </c:forEach>
                            </select>
                            <input type="hidden" id="clientId" name="clientId" value="1">
                            <input type="hidden" id="buyerWalletAddress" name="buyerWalletAddress" value="">
                        </td>
                    </tr>

                    <c:if test="${wallet.role eq 'OPERATOR'}">
                    <tr>
                        <td class="dev-form-title" field="NN"><label>Type</label></td>
                        <td class="dev-form-content form-group">
                            <div class="form-check form-check-inline ms-2">
                                <input class="form-check-input rd-type" target=".tr-banker" type="radio" name="rd-type" checked>
                                <label class="form-check-label">Banker</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input rd-type" target=".tr-site" type="radio" name="rd-type">
                                <label class="form-check-label">Site</label>
                            </div>
                            <div class="form-check form-check-inline">
                                <input class="form-check-input rd-type" target=".tr-trader" type="radio" name="rd-type">
                                <label class="form-check-label">Trader</label>
                            </div>
                        </td>
                    </tr>
                    <tr class="tr-rd tr-site d-none">
                        <td class="dev-form-title" field="NN"><label>Site</label></td>
                        <td class="dev-form-content form-group">
                            <select id="siteDomain" class="dev-form-input">
                                <option value="" data-symbol="" data-site="" data-wallet-address="">::SELECTED::</option>
                                <c:forEach items="${sites}" var="item" varStatus="loop">
                                    <option value="${item.clientCode}" data-symbol="${item.symbol}" data-wallet-address="${item.walletAddress}" data-client-id="${item.clientId}" data-unit-price="${item.unitPrice}">${item.clientCode} - [${item.walletAddress}]</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    <tr class="tr-rd tr-trader d-none">
                        <td class="dev-form-title" field="NN"><label>Trader</label></td>
                        <td class="dev-form-content form-group">
                            <select id="trader" class="form-select dev-form-input">
                                <option value="" data-symbol="" data-site="" data-wallet-address="">::SELECTED::</option>
                                <c:forEach items="${traders}" var="item" varStatus="loop">
                                    <option value="${item.clientCode}" data-symbol="${item.symbol}" data-wallet-address="${item.walletAddress}" data-client-id="${item.clientId}" data-unit-price="${item.unitPrice}">${item.walletName} - [${item.walletAddress}]</option>
                                </c:forEach>
                            </select>
                        </td>
                    </tr>
                    </c:if>

                    <tr>
                        <td class="dev-form-title" field="NN"><label><spring:message code="common.admin.field.tokenNum.title"/></label></td>
                        <td class="dev-form-content form-group">
                            <spring:message code="common.admin.field.tokenNum.hint" var="tokenNumHint"/>
                            <input type="number" id="quantity" name="quantity" class="dev-form-input onlynum" placeholder="${tokenNumHint}" />
                        </td>
                    </tr>
                    <tr>
                        <td class="dev-form-title"><label><spring:message code="common.admin.field.unitPrice.title"/></label></td>
                        <td class="dev-form-content form-group ps-2" id="unitPrice">0</td>
                    </tr>
                    <tr>
                        <td class="dev-form-title"><label>Total price</label></td>
                        <td class="dev-form-content form-group ps-2" id="totalPrice">0</td>
                    </tr>
                    <input type="hidden" name="unitPrice"/>
                    <input type="hidden" name="totalPrice"/>
                    </form>
                    <!-- * Form Sell -->

                    <tr>
                        <div class="mt-2">
                            <td></td>
                            <td><button type="button" class="btn btn-success" id="btn-submit"><spring:message code="common.button.submit.title"/></button></td>    
                        </div>
                    </tr>
                </table>
                <!-- 총 기간 별 대쉬 보드 끝 -->
            </div>
        </div>
    </div>
</div>
<script>

    $(document).ready(function(){
        $("[name='symbol']").change();
    })

    $("[name='symbol']").change(function(){
        var optionSelected = $(this).find("option:selected");
        var symbol = optionSelected.val();
        $("#buyerWalletAddress").val(optionSelected.data("walletAddress"));
        $("#unitPrice").html((optionSelected.data("unitPrice")*1).toLocaleString());
        $(`input[name="unitPrice"]`).val(optionSelected.data("unitPrice"))
        $(`input[name="quantity"]`).val("")
        $("#totalPrice").html("0")
        $(`#siteDomain option:not([data-symbol="`+symbol+`"])`).addClass("d-none");
        $(`#siteDomain option[data-symbol="`+symbol+`"]`).removeClass("d-none");
        $(`#siteDomain option[data-symbol=""]`).removeClass("d-none");

        $(`#trader option:not([data-symbol="`+symbol+`"])`).addClass("d-none");
        $(`#trader option[data-symbol="`+symbol+`"]`).removeClass("d-none");
        $(`#trader option[data-symbol=""]`).removeClass("d-none");
    });

    $("#siteDomain").change(function(){
        var optionSelected = $(this).find("option:selected");
        var symbol = optionSelected.val();
        $("#buyerWalletAddress").val(optionSelected.data("walletAddress"));
        $("#unitPrice").html((optionSelected.data("unitPrice")*1).toLocaleString());
        $(`input[name="unitPrice"]`).val(optionSelected.data("unitPrice"))
    })

    $("#trader").change(function(){
        var optionSelected = $(this).find("option:selected");
        var symbol = optionSelected.val();
        $("#buyerWalletAddress").val(optionSelected.data("walletAddress"));
        $("#unitPrice").html((optionSelected.data("unitPrice")*1).toLocaleString());
        $(`input[name="unitPrice"]`).val(optionSelected.data("unitPrice"))
    })

    $("#quantity").keyup(function(){
        var unit = $(`input[name="unitPrice"]`).val() * 1;
        var amount = $(this).val() * 1;
        var totalPrice = unit * amount;
        $("#totalPrice").html(totalPrice.toLocaleString())
        $(`input[name="totalPrice"]`).val(totalPrice)
    })

    $(".rd-type").change(function(){
        var target = $(this).attr("target");
        $(".tr-rd:not(.d-none)").addClass("d-none");
        $(target).removeClass("d-none");
        if(target == ".tr-banker"){
            $("#buyerWalletAddress").val("0x8014cee0f6f494429f2e76b3add33d2842b6126a")
        }else{
            $("#buyerWalletAddress").val("")
        }
    })

    $("#btn-submit").click(function(){
        submitForm('#sellForm')
    })

    <c:if test="${wallet.role eq 'OPERATOR'}">
    $(document).ready(function(){
        $("#buyerWalletAddress").val("0x8014cee0f6f494429f2e76b3add33d2842b6126a")
    })   
    </c:if>
</script>


</body>
</html>
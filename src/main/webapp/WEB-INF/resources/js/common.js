function goPage(_page) {
    var s = new URLSearchParams(window.location.search);
    (s.get("page") == null) ? s.append("page", _page) : s.set("page", _page);
    document.location.href = location.pathname+"?"+s.toString();
};

var formatter = new Intl.NumberFormat('en-US', {
  currency: 'KRW',
});

function changeSearchParam(params){
    var s = new URLSearchParams(window.location.search);
    var hash = location.hash;
    console.log(hash)
    for(var k in params){
        (s.get(k) == null) ? s.append(k, params[k]) : s.set(k, params[k]);
    }
    return location.pathname+"?"+s.toString()+hash;
}

function getParams(par, def){
    var s = new URLSearchParams(window.location.search);
    return (s.get(par) == null) ? def : s.get(par);
}

async function submitForm(tagForm){
    $(tagForm).submit();
}

// Delay + Timer
var timer = ms => new Promise(res => setTimeout(res, ms));

function delay(callback, ms) {
  var timer = 0;
  return function() {
    var context = this, args = arguments;
    clearTimeout(timer);
    timer = setTimeout(function () {
      callback.apply(context, args);
    }, ms || 0);
  };
}

// Http request
var rest = {
    type: {
        FORM: "form",
        JSON: "json"    
    },
    post: function(mUrl, mType, mData){
        if(mType == "json"){
            return $.ajax({
                "url": mUrl,
                "method": "POST",
                "cache": false,
                "timeout": 0,
                "headers": {
                    "Content-Type": "application/json",
                },
                "data": JSON.stringify(mData)
            });
        }else{
            var formData = new FormData();
            for(var key in mData){
                formData.append(key, mData[key]);
            }
            $.ajax({
                "async": true,
                "crossDomain": true,
                "url": mUrl,
                "method": "POST",
                "data": formData,
                "processData": false,
                "contentType": false,
                "mimeType": "multipart/form-data"
            });
        }
    },
    get: function(mUrl, mData){
        return $.ajax({
            "type": "GET",
            "url": mUrl,
            "data": mData,
            "contentType": "application/json; charset=utf-8",
        });
    }
}

var store = {
    get: function(k){
        return sessionStorage.getItem(k);
    },
    set: function(k, v){
        sessionStorage.setItem(k, v);
    },
    remove: function(k){
        sessionStorage.removeItem(k);
    }
}

var client = {
    isExists: async function(apiKey, clientCode) {
        apiKey = (apiKey === undefined || apiKey.length == 0) ? null : apiKey;
        clientCode = (clientCode === undefined || clientCode.length == 0) ? null : clientCode;
        var api = "/admin/api/validate/client";
        var param = {"apiKey": apiKey, "clientCode": clientCode};
        var res = await $.when(rest.get(api, param));
        return res;
    }
}

var token = {
    isExists: async function(symbol) {
        symbol = (symbol === undefined || symbol.length == 0) ? null : symbol;
        var api = "/admin/api/validate/token";
        var param = {"symbol": symbol};
        var res = await $.when(rest.get(api, param));
        return res;
    },
    transferFee: async function(param){
        if(param.fromWalletAddress === undefined || param.toWalletAddress === undefined || param.quantity === undefined) return null
        const api = "/transfer"
        var res = await $.when(rest.post(api, rest.type.JSON, param))
        return res
    }
}

var user = {
    isExists: async function(loginId) {
        loginId = (loginId === undefined || loginId.length == 0) ? null : loginId;
        var api = "/admin/api/validate/user";
        var param = {"loginId": loginId};
        var res = await $.when(rest.get(api, param));
        return res;
    }
}

var analysis = {
    tokenHome: async function(param){
        var api = "/admin/api/analysis/holder/group";
        var res = await $.when(rest.get(api, param));
        return res;
    },
    alarmAdmin: async function(param){
        var api = "/admin/api/analysis/order";
        var res = await $.when(rest.get(api, param));
        return res;
    }
}

function isEllipsisActive($jQueryObject) {
    return ($jQueryObject.outerWidth() < $jQueryObject[0].scrollWidth);
}

function checkFieldNotNull(view, isClient){
    if(view == null) view = "";
    var isNull = false;
    $(view+' [field="NN"]').each(function(){
        var valIp = $(this).parent().find("input");
//        console.log(`${isEmptyInput(valIp)} : ${valIp}`)
        if(isEmptyInput(valIp)){
            isNull = true;
            (!isClient) ? $(this).parent().parent().find(".message").removeAttr("hidden") : $(this).parent().find(".input-label-error").addClass("show");
        }else{

            (!isClient) ? $(this).parent().parent().find(".message").attr("hidden", "") : $(this).parent().find(".input-label-error").removeClass("show");
        }
    })
    return isNull;
}

function generalQRCode(idView, valueQr){
    var qr = new QRious({
        element: document.getElementById(idView),
        value: valueQr,
        background: '#ffffff00', // background color
        foreground: 'black', // foreground color
        backgroundAlpha: 1,
        foregroundAlpha: 1,
        level: 'L', // Error correction level of the QR code (L, M, Q, H)
        mime: 'image/png', // MIME type used to render the image for the QR code
        size: 250, // Size of the QR code in pixels.
        padding: null // padding in pixels
    });
}

/**
 * @param: mType 
 * String yyyy/MM/dd HH:mm:ss
 * #yyyy: year
 * #MM: month
 * #dd: day
 * #HH: hour
 * #mm: minutes
 * #ss: seconds
 * */
Date.prototype.toStringByType = function(mType){
    const year = this.getFullYear();
    const month = (this.getMonth() < 9) ? "0" + (this.getMonth() + 1) : (this.getMonth() + 1);
    const day = (this.getDate() < 10) ? "0" + this.getDate() : this.getDate();
    const hour = (this.getHours() < 10) ? "0" + this.getHours() : this.getHours();
    const minutes = (this.getMinutes() < 10) ? "0" + this.getMinutes() : this.getMinutes();
    const seconds = (this.getSeconds() < 10) ? "0" + this.getSeconds() : this.getSeconds();
    return mType.replace("yyyy", year)
            .replace("MM", month)
            .replace("dd", day)
            .replace("HH", hour)
            .replace("mm", minutes)
            .replace("ss", seconds)
}

Date.prototype.age = function({year="년", day="일", hour="시", minute="분", second="초", ago="전"} = {}){
    var d1 = Date.now();
    var cl = d1 - this.getTime();
    cl = cl / (24 * 60 * 60 * 1000);

    var fm = "";
    var v = {
        years: 0,
        days: 0,
        hours: 0,
        minutes: 0,
        seconds: 0
    }

    //Get day
    v.days = Math.trunc(cl);
    v.years = Math.trunc(cl/365);
    //Get hour
    cl = cl % 1;
    v.hours = Math.trunc(cl * 24);
    //Get minutes
    cl = (cl * 24) % 1;
    v.minutes = Math.trunc(cl * 60);
    //Get second
    cl = (cl * 60) % 1;
    v.seconds = Math.trunc(cl * 60);

    if(v.years > 0) fm = `%y ${year} ${ago}`
    else if(v.days > 100) fm = `%d ${day} ${ago}`
    else if(v.days > 0) fm = `%d ${day} %h ${hour} ${ago}`
    else if(v.hours > 0) fm = `%h ${hour} %m ${minute} ${ago}`
    else if(v.minutes > 0) fm = `%m ${minute} ${ago}`
    else fm = `%s ${seconds} ${ago}`

    return fm.replace("%y", v.years)
        .replace("%d", v.days)
        .replace("%h", v.hours)
        .replace("%m", v.minutes)
        .replace("%s", v.seconds)
}

Date.prototype.addDays = function(days) {
    var date = new Date(this.valueOf());
    date.setDate(date.getDate() + days);
    return date;
}

String.prototype.txShortcut = function(number){
    return this.substr(0, number) + "..." + this.substr(this.length - number, number)
}

String.prototype.isUrl = function(){
    var urlPattern = ["javascript:", "javascript:;", "#", ""]
    return (urlPattern.indexOf(this.toString()) == -1) ? true : false;
}

function isEmptyInput(view){
    var str = view.val().trim();
    if(str.length == 0) return true;
    return false;   
}


function transfer(mFrom, mTo, mAmount, mSymbol){
    var strMessage = "Do you want transfer";
    if(confirm(strMessage) == true){
        //transfer
        var url = "/admin/transfer.al?from="+mFrom+"&to="+mTo+"&amount="+mAmount+"&symbol="+mSymbol;
        location.href = url;
    }else{
        return false;
    }
}

$(document).ready(function(){
    
    //Admin Page
    $('[redirect]').click(function(){
        var url = $(this).attr("redirect");
        // $("#loader").show();
        $("#loader").removeClass("loaded");
        window.location.href = url;
        // $("#loader").hide();
    })

    $("a").click(function(e){ 
        if(!e.ctrlKey && $(this).attr("href") !== undefined && $(this).attr("href").isUrl() == true){
            $("#loader").removeClass("loaded");
        } 
    })

     $("form").submit(function(){
        $(this.submit())
        $("#loader").removeClass("loaded");
     })

    $("input.onlynum").on("input",function(){
        var str = $(this).val();
        var lastChar = (str.length > 0) ? str.substring(str.length - 1)  : false ;
        if(!lastChar) return;
        if(isNaN(lastChar)) $(this).val(str.slice(0, -1)); 
    })

    $(".my-balance[wallet-address]").each(function(){
        loadBalance({walletAddress: $(this).attr("wallet-address"), symbol: $(this).data("symbol")})
    })

    $(`[type="number"][min]`).bind('keyup mouseup', function () {
        var val = $(this).val() * 1
        if(val == 0) $(this).val("")
    });
})

 var myWalletBalance = 0.0;
//Request Common
async function loadBalance(mParam){
    var api = "/balance";
    var param = (mParam == null) ? {} : mParam;
    var res = await $.when(rest.get(api, param));
    if(mParam.symbol == null){
        $(`.my-balance[wallet-address="${mParam.walletAddress}"]`).html((res*1).toLocaleString());
    }else{
        $(`.my-balance[wallet-address="${mParam.walletAddress}"][data-symbol="${mParam.symbol}"]`).html((res*1).toLocaleString());
    }
    //if($(".item-wallet.skeleton")[0]) $(".item-wallet.skeleton").removeClass("skeleton");
}
// Get balance for web
 var myWalletBalance = 0.0;
//Request Common
async function loadBalanceWeb(mParam){
    if (mParam.symbol === 'BANI' || mParam.symbol === 'EGG') {                
        var api = "/balance";
        var param = (mParam == null) ? {} : mParam;
        // console.log(mParam);
        var res = await $.when(rest.get(api, param));
        // console.log(res);
         $(".my-balance[wallet-address='"+mParam.walletAddress+"']").html((res*1).toLocaleString());
        myWalletBalance = res *1;

        // if($(".item-wallet.skeleton")[0]) $(".item-wallet.skeleton").removeClass("skeleton");
    }

}

// async function loadAlarmTotal(mParams, type){
//    var api = "/alarm";

//    var alarmTotal = 0;
//    var param = (mParams == null) ? {lastedId: 0, checkYn: "N", delYn: "N"} : mParams;
//    var res = await $.when(rest.get(api, param));
//     console.log(res);
//    if(res != null) {
//        var data = res;

//        if(data === undefined) return;

//        alarmTotal = data.length;
//        console.log(alarmTotal);
//        // Load alarm total cache
//        var isFristAlarm = (store.get("isFristAlarm") == null) ? true : false;

//        if(alarmTotal > 0 && type == "admin"){
//            notifySound(isFristAlarm);
//            $("#alarmNavbarTotalCntBadge").html(alarmTotal);
//            loadDataAlarmViewAdmin(data);
//        }

//        if(data.length > 0 && type == "user"){

//            loadDataAlarmView(data);
//        }
//    }
// }
var permission = {
    audio: true
}
async function notifySound(isFristAlarm){
    // console.log(countAlarm)
     if(countAlarm <=0){
        return;
    }
    // console.log('@@@');  
    // console.log('seconds: '+seconds);
    // console.log('step_play_sound: '+step_play_sound);
    // console.log('countAlarmFirst: '+countAlarmFirst);
    // console.log('countAlarm: '+countAlarm);
    // console.log('@@@');
    var audio = document.getElementById('sound-3'); 
    document.getElementById('sound-3').volume = 1.0;
    // console.log(audio);
    if (step_play_sound == 0 || step_play_sound == 1 ) {
         countAlarmFirst = countAlarm;
    }
    step_play_sound ++;
 
    if (step_play_sound > seconds) {
        if(countAlarmFirst != countAlarm){            
            step_play_sound = 1;        
            // console.log('audio run again '+ step_play_sound);
         }else {
            // console.log("false");
            audio.loop = false;
            // console.log('stop');            
            return;
         }
    }

    store.set("isFristAlarm", true);
    // console.log('sound');  

    
    document.getElementById('sound-3').muted = false
    if(audio == null) return;
     if(audio.pause && permission.audio){
        document.getElementById('sound-3').play();
        
        // if (seconds < 3000) {
        //     await timer(4000);
        
        // }else{
        //     await timer(2000);
        // }
    }   
    
    
    if (step_play_sound > seconds) {
        // console.log("false");
        //audio.loop = false;
        
    }else{
         document.getElementById('sound-3').play().catch((e)=>{
           
        });;
        // console.log("true" + step_play_sound);
        while(!finishAudio){
            await timer(5000);
        }
        
        
    }
    
/*
    await timer(6000 * seconds);
    audio.pause();
    
   
    audio.currentTime = 0;
  */  
}

// Client
function showModal(view, isScrollTop){
    $(".mask").css({display: "unset"});
    $(view).css({display: "unset"});
    console.log($(view));
    if(isScrollTop){
        $(document).scrollTop(0);
    }
}
function hideModal(view){
    $(".mask").css({display: "none"});
    $(view).css({display: "none"});
    $(view).find("input").val("");
}

function closeTap(obj, isNoneMask){
    console.log(obj);
    obj.parentNode.style.display = "none";
    if(isNoneMask) $(".mask").css({display: "none"});
}

async function updateReadYn(){
    var api = "/alarm/update";
    var param = {checkYn: "Y"};
    var res = await $.when(rest.post(api, rest.type.JSON, param));
}

function displayModal(target){
    $('.dim').click();
    $("#"+target).addClass('is-active');
    $('html').addClass('modal-open');
}

function changeLanguage(language){
    event.preventDefault();
//    let urlParams = window.location.href;
//    console.log(urlParams)
//    urlParams
//    let href = "";
//    console.log(window.location.href);
//
//        if(urlParams.includes("?") === false || urlParams.includes("?langCode") === true){
//            urlParams = urlParams.replace("?langCode=en_US","").replace("&langCode=en_US","");
//            urlParams= urlParams.replace("?langCode=ko_KR","").replace("&langCode=ko_KR","");
//            href = "?langCode=" + language;
//         }
//         else{
//            urlParams = urlParams.replace("?langCode=en_US","").replace("&langCode=en_US","");
//            urlParams= urlParams.replace("?langCode=ko_KR","").replace("&langCode=ko_KR","");
//            href = "&langCode=" + language;
//        }
    location.href = changeSearchParam({langCode: language});
}
const filesApi = {
    uploads: function(file, xhrCallback, successCallback){
        const api = "/files/upload"
        var formData = new FormData();
        formData.append("file", file);
        $.ajax({
            "async": true,
            "crossDomain": true,
            "url": api,
            "method": "POST",
            "data": formData,
            "processData": false,
            "contentType": false,
            "mimeType": "multipart/form-data",
            xhr: function(){
                var xhr = new window.XMLHttpRequest();
                xhr.upload.addEventListener("progress", function(evt) {
                    if (evt.lengthComputable) {
                        var percentComplete = (evt.loaded / evt.total) * 100;
                        // Place upload progress bar visibility code here
                        xhrCallback(percentComplete)
                    }
                }, false);
                return xhr;
            },
            success: function(res){
                successCallback(JSON.parse(res))
            }
        })
    }
}

   
/**
 * make date : 2022-05-14
 * maker : Trung.
 * className : common then use ajax
 * description : Commons Validator for all input form
 */
 var ajaxPost = function(url, data){
    return $.ajax({
        "url": url,
        "method": "POST",
        'cache': false,
        "timeout": 0,
        "headers": {
            "Content-Type": "application/json",
        },
        "data": data
    });
 }

/**
 * make date : 2022-05-24
 * maker : Tuyen.
 * className : common then use ajax
 * description : Call get method
 */
 var ajaxGet = function(url, data){
    return $.ajax({
        "type": "GET",
        "url": url,
        "data": data,
        "contentType": "application/json; charset=utf-8",
    });
 }
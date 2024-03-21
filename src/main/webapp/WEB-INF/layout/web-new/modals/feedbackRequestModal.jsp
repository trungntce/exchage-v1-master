<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="${_ctx}/resources/js/ckeditor/ckeditor.js"></script>

<div class="join-terms-wrap" id="feedbackRequestModal" style="top: 50vh;width: 1000px;">
    <div class="close" id="closeTap-alert-select" onclick="closeTap(this, true)"></div>
    <h2><b><spring:message code="feedback.title.create"/></b></h2>
    <div class="list-wrap trade-list-wrap" id="setting" style="max-height: max-content;">       
            <form id="feedbackForm" method="POST" action="${_ctx}/feedback/request">
                <dl class="trade-pop-form-info-item" style="grid-template-columns:15rem 1fr">
                    <dt><spring:message code="feedback.title.text"/></dt>
                    <dd class="form-group">
                        <input id="title" name="title"  />                       
                        <span class="form-message float-none-message text-red"></span>
                    </dd>
                    <!-- <dd></dd> -->
                </dl>
                <dl class="trade-pop-form-info-item" style="grid-template-columns:15rem 1fr;height: auto;">
                    <dt><spring:message code="feedback.title.contents"/></dt>
                    <dd class="form-group">
                      <textarea id="contents-request" name="contents" cssClass="ckeditor form-control w-100"></textarea>                   
                        <span class="form-message float-none-message text-red"></span>
                    </dd>
                    <!-- <dd></dd> -->
                </dl>
                <dl class="trade-pop-form-info-item" style="grid-template-columns:15rem 1fr;height: auto;">
                    <dt><spring:message code="feedback.title.file.attach"/>
                    <input type="file" id="file-request" name="file" class="d-none">
                                <button type="button" class="btn btn-sm" id="btn-attach-file-request"><i class="ci ci-attach"></i></button>
                                </dt>
                    <dd class="form-group">                       
                                <ul class="list-group list-group-horizontal ml-1" id="list-attach-file-request"></ul>
                    </dd>
                    <!-- <dd></dd> -->
                </dl>
               <div class="submit_btn">
                    <button class="status-btn status-ing" type="submit" style="width:30%"><spring:message code="common.button.submit.title"/></button>
               </div>
            </form>
        <!-- </div> -->
    </div>
</div>
<script>

    editor = CKEDITOR.replace('contents-request');
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

    init()

    function init(){        
        actionView()
    }
    function actionView(){
        $("#btn-attach-file-request").click(function(){            
            $('#file-request').click()
        })

        $('#file-request').change(function(){
            console.log('12222')
            var file = $(this).prop("files")[0];
            console.log(file);
            $("#list-attach-file-request").append(htmlItemFile(file))
            filesApi.uploads(file, xhrCallback, successCallback)
        })
    }
    

    function htmlItemFile(file){
        return `<li class="list-group-item position-relative float-left" style="margin: 5px 0px;">
            <i class="file-ico-remove" onclick="removeAttachFile(this)"></i>
            <div class="text-center"><i class="fas fa-link text-secondary h3"></i></div>
            <input type="hidden" name="fileIds" value="0"/>
            <a class="approval-attr-file" href="#"><small>`+file.name+`</small></a>
            <div class="progress" style="height: 2px;">
                <div class="progress-bar" role="progressbar" style="width: 0%;" aria-valuenow="25" aria-valuemin="0" aria-valuemax="100"></div>
            </div>
        </li>`
    }
    function removeAttachFile(obj){
        console.log(obj);
        obj.parentNode.remove();
    }
    function xhrCallback(percent){
        $(".progress-bar").css("width", percent+"%")
    }
    var fileIds_request = '';
    function successCallback(fileDto){
        console.log(fileDto)
        $(".progress").remove()
        // $(`[name="fileId"][value="0"]`).val(fileDto.fileId)
        fileIds_request = fileDto.fileId;


        $(`[name="fileIds"][value="0"]`).val(fileIds_request)
        
        $(`.approval-attr-file:last`).attr("href", `/upload/`+fileDto.filePath+`/`+fileDto.fileHashName)
    }


</script>
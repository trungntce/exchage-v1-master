<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<script type="text/javascript" src="${_ctx}/resources/js/ckeditor/ckeditor.js"></script>
<div class="join-terms-wrap" id="feedbackModal" style="top: 50vh;width: 1000px; max-height: max-content !important;">    
    <div class="close" id="close-modal"></div>
    <h2><b><spring:message code="feedback.title.create"/></b></h2>
    <div class="list-wrap trade-list-wrap" id="setting" style="max-height:800px !important">       
                <dl class="trade-pop-form-info-item" style="grid-template-columns:20rem 1fr">
                    <dt><spring:message code="feedback.title.text"/></dt>
                    <dd class="form-group">
                        <p>${feedbackDetail[0].title}</p>                       
                        <span class="form-message float-none-message text-red"></span>
                    </dd>
                    <!-- <dd></dd> -->
                </dl>
                <br>
                <c:forEach items="${feedbackDetail}" var="item" varStatus="loop">                  
                <dl class="trade-pop-form-info-item" style="grid-template-columns:20rem 1fr;height: auto; line-height: 30px;">
                    <dt><p style="color:blue">From: ${item.regUser}</p>
                        <p>Time:</p>
                        <p style="font-weight: 100; font-style: italic;"><fmt:formatDate value="${item.regDate}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                        <c:forEach items="${feedbackFiles}" var="itemFiles" varStatus="loop">
                            <c:if test="${itemFiles.refId == item.feedbackId}">
                                <p>Attach file: </p>
                                 <a style="text-decoration:underline; font-weight: 100" id="attach-img" href="/upload/${itemFiles.filePath}/${itemFiles.fileHashName}"><small>${itemFiles.fileName}</small></a>

                            </c:if>
                        </c:forEach>


                    </dt>                    
                    <dd class="form-group" style="font-weight:100">
                        ${item.contents}
                    </dd>
                    <!-- <dd></dd> -->
                </dl>
                </c:forEach>                        
              
                <form id="feedbackForm" method="POST" action="${_ctx}/feedback/request">
                <dl class="trade-pop-form-info-item fix-height-110" style="grid-template-columns:15rem 1fr;height: max-content !important;">
                    <input type="text" name="feedbackId" value="${feedbackDetail[0].feedbackId}" hidden>
                    <input type="text" name="title" value="${feedbackDetail[0].title}" hidden>
                    <input type="text" name="state" value="${feedbackDetail[0].state}" hidden>
                    <dt><spring:message code="feedback.title.contents"/></dt>
                    <dd class="form-group">
                      <textarea id="contents" name="contents" cssClass="ckeditor form-control w-100"></textarea>
                      <br>
                        <span class="form-message float-none-message text-red"></span>
                    </dd>
                    <!-- <dd></dd> -->
                </dl>
                <dl class="trade-pop-form-info-item" style="grid-template-columns:15rem 1fr;height: auto;">
                    <dt><spring:message code="feedback.title.file.attach"/>
                    <input type="file" id="file" name="file" class="d-none">
                                <button type="button" class="btn btn-sm" id="btn-attach-file"><i class="ci ci-attach"></i></button>
                                </dt>
                    <dd class="form-group">                       
                                <ul class="list-group list-group-horizontal ml-1" id="list-attach-file"></ul>
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

    editor = CKEDITOR.replace('contents');
   
           Validator({
            form: '#feedbackForm',
            formGroupSelector: '.form-group',
            errorSelector: '.form-message',
            rules: [
                // Check null
                Validator.isRequired('#contents', "<spring:message code='the.input.not.valid'/>"),
                // Validator.isRegexPhoneNumber('#repeatSeconds', "<spring:message code='the.input.not.valid'/>"),
                // Validator.isNotZero('#repeatSeconds', "<spring:message code='the.input.not.valid'/>"),

            ],
        });

    init()

    function init(){        
        actionView()

    }
    function actionView(){
        $("#btn-attach-file").click(function(){            
            $('#file').click()
        })

        $('#file').change(function(){

            var file = $(this).prop("files")[0];
            console.log(file);
            $("#list-attach-file").append(htmlItemFile(file))
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
    var fileIds = '';
    function successCallback(fileDto){
        console.log(fileDto)
        $(".progress").remove()
        // $(`[name="fileId"][value="0"]`).val(fileDto.fileId)
        fileIds = fileDto.fileId;


        $(`[name="fileIds"][value="0"]`).val(fileIds)
        console.log(fileIds)
        $(`.approval-attr-file:last`).attr("href", `/upload/`+fileDto.filePath+`/`+fileDto.fileHashName)
    }

    $('#close-modal').click(function(){        
        
        // closeTap(this, true);
        var url = changeSearchParam({showDetail:'N'})
        document.location.href = url;
    });
    $('#attach-img').click(function(e){
       $("#loader").hide();
    });

</script>
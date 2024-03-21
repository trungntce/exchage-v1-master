<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="ko">
<%@ include file="/WEB-INF/layout/admin/head.jsp"%>
<body class="pace-done">
<%@ include file="/WEB-INF/layout/admin/loader.jsp"%>
<script type="text/javascript" src="${_ctx}/resources/js/ckeditor/ckeditor.js"></script>
<div id="app" class="app app-header-fixed app-sidebar-fixed">
    <%@ include file="/WEB-INF/layout/admin/header.jsp"%>
    <%@ include file="/WEB-INF/layout/admin/sidebar.jsp"%>

    <div id="content" class="app-content app-wrapper">
        <!-- MAIN PANEL -->
        <div id="main" class="panel panel-inverse">
            <div class="panel-heading panel-top">
                <h4 class="panel-title">
                    <spring:message code="admin.subtitle.account.user.list.title"/>
                </h4>
                <!-- RIBBON -->
                <div class="panel-heading-btn">
                    <ol class="breadcrumb float-xl-end">
                        <li class="breadcrumb-item"><spring:message code="admin.subtitle.account.title"/></li>
                        <li class="breadcrumb-item active">
                            <a href="javascript:window.location.reload();">
                                <spring:message code="admin.subtitle.account.user.list.title"/>
                            </a>
                        </li>
                    </ol>
                </div>
                <!-- END RIBBON -->
            </div>

            <!-- MAIN CONTENT -->
            <div class="panel-body">             

            
            <div id="feedbackModal" style="margin-left: 20px;">    
                <div class="close" id="close-modal"></div>
                <!-- <h2><b><spring:message code="feedback.title.create"/></b></h2> -->
                <div class="list-wrap trade-list-wrap" id="setting">       
                            <dl class="trade-pop-form-info-item" style="grid-template-columns:20rem 1fr">
               <!--                  <dt><spring:message code="feedback.title.text"/></dt> -->
                                <dd class="form-group">
                                    <h2>${feedbackDetail[0].title}</h2>                       
                                    <span class="form-message float-none-message text-red"></span>
                                </dd>
                                <!-- <dd></dd> -->
                            </dl>
                            <br>
                            <c:forEach items="${feedbackDetail}" var="item" varStatus="loop">                  
                            <dl class="trade-pop-form-info-item">
                                <dt><p style="color:blue">From: ${item.regUser}</p>
                                    <p>Time:</p>
                                    <p style="font-weight: 100; font-style: italic;"><fmt:formatDate value="${item.regDate}" pattern="yyyy-MM-dd HH:mm:ss"/></p>
                                     Attach file: 
                                    <c:forEach items="${feedbackFiles}" var="itemFiles" varStatus="loop">
                                        <c:if test="${itemFiles.refId == item.feedbackId}">                                           
                                             <a style="text-decoration:underline; font-weight: 100" id="attach-img" href="/upload/${itemFiles.filePath}/${itemFiles.fileHashName}"><small>${itemFiles.fileName}</small></a>
                                        </c:if>
                                    </c:forEach>
                                </dt>      
                                <br><br>              
                                <dd class="form-group" style="font-weight:100">
                                    ${item.contents}
                                </dd>
                                <!-- <dd></dd> -->
                            </dl>
                            <hr width="100%" color="green" />
                            </c:forEach>                        
                          
                        <form id="feedbackForm" method="POST" action="${_ctx}/admin/feedback/reply">
                              
                                
                            <dl class="trade-pop-form-info-item" style="grid-template-columns:15rem 1fr;height: auto;">
                                <input type="text" name="feedbackId" value="${feedbackDetail[0].feedbackId}" hidden>
                                <input type="text" name="authRequest" value="admin" hidden>
                                <input type="text" id="state" name="state" value="1" hidden>
                                <input type="text" name="title" value="${feedbackDetail[0].title}" hidden>
                                <dt><spring:message code="feedback.title.reply"/></dt>
                                <br>
                                <dd class="form-group">
                                  <textarea id="contents" name="contents" cssClass="ckeditor form-control w-100"><p></textarea>                   
                                    <span class="form-message float-none-message text-red"></span>
                                </dd>
                                <!-- <dd></dd> -->
                            </dl>
                            <dl class="trade-pop-form-info-item">
                                <dt>
                                <input type="file" id="file" name="file" class="d-none">
                                            <button type="button" class="btn btn-dark" id="btn-attach-file"><i class="ci ci-attach"></i><spring:message code="feedback.title.file.attach"/></button>
                                            </dt>
                                <dd class="form-group">                       
                                            <ul class="list-group list-group-horizontal ml-1" id="list-attach-file"></ul>
                                </dd>
                                <!-- <dd></dd> -->
                            </dl>
                           <div class="submit_btn">
                                <button class="btn btn-info" type="button" onclick="submitStatus(2)" style="width:30%"><spring:message code="common.button.submit.title"/></button>

                                <button class="btn btn-warning" type="button" onclick="submitStatus(3)" style="width:30%"><spring:message code="feedback.list.state.processing"/></button>
                                <button class="btn btn-success" type="button" onclick="submitStatus(4)" style="width:30%"><spring:message code="feedback.list.state.finished"/></button>
                           </div>                             
                        </form>
                    <!-- </div> -->
                     <form id="feedbackStatusForm" method="POST" action="${_ctx}/admin/feedback/updateStatus">
                        <input type="text" name="feedbackId" value="${feedbackDetail[0].feedbackId}" hidden>
                        <input type="text" id="status-update" name="state"  hidden>
                    </form>
                </div>
            </div>

            </div>
        </div>
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

    function submitStatus(status){
        // if(status=== 3){
        //     $('#status-update').val(3)
        // }else if(status=== 4){
        //     $('#status-update').val(4)
        // }
        $('#state').val(status);
        $("#feedbackForm").submit();
    }

</script>

</body>
</html>
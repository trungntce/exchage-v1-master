<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<div class="join-terms-wrap modal-wallets" id="alarmSettings" style="top: 50vh">
    <div class="close" id="closeTap-alert-select" onclick="closeTap(this, true)"></div>
    <h2><spring:message code="myroom.setting.title"/></h2>
    <div class="list-wrap trade-list-wrap" id="setting">
        <div class="trade-pop-form-info">
            <dl class="trade-pop-form-info-item" style="grid-template-columns:15rem 1fr">
                <dd><spring:message code="myroom.setting.title"/></dd>
            </dl>
            <form id="alarmForm" method="POST" action="${_ctx}/myRoom/alarmUpdate">
                <dl class="trade-pop-form-info-item" style="grid-template-columns:15rem 1fr">
                    <dt><spring:message code="myroom.information.wallet.address.title"/></dt>
                    <dd>${wallet_current.walletAddress}</dd>
                    <input name="walletAddress" id="walletAddress" type="hidden" value="${wallet_current.walletAddress}" />
                </dl>
                <dl class="trade-pop-form-info-item" style="grid-template-columns:15rem 1fr">
                    <dt><spring:message code="alarm.field.soundYn.title"/></dt>
                    <dd>
                        <input type="radio" id="useYn1" name="useYn" value="Y" <c:if test="${wallet_current.useYn eq 'Y'}">checked</c:if>><label for="useYn1" class="ms-1 me-3"><spring:message code="alarm.useYn.yes.title"/></label>
                        <input type="radio" id="useYn2" name="useYn" value="N" <c:if test="${wallet_current.useYn != 'Y'}">checked</c:if>><label for="useYn2" class="ms-1 me-3"><spring:message code="alarm.useYn.no.title"/></label>
                    </dd>
                </dl>
                <dl class="trade-pop-form-info-item" style="grid-template-columns:15rem 1fr">
                    <dt><spring:message code="myroom.setting.filePath.title"/></dt>
                    <dd>
                        <input type="radio" id="path1" name="path" value="${_ctx}/resources/dist/audio/sound-1.mp3" <c:if test="${wallet_current.path eq '/resources/dist/audio/sound-1.mp3' || walletCurrent.path == null}">checked</c:if>><label for="path1" class="ms-1 me-3"><spring:message code="alarm.sound.title"/> 1</label>
                        <input type="radio" id="path2" name="path" value="${_ctx}/resources/dist/audio/sound-2.mp3" <c:if test="${wallet_current.path eq '/resources/dist/audio/sound-2.mp3'}">checked</c:if>><label for="path2" class="ms-1 me-3"><spring:message code="alarm.sound.title"/> 2</label>
                        <input type="radio" id="path3" name="path" value="${_ctx}/resources/dist/audio/sound-3.mp3" <c:if test="${wallet_current.path eq '/resources/dist/audio/sound-3.mp3'}">checked</c:if>><label for="path3" class="ms-1 me-3"><spring:message code="alarm.sound.title"/> 3</label>


                    </dd>
                </dl>
                <dl class="trade-pop-form-info-item" style="grid-template-columns:15rem 1fr">
                    <dt><spring:message code="alarm.sound.title"/></dt>
                    <dd>
                        <button type="button" class="btn btn-success mb-3 btn-play-audio" for="audioFile"><spring:message code="alarm.play.title"/></button>
                        <audio id="audioFile" controls hidden>
                            <source src="${_ctx}/resources/dist/audio/sound-1.mp3" type="audio/mpeg">
                        </audio>
                    </dd>
                </dl>
                <dl class="trade-pop-form-info-item" style="grid-template-columns:15rem 1fr">
                    <dt><spring:message code="myroom.setting.alarmRepeat.title"/></dt>
                    <dd class="form-group">
                        <input id="repeatSeconds" name="repeatSeconds" value="${wallet_current.repeatSeconds}" />
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
</div>
<script>
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
</script>
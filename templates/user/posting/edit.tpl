{zdebug}{* purpose of this template: build the Form to edit an instance of posting *}
{if $func ne 'display'}
{include file='user/header.tpl'}
{/if}
{pageaddvar name='javascript' value='modules/MUBoard/javascript/MUBoard_editFunctions.js'}
{pageaddvar name='javascript' value='modules/MUBoard/javascript/MUBoard_validation.js'}
{pageaddvar name='javascript' value='jquery'}
{pageaddvar name='javascript' value='jquery-ui'}

{if $func eq 'edit'}
{$forum|muboardGetForumInfo}
{/if}

{if $mode eq 'edit'}
    {if $func eq 'edit' && $parentid > 0}
    {gt text='Edit posting' assign='templateTitle'}
    {else}
    {gt text='Edit issue' assign='templateTitle}
    {/if}
{elseif $mode eq 'create' && $func ne 'display'}
    {gt text='Create issue' assign='templateTitle'}
{elseif $mode eq 'create' && $func eq 'display'}
    {gt text='Answer to posting' assign='templateTitle'}
{else}
    {gt text='Edit posting' assign='templateTitle'}
{/if}
<div class="muboard-posting muboard-edit">
{* {pagesetvar name='title' value=$templateTitle} *}
<div class="z-frontendcontainer">
    <h2>{$templateTitle}</h2>
{muboardform enctype='multipart/form-data' cssClass='z-form'}
    {* add validation summary and a <div> element for styling the form *}
    {muboardFormFrame}
    {if $func eq 'edit'}
    {formsetinitialfocus inputId='title'}    
   {* {else}
    {formsetinitialfocus inputId='text'} *}
    {/if}
    <fieldset>
        <legend>{gt text='Content'}</legend>
        {if ($func ne 'display' && $mode eq 'create') || ($mode eq 'edit' && $parentid eq 0)}
        <div class="z-formrow">
            {formlabel for='title' __text='Title' mandatorysym='1'}
            {formtextinput group='posting' id='title' mandatory=true readOnly=false __title='Enter the title of the posting' textMode='singleline' maxLength=255 cssClass='required' }
            {muboardValidationError id='title' class='required'}
        </div>
        {/if}
        <div class="z-formrow">
            {formlabel for='text' __text='Text' mandatorysym='1'}
            {formtextinput group='posting' id='text' mandatory=true __title='Enter the text of the posting' textMode='multiline' rows='6' cols='50' cssClass='required' }
            {muboardValidationError id='text' class='required'}
        </div>
        <div class="z-formrow" style="display: none;">
            {formlabel for='invocations' __text='Invocations'}
            {formintinput group='posting' id='invocations' mandatory=false __title='Enter the invocations of the posting' maxLength=11 cssClass=' validate-digits'}
            {muboardValidationError id='invocations' class='validate-digits'}
        </div> 
        <input type="hidden" id="state" name="state" value="1" />
        {* <div class="z-formrow" style="display: none;">
            {formlabel for='state' __text='Invocations'}
            {formintinput group='posting' id='state' mandatory=false __title='Enter the invocations of the posting' maxLength=11 cssClass=' validate-digits'}
            {muboardValidationError id='state' class='validate-digits'}
        </div> *}
        {if $uploadImages eq 1}
        {if $numberImages eq 1 || $numberImages eq 2 || $numberImages eq 3}
        <div class="z-formrow">
            {formlabel for='firstImage' __text='First image'}<br />{* break required for Google Chrome *}
            {formuploadinput group='posting' id='firstImage' mandatory=false readOnly=false cssClass=''}
            <div class="z-formnote">{gt text='Allowed file size:'} {$maxSize} </div>
            <div class="z-formnote">{gt text='Allowed file extensions:'} gif, jpeg, jpg, png</div>
            {if $mode ne 'create'}
                {if $posting.firstImage ne ''}
                  <div class="z-formnote">
                      {gt text='Current file'}:
                      <a href="{$posting.firstImageFullPathUrl}" title="{$posting.title|replace:"\"":""}"{if $posting.firstImageMeta.isImage} rel="imageviewer[posting]"{/if}>
                      {if $posting.firstImageMeta.isImage}
                          <img src="{$posting.firstImage|muboardImageThumb:$posting.firstImageFullPath:80:50}" width="80" height="50" alt="{$posting.title|replace:"\"":""}" />
                      {else}
                          {gt text='Download'} ({$posting.firstImageMeta.size|muboardGetFileSize:$posting.firstImageFullPath:false:false})
                      {/if}
                      </a>
                  </div>
                  <div class="z-formnote">
                      {formcheckbox group='posting' id='firstImageDeleteFile' readOnly=false __title='Delete first image ?'}
                      {formlabel for='firstImageDeleteFile' __text='Delete existing file'}
                  </div>
                {/if}
            {/if}
        </div>
        {/if}
        {if $numberImages eq 2 || $numberImages eq 3}
        <div class="z-formrow">
            {formlabel for='secondImage' __text='Second image'}<br />{* break required for Google Chrome *}
            {formuploadinput group='posting' id='secondImage' mandatory=false readOnly=false cssClass=''}
            <div class="z-formnote">{gt text='Allowed file size:'} {$maxSize} </div>
            <div class="z-formnote">{gt text='Allowed file extensions:'} gif, jpeg, jpg, png</div>
            {if $mode ne 'create'}
                {if $posting.secondImage ne ''}
                  <div class="z-formnote">
                      {gt text='Current file'}:
                      <a href="{$posting.secondImageFullPathUrl}" title="{$posting.title|replace:"\"":""}"{if $posting.secondImageMeta.isImage} rel="imageviewer[posting]"{/if}>
                      {if $posting.secondImageMeta.isImage}
                          <img src="{$posting.secondImage|muboardImageThumb:$posting.secondImageFullPath:80:50}" width="80" height="50" alt="{$posting.title|replace:"\"":""}" />
                      {else}
                          {gt text='Download'} ({$posting.secondImageMeta.size|muboardGetFileSize:$posting.secondImageFullPath:false:false})
                      {/if}
                      </a>
                  </div>
                  <div class="z-formnote">
                      {formcheckbox group='posting' id='secondImageDeleteFile' readOnly=false __title='Delete second image ?'}
                      {formlabel for='secondImageDeleteFile' __text='Delete existing file'}
                  </div>
                {/if}
            {/if}
        </div>
        {/if}
        {if $numberImages eq 3}
        <div class="z-formrow">
            {formlabel for='thirdImage' __text='Third image'}<br />{* break required for Google Chrome *}
            {formuploadinput group='posting' id='thirdImage' mandatory=false readOnly=false cssClass=''}
            <div class="z-formnote">{gt text='Allowed file size:'} {$maxSize} </div>
            <div class="z-formnote">{gt text='Allowed file extensions:'} gif, jpeg, jpg, png</div>
            {if $mode ne 'create'}
                {if $posting.thirdImage ne ''}
                  <div class="z-formnote">
                      {gt text='Current file'}:
                      <a href="{$posting.thirdImageFullPathUrl}" title="{$posting.title|replace:"\"":""}"{if $posting.thirdImageMeta.isImage} rel="imageviewer[posting]"{/if}>
                      {if $posting.thirdImageMeta.isImage}
                          <img src="{$posting.thirdImage|muboardImageThumb:$posting.thirdImageFullPath:80:50}" width="80" height="50" alt="{$posting.title|replace:"\"":""}" />
                      {else}
                          {gt text='Download'} ({$posting.thirdImageMeta.size|muboardGetFileSize:$posting.thirdImageFullPath:false:false})
                      {/if}
                      </a>
                  </div>
                  <div class="z-formnote">
                      {formcheckbox group='posting' id='thirdImageDeleteFile' readOnly=false __title='Delete third image ?'}
                      {formlabel for='thirdImageDeleteFile' __text='Delete existing file'}
                  </div>
                {/if}
            {/if}
        </div>
        {/if}
        {/if}
        {if $uploadFiles eq 1}
        {if $numberFiles eq 1 || $numberFiles eq 2 || $numberFiles eq 3}
        <div class="z-formrow">
            {formlabel for='firstFile' __text='First file'}<br />{* break required for Google Chrome *}
            {formuploadinput group='posting' id='firstFile' mandatory=false readOnly=false cssClass=''}

            <div class="z-formnote">{gt text='Allowed file extensions:'} pdf</div>
            {if $mode ne 'create'}
                {if $posting.firstFile ne ''}
                  <div class="z-formnote">
                      {gt text='Current file'}:
                      <a href="{$posting.firstFileFullPathUrl}" title="{$posting.title|replace:"\"":""}"{if $posting.firstFileMeta.isImage} rel="imageviewer[posting]"{/if}>
                      {if $posting.firstFileMeta.isImage}
                          <img src="{$posting.firstFile|muboardImageThumb:$posting.firstFileFullPath:80:50}" width="80" height="50" alt="{$posting.title|replace:"\"":""}" />
                      {else}
                          {gt text='Download'} ({$posting.firstFileMeta.size|muboardGetFileSize:$posting.firstFileFullPath:false:false})
                      {/if}
                      </a>
                  </div>
                  <div class="z-formnote">
                      {formcheckbox group='posting' id='firstFileDeleteFile' readOnly=false __title='Delete first file ?'}
                      {formlabel for='firstFileDeleteFile' __text='Delete existing file'}
                  </div>
                {/if}
            {/if}
        </div>
        {/if}
        {if $numberFiles eq 2 || $numberFiles eq 3}
        <div class="z-formrow">
            {formlabel for='secondFile' __text='Second file'}<br />{* break required for Google Chrome *}
            {formuploadinput group='posting' id='secondFile' mandatory=false readOnly=false cssClass=''}

            <div class="z-formnote">{gt text='Allowed file extensions:'} pdf</div>
            {if $mode ne 'create'}
                {if $posting.secondFile ne ''}
                  <div class="z-formnote">
                      {gt text='Current file'}:
                      <a href="{$posting.secondFileFullPathUrl}" title="{$posting.title|replace:"\"":""}"{if $posting.secondFileMeta.isImage} rel="imageviewer[posting]"{/if}>
                      {if $posting.secondFileMeta.isImage}
                          <img src="{$posting.secondFile|muboardImageThumb:$posting.secondFileFullPath:80:50}" width="80" height="50" alt="{$posting.title|replace:"\"":""}" />
                      {else}
                          {gt text='Download'} ({$posting.secondFileMeta.size|muboardGetFileSize:$posting.secondFileFullPath:false:false})
                      {/if}
                      </a>
                  </div>
                  <div class="z-formnote">
                      {formcheckbox group='posting' id='secondFileDeleteFile' readOnly=false __title='Delete second file ?'}
                      {formlabel for='secondFileDeleteFile' __text='Delete existing file'}
                  </div>
                {/if}
            {/if}
        </div>
        {/if}
        {if $numberFiles eq 3}
        <div class="z-formrow">
            {formlabel for='thirdFile' __text='Third file'}<br />{* break required for Google Chrome *}
            {formuploadinput group='posting' id='thirdFile' mandatory=false readOnly=false cssClass=''}

            <div class="z-formnote">{gt text='Allowed file extensions:'} pdf</div>
            {if $mode ne 'create'}
                {if $posting.thirdFile ne ''}
                  <div class="z-formnote">
                      {gt text='Current file'}:
                      <a href="{$posting.thirdFileFullPathUrl}" title="{$posting.title|replace:"\"":""}"{if $posting.thirdFileMeta.isImage} rel="imageviewer[posting]"{/if}>
                      {if $posting.thirdFileMeta.isImage}
                          <img src="{$posting.thirdFile|muboardImageThumb:$posting.thirdFileFullPath:80:50}" width="80" height="50" alt="{$posting.title|replace:"\"":""}" />
                      {else}
                          {gt text='Download'} ({$posting.thirdFileMeta.size|muboardGetFileSize:$posting.thirdFileFullPath:false:false})
                      {/if}
                      </a>
                  </div>
                  <div class="z-formnote">
                      {formcheckbox group='posting' id='thirdFileDeleteFile' readOnly=false __title='Delete third file ?'}
                      {formlabel for='thirdFileDeleteFile' __text='Delete existing file'}
                  </div>
                {/if}
            {/if}
        </div>
        {/if}
        {/if}
    </fieldset>
    
    {if $func eq 'edit'}
    <input id="muboardForum_ForumItemList" type="hidden" value="{$forum}" name="muboardForum_ForumItemList" />
    <input id="muboardForum_ForumMode" type="hidden" value="{$forum}" name="muboardForum_ForumMode" />
    {/if}
    {if $func eq 'display'}
    <input id="muboardForum_ForumItemList" type="hidden" value="{$forumid}" name="muboardForum_ForumItemList" />
    <input id="muboardForum_ForumMode" type="hidden" value="0" name="muboardForum_ForumMode" />
    {/if}    
    {if $func eq 'edit'}
    {if isset($parentid)}
    	<input type="hidden" id="muboardPosting_ParentItemList" name="muboardPosting_ParentItemList" value={$parentid} />
    	<input type="hidden" id="muboardPosting_ParentMode" name="muboardPosting_ParentMode" value="0" />    
    {else}
    	<input type="hidden" id="muboardPosting_ParentItemList" name="muboardPosting_ParentItemList" value="0" />
    	<input type="hidden" id="muboardPosting_ParentMode" name="muboardPosting_ParentMode" value="0" />            
    {/if}  
    {/if}
    {if $func eq 'display'}
    	<input type="hidden" id="muboardPosting_ParentItemList" name="muboardPosting_ParentItemList" value="{$posting.id}" />
    	<input type="hidden" id="muboardPosting_ParentMode" name="muboardPosting_ParentMode" value="0" />
    {/if}
    <div id="muboard-user-preview" style="display: none; height: 40px;"></div>

    {* include possible submit actions *}
    <div class="muboard-posting-edit-action">
    <div class="z-buttons z-formbuttons">
    {if $mode eq 'edit'}
        {if $func eq 'edit' && $parentid > 0}
        {formbutton id='btnUpdate' commandName='update' __text='Update posting' class='z-bt-save'}
        {formbutton id='btnDelete' commandName='delete' __text='Delete' class='z-bt-delete'}
        {else}
        {formbutton id='btnUpdate' commandName='update' __text='Update issue' class='z-bt-save'}
        {/if}
        {formbutton id='btnPreview' commandName='preview' __text='Preview' class='z-bt-ok'}
    {elseif $mode eq 'create'}
    {if $func eq 'edit'}
        {formbutton id='btnCreate' commandName='create' __text='Create issue' class='z-bt-ok'}
       {* {formbutton id='btnToforum' commandName='toforum' __text='Back to Forum' class='z-bt-back'} *}
    {else}
        {formbutton id='btnCreate' commandName='create' __text='Save answer' class='z-bt-ok'}
    {/if}
        {formbutton id='btnPreview' commandName='preview' __text='Preview' class='z-bt-ok'}

    {else}
        {formbutton id='btnUpdate' commandName='update' __text='OK' class='z-bt-ok'}
    {/if}
        {formbutton id='btnCancel' commandName='cancel' __text='Cancel' class='z-bt-cancel'}
    </div>
    <div class="muboard-posting-edit-hooks">
            
        {* include display hooks *}
        {if $mode eq 'create'}
        {notifydisplayhooks eventname='muboard.ui_hooks.postings.form_edit' id=null assign='hooks'}
        {else}
        {notifydisplayhooks eventname='muboard.ui_hooks.postings.form_edit' id=$posting.id assign='hooks'}
        {/if}
        {if $func eq 'edit' || $func eq 'display'}
        {foreach key='hookName' item='hook' from=$hooks name=hooks}
            {if $hookName ne 'Tag'}
            {if $smarty.foreach.hooks.iteration == 1 || $smarty.foreach.hooks.iteration == 3 || $smarty.foreach.hooks.iteration == 5 || $smarty.foreach.hooks.iteration == 7 
            || $smarty.foreach.hooks.iteration == 9 || $smarty.foreach.hooks.iteration == 11 || $smarty.foreach.hooks.iteration == 13 || $smarty.foreach.hooks.iteration == 15}
            <div class="z-formrow muboard-hook-left">
                {$hook}
            </div>
            {else}
            <div class="z-formrow muboard-hook-right">
                {$hook}
            </div>
            {/if}
            {/if}
        {/foreach}
        {/if}    
    </div>  
    </div>  
  {/muboardFormFrame}
{/muboardform}
</div>
</div>
{include file='user/footer.tpl'}

{icon type='edit' size='extrasmall' assign='editImageArray'}
{icon type='delete' size='extrasmall' assign='deleteImageArray'}

<script type="text/javascript" charset="utf-8">
/* <![CDATA[ */
    var editImage = '<img src="{{$editImageArray.src}}" width="16" height="16" alt="" />';
    var removeImage = '<img src="{{$deleteImageArray.src}}" width="16" height="16" alt="" />';
    var relationHandler = new Array();
    var newItem = new Object();
    newItem['ot'] = 'posting';
    newItem['alias'] = 'Parent';
    newItem['prefix'] = 'muboardPosting_ParentSelectorDoNew';
    newItem['acInstance'] = null;
    newItem['windowInstance'] = null;
    relationHandler.push(newItem);
    var newItem = new Object();
    newItem['ot'] = 'forum';
    newItem['alias'] = 'Forum';
    newItem['prefix'] = 'muboardForum_ForumSelectorDoNew';
    newItem['acInstance'] = null;
    newItem['windowInstance'] = null;
    relationHandler.push(newItem);

    document.observe('dom:loaded', function() {
        muboardInitRelationItemsForm('posting', 'muboardPosting_Parent', false);
        muboardInitRelationItemsForm('forum', 'muboardForum_Forum', true);

        muboardAddCommonValidationRules('posting', '{{if $mode eq 'create'}}{{else}}{{$posting.id}}{{/if}}');

        // observe button events instead of form submit
        var valid = new Validation('{{$__formid}}', {onSubmit: false, immediate: true, focusOnError: false});
        {{if $mode ne 'create'}}
            var result = valid.validate();
        {{/if}}

        $('{{if $mode eq 'create'}}btnCreate{{else}}btnUpdate{{/if}}').observe('click', function(event) {
            var result = valid.validate();
            if (!result) {
                // validation error, abort form submit
                Event.stop(event);
            } else {
                // hide form buttons to prevent double submits by accident
                $$('div.z-formbuttons input').each(function(btn) {
                    btn.hide();
                });
            }
            return result;
        });

        Zikula.UI.Tooltips($$('.muboardFormTooltips'));
    });
    
    var MU = jQuery.noConflict();
    MU(document).ready( function() { 

       MU("#btnPreview").click(function(d) {
           d.preventDefault();
           MU("#muboard-user-preview").slideDown(500).html("<img style='margin: 0 auto;' src='images/ajax/large_square_white.gif' />");
           var url;
           url = "index.php?module=muboard&type=ajax&func=preview&theme=printer";
           {{if $func eq 'display' && $mode eq 'create'}}
           url = "index.php?module=muboard&type=ajax&func=preview&theme=printer&answer=1";
           {{/if}}
           {{if $func eq 'edit' && $mode eq 'edit'}}
           url = "index.php?module=muboard&type=ajax&func=preview&theme=printer&id={{$posting.id}}";
           {{/if}}           
           var datas = MU("#{{$__formid}}").serialize();
           var datatyp = 'html';
           var datawork = function(answer) {
               if (answer) {
                   MU("#muboard-user-preview").fadeOut(10).html("")
                   .fadeIn(1000).html(answer); 
               }
           }
           
           MU.get(url, datas, datawork, datatyp);

       });
       
     {{*  MU("#btnCreate").click(function() {
           MU("#{{$__formid}}").submit();
       }); 
       
       MU("#btnToforum").click(function() {
           MU("#{{$__formid}}").submit();
       });   

       MU("#btnCancel").click(function(f) {
           f.preventDefault();
           MU("#muboard-user-preview").slideUp(2000);
       }); *}}
   });  

/* ]]> */
</script>

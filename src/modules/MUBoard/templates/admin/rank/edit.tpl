{* purpose of this template: build the Form to edit an instance of rank *}
{include file='admin/header.tpl'}
{pageaddvar name='javascript' value='modules/MUBoard/javascript/MUBoard_editFunctions.js'}
{pageaddvar name='javascript' value='modules/MUBoard/javascript/MUBoard_validation.js'}

{if $mode eq 'edit'}
    {gt text='Edit rank' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{elseif $mode eq 'create'}
    {gt text='Create rank' assign='templateTitle'}
    {assign var='adminPageIcon' value='new'}
{else}
    {gt text='Edit rank' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{/if}
<div class="muboard-rank muboard-edit">
{pagesetvar name='title' value=$templateTitle}
<div class="z-admin-content-pagetitle">
    {icon type=$adminPageIcon size='small' alt=$templateTitle}
    <h3>{$templateTitle}</h3>
</div>
{form enctype='multipart/form-data' cssClass='z-form'}
    {* add validation summary and a <div> element for styling the form *}
    {muboardFormFrame}
    {formsetinitialfocus inputId='name'}

    <fieldset>
        <legend>{gt text='Content'}</legend>
        <div class="z-formrow">
            {formlabel for='name' __text='Name' mandatorysym='1'}
            {formtextinput group='rank' id='name' mandatory=true readOnly=false __title='Enter the name of the rank' textMode='singleline' maxLength=100 cssClass='required'}
            {muboardValidationError id='name' class='required'}
        </div>
        <div class="z-formrow">
            {formlabel for='minPostings' __text='Min postings'}
            {formintinput group='rank' id='minPostings' mandatory=false __title='Enter the min postings of the rank' maxLength=11 cssClass=' validate-digits'}
            {muboardValidationError id='minPostings' class='validate-digits'}
        </div>
        <div class="z-formrow">
            {formlabel for='maxPostings' __text='Max postings'}
            {formintinput group='rank' id='maxPostings' mandatory=false __title='Enter the max postings of the rank' maxLength=11 cssClass=' validate-digits'}
            {muboardValidationError id='maxPostings' class='validate-digits'}
        </div>
        <div class="z-formrow">
            {formlabel for='numberOfIcons' __text='Number of icons' mandatorysym='1'}
            {formintinput group='rank' id='numberOfIcons' mandatory=true __title='Enter the number of icons of the rank' maxLength=2 cssClass='required validate-digits'}
            {muboardValidationError id='numberOfIcons' class='required'}
            {muboardValidationError id='numberOfIcons' class='validate-digits'}
        </div>
        <div class="z-formrow">
          {*  {assign var='mandatorySym' value='1'}
            {if $mode ne 'create'} *}
                {assign var='mandatorySym' value='0'}
           {* {/if} *}
            {formlabel for='uploadImage' __text='Upload image' mandatorysym=$mandatorySym}<br />{* break required for Google Chrome *}
{if $mode eq 'create'}
            {formuploadinput group='rank' id='uploadImage' mandatory=false readOnly=false cssClass=''}
{else}
            {formuploadinput group='rank' id='uploadImage' mandatory=false readOnly=false cssClass=''}
{/if}

            <div class="z-formnote">{gt text='Allowed file extensions:'} gif, jpeg, jpg, png</div>
            {if $mode ne 'create'}
                  <div class="z-formnote">
                      {gt text='Current file'}:
                      <a href="{$rank.uploadImageFullPathUrl}" title="{$rank.name|replace:"\"":""}"{if $rank.uploadImageMeta.isImage} rel="imageviewer[rank]"{/if}>
                      {if $rank.uploadImageMeta.isImage}
                          <img src="{$rank.uploadImage|muboardImageThumb:$rank.uploadImageFullPath:80:50}" width="80" height="50" alt="{$rank.name|replace:"\"":""}" />
                      {else}
                          {gt text='Download'} ({$rank.uploadImageMeta.size|muboardGetFileSize:$rank.uploadImageFullPath:false:false})
                      {/if}
                      </a>
                  </div>
            {/if}
           {* {muboardValidationError id='uploadImage' class=''} *}
        </div>
        <div class="z-formrow">
            {formlabel for='special' __text='Special' mandatorysym='0'}
            {formcheckbox group='rank' id='special' readOnly=false __title='special ?' cssClass=''}
            {muboardValidationError id='special' class=''}
        </div>
    </fieldset>

    {if $mode ne 'create'}
        {include file='admin/include_standardfields_edit.tpl' obj=$rank}
    {/if}

    {* include display hooks *}
    {if $mode eq 'create'}
        {notifydisplayhooks eventname='muboard.ui_hooks.ranks.form_edit' id=null assign='hooks'}
    {else}
        {notifydisplayhooks eventname='muboard.ui_hooks.ranks.form_edit' id=$rank.id assign='hooks'}
    {/if}
    {if is_array($hooks) && isset($hooks[0])}
        <fieldset>
            <legend>{gt text='Hooks'}</legend>
            {foreach key='hookName' item='hook' from=$hooks}
            <div class="z-formrow">
                {$hook}
            </div>
            {/foreach}
        </fieldset>
    {/if}

    {* include return control *}
    {if $mode eq 'create'}
        <fieldset>
            <legend>{gt text='Return control'}</legend>
            <div class="z-formrow">
                {formlabel for='repeatcreation' __text='Create another item after save'}
                {formcheckbox group='rank' id='repeatcreation' readOnly=false}
            </div>
        </fieldset>
    {/if}

    {* include possible submit actions *}
    <div class="z-buttons z-formbuttons">
    {if $mode eq 'edit'}
        {formbutton id='btnUpdate' commandName='update' __text='Update rank' class='z-bt-save'}
      {if !$inlineUsage}
        {gt text='Really delete this rank?' assign='deleteConfirmMsg'}
        {formbutton id='btnDelete' commandName='delete' __text='Delete rank' class='z-bt-delete z-btred' confirmMessage=$deleteConfirmMsg}
      {/if}
    {elseif $mode eq 'create'}
        {formbutton id='btnCreate' commandName='create' __text='Create rank' class='z-bt-ok'}
    {else}
        {formbutton id='btnUpdate' commandName='update' __text='OK' class='z-bt-ok'}
    {/if}
        {formbutton id='btnCancel' commandName='cancel' __text='Cancel' class='z-bt-cancel'}
    </div>
  {/muboardFormFrame}
{/form}

</div>
{include file='admin/footer.tpl'}

{icon type='edit' size='extrasmall' assign='editImageArray'}
{icon type='delete' size='extrasmall' assign='deleteImageArray'}

<script type="text/javascript" charset="utf-8">
/* <![CDATA[ */
    var editImage = '<img src="{{$editImageArray.src}}" width="16" height="16" alt="" />';
    var removeImage = '<img src="{{$deleteImageArray.src}}" width="16" height="16" alt="" />';

    document.observe('dom:loaded', function() {

        muboardAddCommonValidationRules('rank', '{{if $mode eq 'create'}}{{else}}{{$rank.id}}{{/if}}');

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

/* ]]> */
</script>

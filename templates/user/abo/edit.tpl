{* purpose of this template: build the Form to edit an instance of abo *}
{include file='user/header.tpl'}
{pageaddvar name='javascript' value='modules/MUBoard/javascript/MUBoard_editFunctions.js'}
{pageaddvar name='javascript' value='modules/MUBoard/javascript/MUBoard_validation.js'}

{if $mode eq 'edit'}
    {gt text='Edit abo' assign='templateTitle'}
{elseif $mode eq 'create'}
    {gt text='Create abo' assign='templateTitle'}
{else}
    {gt text='Edit abo' assign='templateTitle'}
{/if}
<div class="muboard-abo muboard-edit">
{pagesetvar name='title' value=$templateTitle}
<div class="z-frontendcontainer">
    <h2>{$templateTitle}</h2>
{form cssClass='z-form'}
    {* add validation summary and a <div> element for styling the form *}
    {muboardFormFrame}
    {formsetinitialfocus inputId='userid'}

    <fieldset>
        <legend>{gt text='Content'}</legend>
        <div class="z-formrow">
            {formlabel for='userid' __text='Userid' mandatorysym='1'}
            {formintinput group='abo' id='userid' mandatory=true __title='Enter the userid of the abo' maxLength=11 cssClass='required validate-digits'}
            {muboardValidationError id='userid' class='required'}
            {muboardValidationError id='userid' class='validate-digits'}
        </div>
        <div class="z-formrow">
            {formlabel for='catid' __text='Catid'}
            {formintinput group='abo' id='catid' mandatory=false __title='Enter the catid of the abo' maxLength=11 cssClass=' validate-digits'}
            {muboardValidationError id='catid' class='validate-digits'}
        </div>
        <div class="z-formrow">
            {formlabel for='forumid' __text='Forumid'}
            {formintinput group='abo' id='forumid' mandatory=false __title='Enter the forumid of the abo' maxLength=11 cssClass=' validate-digits'}
            {muboardValidationError id='forumid' class='validate-digits'}
        </div>
        <div class="z-formrow">
            {formlabel for='postingid' __text='Postingid'}
            {formintinput group='abo' id='postingid' mandatory=false __title='Enter the postingid of the abo' maxLength=11 cssClass=' validate-digits'}
            {muboardValidationError id='postingid' class='validate-digits'}
        </div>
    </fieldset>

    {if $mode ne 'create'}
        {include file='user/include_standardfields_edit.tpl' obj=$abo}
    {/if}

    {* include display hooks *}
    {if $mode eq 'create'}
        {notifydisplayhooks eventname='muboard.ui_hooks.abos.form_edit' id=null assign='hooks'}
    {else}
        {notifydisplayhooks eventname='muboard.ui_hooks.abos.form_edit' id=$abo.id assign='hooks'}
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
                {formcheckbox group='abo' id='repeatcreation' readOnly=false}
            </div>
        </fieldset>
    {/if}

    {* include possible submit actions *}
    <div class="z-buttons z-formbuttons">
    {if $mode eq 'edit'}
        {formbutton id='btnUpdate' commandName='update' __text='Update abo' class='z-bt-save'}
      {if !$inlineUsage}
        {gt text='Really delete this abo?' assign='deleteConfirmMsg'}
        {formbutton id='btnDelete' commandName='delete' __text='Delete abo' class='z-bt-delete z-btred' confirmMessage=$deleteConfirmMsg}
      {/if}
    {elseif $mode eq 'create'}
        {formbutton id='btnCreate' commandName='create' __text='Create abo' class='z-bt-ok'}
    {else}
        {formbutton id='btnUpdate' commandName='update' __text='OK' class='z-bt-ok'}
    {/if}
        {formbutton id='btnCancel' commandName='cancel' __text='Cancel' class='z-bt-cancel'}
    </div>
  {/muboardFormFrame}
{/form}

</div>
</div>
{include file='user/footer.tpl'}

{icon type='edit' size='extrasmall' assign='editImageArray'}
{icon type='delete' size='extrasmall' assign='deleteImageArray'}

<script type="text/javascript" charset="utf-8">
/* <![CDATA[ */
    var editImage = '<img src="{{$editImageArray.src}}" width="16" height="16" alt="" />';
    var removeImage = '<img src="{{$deleteImageArray.src}}" width="16" height="16" alt="" />';

    document.observe('dom:loaded', function() {

        muboardAddCommonValidationRules('abo', '{{if $mode eq 'create'}}{{else}}{{$abo.id}}{{/if}}');

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

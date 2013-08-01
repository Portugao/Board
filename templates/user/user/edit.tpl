{* purpose of this template: build the Form to edit an instance of user *}
{include file='user/header.tpl'}
{pageaddvar name='javascript' value='modules/MUBoard/javascript/MUBoard_editFunctions.js'}
{pageaddvar name='javascript' value='modules/MUBoard/javascript/MUBoard_validation.js'}

{if $mode eq 'edit'}
    {gt text='Edit user' assign='templateTitle'}
{elseif $mode eq 'create'}
    {gt text='Create user' assign='templateTitle'}
{else}
    {gt text='Edit user' assign='templateTitle'}
{/if}
<div class="muboard-user muboard-edit">
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
            {formintinput group='user' id='userid' mandatory=true __title='Enter the userid of the user' maxLength=11 cssClass='required validate-digits'}
            {muboardValidationError id='userid' class='required'}
            {muboardValidationError id='userid' class='validate-digits'}
        </div>
        <div class="z-formrow">
            {formlabel for='numberPostings' __text='Number postings' mandatorysym='1'}
            {formintinput group='user' id='numberPostings' mandatory=true __title='Enter the number postings of the user' maxLength=11 cssClass='required validate-digits'}
            {muboardValidationError id='numberPostings' class='required'}
            {muboardValidationError id='numberPostings' class='validate-digits'}
        </div>
        <div class="z-formrow">
            {formlabel for='lastVisit' __text='Last visit' mandatorysym='1'}
            {if $mode ne 'create'}
                {formdateinput group='user' id='lastVisit' mandatory=true __title='Enter the last visit of the user' includeTime=true cssClass='required'}
            {else}
                {formdateinput group='user' id='lastVisit' mandatory=true __title='Enter the last visit of the user' includeTime=true defaultValue='now' cssClass='required'}
            {/if}
            {muboardValidationError id='lastVisit' class='required'}
        </div>
    </fieldset>

    {include file='user/rank/include_selectEditOne.tpl' relItem=$user aliasName='rank' idPrefix='muboardRank_Rank'}

    {* include display hooks *}
    {if $mode eq 'create'}
        {notifydisplayhooks eventname='muboard.ui_hooks.users.form_edit' id=null assign='hooks'}
    {else}
        {notifydisplayhooks eventname='muboard.ui_hooks.users.form_edit' id=$user.id assign='hooks'}
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
                {formcheckbox group='user' id='repeatcreation' readOnly=false}
            </div>
        </fieldset>
    {/if}

    {* include possible submit actions *}
    <div class="z-buttons z-formbuttons">
    {if $mode eq 'edit'}
        {formbutton id='btnUpdate' commandName='update' __text='Update user' class='z-bt-save'}
      {if !$inlineUsage}
        {gt text='Really delete this user?' assign='deleteConfirmMsg'}
        {formbutton id='btnDelete' commandName='delete' __text='Delete user' class='z-bt-delete z-btred' confirmMessage=$deleteConfirmMsg}
      {/if}
    {elseif $mode eq 'create'}
        {formbutton id='btnCreate' commandName='create' __text='Create user' class='z-bt-ok'}
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
    var relationHandler = new Array();
    var newItem = new Object();
    newItem['ot'] = 'rank';
    newItem['alias'] = 'Rank';
    newItem['prefix'] = 'muboardRank_RankSelectorDoNew';
    newItem['acInstance'] = null;
    newItem['windowInstance'] = null;
    relationHandler.push(newItem);

    document.observe('dom:loaded', function() {
        muboardInitRelationItemsForm('rank', 'muboardRank_Rank', true);

        muboardAddCommonValidationRules('user', '{{if $mode eq 'create'}}{{else}}{{$user.id}}{{/if}}');

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

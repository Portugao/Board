{* purpose of this template: build the Form to edit an instance of forum *}
{include file='admin/header.tpl'}
{pageaddvar name='javascript' value='modules/MUBoard/javascript/MUBoard_editFunctions.js'}
{pageaddvar name='javascript' value='modules/MUBoard/javascript/MUBoard_validation.js'}

{if $mode eq 'edit'}
    {gt text='Edit forum' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{elseif $mode eq 'create'}
    {gt text='Create forum' assign='templateTitle'}
    {assign var='adminPageIcon' value='new'}
{else}
    {gt text='Edit forum' assign='templateTitle'}
    {assign var='adminPageIcon' value='edit'}
{/if}
<div class="muboard-forum muboard-edit">
{pagesetvar name='title' value=$templateTitle}
<div class="z-admin-content-pagetitle">
    {icon type=$adminPageIcon size='small' alt=$templateTitle}
    <h3>{$templateTitle}</h3>
</div>
{form cssClass='z-form'}
    {* add validation summary and a <div> element for styling the form *}
    {muboardFormFrame}
    {formsetinitialfocus inputId='title'}

    <fieldset>
        <legend>{gt text='Content'}</legend>
        <div class="z-formrow">
            {formlabel for='title' __text='Title' mandatorysym='1'}
            {formtextinput group='forum' id='title' mandatory=true readOnly=false __title='Enter the title of the forum' textMode='singleline' maxLength=255 cssClass='required'}
            {muboardValidationError id='title' class='required'}
        </div>
        <div class="z-formrow">
            {formlabel for='description' __text='Description' mandatorysym='1'}
            {formtextinput group='forum' id='description' mandatory=true __title='Enter the description of the forum' textMode='multiline' rows='6' cols='50' cssClass='required'}
            {muboardValidationError id='description' class='required'}
        </div>
        <div class="z-formrow">
            {formlabel for='pos' __text='Pos' mandatorysym='1'}
            {formintinput group='forum' id='pos' mandatory=true __title='Enter the pos of the forum' maxLength=3 cssClass='required validate-digits'}
            {muboardValidationError id='pos' class='required'}
            {muboardValidationError id='pos' class='validate-digits'}
        </div>
    </fieldset>

    {if $mode ne 'create'}
        {include file='admin/include_standardfields_edit.tpl' obj=$forum}
    {/if}
    {include file='admin/category/include_selectEditOne.tpl' relItem=$forum aliasName='category' idPrefix='muboardCategory_Category'}

    {* include display hooks *}
    {if $mode eq 'create'}
        {notifydisplayhooks eventname='muboard.ui_hooks.forums.form_edit' id=null assign='hooks'}
    {else}
        {notifydisplayhooks eventname='muboard.ui_hooks.forums.form_edit' id=$forum.id assign='hooks'}
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
                {formcheckbox group='forum' id='repeatcreation' readOnly=false}
            </div>
        </fieldset>
    {/if}

    {* include possible submit actions *}
    <div class="z-buttons z-formbuttons">
    {if $mode eq 'edit'}
        {formbutton id='btnUpdate' commandName='update' __text='Update forum' class='z-bt-save'}
      {if !$inlineUsage}
        {gt text='Really delete this forum?' assign='deleteConfirmMsg'}
        {formbutton id='btnDelete' commandName='delete' __text='Delete forum' class='z-bt-delete z-btred' confirmMessage=$deleteConfirmMsg}
      {/if}
    {elseif $mode eq 'create'}
        {formbutton id='btnCreate' commandName='create' __text='Create forum' class='z-bt-ok'}
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
    var relationHandler = new Array();
    var newItem = new Object();
    newItem['ot'] = 'category';
    newItem['alias'] = 'Category';
    newItem['prefix'] = 'muboardCategory_CategorySelectorDoNew';
    newItem['acInstance'] = null;
    newItem['windowInstance'] = null;
    relationHandler.push(newItem);

    document.observe('dom:loaded', function() {
        muboardInitRelationItemsForm('category', 'muboardCategory_Category', true);

        muboardAddCommonValidationRules('forum', '{{if $mode eq 'create'}}{{else}}{{$forum.id}}{{/if}}');

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

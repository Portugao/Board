{* purpose of this template: module configuration *}
{include file='admin/header.tpl'}
{* {pageaddvar name='javascript' value='modules/MUBoard/javascript/MUBoard_animation.js'} *}
<div class="muboard-config">
{gt text='Import' assign='templateTitle'}
{pagesetvar name='title' value=$templateTitle}
<div class="z-admin-content-pagetitle">
    {icon type='config' size='small' __alt='Settings'}
    <h3>{$templateTitle}</h3>
</div>

    {form cssClass='z-form'}
        {* add validation summary and a <div> element for styling the form *}
        {muboardFormFrame}
        {formsetinitialfocus inputId='uploadImages'}
            <fieldset>
            <div class="z-informationmsg z-formnote">{gt text='For security aspects you have to enter your datas to give the import function access to the database!'}</div>
                <legend>{gt text='Here you can import datas of Dizkus.'}</legend>
                <div class="z-formrow">
                    {formlabel for='host' __text='Host'}
                    {formtextinput id='host' group='import' maxLength="30"}
                </div>
                <div class="z-formrow">
                    {formlabel for='dbname' __text='DB Name'}
                    {formtextinput id='dbname' group='import' maxLength="30"}
                </div>
                <div class="z-formrow">
                    {formlabel for='user' __text='User'}
                    {formtextinput id='user' group='import' maxLength="30"}
                </div>
                <div class="z-formrow">
                    {formlabel for='password' __text='Password'}
                    {formtextinput textMode='password' id='password' group='import' maxLength="30"}
                </div>
                <div class="z-formrow">
                    {formlabel for='dizkustable' __text='Tables of dizkus'}
                    {formdropdownlist id='dizkustable' group='import'}
                    <div class="z-informationmsg z-formnote">{gt text='Here you can select if you wish to import all tables in one process or if you wish to do it in 3 steps. If you have much datas it is possible that you get problems if you select All!'}</div>
                </div>
            </fieldset>

            <div class="z-buttons z-formbuttons">
                {formbutton commandName='import' __text='Start import' class='z-bt-save'}
                {formbutton commandName='cancel' __text='Cancel' class='z-bt-cancel'}
            </div>
        {/muboardFormFrame}
    {/form}
</div>
{include file='admin/footer.tpl'}

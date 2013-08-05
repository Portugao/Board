{* purpose of this template: module configuration *}
{include file='admin/header.tpl'}
{pageaddvar name='javascript' value='jquery'}
{pageaddvar name='javascript' value='jquery-ui'}
{* {pageaddvar name='javascript' value='modules/MUBoard/javascript/MUBoard_animation.js'} *}
<div class="muboard-config">
{gt text='Settings' assign='templateTitle'}
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
                <legend>{gt text='Here you can manage all basic settings for this application.'}</legend>

                <div class="z-formrow">
                    {formlabel for='uploadImages' __text='Upload images'}
                    {formcheckbox id='uploadImages' group='config'}
                </div>
                <div id="imageoptions" style="display: none;">
                <div class="z-formrow">
                    {formlabel for='allowedSizeOfImages' __text='Allowed size of images'}
                    {formintinput id='allowedSizeOfImages' group='config' maxLength=255 width=20em __title='Enter this setting. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {formlabel for='numberImages' __text='Number images'}
                    {formdropdownlist id='numberImages' group='config'}
                </div>
                </div>
                <div class="z-formrow">
                    {formlabel for='uploadFiles' __text='Upload files'}
                    {formcheckbox id='uploadFiles' group='config'}
                </div>
                <div id="fileoptions" style="display: none;">
                <div class="z-formrow" style="display: none;">
                    {formlabel for='allowedSizeOfFiles' __text='Allowed size of files'}
                    {formintinput id='allowedSizeOfFiles' group='config' maxLength=255 width=20em __title='Enter this setting. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {formlabel for='numberFiles' __text='Number files'}
                    {formdropdownlist id='numberFiles' group='config'}
                </div>
                </div>
                <div class="z-formrow">
                    {formlabel for='editPostings' __text='Edit postings'}
                    {formcheckbox id='editPostings' group='config'}
                </div>
                <div id="editoptions" style="display: none;">
                <div class="z-formrow">
                    {formlabel for='editTime' __text='Edit time' class='muboardFormTooltips' title=$toolTip}
                    {formintinput id='editTime' group='config' maxLength=255 width=20em __title='Enter this setting. Only digits are allowed.'}
                </div>
                </div>
                <div class="z-formrow">
                    {formlabel for='latestPostings' __text='Latest postings'}
                    {formintinput id='latestPostings' group='config' maxLength=255 width=20em __title='Enter this setting. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {formlabel for='sortingCategories' __text='Sorting categories'}
                    {formdropdownlist id='sortingCategories' group='config'}
                </div>
                <div class="z-formrow">
                    {formlabel for='sortingPostings' __text='Sorting postings'}
                    {formdropdownlist id='sortingPostings' group='config'}
                </div>
                <div class="z-formrow" style="display: none;">
                    {formlabel for='iconSet' __text='Icon set'}
                    {formdropdownlist id='iconSet' group='config'}
                </div>
                <div class="z-formrow" style="display: none;">
                    {formlabel for='template' __text='Template'}
                    {formdropdownlist id='template' group='config'}
                </div>
                <div class="z-formrow">
                    {formlabel for='pagesize' __text='Pagesize'}
                    {formintinput id='pagesize' group='config' maxLength=255 width=20em __title='Enter this setting. Only digits are allowed.'}
                </div>
                <div class="z-formrow">
                    {formlabel for='standardIcon' __text='Standard icon' class='muboardFormTooltips' title=$toolTip}
                    {formtextinput id='standardIcon' group='config' maxLength=255 width=20em __title='Enter this setting.'}
                </div>
                <div class="z-formrow">
                    {formlabel for='specialIcon' __text='Special icon' class='muboardFormTooltips' title=$toolTip}
                    {formtextinput id='specialIcon' group='config' maxLength=255 width=20em __title='Enter this setting.'}
                </div>
            </fieldset>

            <div class="z-buttons z-formbuttons">
                {formbutton commandName='save' __text='Update configuration' class='z-bt-save'}
                {formbutton commandName='cancel' __text='Cancel' class='z-bt-cancel'}
            </div>
        {/muboardFormFrame}
    {/form}
</div>
<script type="text/javascript" charset="utf-8">
/* <![CDATA[ */
             
    var MU = jQuery.noConflict();
    MU(document).ready(function() {
        if(MU(".z-formrow > #uploadImages").is(':checked')) {
        MU("#imageoptions").css({display: 'block'});
        }

        if(MU(".z-formrow > #uploadFiles").is(':checked')) {
            MU("#fileoptions").css({display: 'block'});
        }

        if(MU(".z-formrow > #editPostings").is(':checked')) {
            MU("#editoptions").css({display: 'block'});
        }
        
    	MU(".z-formrow > #uploadImages").click( function() {
        if(MU(this).is(':checked')) {
        	MU("#imageoptions").slideDown('slow');
        }
        else {
        	MU("#imageoptions").slideUp('slow');
        }

    });

    	MU(".z-formrow > #uploadFiles").click( function() {
            if(MU(this).is(':checked')) {
            	MU("#fileoptions").slideDown('slow');
            }
            else {
            	MU("#fileoptions").slideUp('slow');
            }

        }); 

    	MU(".z-formrow > #editPostings").click( function() {
            if(MU(this).is(':checked')) {
            	MU("#editoptions").slideDown('slow');
            }
            else {
            	MU("#editoptions").slideUp('slow');
            }

        });        
    });


/* ]]> */
</script>
{include file='admin/footer.tpl'}

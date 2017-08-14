{* Purpose of this template: edit view of generic item list content type *}
<div class="form-group">
    {gt text='Object type' domain='muboardmodule' assign='objectTypeSelectorLabel'}
    {formlabel for='mUBoardModuleObjectType' text=$objectTypeSelectorLabel cssClass='col-sm-3 control-label'}
    <div class="col-sm-9">
        {muboardmoduleObjectTypeSelector assign='allObjectTypes'}
        {formdropdownlist id='mUBoardModuleObjectType' dataField='objectType' group='data' mandatory=true items=$allObjectTypes cssClass='form-control'}
        <span class="help-block">{gt text='If you change this please save the element once to reload the parameters below.' domain='muboardmodule'}</span>
    </div>
</div>

<div class="form-group">
    {gt text='Sorting' domain='muboardmodule' assign='sortingLabel'}
    {formlabel text=$sortingLabel cssClass='col-sm-3 control-label'}
    <div class="col-sm-9">
        {formradiobutton id='mUBoardModuleSortRandom' value='random' dataField='sorting' group='data' mandatory=true}
        {gt text='Random' domain='muboardmodule' assign='sortingRandomLabel'}
        {formlabel for='mUBoardModuleSortRandom' text=$sortingRandomLabel}
        {formradiobutton id='mUBoardModuleSortNewest' value='newest' dataField='sorting' group='data' mandatory=true}
        {gt text='Newest' domain='muboardmodule' assign='sortingNewestLabel'}
        {formlabel for='mUBoardModuleSortNewest' text=$sortingNewestLabel}
        {formradiobutton id='mUBoardModuleSortDefault' value='default' dataField='sorting' group='data' mandatory=true}
        {gt text='Default' domain='muboardmodule' assign='sortingDefaultLabel'}
        {formlabel for='mUBoardModuleSortDefault' text=$sortingDefaultLabel}
    </div>
</div>

<div class="form-group">
    {gt text='Amount' domain='muboardmodule' assign='amountLabel'}
    {formlabel for='mUBoardModuleAmount' text=$amountLabel cssClass='col-sm-3 control-label'}
    <div class="col-sm-9">
        {formintinput id='mUBoardModuleAmount' dataField='amount' group='data' mandatory=true maxLength=2 cssClass='form-control'}
    </div>
</div>

<div class="form-group">
    {gt text='Template' domain='muboardmodule' assign='templateLabel'}
    {formlabel for='mUBoardModuleTemplate' text=$templateLabel cssClass='col-sm-3 control-label'}
    <div class="col-sm-9">
        {muboardmoduleTemplateSelector assign='allTemplates'}
        {formdropdownlist id='mUBoardModuleTemplate' dataField='template' group='data' mandatory=true items=$allTemplates cssClass='form-control'}
    </div>
</div>

<div id="customTemplateArea" class="form-group"{* data-switch="mUBoardModuleTemplate" data-switch-value="custom"*}>
    {gt text='Custom template' domain='muboardmodule' assign='customTemplateLabel'}
    {formlabel for='mUBoardModuleCustomTemplate' text=$customTemplateLabel cssClass='col-sm-3 control-label'}
    <div class="col-sm-9">
        {formtextinput id='mUBoardModuleCustomTemplate' dataField='customTemplate' group='data' mandatory=false maxLength=80 cssClass='form-control'}
        <span class="help-block">{gt text='Example' domain='muboardmodule'}: <em>itemlist_[objectType]_display.html.twig</em></span>
    </div>
</div>

<div class="form-group">
    {gt text='Filter (expert option)' domain='muboardmodule' assign='filterLabel'}
    {formlabel for='mUBoardModuleFilter' text=$filterLabel cssClass='col-sm-3 control-label'}
    <div class="col-sm-9">
        {formtextinput id='mUBoardModuleFilter' dataField='filter' group='data' mandatory=false maxLength=255 cssClass='form-control'}
    </div>
</div>

<script type="text/javascript">
    (function($) {
    	$('#mUBoardModuleTemplate').change(function() {
    	    $('#customTemplateArea').toggleClass('hidden', $(this).val() != 'custom');
	    }).trigger('change');
    })(jQuery)
</script>

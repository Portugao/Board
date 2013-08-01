{* Purpose of this template: edit view of generic item list content type *}

<div class="z-formrow">
    {formlabel for='MUBoard_objecttype' __text='Object type'}
    {muboardSelectorObjectTypes assign='allObjectTypes'}
    {formdropdownlist id='MUBoard_objecttype' dataField='objectType' group='data' mandatory=true items=$allObjectTypes}
</div>

<div class="z-formrow">
    {formlabel __text='Sorting'}
    <div>
        {formradiobutton id='MUBoard_srandom' value='random' dataField='sorting' group='data' mandatory=true}
        {formlabel for='MUBoard_srandom' __text='Random'}
        {formradiobutton id='MUBoard_snewest' value='newest' dataField='sorting' group='data' mandatory=true}
        {formlabel for='MUBoard_snewest' __text='Newest'}
        {formradiobutton id='MUBoard_sdefault' value='default' dataField='sorting' group='data' mandatory=true}
        {formlabel for='MUBoard_sdefault' __text='Default'}
    </div>
</div>

<div class="z-formrow">
    {formlabel for='MUBoard_amount' __text='Amount'}
    {formtextinput id='MUBoard_amount' dataField='amount' group='data' mandatory=true maxLength=2}
</div>

<div class="z-formrow">
    {formlabel for='MUBoard_template' __text='Template File'}
    {muboardSelectorTemplates assign='allTemplates'}
    {formdropdownlist id='MUBoard_template' dataField='template' group='data' mandatory=true items=$allTemplates}
</div>

<div class="z-formrow">
    {formlabel for='MUBoard_filter' __text='Filter (expert option)'}
    {formtextinput id='MUBoard_filter' dataField='filter' group='data' mandatory=false maxLength=255}
    <div class="z-formnote">({gt text='Syntax examples'}: <kbd>name:like:foobar</kbd> {gt text='or'} <kbd>status:ne:3</kbd>)</div>
</div>

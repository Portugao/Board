{* purpose of this template: inclusion template for managing related Ranks in admin area *}
<fieldset>
    <legend>{gt text='Rank'}</legend>
    <div class="z-formrow">
    <div class="muboardRelationRightSide">
        <a id="{$idPrefix}AddLink" href="javascript:void(0);" style="display: none">{gt text='Select rank'}</a>
        <div id="{$idPrefix}AddFields">
            <label for="{$idPrefix}Selector">{gt text='Find rank'}</label>
            <br />
            {icon type='search' size='extrasmall' __alt='Search rank'}
            <input type="text" name="{$idPrefix}Selector" id="{$idPrefix}Selector" value="" />
            <input type="hidden" name="{$idPrefix}Scope" id="{$idPrefix}Scope" value="0" />
            {img src='indicator_circle.gif' modname='core' set='ajax' alt='' id="`$idPrefix`Indicator" style='display: none'}
            <div id="{$idPrefix}SelectorChoices" class="muboardAutoCompleteWithImage"></div>
            <input type="button" id="{$idPrefix}SelectorDoCancel" name="{$idPrefix}SelectorDoCancel" value="{gt text='Cancel'}" class="z-button muboardInlineButton" />
            <a id="{$idPrefix}SelectorDoNew" href="{modurl modname='MUBoard' type='admin' func='edit' ot='rank'}" title="{gt text='Create new rank'}" class="z-button muboardInlineButton">{gt text='Create'}</a>
        </div>
        <noscript><p>{gt text='This function requires JavaScript activated!'}</p></noscript>
    </div>
    <div class="muboardRelationLeftSide">
        {if isset($userSelection.$aliasName) && $userSelection.$aliasName ne ''}
            {* the user has submitted something *}
            {include file='admin/rank/include_selectEditItemListOne.tpl' item=$userSelection.$aliasName}
        {elseif $mode ne 'create' || isset($relItem.$aliasName)}
            {include file='admin/rank/include_selectEditItemListOne.tpl' item=$relItem.$aliasName}
        {else}
            {include file='admin/rank/include_selectEditItemListOne.tpl'}
        {/if}
    </div>
    <br style="clear: both" />
    </div>
</fieldset>

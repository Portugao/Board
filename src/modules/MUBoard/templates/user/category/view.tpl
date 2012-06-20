{* purpose of this template: categories view view in user area *}
<div class="muboard-category muboard-view">
{include file='user/header.tpl'}
{gt text='Forum - Category Overview' assign='templateTitle'}
{pagesetvar name='title' value=$templateTitle}
<div class="z-frontendcontainer">
    <h2>{$templateTitle}</h2>


   {* {checkpermissionblock component='MUBoard::' instance='.*' level="ACCESS_ADD"}
        {gt text='Create category' assign='createTitle'}
        <a href="{modurl modname='MUBoard' type='user' func='edit' ot='category'}" title="{$createTitle}" class="z-icon-es-add">
            {$createTitle}
        </a>
    {/checkpermissionblock}

    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='MUBoard' type='user' func='view' ot='category'}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='MUBoard' type='user' func='view' ot='category' all=1}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
    {/if}

<table class="z-datatable">
    <colgroup>
        <col id="ctitle" />
        <col id="cdescription" />
        <col id="cpos" />
        <col id="citemactions" />
    </colgroup>
    <thead>
    <tr>
        <th id="htitle" scope="col" class="z-left">
            {sortlink __linktext='Title' sort='title' currentsort=$sort sortdir=$sdir all=$all modname='MUBoard' type='user' func='view' ot='category'}
        </th>
        <th id="hdescription" scope="col" class="z-left">
            {sortlink __linktext='Description' sort='description' currentsort=$sort sortdir=$sdir all=$all modname='MUBoard' type='user' func='view' ot='category'}
        </th>
        <th id="hpos" scope="col" class="z-right">
            {sortlink __linktext='Pos' sort='pos' currentsort=$sort sortdir=$sdir all=$all modname='MUBoard' type='user' func='view' ot='category'}
        </th>
        <th id="hitemactions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
    </tr>
    </thead>
    <tbody> *}

    {foreach item='category' from=$items}
    {checkpermissionblock component='MUBoard:Category:' instance="`$category.id`::" level="ACCESS_OVERVIEW"}
    <div class="muboard-user-category">
        <div class="muboard-user-category-header">
        <div class="muboard-user-category-header-title">
            <h2>
            {* {gt text='Category: '} *}
            <a href="{modurl modname='MUBoard' type='user' func='display' ot='category' id=$category.id}">{$category.title|notifyfilters:'muboard.filterhook.categories'}</a>
            </h2>
        </div>
        <div class="muboard-user-category-header-statistic issues">{$category.id|muboardGetNumberOfIssuesOfCategory:$category.id}</div>
        <div class="muboard-user-category-header-statistic postings">{$category.id|muboardGetNumberOfPostingsOfCategory:$category.id}</div>
        </div>
        <div class=muboard-user-category-content>
            {if isset($category.forum) && $category.forum ne null}
            {include file='user/forum/include_displayItemListMany.tpl' items=$category.forum}
            {else}
            {gt text='There are no forums in this category!'}
            {/if}
        </div>
    
    </div>
    {/checkpermissionblock}

 {*  <tr class="{cycle values='z-odd, z-even'}">
        <td headers="htitle" class="z-left">
            {$category.title|notifyfilters:'muboard.filterhook.categories'}
        </td>
        <td headers="hdescription" class="z-left">
            {$category.description}
        </td>
        <td headers="hpos" class="z-right">
            {$category.pos}
        </td>
        <td headers="hitemactions" class="z-right z-nowrap z-w02">
            {if count($category._actions) gt 0}
            {strip}
                {foreach item='option' from=$category._actions}
                    <a href="{$option.url.type|muboardActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>
                        {icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}
                    </a>
                {/foreach}
            {/strip}
            {/if}
        </td>
    </tr> *}
    {foreachelse}
        <tr class="z-datatableempty">
          <td class="z-left" colspan="4">
            {gt text='No categories found.'}
          </td>
        </tr>
    {/foreach}

 {*   </tbody>
</table> *}


    {if !isset($showAllEntries) || $showAllEntries ne 1}
        {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page'}
    {/if}

    {notifydisplayhooks eventname='muboard.ui_hooks.categories.display_view' urlobject=$currentUrlObject assign='hooks'}
    {foreach key='hookname' item='hook' from=$hooks}
        {$hook}
    {/foreach}
</div>
</div>
        
    <div class="z-informationmsg z-formnote" style="float: left; width: 96%;">
    {gt text='Number of issues'} <div class="muboard-user-category-header-statistic issues">5</div> 
    {gt text='Number of postings'} <div class="muboard-user-category-header-statistic postings">3</div>
    </div>
{include file='user/footer.tpl'}


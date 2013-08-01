{* purpose of this template: categories view view in admin area *}
<div class="muboard-category muboard-view">
{include file='admin/header.tpl'}
{gt text='Category list' assign='templateTitle'}
{pagesetvar name='title' value=$templateTitle}
<div class="z-admin-content-pagetitle">
    {icon type='view' size='small' alt=$templateTitle}
    <h3>{$templateTitle}</h3>
</div>


    {checkpermissionblock component='MUBoard::' instance='.*' level="ACCESS_ADD"}
        {gt text='Create category' assign='createTitle'}
        <a href="{modurl modname='MUBoard' type='admin' func='edit' ot='category'}" title="{$createTitle}" class="z-icon-es-add">
            {$createTitle}
        </a>
    {/checkpermissionblock}

    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='MUBoard' type='admin' func='view' ot='category'}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='MUBoard' type='admin' func='view' ot='category' all=1}" title="{$linkTitle}" class="z-icon-es-view">
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
            {sortlink __linktext='Title' sort='title' currentsort=$sort sortdir=$sdir all=$all modname='MUBoard' type='admin' func='view' ot='category'}
        </th>
        <th id="hdescription" scope="col" class="z-left">
            {sortlink __linktext='Description' sort='description' currentsort=$sort sortdir=$sdir all=$all modname='MUBoard' type='admin' func='view' ot='category'}
        </th>
        <th id="hpos" scope="col" class="z-right">
            {sortlink __linktext='Pos' sort='pos' currentsort=$sort sortdir=$sdir all=$all modname='MUBoard' type='admin' func='view' ot='category'}
        </th>
        <th id="hitemactions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
    </tr>
    </thead>
    <tbody>

    {foreach item='category' from=$items}
    <tr class="{cycle values='z-odd, z-even'}">
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
    </tr>
    {foreachelse}
        <tr class="z-admintableempty">
          <td class="z-left" colspan="4">
            {gt text='No categories found.'}
          </td>
        </tr>
    {/foreach}

    </tbody>
</table>

    {if !isset($showAllEntries) || $showAllEntries ne 1}
        {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page'}
    {/if}
</div>
{include file='admin/footer.tpl'}


{* purpose of this template: abos view view in user area *}
<div class="muboard-abo muboard-view">
{include file='user/header.tpl'}
{gt text='Abo list' assign='templateTitle'}
{pagesetvar name='title' value=$templateTitle}
<div class="z-frontendcontainer">
    <h2>{$templateTitle}</h2>


    {checkpermissionblock component='MUBoard::' instance='.*' level="ACCESS_ADD"}
        {gt text='Create abo' assign='createTitle'}
        <a href="{modurl modname='MUBoard' type='user' func='edit' ot='abo'}" title="{$createTitle}" class="z-icon-es-add">
            {$createTitle}
        </a>
    {/checkpermissionblock}

    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='MUBoard' type='user' func='view' ot='abo'}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='MUBoard' type='user' func='view' ot='abo' all=1}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
    {/if}

<table class="z-datatable">
    <colgroup>
        <col id="cuserid" />
        <col id="ccatid" />
        <col id="cforumid" />
        <col id="cpostingid" />
        <col id="citemactions" />
    </colgroup>
    <thead>
    <tr>
        <th id="huserid" scope="col" class="z-right">
            {sortlink __linktext='Userid' sort='userid' currentsort=$sort sortdir=$sdir all=$all modname='MUBoard' type='user' func='view' ot='abo'}
        </th>
        <th id="hcatid" scope="col" class="z-right">
            {sortlink __linktext='Catid' sort='catid' currentsort=$sort sortdir=$sdir all=$all modname='MUBoard' type='user' func='view' ot='abo'}
        </th>
        <th id="hforumid" scope="col" class="z-right">
            {sortlink __linktext='Forumid' sort='forumid' currentsort=$sort sortdir=$sdir all=$all modname='MUBoard' type='user' func='view' ot='abo'}
        </th>
        <th id="hpostingid" scope="col" class="z-right">
            {sortlink __linktext='Postingid' sort='postingid' currentsort=$sort sortdir=$sdir all=$all modname='MUBoard' type='user' func='view' ot='abo'}
        </th>
        <th id="hitemactions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
    </tr>
    </thead>
    <tbody>

    {foreach item='abo' from=$items}
    <tr class="{cycle values='z-odd, z-even'}">
        <td headers="huserid" class="z-right">
            {$abo.userid|notifyfilters:'muboard.filterhook.abos'}
        </td>
        <td headers="hcatid" class="z-right">
            {$abo.catid}
        </td>
        <td headers="hforumid" class="z-right">
            {$abo.forumid}
        </td>
        <td headers="hpostingid" class="z-right">
            {$abo.postingid}
        </td>
        <td headers="hitemactions" class="z-right z-nowrap z-w02">
            {if count($abo._actions) gt 0}
            {strip}
                {foreach item='option' from=$abo._actions}
                    <a href="{$option.url.type|muboardActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>
                        {icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}
                    </a>
                {/foreach}
            {/strip}
            {/if}
        </td>
    </tr>
    {foreachelse}
        <tr class="z-datatableempty">
          <td class="z-left" colspan="5">
            {gt text='No abos found.'}
          </td>
        </tr>
    {/foreach}

    </tbody>
</table>

    {if !isset($showAllEntries) || $showAllEntries ne 1}
        {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page'}
    {/if}

    {notifydisplayhooks eventname='muboard.ui_hooks.abos.display_view' urlobject=$currentUrlObject assign='hooks'}
    {foreach key='hookname' item='hook' from=$hooks}
        {$hook}
    {/foreach}
</div>
</div>
{include file='user/footer.tpl'}


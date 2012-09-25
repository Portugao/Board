{* purpose of this template: users view view in user area *}
<div class="muboard-user muboard-view">
{include file='user/header.tpl'}
{gt text='User list' assign='templateTitle'}
{pagesetvar name='title' value=$templateTitle}
<div class="z-frontendcontainer">
    <h2>{$templateTitle}</h2>


    {checkpermissionblock component='MUBoard::' instance='.*' level="ACCESS_ADD"}
        {gt text='Create user' assign='createTitle'}
        <a href="{modurl modname='MUBoard' type='user' func='edit' ot='user'}" title="{$createTitle}" class="z-icon-es-add">
            {$createTitle}
        </a>
    {/checkpermissionblock}

    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='MUBoard' type='user' func='view' ot='user'}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='MUBoard' type='user' func='view' ot='user' all=1}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
    {/if}

<table class="z-datatable">
    <colgroup>
        <col id="cuserid" />
        <col id="cnumberpostings" />
        <col id="crankuser" />
        <col id="clastvisit" />
        <col id="crank" />
        <col id="citemactions" />
    </colgroup>
    <thead>
    <tr>
        <th id="huserid" scope="col" class="z-right">
            {sortlink __linktext='Userid' sort='userid' currentsort=$sort sortdir=$sdir all=$all modname='MUBoard' type='user' func='view' ot='user'}
        </th>
        <th id="hnumberpostings" scope="col" class="z-right">
            {sortlink __linktext='Number postings' sort='numberPostings' currentsort=$sort sortdir=$sdir all=$all modname='MUBoard' type='user' func='view' ot='user'}
        </th>
        <th id="hrankuser" scope="col" class="z-right">
            {sortlink __linktext='Rank user' sort='rankUser' currentsort=$sort sortdir=$sdir all=$all modname='MUBoard' type='user' func='view' ot='user'}
        </th>
        <th id="hlastvisit" scope="col" class="z-left">
            {sortlink __linktext='Last visit' sort='lastVisit' currentsort=$sort sortdir=$sdir all=$all modname='MUBoard' type='user' func='view' ot='user'}
        </th>
        <th id="hrank" scope="col" class="z-left">
            {sortlink __linktext='Rank' sort='rank' currentsort=$sort sortdir=$sdir all=$all modname='MUBoard' type='user' func='view' ot='user'}
        </th>
        <th id="hitemactions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
    </tr>
    </thead>
    <tbody>

    {foreach item='user' from=$items}
    <tr class="{cycle values='z-odd, z-even'}">
        <td headers="huserid" class="z-right">
            {$user.userid|notifyfilters:'muboard.filterhook.users'}
        </td>
        <td headers="hnumberpostings" class="z-right">
            {$user.numberPostings}
        </td>
        <td headers="hrankuser" class="z-right">
            {$user.rankUser}
        </td>
        <td headers="hlastvisit" class="z-left">
            {$user.lastVisit|dateformat:'datetimebrief'}
        </td>
        <td headers="hrank" class="z-left">
            {if isset($user.Rank) && $user.Rank ne null}
                <a href="{modurl modname='MUBoard' type='user' func='display' ot='rank' id=$user.Rank.id}">
                    {$user.Rank.name|default:""}
                </a>
                <a id="rankItem{$user.id}_rel_{$user.Rank.id}Display" href="{modurl modname='MUBoard' type='user' func='display' ot='rank' id=$user.Rank.id theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" style="display: none">
                    {icon type='view' size='extrasmall' __alt='Quick view'}
                </a>
                <script type="text/javascript" charset="utf-8">
                /* <![CDATA[ */
                    document.observe('dom:loaded', function() {
                        muboardInitInlineWindow($('rankItem{{$user.id}}_rel_{{$user.Rank.id}}Display'), '{{$user.Rank.name|replace:"'":""}}');
                    });
                /* ]]> */
                </script>
            {else}
                {gt text='Not set.'}
            {/if}
        </td>
        <td headers="hitemactions" class="z-right z-nowrap z-w02">
            {if count($user._actions) gt 0}
            {strip}
                {foreach item='option' from=$user._actions}
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
          <td class="z-left" colspan="6">
            {gt text='No users found.'}
          </td>
        </tr>
    {/foreach}

    </tbody>
</table>

    {if !isset($showAllEntries) || $showAllEntries ne 1}
        {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page'}
    {/if}

    {notifydisplayhooks eventname='muboard.ui_hooks.users.display_view' urlobject=$currentUrlObject assign='hooks'}
    {foreach key='hookname' item='hook' from=$hooks}
        {$hook}
    {/foreach}
</div>
</div>
{include file='user/footer.tpl'}


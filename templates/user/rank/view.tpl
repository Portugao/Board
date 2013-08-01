{* purpose of this template: ranks view view in user area *}
<div class="muboard-rank muboard-view">
{include file='user/header.tpl'}
{gt text='Rank list' assign='templateTitle'}
{pagesetvar name='title' value=$templateTitle}
<div class="z-frontendcontainer">
    <h2>{$templateTitle}</h2>


    {checkpermissionblock component='MUBoard::' instance='.*' level="ACCESS_ADD"}
        {gt text='Create rank' assign='createTitle'}
        <a href="{modurl modname='MUBoard' type='user' func='edit' ot='rank'}" title="{$createTitle}" class="z-icon-es-add">
            {$createTitle}
        </a>
    {/checkpermissionblock}

    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='MUBoard' type='user' func='view' ot='rank'}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='MUBoard' type='user' func='view' ot='rank' all=1}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
    {/if}

<table class="z-datatable">
    <colgroup>
        <col id="cname" />
        <col id="cminpostings" />
        <col id="cmaxpostings" />
        <col id="cnumberoficons" />
        <col id="cuploadimage" />
        <col id="cspecial" />
        <col id="citemactions" />
    </colgroup>
    <thead>
    <tr>
        <th id="hname" scope="col" class="z-left">
            {sortlink __linktext='Name' sort='name' currentsort=$sort sortdir=$sdir all=$all modname='MUBoard' type='user' func='view' ot='rank'}
        </th>
        <th id="hminpostings" scope="col" class="z-right">
            {sortlink __linktext='Min postings' sort='minPostings' currentsort=$sort sortdir=$sdir all=$all modname='MUBoard' type='user' func='view' ot='rank'}
        </th>
        <th id="hmaxpostings" scope="col" class="z-right">
            {sortlink __linktext='Max postings' sort='maxPostings' currentsort=$sort sortdir=$sdir all=$all modname='MUBoard' type='user' func='view' ot='rank'}
        </th>
        <th id="hnumberoficons" scope="col" class="z-right">
            {sortlink __linktext='Number of icons' sort='numberOfIcons' currentsort=$sort sortdir=$sdir all=$all modname='MUBoard' type='user' func='view' ot='rank'}
        </th>
        <th id="huploadimage" scope="col" class="z-left">
            {sortlink __linktext='Upload image' sort='uploadImage' currentsort=$sort sortdir=$sdir all=$all modname='MUBoard' type='user' func='view' ot='rank'}
        </th>
        <th id="hspecial" scope="col" class="z-center">
            {sortlink __linktext='Special' sort='special' currentsort=$sort sortdir=$sdir all=$all modname='MUBoard' type='user' func='view' ot='rank'}
        </th>
        <th id="hitemactions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
    </tr>
    </thead>
    <tbody>

    {foreach item='rank' from=$items}
    <tr class="{cycle values='z-odd, z-even'}">
        <td headers="hname" class="z-left">
            {$rank.name|notifyfilters:'muboard.filterhook.ranks'}
        </td>
        <td headers="hminpostings" class="z-right">
            {$rank.minPostings}
        </td>
        <td headers="hmaxpostings" class="z-right">
            {$rank.maxPostings}
        </td>
        <td headers="hnumberoficons" class="z-right">
            {$rank.numberOfIcons}
        </td>
        <td headers="huploadimage" class="z-left">
            {if $rank.uploadImage ne ''}
              <a href="{$rank.uploadImageFullPathURL}" title="{$rank.name|replace:"\"":""}"{if $rank.uploadImageMeta.isImage} rel="imageviewer[rank]"{/if}>
              {if $rank.uploadImageMeta.isImage}
                  <img src="{$rank.uploadImage|muboardImageThumb:$rank.uploadImageFullPath:32:20}" width="32" height="20" alt="{$rank.name|replace:"\"":""}" />
              {else}
                  {gt text='Download'} ({$rank.uploadImageMeta.size|muboardGetFileSize:$rank.uploadImageFullPath:false:false})
              {/if}
              </a>
            {else}&nbsp;{/if}

        </td>
        <td headers="hspecial" class="z-center">
            {assign var='itemid' value=$rank.id}
            <a id="togglespecial{$itemid}" href="javascript:void(0);" style="display: none">
            {if $rank.special}
                {icon type='ok' size='extrasmall' __alt='Yes' id="yesspecial_`$itemid`" __title="This setting is enabled. Click here to disable it."}
                {icon type='cancel' size='extrasmall' __alt='No' id="nospecial_`$itemid`" __title="This setting is disabled. Click here to enable it." style="display: none;"}
            {else}
                {icon type='ok' size='extrasmall' __alt='Yes' id="yesspecial_`$itemid`" __title="This setting is enabled. Click here to disable it." style="display: none;"}
                {icon type='cancel' size='extrasmall' __alt='No' id="nospecial_`$itemid`" __title="This setting is disabled. Click here to enable it."}
            {/if}
            </a>
            <noscript><div id="noscriptspecial{$itemid}">
                {$rank.special|yesno:true}            </div></noscript>

        </td>
        <td headers="hitemactions" class="z-right z-nowrap z-w02">
            {if count($rank._actions) gt 0}
            {strip}
                {foreach item='option' from=$rank._actions}
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
          <td class="z-left" colspan="7">
            {gt text='No ranks found.'}
          </td>
        </tr>
    {/foreach}

    </tbody>
</table>

    {if !isset($showAllEntries) || $showAllEntries ne 1}
        {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page'}
    {/if}

    {notifydisplayhooks eventname='muboard.ui_hooks.ranks.display_view' urlobject=$currentUrlObject assign='hooks'}
    {foreach key='hookname' item='hook' from=$hooks}
        {$hook}
    {/foreach}
</div>
</div>
{include file='user/footer.tpl'}

<script type="text/javascript" charset="utf-8">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
    {{foreach item='rank' from=$items}}
        {{assign var='itemid' value=$rank.id}}
        muboardInitToggle('rank', 'special', '{{$itemid}}');
    {{/foreach}}
    });
/* ]]> */
</script>

{* purpose of this template: ranks display view in user area *}
{include file='user/header.tpl'}
<div class="muboard-rank muboard-display">
{gt text='Rank' assign='templateTitle'}
{assign var='templateTitle' value=$rank.name|default:$templateTitle}
{pagesetvar name='title' value=$templateTitle|@html_entity_decode}
<div class="z-frontendcontainer">
    <h2>{$templateTitle|notifyfilters:'muboard.filter_hooks.ranks.filter'}</h2>

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
<div class="muboardRightBox">
<h3>{gt text='Users'}</h3>

{if isset($rank.user) && $rank.user ne null}
    {include file='user/user/include_displayItemListMany.tpl' items=$rank.user}
{/if}

{checkpermission component='MUBoard::' instance='.*' level='ACCESS_ADMIN' assign='authAdmin'}
{if $authAdmin || (isset($uid) && isset($rank.createdUserId) && $rank.createdUserId eq $uid)}
<p class="manageLink">
    {gt text='Create user' assign='createTitle'}
    <a href="{modurl modname='MUBoard' type='user' func='edit' ot='user' rank="`$rank.id`" returnTo='userDisplayRank'}" title="{$createTitle}" class="z-icon-es-add">
        {$createTitle}
    </a>
</p>
{/if}
</div>
{/if}

<dl id="MUBoard_body">
    <dt>{gt text='Min postings'}</dt>
    <dd>{$rank.minPostings}</dd>
    <dt>{gt text='Max postings'}</dt>
    <dd>{$rank.maxPostings}</dd>
    <dt>{gt text='Number of icons'}</dt>
    <dd>{$rank.numberOfIcons}</dd>
    <dt>{gt text='Upload image'}</dt>
    <dd>{if $rank.uploadImage ne ''}
  <a href="{$rank.uploadImageFullPathURL}" title="{$rank.name|replace:"\"":""}"{if $rank.uploadImageMeta.isImage} rel="imageviewer[rank]"{/if}>
  {if $rank.uploadImageMeta.isImage}
      <img src="{$rank.uploadImage|muboardImageThumb:$rank.uploadImageFullPath:250:150}" width="250" height="150" alt="{$rank.name|replace:"\"":""}" />
  {else}
      {gt text='Download'} ({$rank.uploadImageMeta.size|muboardGetFileSize:$rank.uploadImageFullPath:false:false})
  {/if}
  </a>
{else}&nbsp;{/if}
</dd>
    <dt>{gt text='Special'}</dt>
    <dd>{assign var='itemid' value=$rank.id}
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
    {$rank.special|yesno:true}</div></noscript>
</dd>
</dl>
    {include file='user/include_standardfields_display.tpl' obj=$rank}

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
{if count($rank._actions) gt 0}
    <p>{strip}
    {foreach item='option' from=$rank._actions}
        <a href="{$option.url.type|muboardActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">
            {$option.linkText|safetext}
        </a>
    {/foreach}
    {/strip}</p>
{/if}

{* include display hooks *}
{notifydisplayhooks eventname='muboard.ui_hooks.ranks.display_view' id=$rank.id urlobject=$currentUrlObject assign='hooks'}
{foreach key='hookname' item='hook' from=$hooks}
    {$hook}
{/foreach}

<br style="clear: right" />
{/if}

</div>
</div>
{include file='user/footer.tpl'}

<script type="text/javascript" charset="utf-8">
/* <![CDATA[ */
    document.observe('dom:loaded', function() {
        {{assign var='itemid' value=$rank.id}}
        muboardInitToggle('rank', 'special', '{{$itemid}}');
    });
/* ]]> */
</script>

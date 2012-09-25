{* purpose of this template: users display view in admin area *}
{include file='admin/header.tpl'}
<div class="muboard-user muboard-display">
{gt text='User' assign='templateTitle'}
{assign var='templateTitle' value=$user.userid|default:$templateTitle}
{pagesetvar name='title' value=$templateTitle|@html_entity_decode}
<div class="z-admin-content-pagetitle">
    {icon type='display' size='small' __alt='Details'}
    <h3>{$templateTitle|notifyfilters:'muboard.filter_hooks.users.filter'}</h3>
</div>

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
<div class="muboardRightBox">
<h3>{gt text='Rank'}</h3>

{if isset($user.rank) && $user.rank ne null}
    {include file='admin/rank/include_displayItemListOne.tpl' item=$user.rank}
{/if}

{if !isset($user.rank) || $user.rank eq null}
{checkpermission component='MUBoard::' instance='.*' level='ACCESS_ADMIN' assign='authAdmin'}
{if $authAdmin || (isset($uid) && isset($user.createdUserId) && $user.createdUserId eq $uid)}
<p class="manageLink">
    {gt text='Create rank' assign='createTitle'}
    <a href="{modurl modname='MUBoard' type='admin' func='edit' ot='rank' user="`$user.id`" returnTo='adminDisplayUser'}" title="{$createTitle}" class="z-icon-es-add">
        {$createTitle}
    </a>
</p>
{/if}
{/if}
</div>
{/if}

<dl id="MUBoard_body">
    <dt>{gt text='Number postings'}</dt>
    <dd>{$user.numberPostings}</dd>
    <dt>{gt text='Rank user'}</dt>
    <dd>{$user.rankUser}</dd>
    <dt>{gt text='Last visit'}</dt>
    <dd>{$user.lastVisit|dateformat:'datetimebrief'}</dd>
</dl>

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
{if count($user._actions) gt 0}
    <p>{strip}
    {foreach item='option' from=$user._actions}
        <a href="{$option.url.type|muboardActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">
            {$option.linkText|safetext}
        </a>
    {/foreach}
    {/strip}</p>
{/if}

{* include display hooks *}
{notifydisplayhooks eventname='muboard.ui_hooks.users.display_view' id=$user.id urlobject=$currentUrlObject assign='hooks'}
{foreach key='hookname' item='hook' from=$hooks}
    {$hook}
{/foreach}

<br style="clear: right" />
{/if}

</div>
{include file='admin/footer.tpl'}


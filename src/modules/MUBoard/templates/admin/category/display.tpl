{* purpose of this template: categories display view in admin area *}
{include file='admin/header.tpl'}
<div class="muboard-category muboard-display">
{gt text='Category' assign='templateTitle'}
{assign var='templateTitle' value=$category.title|default:$templateTitle}
{pagesetvar name='title' value=$templateTitle|@html_entity_decode}
<div class="z-admin-content-pagetitle">
    {icon type='display' size='small' __alt='Details'}
    <h3>{$templateTitle|notifyfilters:'muboard.filter_hooks.categories.filter'}</h3>
</div>

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
<div class="muboardRightBox">
<h3>{gt text='Forums'}</h3>

{if isset($category.forum) && $category.forum ne null}
    {include file='admin/forum/include_displayItemListMany.tpl' items=$category.forum}
{/if}

{checkpermission component='MUBoard::' instance='.*' level='ACCESS_ADMIN' assign='authAdmin'}
{if $authAdmin || (isset($uid) && isset($category.createdUserId) && $category.createdUserId eq $uid)}
<p class="manageLink">
    {gt text='Create forum' assign='createTitle'}
    <a href="{modurl modname='MUBoard' type='admin' func='edit' ot='forum' category="`$category.id`" returnTo='adminDisplayCategory'}" title="{$createTitle}" class="z-icon-es-add">
        {$createTitle}
    </a>
</p>
{/if}
</div>
{/if}

<dl id="MUBoard_body">
    <dt>{gt text='Description'}</dt>
    <dd>{$category.description}</dd>
    <dt>{gt text='Pos'}</dt>
    <dd>{$category.pos}</dd>
</dl>
    {include file='admin/include_standardfields_display.tpl' obj=$category}

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
{if count($category._actions) gt 0}
    <p>{strip}
    {foreach item='option' from=$category._actions}
        <a href="{$option.url.type|muboardActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">
            {$option.linkText|safetext}
        </a>
    {/foreach}
    {/strip}</p>
{/if}

{* include display hooks *}
{notifydisplayhooks eventname='muboard.ui_hooks.categories.display_view' id=$category.id urlobject=$currentUrlObject assign='hooks'}
{foreach key='hookname' item='hook' from=$hooks}
    {$hook}
{/foreach}

<br style="clear: right" />
{/if}

</div>
{include file='admin/footer.tpl'}


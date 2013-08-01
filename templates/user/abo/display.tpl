{* purpose of this template: abos display view in user area *}
{include file='user/header.tpl'}
<div class="muboard-abo muboard-display">
{gt text='Abo' assign='templateTitle'}
{assign var='templateTitle' value=$abo.userid|default:$templateTitle}
{pagesetvar name='title' value=$templateTitle|@html_entity_decode}
<div class="z-frontendcontainer">
    <h2>{$templateTitle|notifyfilters:'muboard.filter_hooks.abos.filter'}</h2>


<dl id="MUBoard_body">
    <dt>{gt text='Catid'}</dt>
    <dd>{$abo.catid}</dd>
    <dt>{gt text='Forumid'}</dt>
    <dd>{$abo.forumid}</dd>
    <dt>{gt text='Postingid'}</dt>
    <dd>{$abo.postingid}</dd>
</dl>
    {include file='user/include_standardfields_display.tpl' obj=$abo}

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
{if count($abo._actions) gt 0}
    <p>{strip}
    {foreach item='option' from=$abo._actions}
        <a href="{$option.url.type|muboardActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">
            {$option.linkText|safetext}
        </a>
    {/foreach}
    {/strip}</p>
{/if}

{* include display hooks *}
{notifydisplayhooks eventname='muboard.ui_hooks.abos.display_view' id=$abo.id urlobject=$currentUrlObject assign='hooks'}
{foreach key='hookname' item='hook' from=$hooks}
    {$hook}
{/foreach}

{/if}

</div>
</div>
{include file='user/footer.tpl'}


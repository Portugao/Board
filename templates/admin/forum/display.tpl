{* purpose of this template: forums display view in admin area *}
{include file='admin/header.tpl'}
<div class="muboard-forum muboard-display">
{gt text='Forum' assign='templateTitle'}
{assign var='templateTitle' value=$forum.title|default:$templateTitle}
{pagesetvar name='title' value=$templateTitle|@html_entity_decode}
<div class="z-admin-content-pagetitle">
    {icon type='display' size='small' __alt='Details'}
    <h3>{$templateTitle|notifyfilters:'muboard.filter_hooks.forums.filter'}</h3>
</div>

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
<div class="muboardRightBox">
<h3>{gt text='Postings'}</h3>

{if isset($forum.posting) && $forum.posting ne null}
    {include file='admin/posting/include_displayItemListMany.tpl' items=$forum.posting}
{/if}

{checkpermission component='MUBoard::' instance='.*' level='ACCESS_ADMIN' assign='authAdmin'}
{if $authAdmin || (isset($uid) && isset($forum.createdUserId) && $forum.createdUserId eq $uid)}
<p class="manageLink">
    {gt text='Create posting' assign='createTitle'}
    <a href="{modurl modname='MUBoard' type='admin' func='edit' ot='posting' forum="`$forum.id`" returnTo='adminDisplayForum'}" title="{$createTitle}" class="z-icon-es-add">
        {$createTitle}
    </a>
</p>
{/if}
</div>
{/if}

<dl id="MUBoard_body">
    <dt>{gt text='Description'}</dt>
    <dd>{$forum.description}</dd>
    <dt>{gt text='Pos'}</dt>
    <dd>{$forum.pos}</dd>
    <dt>{gt text='Category'}</dt>
    <dd>
    {if isset($forum.Category) && $forum.Category ne null}
      {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        <a href="{modurl modname='MUBoard' type='admin' func='display' ot='category' id=$forum.Category.id}">
            {$forum.Category.title|default:""}
        </a>
        <a id="categoryItem{$forum.Category.id}Display" href="{modurl modname='MUBoard' type='admin' func='display' ot='category' id=$forum.Category.id theme='Printer'}" title="{gt text='Open quick view window'}" style="display: none">
            {icon type='view' size='extrasmall' __alt='Quick view'}
        </a>
        <script type="text/javascript" charset="utf-8">
        /* <![CDATA[ */
            document.observe('dom:loaded', function() {
                muboardInitInlineWindow($('categoryItem{{$forum.Category.id}}Display'), '{{$forum.Category.title|replace:"'":""}}');
            });
        /* ]]> */
        </script>
      {else}
        {$forum.Category.title|default:""}
      {/if}
    {else}
        {gt text='No set.'}
    {/if}
    </dd>
</dl>
    {include file='admin/include_standardfields_display.tpl' obj=$forum}

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
{if count($forum._actions) gt 0}
    <p>{strip}
    {foreach item='option' from=$forum._actions}
        <a href="{$option.url.type|muboardActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">
            {$option.linkText|safetext}
        </a>
    {/foreach}
    {/strip}</p>
{/if}

{* include display hooks *}
{notifydisplayhooks eventname='muboard.ui_hooks.forums.display_view' id=$forum.id urlobject=$currentUrlObject assign='hooks'}
{foreach key='hookname' item='hook' from=$hooks}
    {$hook}
{/foreach}

<br style="clear: right" />
{/if}

</div>
{include file='admin/footer.tpl'}


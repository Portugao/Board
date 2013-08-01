{* purpose of this template: categories display view in user area *}
{include file='user/header.tpl'}
<div class="muboard-category muboard-display">
{gt text='Category' assign='templateTitle'}
{assign var='templateTitle' value=$category.title|default:$templateTitle}
{* {pagesetvar name='title' value=$templateTitle|@html_entity_decode} *}
<div class="z-frontendcontainer">
   {* <h2>{$templateTitle|notifyfilters:'muboard.filter_hooks.categories.filter'}</h2> *}

 {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
{*<div class="muboardRightBox">
<h3>{gt text='Forums'}</h3> *}

{checkpermissionblock component='MUBoard:Category:' instance="`$category.id`::" level="ACCESS_OVERVIEW"}
    <div class="muboard-user-category">
        <div class="muboard-user-category-header">
        <div class="muboard-user-category-header-title">
            <h2>
            {* {gt text='Category:'} *} {$category.title|notifyfilters:'muboard.filterhook.categories'}
            </h2>
        </div>
        <div class="muboard-user-category-header-statistic issues">{$category.id|muboardGetNumberOfIssuesOfCategory:$category.id}</div>   
        <div class="muboard-user-category-header-statistic postings">{$category.id|muboardGetNumberOfPostingsOfCategory:$category.id}</div>
        </div>
        <div class=muboard-user-category-content>
            {if isset($category.forum) && $category.forum ne null}
            {include file='user/forum/include_displayItemListMany.tpl' items=$category.forum}
            {/if}
        </div>
    
    </div>
{/checkpermissionblock}

{* {checkpermission component='MUBoard::' instance='.*' level='ACCESS_ADMIN' assign='authAdmin'}
{if $authAdmin || (isset($uid) && isset($category.createdUserId) && $category.createdUserId eq $uid)}
<p class="manageLink">
    {gt text='Create forum' assign='createTitle'}
    <a href="{modurl modname='MUBoard' type='user' func='edit' ot='forum' category="`$category.id`" returnTo='userDisplayCategory'}" title="{$createTitle}" class="z-icon-es-add">
        {$createTitle}
    </a>
</p>
{/if}
</div> *}
{/if}

{* <dl id="MUBoard_body">
    <dt>{gt text='Description'}</dt>
    <dd>{$category.description}</dd>
    <dt>{gt text='Pos'}</dt>
    <dd>{$category.pos}</dd>
</dl>
    {include file='user/include_standardfields_display.tpl' obj=$category}

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
{if count($category._actions) gt 0}
    <p>{strip}
    {foreach item='option' from=$category._actions}
        <a href="{$option.url.type|muboardActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">
            {$option.linkText|safetext}
        </a>
    {/foreach}
    {/strip}</p>
{/if} *}

{* include display hooks *}
{notifydisplayhooks eventname='muboard.ui_hooks.categories.display_view' id=$category.id urlobject=$currentUrlObject assign='hooks'}
{foreach key='hookname' item='hook' from=$hooks}
    {$hook}
{/foreach}

{* <br style="clear: right" />
{/if}

</div> *}
</div>
    <div class="z-informationmsg z-formnote muboard-category-legend">
    <div class="muboard-user-legend"><span>{gt text='Number of issues'}</span><span class="muboard-user-category-footer-statistic issues">3</span></div> 
    <div class="muboard-user-legend"><span>{gt text='Number of postings'}</span><span class="muboard-user-category-footer-statistic postings">5</span></div>
    </div>
{include file='user/footer.tpl'}


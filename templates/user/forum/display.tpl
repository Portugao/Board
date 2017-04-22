{* purpose of this template: forums display view in user area *}
{include file='user/header.tpl'}
<div class="muboard-forum muboard-display">
{gt text='Forum' assign='templateTitle'}
{assign var='templateTitle' value=$forum.title|default:$templateTitle}
{* {pagesetvar name='title' value=$templateTitle|@html_entity_decode} *}
<div class="z-frontendcontainer">

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}

    <div class="muboard-user-forum-display">
    {checkpermissionblock component='MUBoard:Category:' instance="`$forum.category.id`::" level="ACCESS_OVERVIEW"}
    {checkpermissionblock component='MUBoard:Forum:' instance="`$forum.id`::" level="ACCESS_OVERVIEW"}
        <div class="muboard-user-forum-header">
        <div class="muboard-user-forum-header-title">
            <h2>
            {gt text='Forum:'} {$forum.title|notifyfilters:'muboard.filterhook.categories'}
            </h2>
        </div>
        <div class="muboard-user-forum-header-statistic postings">{$forum.id|muboardGetNumberOfPostingsOfForum:$forum.id}</div>
        <div class="muboard-user-forum-header-infos">{$forum.id|muboardGetStateOfForumAbo:$func}</div> 
        <div class="muboard-user-forum-header-category">{gt text='Category:'} <a href="{modurl modname='MUBoard' type='user' func='display' ot='category' id=$forum.category.id}">{$forum.category.title}</a></div>        
        </div>
        <div class=muboard-user-forum-content>
        {if isset($forum.posting) && $forum.posting ne null}
             {include file='user/posting/include_displayItemListMany.tpl' items=$postings}
        {/if}
        </div> 
        <div class="z-informationmsg z-formnote muboard-category-legend">
        <div class="muboard-user-legend"><span>{gt text='Answers'}</span><span class="muboard-user-forum-footer-statistic answers">3</span></div> 
        <div class="muboard-user-legend"><span>{gt text='Invocations'}</span><span class="muboard-user-forum-footer-statistic invocations">5</span></div>
        </div>  
        {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page'}
    {/checkpermissionblock}
    {/checkpermissionblock}
    </div>

{/if}


{* include display hooks *}
{notifydisplayhooks eventname='muboard.ui_hooks.forums.display_view' id=$forum.id urlobject=$currentUrlObject assign='hooks'}
{foreach key='hookname' item='hook' from=$hooks}
    {$hook}
{/foreach}

<br style="clear: right" />
</div>
</div>
{include file='user/footer.tpl'}


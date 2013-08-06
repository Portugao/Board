{* purpose of this template: categories display view in user area *}
{include file='user/header.tpl'}
<div class="muboard-category muboard-display">
{gt text='Category' assign='templateTitle'}
{assign var='templateTitle' value=$category.title|default:$templateTitle}
{* {pagesetvar name='title' value=$templateTitle|@html_entity_decode} *}
<div class="z-frontendcontainer">

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}

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
{/if}

{* include display hooks *}
{notifydisplayhooks eventname='muboard.ui_hooks.categories.display_view' id=$category.id urlobject=$currentUrlObject assign='hooks'}
{foreach key='hookname' item='hook' from=$hooks}
    {$hook}
{/foreach}

</div>
    <div class="z-informationmsg z-formnote muboard-category-legend">
    <div class="muboard-user-legend"><span>{gt text='Number of issues'}</span><span class="muboard-user-category-footer-statistic issues">3</span></div> 
    <div class="muboard-user-legend"><span>{gt text='Number of postings'}</span><span class="muboard-user-category-footer-statistic postings">5</span></div>
    </div>
</div>
{include file='user/footer.tpl'}


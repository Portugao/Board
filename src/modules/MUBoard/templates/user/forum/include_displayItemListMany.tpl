{* purpose of this template: inclusion template for display of related Forums in user area *}

{if isset($items) && $items ne null}
{* <ul class="relatedItemList Forum"> *}
{foreach name='relLoop' item='item' from=$items}

<div class="muboard-user-forum">
<div class="muboard-user-forum-left">
    {gt text='Forum:'}
    <a href="{modurl modname='MUBoard' type='user' func='display' ot='forum' id=$item.id}">
     {$item.title}
    </a><br />
    {$item.description}
</div>
<div class="muboard-user-forum-right">
    <div class="muboard-user-category-header-statistic issues">{$item.id|muboardGetNumberOfIssuesOfForum:$item.id}</div>
    <div class="muboard-user-category-header-statistic postings">{$item.id|muboardGetNumberOfPostingsOfForum:$item.id}</div>
    <div class="muboard-user-category-header-lastposting">
    {$item.id|muboardGetLastPosting:$item.id}
    </div>
    <div class="muboard-user-posting-header-infos">
    {* <a id="muboard-user-posting-header-infos-close" href="{modurl modname='muboard' type='admin' func='take' ot='abo' posting=$posting.id}">
    <img src="/images/icons/extrasmall/mail_get.png" />
    </a> *}
    {$item.id|muboardGetStateOfForumAbo:$func}
    {if $posting.state eq 1}
    {checkpermissionblock component='MUBoard::' instance='.*' level="ACCESS_ADMIN"}
    <a id="muboard-user-posting-header-infos-close" href="{modurl modname='muboard' type='admin' func='close' ot='posting' id=$item.id}">             
    {/checkpermissionblock}          
    {$posting.state|yesno:true}
    {checkpermissionblock component='MUBoard::' instance='.*' level="ACCESS_ADMIN"}
    </a>            
    {/checkpermissionblock}    
    {else}
    {$posting.state|yesno:true}
    {/if}                
    </div>
</div>
</div>

   {* <li>
    <a href="{modurl modname='MUBoard' type='user' func='display' ot='forum' id=$item.id}">
        {$item.title}
    </a>
    <a id="forumItem{$item.id}Display" href="{modurl modname='MUBoard' type='user' func='display' ot='forum' id=$item.id theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" style="display: none">
        {icon type='view' size='extrasmall' __alt='Quick view'}
    </a>
    <script type="text/javascript" charset="utf-8">
    /* <![CDATA[ */
        document.observe('dom:loaded', function() {
            muboardInitInlineWindow($('forumItem{{$item.id}}Display'), '{{$item.title|replace:"'":""}}');
        });
    /* ]]> */
    </script>

    </li> *}
{/foreach}
{* </ul> *}
            {else}
            {gt text='There are no forums in this category!'}
{/if}


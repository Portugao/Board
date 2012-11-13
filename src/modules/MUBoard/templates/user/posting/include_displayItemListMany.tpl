{* purpose of this template: inclusion template for display of related Postings in user area *}

{if isset($items) && $items ne null}
{* <ul class="relatedItemList Posting"> *}
{foreach name='relLoop' item='item' from=$items}
{if $item.parent_id eq NULL}
<div class="muboard-user-forum">
<div class="muboard-user-forum-left">
<div class="muboard-user-forum-left-icon">
{$item.id|muboardPostingsSinceLastLogin:2}
</div>
<div class="muboard-user-forum-left-creater">
    <a href="{modurl modname='MUBoard' type='user' func='display' ot='posting' id=$item.id}">
        {$item.title}
    </a><br />
    {gt text='Writer:'} {usergetvar name=uname uid=$item.createdUserId}
</div>
</div>
<div class="muboard-user-forum-right">
<div class="muboard-user-category-header-statistic children">{$item.id|muboardGetNumberOfAnswersOfPosting:$item.id}</div>
<div class="muboard-user-category-header-statistic calls">{$item.invocations}</div>
<div class="muboard-user-posting-header-infos">
    {$item.id|muboardGetStateOfPostingAbo:$func}
    {$item.id|muboardGetStateOfPosting}                
</div>
</div>
</div>
{/if}
    {* <li>
    <a href="{modurl modname='MUBoard' type='user' func='display' ot='posting' id=$item.id}">
        {$item.title}
    </a>
    <a id="postingItem{$item.id}Display" href="{modurl modname='MUBoard' type='user' func='display' ot='posting' id=$item.id theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" style="display: none">
        {icon type='view' size='extrasmall' __alt='Quick view'}
    </a>
    <script type="text/javascript" charset="utf-8">
    /* <![CDATA[ */
        document.observe('dom:loaded', function() {
            muboardInitInlineWindow($('postingItem{{$item.id}}Display'), '{{$item.title|replace:"'":""}}');
        });
    /* ]]> */
    </script>
    <br />
{if $item.firstImage ne '' && isset($item.firstImageFullPathURL)}
    <img src="{$item.firstImage|muboardImageThumb:$item.firstImageFullPathURL:50:40}" width="50" height="40" alt="{$item.title|replace:"\"":""}" />
{/if}

    </li> *}
{/foreach}
{* </ul> *}
{/if}


{* purpose of this template: inclusion template for display of related Postings in user area *}

{if isset($items) && $items ne null}
{* <ul class="relatedItemList Posting"> *}
{foreach name='relLoop' item='item' from=$items}
{if $item.parent_id eq NULL}
<div class="muboard-user-forum">
<div class="muboard-user-forum-left">
<div class="muboard-user-forum-left-icon">
{$item.id|muboardPostingsSinceLastLogin:2}
{if $item.children|@count > 20}
    <img alt"={gt text='Important issue'}" src="/images/icons/small/important.png" />
{/if}
</div>
<div class="muboard-user-forum-left-solved">
{if $item.solved eq 0}
    {if $item.createdUserId eq $coredata.user.uid}
        {gt text='Mark this issue as solved!' assign='linkText'}
        {assign var='linkTitle' value=$linkText}
            <a title="{$linkTitle}" href="{modurl modname='MUBoard' type='admin' func='solved' ot='posting' id=$item.id}">
            <img src="images/icons/extrasmall/redled.png" />
            </a>
     {else}
         <img src="images/icons/extrasmall/redled.png" />
     {/if}
     {/if}
     {if $item.solved eq 1}
     {if $item.createdUserId eq $coredata.user.uid}
         {gt text='This issue is marked as solved! Mark it as unsolved! ' assign='linkText'}
         {assign var='linkTitle' value=$linkText}
             <a title="{$linkTitle}" href="{modurl modname='MUBoard' type='admin' func='unsolved' ot='posting' id=$item.id}">                    
             <img alt="{$linkTitle}" src="images/icons/extrasmall/greenled.png" />
             </a>
     {else}
          <img alt="{$linkTitle}" src="images/icons/extrasmall/greenled.png" />
     {/if}                  
     {/if}
</div>
<div class="muboard-user-forum-left-creater">
    <a href="{modurl modname='MUBoard' type='user' func='display' ot='posting' id=$item.id}">
        {$item.title}
    </a><br />
    {gt text='Writer:'} {if $item.createdUserId > 1}{usergetvar name=uname uid=$item.createdUserId}{else} {gt text='Guest'}{/if}
</div>
</div>
<div class="muboard-user-forum-right">
<div class="muboard-user-category-header-statistic children">{$item.id|muboardGetNumberOfAnswersOfPosting}</div>
<div class="muboard-user-category-header-statistic calls">{$item.invocations}</div>
<div class="muboard-user-category-header-statistic last-posting">{$item.id|muboardGetLastAnswer}</div>
<div class="muboard-user-posting-header-infos">
    {checkpermissionblock component='MUBoard::' instance='.*' level="ACCESS_ADMIN"}
    <a title="{gt text='Move issue to another forum!'}" href="{modurl modname='MUBoard' type='admin' func='edit' ot='posting' id=$item.id work='movetoforum'}"><img src="/images/icons/extrasmall/1rightarrow.png" /></a>
    {/checkpermissionblock}
    {* {$item.id|muboardGetStateOfPostingAbo:$func} *}
    {* {$item.id|muboardGetStateOfPosting}  *}
    {checkpermissionblock component='MUBoard::' instance='.*' level="ACCESS_ADMIN"}    
    {if $item.state eq 1}
        <a title="{gt text='Issue is open! You have permissions to close this issue!'}" class="muboard-user-posting-header-infos-abo" href="{modurl modname='MUBoard' type='admin' func='close' ot='posting' id=$item.id}">
            <img src='/images/icons/extrasmall/button_ok.png' />
        </a>
    {else}
         <a title="{gt text='Issue is closed. You have permissions to reopen this issue!'}" id="muboard-user-posting-header-infos-abo" href="{modurl modname='MUBoard' type='admin' func='open' ot='posting' id=$item.id}">
            <img src='/images/icons/extrasmall/button_cancel.png' />
        </a>
    {/if}
    {* <a title="{gt text='You have permissions to delete this issue!'}" id="muboard-user-posting-header-infos-abo" href="{modurl modname='MUBoard' type='admin' func='delete' ot='posting' id=$item.id}">
        <img src='/images/icons/extrasmall/14_layer_deletelayer.png' />
    </a> *}
    {/checkpermissionblock}              
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
{else}
{gt text='No postings available!'} {gt text='Be the first who created an issue!'}
{/if}


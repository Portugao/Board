{* purpose of this template: postings display view in user area *}
{include file='user/header.tpl'}
<div class="muboard-posting muboard-display">
{gt text='Posting' assign='templateTitle'}
{assign var='templateTitle' value=$posting.title|default:$templateTitle}
{pagesetvar name='title' value=$templateTitle|@html_entity_decode}
<div class="z-frontendcontainer">
   {* <h2>{$templateTitle|notifyfilters:'muboard.filter_hooks.postings.filter'}</h2> *}

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
{* <div class="muboardRightBox">
<h3>{gt text='Posting'}</h3> *}
{checkpermissionblock component='MUBoard:Posting:' instance="`$posting.id`::" level="ACCESS_OVERVIEW"}
    <div class="muboard-user-posting">
        <div class="muboard-user-posting-header">
            <div class="muboard-user-posting-header-title">
                <h2>
                     {gt text='Posting:'} {$posting.title|notifyfilters:'muboard.filterhook.categories'}
                </h2>
                {gt text='Created: '}{$posting.createdDate|dateformat:datetimelong}
            </div>
            <div class="muboard-user-posting-header-infos">
                
            </div>
            <div class="muboard-user-posting-header-action">
                {if count($posting._actions) gt 0}
                    <p>{strip}
                    {foreach item='option' from=$posting._actions}
                         <a href="{$option.url.type|muboardActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">
                             {$option.linkText|safetext}
                         </a>
                    {/foreach}
                    {/strip}</p>
                {/if}
            </div>
        </div>
        <div class="muboard-user-posting-user">
        <div class="muboard-user-posting-avatar">
        {useravatar uid=$posting.createdUserId}
        </div>
        </div>
        <div class="muboard-user-posting-content">
        <div class="muboard-user-posting-content-text">
        {$posting.text}
        </div>
        <div class="muboard-user-posting-content-image">
        {if $posting.firstImage ne ''}
        <a href="{$posting.firstImageFullPathURL}" title="{$posting.title|replace:"\"":""}"{if $posting.firstImageMeta.isImage} rel="imageviewer[posting]"{/if}>
        {if $posting.firstImageMeta.isImage}
        <img src="{$posting.firstImage|muboardImageThumb:$posting.firstImageFullPath:250:150}" width="250" height="150" alt="{$posting.title|replace:"\"":""}" />
        {else}
        {gt text='Download'} ({$posting.firstImageMeta.size|muboardGetFileSize:$posting.firstImageFullPath:false:false})
        {/if}       
        </a>
        {else}&nbsp;{/if}
        </div>
        </div>   
    </div>
    {/checkpermissionblock}
    {foreach item='childPosting' from=$posting.children}
        <div class="muboard-user-posting">
        <div class="muboard-user-posting-user">
        <div class="muboard-user-posting-avatar">
        {useravatar uid=$childPosting.createdUserId}
        </div>
        <div class="muboard-user-posting-avatar">

        </div>
        </div>
        <div class="muboard-user-posting-content">
        <div class="muboard-user-posting-created">
        {$childPosting.createdDate|dateformat:datetimelong}
        </div>
        <div class="muboard-user-posting-content-text">
        {$childPosting.text}
        </div>
        {if $childPosting.firstImage ne ''}        
        <div class="muboard-user-posting-content-image">
        <a href="{$childPosting.firstImageFullPathURL}" title="{$childPosting.title|replace:"\"":""}"{if $childPosting.firstImageMeta.isImage} rel="imageviewer[posting]"{/if}>
        {if $childPosting.firstImageMeta.isImage}
        <img src="{$childPosting.firstImage|muboardImageThumb:$childPosting.firstImageFullPath:250:150}" width="250" height="150" alt="{$childPosting.title|replace:"\"":""}" />
        {else}
        {gt text='Download'} ({$childPosting.firstImageMeta.size|muboardGetFileSize:$posting.firstImageFullPath:false:false})
        {/if}       
        </a>
        </div>
        {else}&nbsp;{/if} 
        {if $childPosting.secondImage ne ''}               
        <div class="muboard-user-posting-content-image">
        <a href="{$childPosting.secondImageFullPathURL}" title="{$childPosting.title|replace:"\"":""}"{if $childPosting.secondImageMeta.isImage} rel="imageviewer[posting]"{/if}>
        {if $childPosting.secondImageMeta.isImage}
        <img src="{$childPosting.secondImage|muboardImageThumb:$childPosting.secondImageFullPath:250:150}" width="250" height="150" alt="{$childPosting.title|replace:"\"":""}" />
        {else}
        {gt text='Download'} ({$childPosting.secondImageMeta.size|muboardGetFileSize:$childPosting.secondImageFullPath:false:false})
        {/if}       
        </a>
        </div> 
        {else}&nbsp;{/if}
        {if $childPosting.thirdImage ne ''}               
        <div class="muboard-user-posting-content-image">
        <a href="{$posting.thirdImageFullPathURL}" title="{$posting.title|replace:"\"":""}"{if $posting.thirdImageMeta.isImage} rel="imageviewer[posting]"{/if}>
        {if $childPosting.thirdImageMeta.isImage}
        <img src="{$posting.thirdImage|muboardImageThumb:$posting.thirdImageFullPath:250:150}" width="250" height="150" alt="{$posting.title|replace:"\"":""}" />
        {else}
        {gt text='Download'} ({$posting.thirdImageMeta.size|muboardGetFileSize:$posting.thirdImageFullPath:false:false})
        {/if}       
        </a>
        </div>
        {else}&nbsp;{/if} 
        {if $posting.firstFile ne ''}               
        <div class="muboard-user-posting-content-file">
        <a href="{$posting.firstFileFullPathURL}" title="{$posting.title|replace:"\"":""}"{if $posting.firstFileMeta.isImage} rel="imageviewer[posting]"{/if}>
        {if $posting.firstFileMeta.isImage}
        <img src="{$posting.firstFile|muboardImageThumb:$posting.firstFileFullPath:250:150}" width="250" height="150" alt="{$posting.title|replace:"\"":""}" />
        {else}
        {gt text='Download'} ({$posting.firstFileMeta.size|muboardGetFileSize:$posting.firstFileFullPath:false:false})
        {/if}
        </a>
        </div> 
        {else}&nbsp;{/if} 
        {if $posting.secondFile ne ''}               
        <div class="muboard-user-posting-content-file">
        <a href="{$posting.secondFileFullPathURL}" title="{$posting.title|replace:"\"":""}"{if $posting.secondFileMeta.isImage} rel="imageviewer[posting]"{/if}>
        {if $posting.secondFileMeta.isImage}
        <img src="{$posting.secondFile|muboardImageThumb:$posting.secondFileFullPath:250:150}" width="250" height="150" alt="{$posting.title|replace:"\"":""}" />
        {else}
        {gt text='Download'} ({$posting.secondFileMeta.size|muboardGetFileSize:$posting.secondFileFullPath:false:false})
        {/if}
        </a>
        </div> 
        {else}&nbsp;{/if}  
        {if $posting.thirdFile ne ''}              
        <div class="muboard-user-posting-content-file">
        <a href="{$posting.thirdFileFullPathURL}" title="{$posting.title|replace:"\"":""}"{if $posting.thirdFileMeta.isImage} rel="imageviewer[posting]"{/if}>
        {if $posting.thirdFileMeta.isImage}
        <img src="{$posting.thirdFile|muboardImageThumb:$posting.thirdFileFullPath:250:150}" width="250" height="150" alt="{$posting.title|replace:"\"":""}" />
        {else}
        {gt text='Download'} ({$posting.thirdFileMeta.size|muboardGetFileSize:$posting.thirdFileFullPath:false:false})
        {/if}
        </a>
        </div>
        {else}&nbsp;{/if}            
        </div>
        </div>

    {/foreach}
    {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page'}
    {modfunc modname='MUBoard' type='user' func='edit' ot='posting'}
    
    
{* {if isset($posting.parent) && $posting.parent ne null}
    {include file='user/posting/include_displayItemListOne.tpl' item=$posting.parent}
{/if} 

{if !isset($posting.parent) || $posting.parent eq null}
{checkpermission component='MUBoard::' instance='.*' level='ACCESS_ADMIN' assign='authAdmin'}
{if $authAdmin || (isset($uid) && isset($posting.createdUserId) && $posting.createdUserId eq $uid)}
<p class="manageLink">
    {gt text='Create posting' assign='createTitle'}
    <a href="{modurl modname='MUBoard' type='user' func='edit' ot='posting' children="`$posting.id`" returnTo='userDisplayPosting'}" title="{$createTitle}" class="z-icon-es-add">
        {$createTitle}
    </a>
</p>
{/if}
{/if}*}
</div>
{/if}

{* <dl id="MUBoard_body">
    <dt>{gt text='Parent_id'}</dt>
    <dd>{$posting.parent_id}</dd>
    <dt>{gt text='Text'}</dt>
    <dd>{$posting.text}</dd>
    <dt>{gt text='Invocations'}</dt>
    <dd>{$posting.invocations}</dd>
    <dt>{gt text='First image'}</dt>
    <dd>{if $posting.firstImage ne ''}
  <a href="{$posting.firstImageFullPathURL}" title="{$posting.title|replace:"\"":""}"{if $posting.firstImageMeta.isImage} rel="imageviewer[posting]"{/if}>
  {if $posting.firstImageMeta.isImage}
      <img src="{$posting.firstImage|muboardImageThumb:$posting.firstImageFullPath:250:150}" width="250" height="150" alt="{$posting.title|replace:"\"":""}" />
  {else}
      {gt text='Download'} ({$posting.firstImageMeta.size|muboardGetFileSize:$posting.firstImageFullPath:false:false})
  {/if}
  </a>
{else}&nbsp;{/if}
</dd>
    <dt>{gt text='Second image'}</dt>
    <dd>{if $posting.secondImage ne ''}
  <a href="{$posting.secondImageFullPathURL}" title="{$posting.title|replace:"\"":""}"{if $posting.secondImageMeta.isImage} rel="imageviewer[posting]"{/if}>
  {if $posting.secondImageMeta.isImage}
      <img src="{$posting.secondImage|muboardImageThumb:$posting.secondImageFullPath:250:150}" width="250" height="150" alt="{$posting.title|replace:"\"":""}" />
  {else}
      {gt text='Download'} ({$posting.secondImageMeta.size|muboardGetFileSize:$posting.secondImageFullPath:false:false})
  {/if}
  </a>
{else}&nbsp;{/if}
</dd>
    <dt>{gt text='Third image'}</dt>
    <dd>{if $posting.thirdImage ne ''}
  <a href="{$posting.thirdImageFullPathURL}" title="{$posting.title|replace:"\"":""}"{if $posting.thirdImageMeta.isImage} rel="imageviewer[posting]"{/if}>
  {if $posting.thirdImageMeta.isImage}
      <img src="{$posting.thirdImage|muboardImageThumb:$posting.thirdImageFullPath:250:150}" width="250" height="150" alt="{$posting.title|replace:"\"":""}" />
  {else}
      {gt text='Download'} ({$posting.thirdImageMeta.size|muboardGetFileSize:$posting.thirdImageFullPath:false:false})
  {/if}
  </a>
{else}&nbsp;{/if}
</dd>
    <dt>{gt text='First file'}</dt>
    <dd>{if $posting.firstFile ne ''}
  <a href="{$posting.firstFileFullPathURL}" title="{$posting.title|replace:"\"":""}"{if $posting.firstFileMeta.isImage} rel="imageviewer[posting]"{/if}>
  {if $posting.firstFileMeta.isImage}
      <img src="{$posting.firstFile|muboardImageThumb:$posting.firstFileFullPath:250:150}" width="250" height="150" alt="{$posting.title|replace:"\"":""}" />
  {else}
      {gt text='Download'} ({$posting.firstFileMeta.size|muboardGetFileSize:$posting.firstFileFullPath:false:false})
  {/if}
  </a>
{else}&nbsp;{/if}
</dd>
    <dt>{gt text='Second file'}</dt>
    <dd>{if $posting.secondFile ne ''}
  <a href="{$posting.secondFileFullPathURL}" title="{$posting.title|replace:"\"":""}"{if $posting.secondFileMeta.isImage} rel="imageviewer[posting]"{/if}>
  {if $posting.secondFileMeta.isImage}
      <img src="{$posting.secondFile|muboardImageThumb:$posting.secondFileFullPath:250:150}" width="250" height="150" alt="{$posting.title|replace:"\"":""}" />
  {else}
      {gt text='Download'} ({$posting.secondFileMeta.size|muboardGetFileSize:$posting.secondFileFullPath:false:false})
  {/if}
  </a>
{else}&nbsp;{/if}
</dd>
    <dt>{gt text='Third file'}</dt>
    <dd>{if $posting.thirdFile ne ''}
  <a href="{$posting.thirdFileFullPathURL}" title="{$posting.title|replace:"\"":""}"{if $posting.thirdFileMeta.isImage} rel="imageviewer[posting]"{/if}>
  {if $posting.thirdFileMeta.isImage}
      <img src="{$posting.thirdFile|muboardImageThumb:$posting.thirdFileFullPath:250:150}" width="250" height="150" alt="{$posting.title|replace:"\"":""}" />
  {else}
      {gt text='Download'} ({$posting.thirdFileMeta.size|muboardGetFileSize:$posting.thirdFileFullPath:false:false})
  {/if}
  </a>
{else}&nbsp;{/if}
</dd>
    <dt>{gt text='Parent'}</dt>
    <dd>
    {if isset($posting.Parent) && $posting.Parent ne null}
      {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        <a href="{modurl modname='MUBoard' type='user' func='display' ot='posting' id=$posting.Parent.id}">
            {$posting.Parent.title|default:""}
        </a>
        <a id="postingItem{$posting.Parent.id}Display" href="{modurl modname='MUBoard' type='user' func='display' ot='posting' id=$posting.Parent.id theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" style="display: none">
            {icon type='view' size='extrasmall' __alt='Quick view'}
        </a>
        <script type="text/javascript" charset="utf-8">
        /* <![CDATA[ */
            document.observe('dom:loaded', function() {
                muboardInitInlineWindow($('postingItem{{$posting.Parent.id}}Display'), '{{$posting.Parent.title|replace:"'":""}}');
            });
        /* ]]> */
        </script>
      {else}
        {$posting.Parent.title|default:""}
      {/if}
    {else}
        {gt text='No set.'}
    {/if}
    </dd>
    <dt>{gt text='Forum'}</dt>
    <dd>
    {if isset($posting.Forum) && $posting.Forum ne null}
      {if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
        <a href="{modurl modname='MUBoard' type='user' func='display' ot='forum' id=$posting.Forum.id}">
            {$posting.Forum.title|default:""}
        </a>
        <a id="forumItem{$posting.Forum.id}Display" href="{modurl modname='MUBoard' type='user' func='display' ot='forum' id=$posting.Forum.id theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" style="display: none">
            {icon type='view' size='extrasmall' __alt='Quick view'}
        </a>
        <script type="text/javascript" charset="utf-8">
        /* <![CDATA[ */
            document.observe('dom:loaded', function() {
                muboardInitInlineWindow($('forumItem{{$posting.Forum.id}}Display'), '{{$posting.Forum.title|replace:"'":""}}');
            });
        /* ]]> */
        </script>
      {else}
        {$posting.Forum.title|default:""}
      {/if}
    {else}
        {gt text='No set.'}
    {/if}
    </dd>
</dl> *}
  {*  {include file='user/include_standardfields_display.tpl' obj=$posting} *}

{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
{* {if count($posting._actions) gt 0}
    <p>{strip}
    {foreach item='option' from=$posting._actions}
        <a href="{$option.url.type|muboardActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}" class="z-icon-es-{$option.icon}">
            {$option.linkText|safetext}
        </a>
    {/foreach}
    {/strip}</p>
{/if} *}

{* include display hooks *}
{notifydisplayhooks eventname='muboard.ui_hooks.postings.display_view' id=$posting.id urlobject=$currentUrlObject assign='hooks'}
{foreach key='hookname' item='hook' from=$hooks}
    {$hook}
{/foreach}

<br style="clear: right" />
{/if}

</div>
</div>
{include file='user/footer.tpl'}


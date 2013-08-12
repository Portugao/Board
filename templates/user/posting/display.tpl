{* purpose of this template: postings display view in user area *}
{include file='user/header.tpl'}
<div class="muboard-posting muboard-display">
{gt text='Posting' assign='templateTitle'}
{assign var='templateTitle' value=$posting.title|default:$templateTitle}

<div class="z-frontendcontainer">
{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
{checkpermissionblock component='MUBoard:Category:' instance="`$posting.forum.category.id`::" level="ACCESS_OVERVIEW"}
{checkpermissionblock component='MUBoard:Forum:' instance="`$posting.forum.id`::" level="ACCESS_OVERVIEW"}
{checkpermissionblock component='MUBoard:Posting:' instance="`$posting.id`::" level="ACCESS_OVERVIEW"}
    <div id="top" class="muboard-user-posting-parent">
        <div class="muboard-user-posting-header">
            <div class="muboard-user-posting-header-title">
                <h2>
                    {gt text='Issue:'} {$posting.title|notifyfilters:'muboard.filterhook.categories'}
                        {if $posting.solved eq 0}
                            {if $posting.createdUserId eq $coredata.user.uid}
                                {gt text='Mark this issue as solved!' assign='linkText'}
                                {assign var='linkTitle' value=$linkText}
                                <a title="{$linkTitle}" href="{modurl modname='MUBoard' type='admin' func='solved' ot='posting' id=$posting.id}">
                                     <img src="images/icons/extrasmall/redled.png" />
                                </a>
                            {else}
                                <img src="images/icons/extrasmall/redled.png" />
                            {/if}
                        {/if}
                        {if $posting.solved eq 1}
                            {if $posting.createdUserId eq $coredata.user.uid}
                                {gt text='This issue is marked as solved! Mark it as unsolved! ' assign='linkText'}
                                {assign var='linkTitle' value=$linkText}
                                <a title="{$linkTitle}" href="{modurl modname='MUBoard' type='admin' func='unsolved' ot='posting' id=$posting.id}">                    
                                   <img alt="{$linkTitle}" src="images/icons/extrasmall/greenled.png" />
                                </a>
                            {else}
                                <img alt="{$linkTitle}" src="images/icons/extrasmall/greenled.png" />
                            {/if}
                        {/if}
                </h2>
                {gt text='Created: '}{$posting.createdDate|dateformat:datetimelong}
            </div> {* class="muboard-user-posting-header-title *}
            <div class="muboard-user-posting-header-action">
                <div class="muboard-user-posting-header-action-category">{gt text='Category:'} <a title="{gt text='Back to'} {$posting.forum.category.title}" href="{modurl modname='MUBoard' type='user' func='display' ot='category' id=$posting.forum.category.id}">{$posting.forum.category.title}</a>
                </div>
                <div class="muboard-user-posting-header-action-forum">{gt text='Forum:'} <a title="{gt text='Back to'} {$posting.forum.title}" href="{modurl modname='MUBoard' type='user' func='display' ot='forum' id=$posting.forum.id}">{$posting.forum.title}</a>
                </div>
                <div class="muboard-user-posting-header-hooks">
                    {notifydisplayhooks eventname='muboard.ui_hooks.postings.display_view' id=$posting.id urlobject=$currentUrlObject assign='hooks'}
                        {foreach key='hookname' item='hook' from=$hooks}
                            {$hook}
                        {/foreach}
                </div>
             </div>  {* class="muboard-user-posting-header-action *}          
             <div class="muboard-user-posting-header-infos">
               {*  {$posting.id|muboardGetStateOfPostingAbo:$posting.id} at the moment no abonement of issues *}
                     {if $posting.state eq 1}
                         {checkpermissionblock component='MUBoard::' instance='.*' level="ACCESS_ADMIN"} 
                         <a title="{gt text='Issue is open! You have permissions to close this issue!'}" id="muboard-user-posting-header-infos-abo" href="{modurl modname='MUBoard' type='admin' func='close' ot='posting' id=$posting.id}">
                         {/checkpermissionblock}              
                         <img src='/images/icons/extrasmall/button_ok.png' />
                         {checkpermissionblock component='MUBoard::' instance='.*' level="ACCESS_ADMIN"} 
                         </a>
                         {/checkpermissionblock}   
                     {else}
                         {checkpermissionblock component='MUBoard::' instance='.*' level="ACCESS_ADMIN"} 
                         <a title="{gt text='Issue is closed. You have permissions to reopen this issue!'}" id="muboard-user-posting-header-infos-abo" href="{modurl modname='MUBoard' type='admin' func='open' ot='posting' id=$posting.id}">
                         {/checkpermissionblock}   
                         <img src='/images/icons/extrasmall/button_cancel.png' />
                         {checkpermissionblock component='MUBoard::' instance='.*' level="ACCESS_ADMIN"} 
                         </a>
                         {/checkpermissionblock}   
                     {/if}
                 {$posting.id|muboardGetStateOfEditOfIssue}    
             </div> {* class="muboard-user-posting-header-action *}
         </div> {* class="muboard-user-posting-header *}
         <div class="muboard-user-posting-user">
             <div class="muboard-user-posting-avatar">
             {useravatar uid=$posting.createdUserId size=80}<br />
             {if $posting.createdUserId > 1}
                 {usergetvar name=uname uid=$posting.createdUserId}
             {else}
                 {gt text='Guest' assign=username}
                 {$username}
             {/if}
             </div> {* class="muboard-user-posting-avatar *}
             <div class="muboard-user-posting-datas">
                 {$posting.createdUserId|muboardGetUserRank}
             </div> {* class="muboard-user-posting-datas *}
         </div> {* class="muboard-user-posting-user *}
         <div class="muboard-user-posting-content">
             <div class="muboard-user-posting-content-text">
             {$posting.text|notifyfilters:'muboard.filter_hooks.postings.filter'|safehtml|nl2br}
             </div> {* class="muboard-user-posting-content-text *}
             <div class="muboard-user-posting-content-image">
             {if $posting.firstImage ne ''}
                 <a href="{$posting.firstImageFullPathURL}" title="{$posting.title|replace:"\"":""}"{if $posting.firstImageMeta.isImage} rel="imageviewer[posting{$posting.id}]"{/if}>
                 {if $posting.firstImageMeta.isImage}
                     <div class="muboard-image-container" style="background: url({$posting.firstImageFullPathURL}) center center; background-size: cover;"></div>
                 {else}
                     {gt text='Download'} ({$posting.firstImageMeta.size|muboardGetFileSize:$posting.firstImageFullPath:false:false})
                 {/if}       
                 </a>
             {else}&nbsp;{/if}
             {if $posting.secondImage ne ''}
                 <a href="{$posting.secondImageFullPathURL}" title="{$posting.title|replace:"\"":""}"{if $posting.firstImageMeta.isImage} rel="imageviewer[posting{$posting.id}]"{/if}>
                 {if $posting.secondImageMeta.isImage}
                     <div class="muboard-image-container" style="background: url({$posting.secondImageFullPathURL}) center center; background-size: cover;"></div>
                 {else}
                     {gt text='Download'} ({$posting.secondImageMeta.size|muboardGetFileSize:$posting.secondImageFullPath:false:false})
                 {/if}       
                 </a>
             {else}&nbsp;{/if}
             {if $posting.thirdImage ne ''}
                 <a href="{$posting.thirdImageFullPathURL}" title="{$posting.title|replace:"\"":""}"{if $posting.thirdImageMeta.isImage} rel="imageviewer[posting{$posting.id}]"{/if}>
                 {if $posting.thirdImageMeta.isImage}
                     <div class="muboard-image-container" style="background: url({$posting.thirdImageFullPathURL}) center center; background-size: cover;"></div>
                 {else}
                     {gt text='Download'} ({$posting.thirdImageMeta.size|muboardGetFileSize:$posting.thirdImageFullPath:false:false})
                 {/if}       
                 </a>
              {else}&nbsp;{/if}
              </div> {* class="muboard-user-posting-content-image *}
              <div class="muboard-user-posting-content-file">  
              {* Here we found the embedded files for the issue itself *} 
              {if $posting.firstFile ne ''}               
                  <div class="muboard-user-posting-content-file">
                  <a href="{$posting.firstFileFullPathURL}" title="{$posting.title|replace:"\"":""}"{if $posting.firstFileMeta.isImage} rel="imageviewer[posting]"{/if}>
                  {if $posting.firstFileMeta.isImage}
                      <img src="{$childPosting.firstFile|muboardImageThumb:$posting.firstFileFullPath:250:150}" width="250" height="150" alt="{$posting.title|replace:"\"":""}" />
                  {else}
                      {$posting.firstFile|safetext} ({$posting.firstFileMeta.size|muboardGetFileSize:$posting.firstFileFullPath:false:false})
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
                      {$posting.secondFile|safetext} ({$posting.secondFileMeta.size|muboardGetFileSize:$posting.secondFileFullPath:false:false})
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
                      {$posting.thirdFile|safetext} ({$posting.thirdFileMeta.size|muboardGetFileSize:$posting.thirdFileFullPath:false:false})
                  {/if}
                  </a>
                  </div>
              {else}&nbsp;{/if}            
              </div> {* class="muboard-user-posting-content-file *}     
              </div> {* class="muboard-user-posting-content *}
          </div> {* class="muboard-user-posting-parent *}
      {foreach item='childPosting' from=$postings}
          <div id={$childPosting.id} class="muboard-user-posting">
              <div class="muboard-user-posting-user">
                  <div class=  "muboard-user-posting-avatar">
                  {useravatar uid=$childPosting.createdUserId size=60}<br />
                  {usergetvar name=uname uid=$childPosting.createdUserId}
                  </div>
                  <div class="muboard-user-posting-datas">
                  {$childPosting.createdUserId|muboardGetUserRank}
                  </div>
              </div> {* class="muboard-user-posting-user *}
              <div class="muboard-user-posting-content">
                  <div class="muboard-user-posting-created">
                  {$childPosting.createdDate|dateformat:datetimelong} 
                  {if $editPostings eq 1}
                      <div class="muboard-user-posting-edit">
                      {$childPosting.id|muboardGetStateOfEditOfIssue}
                      </div>
                  {/if}
                  </div>
                  <div class="muboard-user-posting-content-text">
                  {$childPosting.text|notifyfilters:'muboard.filter_hooks.postings.filter'|nl2br|safehtml}
                  </div>
                  {if $childPosting.firstImage ne '' || $childPosting.secondImage ne '' || $childPosting.thirdImage ne ''}
                  <div class="muboard-user-posting-content-image">
                  {if $childPosting.firstImage ne ''}        
                      <a href="{$childPosting.firstImageFullPathURL}" title="{$childPosting.title|replace:"\"":""}"{if $childPosting.firstImageMeta.isImage} rel="imageviewer[posting{$childPosting.id}]"{/if}>
                      {if $childPosting.firstImageMeta.isImage}
                          <div class="muboard-image-container" style="background: url({$childPosting.firstImageFullPathURL}) center center; background-size: cover;"></div>
                      {else}
                          {gt text='Download'} ({$childPosting.firstImageMeta.size|muboardGetFileSize:$posting.firstImageFullPath:false:false})
                      {/if}       
                      </a>
                  {else}&nbsp;{/if} 
                  {if $childPosting.secondImage ne ''}               
                      <a href="{$childPosting.secondImageFullPathURL}" title="{$childPosting.title|replace:"\"":""}"{if $childPosting.secondImageMeta.isImage} rel="imageviewer[posting{$childPosting.id}]"{/if}>
                      {if $childPosting.secondImageMeta.isImage}
                          <div class="muboard-image-container" style="background: url({$childPosting.secondImageFullPathURL}) center center; background-size: cover;"></div>
                      {else}
                          {gt text='Download'} ({$childPosting.secondImageMeta.size|muboardGetFileSize:$childPosting.secondImageFullPath:false:false})
                      {/if}       
                          </a>
                  {else}&nbsp;{/if}
                  {if $childPosting.thirdImage ne ''}               
                      <a href="{$childPosting.thirdImageFullPathURL}" title="{$childPosting.title|replace:"\"":""}"{if $childPosting.thirdImageMeta.isImage} rel="imageviewer[posting{$childPosting.id}]"{/if}>
                      {if $childPosting.thirdImageMeta.isImage}
                          <div class="muboard-image-container" style="background: url({$childPosting.thirdImageFullPathURL}) center center; background-size: cover;"></div>
                      {else}
                          {gt text='Download'} ({$posting.thirdImageMeta.size|muboardGetFileSize:$posting.thirdImageFullPath:false:false})
                      {/if}       
                          </a>
                  {else}&nbsp;{/if} 
                  </div> {* class="muboard-user-posting-content-image *}
                  {/if}
                  {if $childPosting.firstFile ne ''}               
                      <div class="muboard-user-posting-content-file">
                      <a href="{$childPosting.firstFileFullPathURL}" title="{$childPosting.title|replace:"\"":""}"{if $childPosting.firstFileMeta.isImage} rel="imageviewer[childPosting]"{/if}>
                      {if $childPosting.firstFileMeta.isImage}
                          <img src="{$childPosting.firstFile|muboardImageThumb:$childPosting.firstFileFullPath:250:150}" width="250" height="150" alt="{$childPosting.title|replace:"\"":""}" />
                      {else}
                          {$childPosting.firstFile|safetext} ({$childPosting.firstFileMeta.size|muboardGetFileSize:$childPosting.firstFileFullPath:false:false})
                      {/if}
                      </a>
                      </div> 
                  {else}&nbsp;{/if} 
                  {if $childPosting.secondFile ne ''}               
                      <div class="muboard-user-posting-content-file">
                      <a href="{$childPosting.secondFileFullPathURL}" title="{$childPosting.title|replace:"\"":""}"{if $childPosting.secondFileMeta.isImage} rel="imageviewer[posting]"{/if}>
                      {if $childPosting.secondFileMeta.isImage}
                          <img src="{$childPosting.secondFile|muboardImageThumb:$childPosting.secondFileFullPath:250:150}" width="250" height="150" alt="{$childPosting.title|replace:"\"":""}" />
                      {else}
                          {$childPosting.secondFile|safetext} ({$childPosting.secondFileMeta.size|muboardGetFileSize:$childPosting.secondFileFullPath:false:false})
                      {/if}
                      </a>
                      </div> 
                  {else}&nbsp;{/if}  
                  {if $childPosting.thirdFile ne ''}              
                      <div class="muboard-user-posting-content-file">
                      <a href="{$childPosting.thirdFileFullPathURL}" title="{$childPosting.title|replace:"\"":""}"{if $childPosting.thirdFileMeta.isImage} rel="imageviewer[posting]"{/if}>
                      {if $childPosting.thirdFileMeta.isImage}
                          <img src="{$childPosting.thirdFile|muboardImageThumb:$childPosting.thirdFileFullPath:250:150}" width="250" height="150" alt="{$childPosting.title|replace:"\"":""}" />
                      {else}
                          {$childPosting.thirdFile|safetext} ({$childPosting.thirdFileMeta.size|muboardGetFileSize:$childPosting.thirdFileFullPath:false:false})
                      {/if}
                      </a>
                      </div>
                    {else}&nbsp;{/if}            
                </div>
                <div class="muboard-user-posting-content-bottom">
                    <a class="muboard-user-posting-content-links" href="{$siteurl}#theme_header">
                        <img alt="{gt text=''}" src="images/icons/extrasmall/1uparrow.png" />
                    </a>
                </div>     
            </div>
        {/foreach}
        {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page'}
        {if $mayEdit eq true}
            {checkpermissionblock component='MUBoard::' instance=".*" level="ACCESS_ADD"}
                {checkpermissionblock component='MUBoard:Category:' instance="`$posting.forum.category.id`::" level="ACCESS_ADD"}
                  {if $posting.state eq 1}
                     {modfunc modname='MUBoard' type='user' func='edit' ot='posting'}
                  {/if}   
              {/checkpermissionblock}
            {/checkpermissionblock}  
        {/if}
{/checkpermissionblock}
{/checkpermissionblock}
{/checkpermissionblock}

{/if}
</div>
{if !isset($smarty.get.theme) || $smarty.get.theme ne 'Printer'}
<br style="clear: right" />
{/if}
</div>
{include file='user/footer.tpl'}
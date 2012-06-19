{* purpose of this template: postings view view in user area *}
<div class="muboard-posting muboard-view">
{include file='user/header.tpl'}
{gt text='Posting list' assign='templateTitle'}
{pagesetvar name='title' value=$templateTitle}
<div class="z-frontendcontainer">
    <h2>{$templateTitle}</h2>


    {checkpermissionblock component='MUBoard::' instance='.*' level="ACCESS_ADD"}
        {gt text='Create posting' assign='createTitle'}
        <a href="{modurl modname='MUBoard' type='user' func='edit' ot='posting'}" title="{$createTitle}" class="z-icon-es-add">
            {$createTitle}
        </a>
    {/checkpermissionblock}

    {assign var='all' value=0}
    {if isset($showAllEntries) && $showAllEntries eq 1}
        {gt text='Back to paginated view' assign='linkTitle'}
        <a href="{modurl modname='MUBoard' type='user' func='view' ot='posting'}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
        {assign var='all' value=1}
    {else}
        {gt text='Show all entries' assign='linkTitle'}
        <a href="{modurl modname='MUBoard' type='user' func='view' ot='posting' all=1}" title="{$linkTitle}" class="z-icon-es-view">
            {$linkTitle}
        </a>
    {/if}

<table class="z-datatable">
    <colgroup>
        <col id="cparent_id" />
        <col id="ctitle" />
        <col id="ctext" />
        <col id="cinvocations" />
        <col id="cfirstimage" />
        <col id="csecondimage" />
        <col id="cthirdimage" />
        <col id="cfirstfile" />
        <col id="csecondfile" />
        <col id="cthirdfile" />
        <col id="cparent" />
        <col id="cforum" />
        <col id="citemactions" />
    </colgroup>
    <thead>
    <tr>
        <th id="hparent_id" scope="col" class="z-right">
            {sortlink __linktext='Parent_id' sort='parent_id' currentsort=$sort sortdir=$sdir all=$all modname='MUBoard' type='user' func='view' ot='posting'}
        </th>
        <th id="htitle" scope="col" class="z-left">
            {sortlink __linktext='Title' sort='title' currentsort=$sort sortdir=$sdir all=$all modname='MUBoard' type='user' func='view' ot='posting'}
        </th>
        <th id="htext" scope="col" class="z-left">
            {sortlink __linktext='Text' sort='text' currentsort=$sort sortdir=$sdir all=$all modname='MUBoard' type='user' func='view' ot='posting'}
        </th>
        <th id="hinvocations" scope="col" class="z-right">
            {sortlink __linktext='Invocations' sort='invocations' currentsort=$sort sortdir=$sdir all=$all modname='MUBoard' type='user' func='view' ot='posting'}
        </th>
        <th id="hfirstimage" scope="col" class="z-left">
            {sortlink __linktext='First image' sort='firstImage' currentsort=$sort sortdir=$sdir all=$all modname='MUBoard' type='user' func='view' ot='posting'}
        </th>
        <th id="hsecondimage" scope="col" class="z-left">
            {sortlink __linktext='Second image' sort='secondImage' currentsort=$sort sortdir=$sdir all=$all modname='MUBoard' type='user' func='view' ot='posting'}
        </th>
        <th id="hthirdimage" scope="col" class="z-left">
            {sortlink __linktext='Third image' sort='thirdImage' currentsort=$sort sortdir=$sdir all=$all modname='MUBoard' type='user' func='view' ot='posting'}
        </th>
        <th id="hfirstfile" scope="col" class="z-left">
            {sortlink __linktext='First file' sort='firstFile' currentsort=$sort sortdir=$sdir all=$all modname='MUBoard' type='user' func='view' ot='posting'}
        </th>
        <th id="hsecondfile" scope="col" class="z-left">
            {sortlink __linktext='Second file' sort='secondFile' currentsort=$sort sortdir=$sdir all=$all modname='MUBoard' type='user' func='view' ot='posting'}
        </th>
        <th id="hthirdfile" scope="col" class="z-left">
            {sortlink __linktext='Third file' sort='thirdFile' currentsort=$sort sortdir=$sdir all=$all modname='MUBoard' type='user' func='view' ot='posting'}
        </th>
        <th id="hparent" scope="col" class="z-left">
            {sortlink __linktext='Parent' sort='parent' currentsort=$sort sortdir=$sdir all=$all modname='MUBoard' type='user' func='view' ot='posting'}
        </th>
        <th id="hforum" scope="col" class="z-left">
            {sortlink __linktext='Forum' sort='forum' currentsort=$sort sortdir=$sdir all=$all modname='MUBoard' type='user' func='view' ot='posting'}
        </th>
        <th id="hitemactions" scope="col" class="z-right z-order-unsorted">{gt text='Actions'}</th>
    </tr>
    </thead>
    <tbody>

    {foreach item='posting' from=$items}
    <tr class="{cycle values='z-odd, z-even'}">
        <td headers="hparent_id" class="z-right">
            {$posting.parent_id}
        </td>
        <td headers="htitle" class="z-left">
            {$posting.title|notifyfilters:'muboard.filterhook.postings'}
        </td>
        <td headers="htext" class="z-left">
            {$posting.text}
        </td>
        <td headers="hinvocations" class="z-right">
            {$posting.invocations}
        </td>
        <td headers="hfirstimage" class="z-left">
            {if $posting.firstImage ne ''}
              <a href="{$posting.firstImageFullPathURL}" title="{$posting.title|replace:"\"":""}"{if $posting.firstImageMeta.isImage} rel="imageviewer[posting]"{/if}>
              {if $posting.firstImageMeta.isImage}
                  <img src="{$posting.firstImage|muboardImageThumb:$posting.firstImageFullPath:32:20}" width="32" height="20" alt="{$posting.title|replace:"\"":""}" />
              {else}
                  {gt text='Download'} ({$posting.firstImageMeta.size|muboardGetFileSize:$posting.firstImageFullPath:false:false})
              {/if}
              </a>
            {else}&nbsp;{/if}

        </td>
        <td headers="hsecondimage" class="z-left">
            {if $posting.secondImage ne ''}
              <a href="{$posting.secondImageFullPathURL}" title="{$posting.title|replace:"\"":""}"{if $posting.secondImageMeta.isImage} rel="imageviewer[posting]"{/if}>
              {if $posting.secondImageMeta.isImage}
                  <img src="{$posting.secondImage|muboardImageThumb:$posting.secondImageFullPath:32:20}" width="32" height="20" alt="{$posting.title|replace:"\"":""}" />
              {else}
                  {gt text='Download'} ({$posting.secondImageMeta.size|muboardGetFileSize:$posting.secondImageFullPath:false:false})
              {/if}
              </a>
            {else}&nbsp;{/if}

        </td>
        <td headers="hthirdimage" class="z-left">
            {if $posting.thirdImage ne ''}
              <a href="{$posting.thirdImageFullPathURL}" title="{$posting.title|replace:"\"":""}"{if $posting.thirdImageMeta.isImage} rel="imageviewer[posting]"{/if}>
              {if $posting.thirdImageMeta.isImage}
                  <img src="{$posting.thirdImage|muboardImageThumb:$posting.thirdImageFullPath:32:20}" width="32" height="20" alt="{$posting.title|replace:"\"":""}" />
              {else}
                  {gt text='Download'} ({$posting.thirdImageMeta.size|muboardGetFileSize:$posting.thirdImageFullPath:false:false})
              {/if}
              </a>
            {else}&nbsp;{/if}

        </td>
        <td headers="hfirstfile" class="z-left">
            {if $posting.firstFile ne ''}
              <a href="{$posting.firstFileFullPathURL}" title="{$posting.title|replace:"\"":""}"{if $posting.firstFileMeta.isImage} rel="imageviewer[posting]"{/if}>
              {if $posting.firstFileMeta.isImage}
                  <img src="{$posting.firstFile|muboardImageThumb:$posting.firstFileFullPath:32:20}" width="32" height="20" alt="{$posting.title|replace:"\"":""}" />
              {else}
                  {gt text='Download'} ({$posting.firstFileMeta.size|muboardGetFileSize:$posting.firstFileFullPath:false:false})
              {/if}
              </a>
            {else}&nbsp;{/if}

        </td>
        <td headers="hsecondfile" class="z-left">
            {if $posting.secondFile ne ''}
              <a href="{$posting.secondFileFullPathURL}" title="{$posting.title|replace:"\"":""}"{if $posting.secondFileMeta.isImage} rel="imageviewer[posting]"{/if}>
              {if $posting.secondFileMeta.isImage}
                  <img src="{$posting.secondFile|muboardImageThumb:$posting.secondFileFullPath:32:20}" width="32" height="20" alt="{$posting.title|replace:"\"":""}" />
              {else}
                  {gt text='Download'} ({$posting.secondFileMeta.size|muboardGetFileSize:$posting.secondFileFullPath:false:false})
              {/if}
              </a>
            {else}&nbsp;{/if}

        </td>
        <td headers="hthirdfile" class="z-left">
            {if $posting.thirdFile ne ''}
              <a href="{$posting.thirdFileFullPathURL}" title="{$posting.title|replace:"\"":""}"{if $posting.thirdFileMeta.isImage} rel="imageviewer[posting]"{/if}>
              {if $posting.thirdFileMeta.isImage}
                  <img src="{$posting.thirdFile|muboardImageThumb:$posting.thirdFileFullPath:32:20}" width="32" height="20" alt="{$posting.title|replace:"\"":""}" />
              {else}
                  {gt text='Download'} ({$posting.thirdFileMeta.size|muboardGetFileSize:$posting.thirdFileFullPath:false:false})
              {/if}
              </a>
            {else}&nbsp;{/if}

        </td>
        <td headers="hparent" class="z-left">
            {if isset($posting.Parent) && $posting.Parent ne null}
                <a href="{modurl modname='MUBoard' type='user' func='display' ot='posting' id=$posting.Parent.id}">
                    {$posting.Parent.title|default:""}
                </a>
                <a id="postingItem{$posting.id}_rel_{$posting.Parent.id}Display" href="{modurl modname='MUBoard' type='user' func='display' ot='posting' id=$posting.Parent.id theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" style="display: none">
                    {icon type='view' size='extrasmall' __alt='Quick view'}
                </a>
                <script type="text/javascript" charset="utf-8">
                /* <![CDATA[ */
                    document.observe('dom:loaded', function() {
                        muboardInitInlineWindow($('postingItem{{$posting.id}}_rel_{{$posting.Parent.id}}Display'), '{{$posting.Parent.title|replace:"'":""}}');
                    });
                /* ]]> */
                </script>
            {else}
                {gt text='Not set.'}
            {/if}
        </td>
        <td headers="hforum" class="z-left">
            {if isset($posting.Forum) && $posting.Forum ne null}
                <a href="{modurl modname='MUBoard' type='user' func='display' ot='forum' id=$posting.Forum.id}">
                    {$posting.Forum.title|default:""}
                </a>
                <a id="forumItem{$posting.id}_rel_{$posting.Forum.id}Display" href="{modurl modname='MUBoard' type='user' func='display' ot='forum' id=$posting.Forum.id theme='Printer' forcelongurl=true}" title="{gt text='Open quick view window'}" style="display: none">
                    {icon type='view' size='extrasmall' __alt='Quick view'}
                </a>
                <script type="text/javascript" charset="utf-8">
                /* <![CDATA[ */
                    document.observe('dom:loaded', function() {
                        muboardInitInlineWindow($('forumItem{{$posting.id}}_rel_{{$posting.Forum.id}}Display'), '{{$posting.Forum.title|replace:"'":""}}');
                    });
                /* ]]> */
                </script>
            {else}
                {gt text='Not set.'}
            {/if}
        </td>
        <td headers="hitemactions" class="z-right z-nowrap z-w02">
            {if count($posting._actions) gt 0}
            {strip}
                {foreach item='option' from=$posting._actions}
                    <a href="{$option.url.type|muboardActionUrl:$option.url.func:$option.url.arguments}" title="{$option.linkTitle|safetext}"{if $option.icon eq 'preview'} target="_blank"{/if}>
                        {icon type=$option.icon size='extrasmall' alt=$option.linkText|safetext}
                    </a>
                {/foreach}
            {/strip}
            {/if}
        </td>
    </tr>
    {foreachelse}
        <tr class="z-datatableempty">
          <td class="z-left" colspan="11">
            {gt text='No postings found.'}
          </td>
        </tr>
    {/foreach}

    </tbody>
</table>

    {if !isset($showAllEntries) || $showAllEntries ne 1}
        {pager rowcount=$pager.numitems limit=$pager.itemsperpage display='page'}
    {/if}

    {notifydisplayhooks eventname='muboard.ui_hooks.postings.display_view' urlobject=$currentUrlObject assign='hooks'}
    {foreach key='hookname' item='hook' from=$hooks}
        {$hook}
    {/foreach}
</div>
</div>
{include file='user/footer.tpl'}


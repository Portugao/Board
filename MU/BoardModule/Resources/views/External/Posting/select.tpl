{* Purpose of this template: Display a popup selector for Forms and Content integration *}
{assign var='baseID' value='posting'}
<div id="itemSelectorInfo" class="hidden" data-base-id="{$baseID}" data-selected-id="{$selectedId|default:0}"></div>
<div class="row">
    <div class="col-sm-8">
        <div class="form-group">
            <label for="{$baseID}Id" class="col-sm-3 control-label">{gt text='Posting'}:</label>
            <div class="col-sm-9">
                <select id="{$baseID}Id" name="id" class="form-control">
                    {foreach item='posting' from=$items}
                        <option value="{$posting->getKey()}"{if $selectedId eq $posting->getKey()} selected="selected"{/if}>{$posting->getTitle()}</option>
                    {foreachelse}
                        <option value="0">{gt text='No entries found.'}</option>
                    {/foreach}
                </select>
            </div>
        </div>
        <div class="form-group">
            <label for="{$baseID}Sort" class="col-sm-3 control-label">{gt text='Sort by'}:</label>
            <div class="col-sm-9">
                <select id="{$baseID}Sort" name="sort" class="form-control">
                    <option value="workflowState"{if $sort eq 'workflowState'} selected="selected"{/if}>{gt text='Workflow state'}</option>
                    <option value="parent_id"{if $sort eq 'parent_id'} selected="selected"{/if}>{gt text='Parent_id'}</option>
                    <option value="title"{if $sort eq 'title'} selected="selected"{/if}>{gt text='Title'}</option>
                    <option value="text"{if $sort eq 'text'} selected="selected"{/if}>{gt text='Text'}</option>
                    <option value="invocations"{if $sort eq 'invocations'} selected="selected"{/if}>{gt text='Invocations'}</option>
                    <option value="firstImage"{if $sort eq 'firstImage'} selected="selected"{/if}>{gt text='First image'}</option>
                    <option value="secondImage"{if $sort eq 'secondImage'} selected="selected"{/if}>{gt text='Second image'}</option>
                    <option value="thirdImage"{if $sort eq 'thirdImage'} selected="selected"{/if}>{gt text='Third image'}</option>
                    <option value="firstFile"{if $sort eq 'firstFile'} selected="selected"{/if}>{gt text='First file'}</option>
                    <option value="secondFile"{if $sort eq 'secondFile'} selected="selected"{/if}>{gt text='Second file'}</option>
                    <option value="thirdFile"{if $sort eq 'thirdFile'} selected="selected"{/if}>{gt text='Third file'}</option>
                    <option value="createdDate"{if $sort eq 'createdDate'} selected="selected"{/if}>{gt text='Creation date'}</option>
                    <option value="createdBy"{if $sort eq 'createdBy'} selected="selected"{/if}>{gt text='Creator'}</option>
                    <option value="updatedDate"{if $sort eq 'updatedDate'} selected="selected"{/if}>{gt text='Update date'}</option>
                    <option value="updatedBy"{if $sort eq 'updatedBy'} selected="selected"{/if}>{gt text='Updater'}</option>
                </select>
                <select id="{$baseID}SortDir" name="sortdir" class="form-control">
                    <option value="asc"{if $sortdir eq 'asc'} selected="selected"{/if}>{gt text='ascending'}</option>
                    <option value="desc"{if $sortdir eq 'desc'} selected="selected"{/if}>{gt text='descending'}</option>
                </select>
            </div>
        </div>
        <div class="form-group">
            <label for="{$baseID}SearchTerm" class="col-sm-3 control-label">{gt text='Search for'}:</label>
            <div class="col-sm-9">
                <div class="input-group">
                    <input type="text" id="{$baseID}SearchTerm" name="q" class="form-control" />
                    <span class="input-group-btn">
                        <input type="button" id="mUBoardModuleSearchGo" name="gosearch" value="{gt text='Filter'}" class="btn btn-default" />
                    </span>
                </div>
            </div>
        </div>
    </div>
    <div class="col-sm-4">
        <div id="{$baseID}Preview" style="border: 1px dotted #a3a3a3; padding: .2em .5em">
            <p><strong>{gt text='Posting information'}</strong></p>
            {img id='ajaxIndicator' modname='core' set='ajax' src='indicator_circle.gif' alt='' class='hidden'}
            <div id="{$baseID}PreviewContainer">&nbsp;</div>
        </div>
    </div>
</div>

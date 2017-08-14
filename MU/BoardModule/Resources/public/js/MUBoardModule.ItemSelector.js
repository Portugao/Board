'use strict';

var mUBoardModule = {};

mUBoardModule.itemSelector = {};
mUBoardModule.itemSelector.items = {};
mUBoardModule.itemSelector.baseId = 0;
mUBoardModule.itemSelector.selectedId = 0;

mUBoardModule.itemSelector.onLoad = function (baseId, selectedId)
{
    mUBoardModule.itemSelector.baseId = baseId;
    mUBoardModule.itemSelector.selectedId = selectedId;

    // required as a changed object type requires a new instance of the item selector plugin
    jQuery('#mUBoardModuleObjectType').change(mUBoardModule.itemSelector.onParamChanged);

    jQuery('#' + baseId + '_catidMain').change(mUBoardModule.itemSelector.onParamChanged);
    jQuery('#' + baseId + '_catidsMain').change(mUBoardModule.itemSelector.onParamChanged);
    jQuery('#' + baseId + 'Id').change(mUBoardModule.itemSelector.onItemChanged);
    jQuery('#' + baseId + 'Sort').change(mUBoardModule.itemSelector.onParamChanged);
    jQuery('#' + baseId + 'SortDir').change(mUBoardModule.itemSelector.onParamChanged);
    jQuery('#mUBoardModuleSearchGo').click(mUBoardModule.itemSelector.onParamChanged);
    jQuery('#mUBoardModuleSearchGo').keypress(mUBoardModule.itemSelector.onParamChanged);

    mUBoardModule.itemSelector.getItemList();
};

mUBoardModule.itemSelector.onParamChanged = function ()
{
    jQuery('#ajaxIndicator').removeClass('hidden');

    mUBoardModule.itemSelector.getItemList();
};

mUBoardModule.itemSelector.getItemList = function ()
{
    var baseId;
    var params;

    baseId = mUBoardModule.itemSelector.baseId;
    params = {
        ot: baseId,
        sort: jQuery('#' + baseId + 'Sort').val(),
        sortdir: jQuery('#' + baseId + 'SortDir').val(),
        q: jQuery('#' + baseId + 'SearchTerm').val()
    }
    if (jQuery('#' + baseId + '_catidMain').length > 0) {
        params[catidMain] = jQuery('#' + baseId + '_catidMain').val();
    } else if (jQuery('#' + baseId + '_catidsMain').length > 0) {
        params[catidsMain] = jQuery('#' + baseId + '_catidsMain').val();
    }

    jQuery.getJSON(Routing.generate('muboardmodule_ajax_getitemlistfinder'), params, function( data ) {
        var baseId;

        baseId = mUBoardModule.itemSelector.baseId;
        mUBoardModule.itemSelector.items[baseId] = data;
        jQuery('#ajaxIndicator').addClass('hidden');
        mUBoardModule.itemSelector.updateItemDropdownEntries();
        mUBoardModule.itemSelector.updatePreview();
    });
};

mUBoardModule.itemSelector.updateItemDropdownEntries = function ()
{
    var baseId, itemSelector, items, i, item;

    baseId = mUBoardModule.itemSelector.baseId;
    itemSelector = jQuery('#' + baseId + 'Id');
    itemSelector.length = 0;

    items = mUBoardModule.itemSelector.items[baseId];
    for (i = 0; i < items.length; ++i) {
        item = items[i];
        itemSelector.get(0).options[i] = new Option(item.title, item.id, false);
    }

    if (mUBoardModule.itemSelector.selectedId > 0) {
        jQuery('#' + baseId + 'Id').val(mUBoardModule.itemSelector.selectedId);
    }
};

mUBoardModule.itemSelector.updatePreview = function ()
{
    var baseId, items, selectedElement, i;

    baseId = mUBoardModule.itemSelector.baseId;
    items = mUBoardModule.itemSelector.items[baseId];

    jQuery('#' + baseId + 'PreviewContainer').addClass('hidden');

    if (items.length === 0) {
        return;
    }

    selectedElement = items[0];
    if (mUBoardModule.itemSelector.selectedId > 0) {
        for (var i = 0; i < items.length; ++i) {
            if (items[i].id == mUBoardModule.itemSelector.selectedId) {
                selectedElement = items[i];
                break;
            }
        }
    }

    if (null !== selectedElement) {
        jQuery('#' + baseId + 'PreviewContainer')
            .html(window.atob(selectedElement.previewInfo))
            .removeClass('hidden');
        mUBoardInitImageViewer();
    }
};

mUBoardModule.itemSelector.onItemChanged = function ()
{
    var baseId, itemSelector, preview;

    baseId = mUBoardModule.itemSelector.baseId;
    itemSelector = jQuery('#' + baseId + 'Id').get(0);
    preview = window.atob(mUBoardModule.itemSelector.items[baseId][itemSelector.selectedIndex].previewInfo);

    jQuery('#' + baseId + 'PreviewContainer').html(preview);
    mUBoardModule.itemSelector.selectedId = jQuery('#' + baseId + 'Id').val();
    mUBoardInitImageViewer();
};

jQuery(document).ready(function() {
    var infoElem;

    infoElem = jQuery('#itemSelectorInfo');
    if (infoElem.length == 0) {
        return;
    }

    mUBoardModule.itemSelector.onLoad(infoElem.data('base-id'), infoElem.data('selected-id'));
});

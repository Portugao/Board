'use strict';

function boardToggleShrinkSettings(fieldName) {
    var idSuffix = fieldName.replace('muboardmodule_appsettings_', '');
    jQuery('#shrinkDetails' + idSuffix).toggleClass('hidden', !jQuery('#muboardmodule_appsettings_enableShrinkingFor' + idSuffix).prop('checked'));
}

jQuery(document).ready(function() {
    jQuery('.shrink-enabler').each(function (index) {
        jQuery(this).bind('click keyup', function (event) {
            boardToggleShrinkSettings(jQuery(this).attr('id').replace('enableShrinkingFor', ''));
        });
        boardToggleShrinkSettings(jQuery(this).attr('id').replace('enableShrinkingFor', ''));
    });
});

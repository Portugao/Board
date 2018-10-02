'use strict';

function boardToggleShrinkSettings(fieldName) {
    var idSuffix;

    idSuffix = fieldName.replace('muboardmodule_config_', '');
    jQuery('#shrinkDetails' + idSuffix).toggleClass('hidden', !jQuery('#muboardmodule_config_enableShrinkingFor' + idSuffix).prop('checked'));
}

jQuery(document).ready(function () {
    jQuery('.shrink-enabler').each(function (index) {
        jQuery(this).bind('click keyup', function (event) {
            boardToggleShrinkSettings(jQuery(this).attr('id').replace('enableShrinkingFor', ''));
        });
        boardToggleShrinkSettings(jQuery(this).attr('id').replace('enableShrinkingFor', ''));
    });
});

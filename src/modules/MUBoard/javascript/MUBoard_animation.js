/**
 * Helper function to animate 
 */


function muboardShowOptions()
{
    var MU = jQuery.noConflict();
    MU(document).ready(function() {
    	MU(".z-formrow > #uploadImages").click( function(e) {
        e.preventDefault();
        if(MU(this).is(':checked')) {
        	MU(this).next.slideDown('slow');
        }
        else {
        	MU(this).next.slideUp('slow');
        }
       /* var url = MU(this).attr("href");
        MU(this).css({"color":"red"});
        if (zaehler == 0) {
        MU(this).append("<div id='work'><img src='images/ajax/indicator.white.gif' /></div>");

        }
        var form = MU(this).next();
        MU.get(url, function(ergebnis) {
        if (ergebnis) {
            form.html(ergebnis).slideToggle(1000, 'easeInCirc');
            MU("#work").remove();

            zaehler++;                                      
    }  */ 
    });     
    });
    	
}
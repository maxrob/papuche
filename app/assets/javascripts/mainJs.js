jQuery(window).on('load', function(){
    ready();
});

var menuNew = 0;
function goToMenu (menu){
	if(menu != menuNew){
		document.getElementById('cat'+menuNew).classList.remove("isHighlight");
    	document.getElementById('cat'+menu).classList.add("isHighlight");
	    switch(menuNew){
	    	case 0:
	    		document.getElementById('container_new').classList.remove("container_visible");
	    	break;
	    	case 1:
	    		document.getElementById('container_popular').classList.remove("container_visible");
	    	break;
	    	case 2:
	    		document.getElementById('container_random').classList.remove("container_visible");
	    	break;
	    	case 3:
	    		document.getElementById('container_unfinished').classList.remove("container_visible");
	    	break;
	    }
	    switch(menu){
    	case 0:
    		document.getElementById('container_new').classList.add("container_visible");
    	break;
    	case 1:
    		document.getElementById('container_popular').classList.add("container_visible");
    	break;
    	case 2:
    		document.getElementById('container_random').classList.add("container_visible");
    	break;
    	case 3:
    		document.getElementById('container_unfinished').classList.add("container_visible");
    		$('#container_unfinished').masonry('reloadItems')
    	break;
	    }
    	menuNew = menu;
    }

}

var ready;
ready = function() {
    if (typePage == 0){
        $('#container_new').addClass( "container_visible" );
        $('#container_new').masonry({
            isFitWidth: true,
            itemSelector : '.item'
        });
        $('#container_new').removeClass( "container_visible" );

        $('#container_popular').addClass( "container_visible" );
        $('#container_popular').masonry({
            isFitWidth: true,
            itemSelector : '.item'
        });
        $('#container_popular').removeClass( "container_visible" );

        $('#container_random').addClass( "container_visible" );
        $('#container_random').masonry({
            isFitWidth: true,
            itemSelector : '.item'
        });
        $('#container_random').removeClass( "container_visible" );

        $('#container_unfinished').addClass( "container_visible" );
        $('#container_unfinished').masonry({
            isFitWidth: true,
            itemSelector : '.item'
        });
        $('#container_unfinished').removeClass( "container_visible" );

        $('#container_new').addClass( "container_visible" );

        document.getElementById('cat0').classList.add("isHighlight");
    }
    else if (typePage == 1){

    }
    else if (typePage == 2){
        // ajout de la classe JS à HTML
        document.querySelector("html").classList.add('js');
         
        // initialisation des variables
        var fileInput  = document.querySelector( ".input-file" ),  
            button     = document.querySelector( ".input-file-trigger" ),
            the_return = document.querySelector(".file-return");
         
        // action lorsque la "barre d'espace" ou "Entrée" est pressée
        button.addEventListener( "keydown", function( event ) {
            if ( event.keyCode == 13 || event.keyCode == 32 ) {
                fileInput.focus();
            }
        });
         
        // action lorsque le label est cliqué
        button.addEventListener( "click", function( event ) {
           fileInput.focus();
           return false;
        });
         
        // affiche un retour visuel dès que input:file change
        fileInput.addEventListener( "change", function( event ) {  
            the_return.innerHTML = this.value;  
        });
    }
    
};

$(document).ready(ready);
$(document).on('page:load', ready);
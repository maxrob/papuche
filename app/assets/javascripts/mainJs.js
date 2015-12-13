jQuery(window).on('load', function(){
  $('#container_unfinished').masonry({
    isFitWidth: true,
    itemSelector : '.item',
  });
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
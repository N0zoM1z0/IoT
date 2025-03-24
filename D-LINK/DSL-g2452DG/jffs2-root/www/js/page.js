/* 
default ui layout function 
*/ 
var onloadValues="";
var isIE = (navigator.appName.indexOf("Microsoft") != -1); 

/**************************************************************************
* * startResize - Resizes the window
 * * This routine enables the window to start resizing. 
 * * RETURNS: NONE */ 
function startResize( ) 
{ 
	var divRightObj = document.getElementById('divRight'); 
	divRightObj.style.display = "block"; 
	divRightObj.style.height = getHeight() 
	divRightObj.style.width = getWidth(); 
	var resizeBlockDivObj = document.getElementById('resizeBlockDiv'); 
	resizeBlockDivObj.style.display = "block"; 
	document.body.onmousemove = resizeFrames; 
	document.body.onmouseup = endResize; 
	document.body.style.cursor = "col-resize"; 
	if (!isIE) document.captureEvents(Event.MOUSEMOVE); 
} 

/**************************************************************************
* * endResize - Resizes the window 
* * This routine stops resizing of a window. 
* * RETURNS: NONE */ 
function endResize ( ) 
{ 
	var divRightObj = document.getElementById('divRight'); 
	divRightObj.style.display = "none"; 
	var resizeBlockDivObj = document.getElementById('resizeBlockDiv'); 
	resizeBlockDivObj.style.display = "none"; 
	document.body.onmousemove = null; 
	document.body.style.cursor = "default"; 
	if (!isIE) 
		document.releaseEvents (Event.MOUSEMOVE); 
} 

/**************************************************************************
* * resizeFrames - Resizes the window 
* * This routine resizes a window. 
* * RETURNS: NONE 
*/ 
function resizeFrames (e) 
{ 
var newPos = 180; 
if (e) 
	newPos = e.clientX; 
else 
	newPos = event.x; 
var menuTdObj = document.getElementById ('menuTd'); 
menuTdObj.width = newPos; 
} 

/**************************************************************************
* * alignMidDiv - Aligns the divider between left menu and content area. 
* * This routine aligns the 4px divider between left menu and content area 
* in the right place. 
* * RETURNS: NONE 
*/ 
function alignMidDiv( ) 
{ 
	var sizeBarDivObj = document.getElementById("sizeBarImg"); 
	var bodyDivObj = document.getElementById("bodyDiv"); 
	var setupWizardDivObj = document.getElementById("wizardDiv"); 

	if (bodyDivObj && isIE) 
	{ 
		bodyDivObj.style.width = "100%"; 
		bodyDivObj.style.paddingTop = "15px"; 
	} 
	if (sizeBarDivObj) 
	{ 
		sizeBarDivObj.width = "0"; 
		if (isIE)
			sizeBarDivObj.height = getHeight() - (15+48+15) - (8+12+15); 
		else	
			sizeBarDivObj.height = getHeight() - (15+40+15) - (8+12+15); 
	} 
	if (setupWizardDivObj) 
	{ 
		if ((getHeight() - 420) > 2) 
			setupWizardDivObj.style.top = (getHeight() - 420)/2; 
		else 
			setupWizardDivObj.style.top = 0; 
		if ((getWidth() - 620) > 2) 
			setupWizardDivObj.style.left = (getWidth() - 620)/2; 
		else 
			setupWizardDivObj.style.left = 0; 
	} 
} 
/**************************************************************************
* * getWidth - Gets the width * * This routine returns the width of the window . 
* * RETURNS: Numeric 
*/ 
function getWidth ( ) 
{ 
	if (typeof window.innerWidth != 'undefined') 
	{ 
		viewportwidth = window.innerWidth; 
		viewportheight = window.innerHeight; 
	} 
	else if (typeof document.documentElement != 'undefined' && typeof document.documentElement.clientWidth !='undefined' && document.documentElement.clientWidth != 0) 
	{ 
		viewportwidth = document.documentElement.clientWidth; 
		viewportheight = document.documentElement.clientHeight; 
	} 
	else 
	{ 
		viewportwidth = document.getElementsByTagName('body')[0].clientWidth; 
		viewportheight = document.getElementsByTagName('body')[0].clientHeight; 
	} 
	return viewportwidth; 
} 
/*************************************************************************** * getHeight - Gets the height * * This routine returns the height of the window * * RETURNS: Numeric */ 
function getHeight ( ) 
{ 
	if (typeof window.innerWidth != 'undefined') 
	{ 
		viewportwidth = window.innerWidth; 
		viewportheight = window.innerHeight; 
	} 
	else if (typeof document.documentElement != 'undefined' && typeof document.documentElement.clientWidth !='undefined' && document.documentElement.clientWidth != 0) 
	{ 
		viewportwidth = document.documentElement.clientWidth; 
		viewportheight = document.documentElement.clientHeight; 
	} 
	else 
	{ 
		viewportwidth = document.getElementsByTagName('body')[0].clientWidth; 
		viewportheight = document.getElementsByTagName('body')[0].clientHeight; 
	} 
	return viewportheight; 
} 

function formStateInit () 
{ 
	alignMidDiv(); 
} 
if(window.attachEvent) 
{ 
	window.attachEvent("onload",formStateInit); 
	window.attachEvent("onresize",alignMidDiv); 
} 
else 
{ 
	window.addEventListener("load",formStateInit,false); 
	window.addEventListener("resize",alignMidDiv,false); 
} 


// for javascript vars in html files.
function getStr(str)
{
    var vars = 'window.parent.' + str;
	return eval(vars);
}
function checkIndexOf()
{
	if (!Array.prototype.indexOf)
	{
		Array.prototype.indexOf = function(obj)
			{              
				for(var i=0; i<this.length; i++)
				{
					if(this[i]==obj)
					{
						return i;
					}
				}
				return -1;
			}
	}
}
// Translate language
jQuery(document).ready(function(){
	jQuery("[langkey]").each(function(){
		var keys_id = 'window.parent.' + jQuery(this).attr("langkey");
		var content = eval(keys_id);
		if('input' == jQuery(this)[0].tagName.toLowerCase())
			jQuery(this).attr("value", content);	
		else 
			jQuery(this).html(content);	
					
		});

		if(jQuery.isFunction(window.__init)) {
			checkIndexOf();
			__init();
		}
		/* create validate code block when init */
		if(0){ //(G_ValidateEnable == 1)
			if(jQuery("#BUTTON_BLOCK")) {
				createValidateBlock();
				createCode();
			}
		}
});

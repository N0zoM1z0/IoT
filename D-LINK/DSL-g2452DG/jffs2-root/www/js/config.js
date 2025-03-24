function ConfigItem()
{
	this.ID = "";
	this.PATH = "";
	this.TYPE = "";
	this.INIT = "";
	this.SBMT = "";
	this.CHK = "";
	this.MSG = "";
	this.VAL = "";
}

function ConfigObject()
{
	this._objpath = "";
}

function isUndefined(ele)
{
	if (typeof(ele) == "undefined")
		return true;
	return false;
}

function isDefined(ele)
{
	return !isUndefined(ele);
}

_reserved_attrs = [ "_objpath", "_inspath", "_index", ];

function isMetaAttr(attr)
{
	if (attr.charAt(0) == '_')
		return true;
	return false;
}

function isReservedAttr(attr)
{
	for (var i in _reserved_attrs) {
		var a = _reserved_attrs[i];
		if (a == attr) {
			return true;
		}
	}
	return false;
}

function ConfigItemUIInit(item, obj)
{
	if (isUndefined(item.ID) ||
			item.ID.length == 0)
		return;

	if (isUndefined(item.INIT))
		item.INIT = "y";

	if (typeof (item.INIT) == "string") {

		if (item.INIT == "y") {
			setValue(item.ID, item.VAL);
		} else if (item.INIT == "n") {
			return;
		} else {
			var code = item.INIT.replace(/this/g, "item");
			eval(code);
		}

	} else if (typeof (item.INIT) == "function") {

		item.INIT(item, obj);

	} else {
		alert("INIT attribute of " + item.ID
			+ "defined incorrectly!");
	}
}

function ConfigItemCheck(item, obj)
{
	if (isUndefined(item.ID) ||
			item.ID.length == 0)
		return;

	if (isUndefined(item.ID) ||
			item.ID.length == 0)
		return;

	if (isUndefined(item.CHK))
		return true;

	if (typeof (item.CHK) == "string") {

		if (item.CHK == "n") {
			return true;
		}

		var code = item.CHK.replace(/this/g, "item");

		var ret = eval(code);
		if (typeof (ret) != "boolean") {
			alert(item.ID + " check failed.");
			return false;
		}
		
		if (!ret && isDefined(item.MSG)) {
			alert(item.MSG);
		}
		return ret;

	} else if (typeof (item.CHK) == "function") {

		if (!item.CHK(item, obj)) {
			if (isDefined(item.MSG)) {
				alert(item.MSG);
			}
			return false;
		}
		return true;

	} else {
		alert("CHK attribute of " + item.ID
			+ "defined incorrectly!");
		return false;
	}
}

function ConfigItemPrepareSet(item, form, objpath, obj)
{
	if (isUndefined(item.ID) ||
			item.ID.length == 0)
		return;

	if (isUndefined(item.SBMT))
		return;

	if (isUndefined(objpath))
		objpath = "";

	if (typeof (item.SBMT) == "string") {

		if (item.SBMT == "y") {
			AddElements(form, objpath +
				item.PATH, getValue(item.ID));

		} else if (item.SBMT == "n") {
			return;
		} else {
			var code = item.SBMT.replace(/this/g, "item");
			eval(code);
		}

	} else if (typeof (item.SBMT) == "function") {

		item.SBMT(item, form, objpath, obj);

	} else {
		alert("SBMT attribute of " + item.ID
			+ "defined incorrectly!");
	}
}

function ConfigObjectUIInit(obj)
{
	for (var attr in obj) {
		if (isMetaAttr(attr))
			continue;
		ConfigItemUIInit(obj[attr], obj);
	}
}

function ConfigObjectCheck(obj)
{
	var valid = true;
	for (var attr in obj) {
		if (isMetaAttr(attr))
			continue;
		
		if (!ConfigItemCheck(obj[attr], obj)) {
			valid = false;
			break;
		}
	}
	return valid;
}

function ConfigObjectGetPath(obj)
{
	if (isDefined(obj._inspath))
		return obj._inspath;

	return obj._objpath;
}

function ConfigObjectPrepareAdd(obj, form)
{
	AddElements(form, "add_obj", obj._objpath);
	obj._inspath = obj._objpath + "{i}.";
}

function ConfigObjectPrepareDel(obj, form)
{
	if (isUndefined(obj._inspath)) {
		return;
	}
	AddElements(form, "del_obj", obj._inspath);
}

function ConfigObjectPrepareSet(obj, form)
{
	var objpath = ConfigObjectGetPath(obj);

	if (objpath.length == 0) {
		return;
	}

	for (var attr in obj) {
		if (isMetaAttr(attr))
			continue;
		ConfigItemPrepareSet(obj[attr], form, objpath, obj);
	}
}

function ConfigItemUIGetId(ele)
{
	if (isDefined(ele.id)) {
		return ele.id;
	}

	if (isDefined(ele.name)) {
		return ele.name;
	}
	return "";
}

function ConfigItemUIGetType(id)
{
	var type = getElementType(id);
	switch (type) {
	
	case "radio":
	case "checkbox":
		return "int";
	
	case "text":
	case "select":
	default:
		return "str";
	}
}

function ConfigItemGetTmpl(ele)
{
	var id = ConfigItemUIGetId(ele);

	if (id == "")
		return "";

	var type = ConfigItemUIGetType(id);

	var str = 'this.attr = { ID: "' + id + '", PATH: "", TYPE: "'+ type +'", '
		+ '\n\tINIT: "y", SBMT: "n",\n\tCHK: "n", MSG: "", VAL: "" };\n';
	return str;
}

function ConfigItemsGenerate()
{
	var inputs = document.getElementsByTagName("input");
	var selects = document.getElementsByTagName("select");

	var code = "";

	for (var i = 0; i < inputs.length; i++) {
		var ele = inputs[i];
		if (ele.type == "button" || ele.type == "submit"
				|| ele.type == "reset")
			continue;

		code += ConfigItemGetTmpl(ele);
	}
	
	for (var i = 0; i < selects.length; i++) {
		var ele = selects[i];
		code += ConfigItemGetTmpl(ele);
	}
	alert(code);
}


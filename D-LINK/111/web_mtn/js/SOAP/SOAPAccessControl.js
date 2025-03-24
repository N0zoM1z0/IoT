
function SOAPGetLocalMacAddressResponse(){
    this.localMac="";
}


function SOAPGetAccessCtlSwitchResponse(){
    this.SwitchState = "";
    this.AclMode = "";
}

function SOAPGetAccessCtlListResponse(){
    var aclClientItem = new AclClientList();
    this.AclClientInfo = $.makeArray(aclClientItem);
}

function AclClientList(){
    this.DeviceName = "";
    this.Mac = "";
}

SOAPGetAccessCtlListResponse.prototype = {
    _init:true,
    push : function(data){
        if(this._init)
        {
            this._init = false;
            this.AclClientInfo.splice(0,1);
        }
        this.AclClientInfo.push(data);
        return true;
    }
}


function SOAPSetAccessCtlSwitchSettings(){
    this.SwitchState = "";
}


function SOAPSetAccessCtlListSettings(){
    this.AccessCtlType = "";
    var aclClientItem = new AclClientList();
    this.AclClientInfo = $.makeArray(aclClientItem);
}


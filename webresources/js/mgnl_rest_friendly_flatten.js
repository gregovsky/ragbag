var mgnl_json = {};

function isVarTypeOf(_var, _type){
    try {
        return _var.constructor === _type;
    } catch(ex) {
        return false;
    }
}

function flatten_object(obj,propNamePrefix){
    for (var key in obj) {
        var propName = propNamePrefix + (propNamePrefix ? "_" : "") + key;
        var propValue = obj[key];

        if (isVarTypeOf(propValue, Object)) {
            // is an Object

            flatten_object(propValue, propName);

        }
        if (isVarTypeOf(propValue, Array)) {
            // is an Array

            flatten_object(propValue, propName);

        }
        if (isVarTypeOf(propValue, String)) {
            // is a String

            mgnl_json['properties'].push({"name": propName, "type": "String", "multiple": false, "values": [ propValue ]});

        }
        if (isVarTypeOf(propValue, Number)) {
            // is a Number

            mgnl_json['properties'].push({"name": propName, "type": "Double", "multiple": false, "values": [ propValue ]});

        }
        if (isVarTypeOf(propValue, Boolean)) {
            // is a Boolean

            mgnl_json['properties'].push({"name": propName, "type": "Boolean", "multiple": false, "values": [ propValue ]});

        }


    };
}

function mgnl_rest_friendly_flatten(obj){
    // ideal for PUT (new node with properties)
    // example of obj: {name:"abc",price:100,user:{name:"John",city:"Basel"}}

    var nodeName = new Date().toISOString().replace(/[^0-9.]/g, "").slice(0,14);

    mgnl_json = {name: nodeName,type: "order",properties:[]};

    flatten_object(obj,"");

    return mgnl_json;
}

function mgnl_rest_friendly_flatten_only_properties(obj){
    // ideal for POST (properties update)

    mgnl_json = {properties:[]};

    flatten_object(obj,"");

    return mgnl_json;
}

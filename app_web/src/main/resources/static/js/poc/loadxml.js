
var keyStr = "ABCDEFGHIJKLMNOP" +
    "QRSTUVWXYZabcdef" +
    "ghijklmnopqrstuv" +
    "wxyz0123456789+/" +
    "=";

function decode64(baseStr)
{
    var output = "";
    var chr1, chr2, chr3 = "";
    var enc1, enc2, enc3, enc4 = "";
    var i = 0;
// remove all characters that are not A-Z, a-z, 0-9, +, /, or =
    var base64test = /[^A-Za-z0-9\+\/\=]/g;
    if (base64test.exec(baseStr))
    {
        alert("There were invalid base64 characters in the input text.\n" +
            "Valid base64 characters are A-Z, a-z, 0-9, '+', '/', and '='\n" +
            "Expect errors in decoding.");
    }
    baseStr = baseStr.replace(/[^A-Za-z0-9\+\/\=]/g, "");
    do
    {
        enc1 = keyStr.indexOf(baseStr.charAt(i++));
        enc2 = keyStr.indexOf(baseStr.charAt(i++));
        enc3 = keyStr.indexOf(baseStr.charAt(i++));
        enc4 = keyStr.indexOf(baseStr.charAt(i++));
        chr1 = (enc1 << 2) | (enc2 >> 4);
        chr2 = ((enc2 & 15) << 4) | (enc3 >> 2);
        chr3 = ((enc3 & 3) << 6) | enc4;
        output = output + String.fromCharCode(chr1);
        if (enc3 != 64)
        {
            output = output + String.fromCharCode(chr2);
        }
        if (enc4 != 64)
        {
            output = output + String.fromCharCode(chr3);
        }
        chr1 = chr2 = chr3 = "";
        enc1 = enc2 = enc3 = enc4 = "";
    } while (i < baseStr.length);
    return unescape(output);
}

function parseXML (xmlStr) {
    if(typeof($.browser)== "undefined"){
        if (!!navigator.userAgent.match(/Trident\/7\./)){// IE11
            xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
            xmlDoc.async = "false";
            xmlDoc.loadXML(xmlStr);
        }else{
            var parser = new DOMParser();
            xmlDoc = parser.parseFromString(xmlStr, "text/xml");
        }
    }else{
        if($.browser.msie){// IE
            xmlDoc = new ActiveXObject("Microsoft.XMLDOM");
            xmlDoc.async = "false";
            xmlDoc.loadXML(xmlStr);
        }else{// Other
            var parser = new DOMParser();
            xmlDoc = parser.parseFromString(xmlStr, "text/xml");
        }
    }
    return xmlDoc;
}

function getRstpUrl(baseStr){
    var xml=decode64(baseStr);
    var bankDoc = parseXML(xml);
    var rtspUrl=$(bankDoc).find('rtsp').text();
    if(rtspUrl!=null && rtspUrl!=''){
        $('#MRL1').val(rtspUrl);
        $('#play_button1').click();
        isVideoPlay = true;
    }
    console.log(rtspUrl);
}
   


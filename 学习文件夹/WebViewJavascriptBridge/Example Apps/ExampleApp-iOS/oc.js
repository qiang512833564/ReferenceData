
(function(){
var getCurrentUsrInfo = function(callback){
    var data = { 'id': '1', 'value': '123456'}
    window.WebViewJavascriptBridge.callHandler('getCurrentUsrInfoNative', data,callback);
}

var isValidURL=function(callback){
    var data = { 'id': '1', 'value': '123456'}
    window.WebViewJavascriptBridge.callHandler('isValidURLNative', data,callback);
}

var sendByDefault = function(callback){
    var data = 'Hello from JS button'
    window.WebViewJavascriptBridge.send(data, callback);
 }

var AppClient = {
    getCurrentUsrInfo:getCurrentUsrInfo,
    isValidURL:isValidURL,
    sendByDefault:sendByDefault
}
 window.AppClient = AppClient;
 }());


function testIfJSLoaded(){
    alert('恭喜,JS与OC可以正常通讯了');
}

function testMethodInvoked(){
    alert('testMethodInvoked');
}


var uniqueId = 1
function log(message, data) {
    var log = document.getElementById('log')
    var el = document.createElement('div')
    el.className = 'logLine'//这里的logLine是对应的cccccc.html里面头部设置的style
    el.innerHTML = uniqueId++ + '. ' + message + ':<br/>' + JSON.stringify(data)
    //innerHTML 属性设置或返回元素的 inner HTML。
    if (log.children.length) { log.insertBefore(el, log.children[0]) }
    else { log.appendChild(el) }
}


function connectWebViewJavascriptBridge(callback) {
    if (window.WebViewJavascriptBridge) {
        callback(WebViewJavascriptBridge)
    } else {
        //addEventListener() 方法用于向指定元素添加事件句柄
        //参数一：必须要有--字符串，指定事件名，注意：不要使用“on”前缀
        //参数二：必须要有--指定要事件触发 时执行的函数
        //参数三：可选值---布尔值，指定事件是否在捕获或冒泡阶段执行-true - 事件句柄在捕获阶段执行-- false- 默认。事件句柄在冒泡阶段执行
        document.addEventListener('WebViewJavascriptBridgeReady', function() {
                                  callback(WebViewJavascriptBridge)
                                  }, false)
    }
}
/*
 JS的关键在于connectWebViewJavascriptBridge函数，log方法用于输出日志，是用户的自定义函数，所有的自定义函数都要写在connectWebViewJavascriptBridge当中作为成员。
 bridge.init和bridge.registerHandler方法用于接收OC发来的send和callHandler，并对OC进行回调
 */
connectWebViewJavascriptBridge(function(bridge) {
                               bridge.init(function(message, responseCallback) {
                                           log('JS000000 ----- OC调用JS，来自OC的输入参数', message)
                                           var data = { '000000JS返回来的结果':'我来自JS!' }
                                           log('JS000000 ----- OC调用JS 用send方法 返回给OC的输出参数', data)
                                           responseCallback(data)
                                           })
                               
                               bridge.registerHandler('testJavascriptHandler', function(data, responseCallback) {
                                                      log('JS222222 ----- OC调用JS  用handle方法  来自OC的输入参数:', data)
                                                      var responseData = { 'JS222222 JS返回的字符串':'同步调用立马返回啦!' }
                                                      log('JS222222 ----- OC调用JS  用handle方法 JS返给OC的输出参数', responseData)
                                                      responseCallback(responseData)
                                                      })
                               })
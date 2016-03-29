
//main.js 

//var fs = require("fs");

//var data = fs.readFileSync('input.txt');

//console.log(data.toString());

//console.log("程序执行结束！");

//var hello = require('./hello');

//hello();

var Hello = require('./hello');

var hello = new Hello();

hello.setName('BYVoid');

hello.sayHello();

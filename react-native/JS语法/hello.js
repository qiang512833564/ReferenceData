
//module.exports = Hello;

//exports.world = function(){
//    console.log('Hello world!');
//}

//module.exports = function(){
//  console.log('HEllo world!');
//}

function Hello() { 
	var name; 
	this.setName = function(thyName) { 
		name = thyName; 
	}; 
	this.sayHello = function() { 
		console.log('Hello ' + name); 
	}; 
}; 
module.exports = Hello;

/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 * 资料摘自：http://www.cnblogs.com/yupeng/archive/2012/04/06/2435386.html
 */
'use strict';

var React = require('react-native');
var Sub = require('./component');
var {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  
} = React;
/*
 * 构造函数的优点是：
 * 例如：http://www.2cto.com/kf/201402/281841.html
 * var o1 = {
    p:”I’m in Object literal”,
    alertP:function(){
        alert(this.p);
    }
}这样，就用对象字面量创建了一个对象o1，它具有一个成员变量p以及一个成员方法alertP。这种写法不需要定义构造函数
种写法的缺点是，每创建一个新的对象都需要写出完整的定义语句，不便于创建大量相同类型的对象，不利于使用继承等高级特性。
new表达式是配合构造函数使用的，例如new String(“a string”)，调用内置的String函数构造了一个字符串对象。
下面我们用构造函数的方式来重新创建一个实现同样功能的对象，首先是定义构造函数，然后是调用new表达式：
function CO(){
    this.p = “I’m in constructed object”;
    this.alertP = function(){
        alert(this.p);
    }
}
var o2 = newCO();-----另外，构造函数也可以实现多个对象公用一个父类，相当于继承
 */
var ConstructorAndState = React.createClass({
 
 getInitialState:function(){
  	//console.log('getInitialState');
  	return {value:10};
  },
  render: function() {
  	//console.log('render%@',this.state);
  	//this.state = {newValue:1000};用于初始化改变this.state
  	//console.log('render%@',this.state);
  	//this.setState({newValue:10});
  	//this.setState({value:100});
  	this.state.blue = "red";//这样可以添加新属性
  	console.log(this.state);
  	//this.setState({
  		//blue:'blue',
  	//});//这样是能改掉的，但是要注意不能在render里面去设置state值，会造成死循环
  	//console.log(this.state);
 /*
  * 在定义函数的时候，函数定义的时候函数本身就会默认有一个prototype的属性，
  * 而我们如果用new 运算符来生成一个对象的时候就没有prototype属性
  */
  	function a(c){
  	this.b = c;
  	this.d = function(){
  		alert(this,b);
  	};
  };
  	//var obj = new a('test');
  	//alert(obj.b);//test-------也就是说方法对象中的this，仅仅只是指该方法对象
  	//alert(this.b);//undefine
  	//a.prototype 包含了2个属性，一个是constructor ，另外一个是__proto__
  	/*方法对象的结构如下：
  	 * obj---->a
  	 *           b:"test"
  	 *           d:function(){}
  	 *           __proto__:a
  	 */
  	//alert(typeof obj.prototype);//undefine
  	//alert(typeof a.prototype);//object
  	//可以看出函数的prototype 属性又指向了一个对象，这个对象就是prototype对象
  	//alert(obj.__proto__===a.prototype);//true
  	/*
  	 * 每个对象都会在其内部初始化一个属性，就是__proto__，当我们访问一个对象的属性 时，
  	 * 如果这个对象内部不存在这个属性，那么他就会去__proto__里找这个属性，
  	 * 这个__proto__又会有自己的__proto__，于是就这样 一直找下去。
  	 */
  	//上面的方法对象初始化，也就相当于下面的方式-----
  	//分析出new运算符做了事情
  	var obj={};//也就是说，初始化一个对象obj
  	obj.__proto__=a.prototype;
  	a.call(obj);//也就是构造obj,也可以称之为初始化obj
  	//alert(obj.__proto__===a.prototype);//true
  	
  	a.prototype.test = function(){
  		alert(this.b);
  	}
  	var obj = function(){}
  	obj.prototype = new a('test');
  	obj.prototype.test1 = function(){
  		alert(22222);		
  	}
  	var t = new obj('test');
  	t.test();//t.__proto__.__proto__ = a.prototype
  	//对象t先去找本身是的prototype 是否有test函数，发现没有，结果再往上级找
  	//
  	alert(obj.constructor);
    return (
    	
      <View style={styles.container}>
        <Sub name='测试' ref={component=>this.sub=component} onPress={this.onPressAction.bind(this)} />
      </View>
      
    );
  },
  onPressAction(){
  	alert('test');
  	this.sub.myname='china';
  	//this.sub.props.name='更新';-----不弄能够实现的，因为props对外是readonly
  }
  
});

var styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    backgroundColor: '#F5FCFF',
  },
  welcome: {
    fontSize: 20,
    textAlign: 'center',
    margin: 10,
  },
  instructions: {
    textAlign: 'center',
    color: '#333333',
    marginBottom: 5,
  },
});

AppRegistry.registerComponent('constructorAndState', () => ConstructorAndState);
/*
 * //构造函数
 //使自己的对象多次复制，同时实例根据设置的访问等级可以访问其内部的属性和方法
 //当对象被实例化后，构造函数会立即执行它所包含的任何代码
 function myObject(msg){
     //特权属性(公有属性)
     this.myMsg = msg; //只在被实例化后的实例中可调用
     this.address = '上海';
     
     //私有属性
     var name = '豪情';
     var age = 29;
     var that = this;
     
     //私有方法
     function sayName(){
         alert(that.name);
     }
     //特权方法(公有方法)
     //能被外部公开访问
     //这个方法每次实例化都要重新构造而prototype是原型共享，所有实例化后，都共同引用同一个
     this.sayAge = function(){
         alert(name); //在公有方法中可以访问私有成员
     }
     //私有和特权成员在函数的内部，在构造函数创建的每个实例中都会包含同样的私有和特权成员的副本，
     //因而实例越多占用的内存越多
 }
 //公有方法
 //适用于通过new关键字实例化的该对象的每个实例
 //向prototype中添加成员将会把新方法添加到构造函数的底层中去
 myObject.prototype.sayHello = function(){
     alert('hello everyone!');
 }
 //静态属性
 //适用于对象的特殊实例，就是作为Function对象实例的构造函数本身
 myObject.name = 'china';
 //静态方法
 myObject.alertname = function(){
     alert(this.name);
 }
 //实例化
 var m1 = new myObject('111');
 //---- 测试属性 ----//
 //console.log(myObject.name); //china
 //console.log(m1.name); //undefined, 静态属性不适用于一般实例
 //console.log(m1.constructor.name); //china, 想访问类的静态属性，先访问该实例的构造函数，然后在访问该类静态属性
 //console.log(myObject.address); //undefined, myObject中的this指的不是函数本身，而是调用address的对象，而且只能是对象
 //console.log(m1.address); //上海 此时this指的是实例化后的m1
 
 //---- 测试方法 ----//
 //myObject.alertname(); //china,直接调用函数的类方法
 //m1.alertname(); //FF: m1.alertname is not a function, alertname 是myObject类的方法，和实例对象没有直接关系
 //m1.constructor.alertname(); //china, 调用该对象构造函数（类函数）的方法（函数）
 //m1.sayHello(); //hello everyone, myObject类的prototype原型下的方法将会被实例继承
 //myObject.sayHello(); //myObject.sayHello is not a function，sayHello是原型方法，不是类的方法
 
 //---- 测试prototype ----//
 //console.log(m1.prototype); //undefined, 实例对象没有prototype
 //console.log(myObject.prototype); //Object 
 //alert(myObject.prototype.constructor); //console.log返回myObject(msg)，此时alert()更清楚，相当于myObject
 //console.log(myObject.prototype.constructor.name); //china, 相当于myObject.name;
复制代码
 */

/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

var React = require('react-native');
var {
  AppRegistry,
  StyleSheet,
  Text,
  View,
} = React;

var ButtonDemo = React.createClass({
  _text(){
  	//alert(arguments.callee.toString());---js
  	alert("_text");
  	/*拷贝一个对象
  	var obj = {a:1};
  	var copy = Object.assign({},obj);
  	console.log(copy);
  	*/
  	/*
  	 * 合并对象
  	
  	var o1 = {a:1};
  	var o2 = {b:2};
  	var o3 = {c:3};
  	
  	var obj = Object.assign(o1,o2,o3);
  	console.log(obj);
  	console.log(o1);
  	 */
  	/*
  	 * 复制属性
  	 
  	var o1 = {a:1};
  	var o2 = {No:2};
  	
  	var obj = Object.assign({},o1,o2);
  	console.log(obj);
  	*/
  	/*
  	 * 继承属性和不可数属性不能被复制
  	 */
  	var obj = Object.create({myfoo:1},{//foo是一个可继承属性
  		bar:{
  			value:2,//bar是一个不可
  			enumerable:true//
  		},
  		baz:{
  			value:3,
  			enumerable:true//
  		}
  	});
    //var copy = Object.assign({},obj);
  	 console.log(obj);
  	 
  },
  
  render: function() {
  	this._text();
    return (
      <View style={styles.container}>
       
      </View>
    );
  }
});

var styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    marginLeft: 20,
    marginRight: 20,
  },
  textStyle: {
    color: 'white'
  },
  textStyle6: {
    color: '#8e44ad',
    fontFamily: 'Avenir',
    fontWeight: 'bold'
  },
  buttonStyle: {
    borderColor: '#f39c12',
    backgroundColor: '#f1c40f'
  },
  buttonStyle1: {
    borderColor: '#d35400',
    backgroundColor: '#e98b39'
  },
  buttonStyle2: {
    borderColor: '#c0392b',
    backgroundColor: '#e74c3c'
  },
  buttonStyle3: {
    borderColor: '#16a085',
    backgroundColor: '#1abc9c'
  },
  buttonStyle4: {
    borderColor: '#27ae60',
    backgroundColor: '#2ecc71'
  },
  buttonStyle5: {
    borderColor: '#2980b9',
    backgroundColor: '#3498db'
  },
  buttonStyle6: {
    borderColor: '#8e44ad',
    backgroundColor: '#9b59b6'
  },
  buttonStyle7: {
    borderColor: '#8e44ad',
    backgroundColor: 'white',
    borderRadius: 0,
    borderWidth: 3,
  }
});

AppRegistry.registerComponent('ButtonDemo', () => ButtonDemo);

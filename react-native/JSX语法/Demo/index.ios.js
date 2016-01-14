/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

var React = require('react-native');
var JSX = require('./jsx.js');
var {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  TouchableWithoutFeedback,
} = React;

var Demo = React.createClass({
  render: function() {
  	/*
  	 * JSX 的新特性 - 延展属性：
  	 */
  	var props={};
  	props.width = 300;
  	props.height = 300;
  	props.backgroundColor = 'red';
  	
  	var myDivElement = <div className='foo' />;
  	
    return (
      <View style={styles.container}>
        <JSX {...props} ref='JSX'>{/*这个 ... 操作符（也被叫做延展操作符 － spread operator）已经被 ES6 数组 支持
        	* 如果再想添加属性{value:10,...props}
        	* */}
          <TouchableWithoutFeedback onPress={this.hide}>
           <View style={{width:100,height:100,backgroundColor:'blue'}}/>
           </TouchableWithoutFeedback>
        </JSX>
      </View>
    );
 },
 hide(){
    	this.refs.JSX.hide();
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

AppRegistry.registerComponent('Demo', () => Demo);

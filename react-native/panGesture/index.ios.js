/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

var React = require('react-native');
var SubComponent = require('./subComponent');
var {
  AppRegistry,
  StyleSheet,
  Text,
  View,
} = React;
var subComponent =  <SubComponent style={{backgroundColor:'red',flex:1,width:100,height:100}}/>;
var panGesture = React.createClass({
    
	render:function(){
		subComponent.onPanBegin
		return (<View style={{backgroundColor:'black',flex:1}}>
		           {subComponent}
		        </View>
		);
	}
})

AppRegistry.registerComponent('panGesture', () => panGesture);

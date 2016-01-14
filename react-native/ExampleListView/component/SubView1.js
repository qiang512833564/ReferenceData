'use strict';

var React = require('react-native');
var {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  TouchableHighlight,
} = React;
var subComponent = React.createClass({
	render:function(){
		//return  onClick={this.handleClick} {this.props.name}; 
		return(
			<TouchableHighlight onPress={this.handleClick.bind(this,'info')}>
			<Text>{this.props.name}</Text>
			</TouchableHighlight>
		);
	},
	
	handleClick: function() {  
	   console.log('大大大大大大');
       this.props.onPress(this.props.name);  
    } ,
});
var styles = StyleSheet.create({
	
});
module.exports = subComponent;
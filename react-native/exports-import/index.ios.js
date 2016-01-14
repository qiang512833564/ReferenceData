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
/*
 * 引入
 */
var Cude = require('./src/test1');
var {
	cude,
	foo,
} = Cude;
console.log(cude(3));
console.log(foo);
/*
 * 
 */
var Test = require('./src/test2')
var ButtonDemo = React.createClass({
  render: function() {
    return (
      <View style={styles.container}>
       <Test />
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
 
});

AppRegistry.registerComponent('ButtonDemo', () => ButtonDemo);

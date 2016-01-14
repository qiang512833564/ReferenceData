/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

var React = require('react-native');
var Index = require('./pages/Index');

var {
  NavigatorIOS,
  AppRegistry,
  StyleSheet,
} = React;

var helloWord = React.createClass({
  render: function() {
    return (
      <NavigatorIOS
        style={styles.container}
        initialRoute={{
          title: '首页',
          component: Index,
        }}
        />
    );
  }
});

var styles = StyleSheet.create({
  container: {
    flex: 1,
  }
});

AppRegistry.registerComponent('helloWord', () => helloWord);

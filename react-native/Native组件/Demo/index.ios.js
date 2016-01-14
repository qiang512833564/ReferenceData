/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

var React = require('react-native');
var Map = require('./map.js');
var {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  MapView
} = React;

var Demo = React.createClass({
  render: function() {
    return (// pitchEnabled={false} 
      <View style={styles.container}>
        <Map style={{width:200,height:200,backgroundColor:'red'}} zoomEnabled={false}/>{/*backgroundColor:'red'*/}
      </View>
    );
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

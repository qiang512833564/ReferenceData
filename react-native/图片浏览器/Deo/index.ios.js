/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

var React = require('react-native');
var Sub = require('./component');
var {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  Image,
  ScrollView,
} = React;

var Deo = React.createClass({
  render: function() {
    return (
    	
      <View style={styles.container}>
        
        <Sub >
        
        <Image style={{flex:1,height:200,backgroundColor:'red'}} 
            resizeMode="contain"
            source={{
          	uri:'http://www.yayomg.com/wp-content/uploads/2014/04/yayomg-pig-wearing-party-hat.jpg'}}/>
        </Sub>
      </View>
    );
  }
});

var styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#F5FCFF',
    paddingTop:400,
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

AppRegistry.registerComponent('Deo', () => Deo);

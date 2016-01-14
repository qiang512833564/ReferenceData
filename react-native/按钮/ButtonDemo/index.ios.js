/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

var React = require('react-native');
var Button = require('react-native-icon-button');
var {
  AppRegistry,
  StyleSheet,
  Text,
  View,
} = React;

var ButtonDemo = React.createClass({

  action: function() {
    //Do stuff! :)
  },
  render: function() {
    return (
      <View style={styles.container}>
        <Button 
          style={styles.button}
          onPress={this.action}
          icon={require('image!my_icon')}
          iconSize={20}
          color={"white"}
          text={"Press me!"}
        />
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

AppRegistry.registerComponent('ButtonDemo', () => ButtonDemo);

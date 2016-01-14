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
  TouchableHighlight,
} = React;
//

var Test = React.createClass({
  onHungry:function(name){
  	//console.log(name);
  	alert(name+'is hungry');
  },
  render: function() {
    return (
      <View style={styles.container}>
        <SubComponent name="名字" onPress ={this.onHungry}/>
        <Text style={{width:100,height:30,color:'red'}}>button</Text>
        
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

AppRegistry.registerComponent('Test', () => Test);

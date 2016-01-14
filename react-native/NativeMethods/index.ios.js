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
  AlertIOS,
  TouchableOpacity,
} = React;
var SubComponent = React.createClass({
	render:function(){
		return (
			<TouchableOpacity onPress={this.action.bind(this)}>
			<View style={{width:100,height:100,backgroundColor:'red'}} ref={(component)=>{this._root=component}}>
			</View>
			</TouchableOpacity>
		);
	},
	action:function(){
  	// this._root.setNativeProps();
  	this._root.measure((ox,oy,width,height,px,py)=>{
  		
  		 // AlertIOS.alert(
           // 'Foo Title',
            // 'My Alert Msg',
            // [
              // {text: width, onPress: () => console.log('Foo Pressed!')},
              // {text: height, onPress: () => console.log('Bar Pressed!')},
              // {text: px, onPress: () => console.log('Bar Pressed!')},
              // {text: py, onPress: () => console.log('Bar Pressed!')},
            // ]
          )
  	});
  }
});
var NativeMethods = React.createClass({
  render: function() {
    return (
      <View style={styles.container}>
        
         <SubComponent />
        
      </View>
    );
  },
  
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

AppRegistry.registerComponent('NativeMethods', () => NativeMethods);

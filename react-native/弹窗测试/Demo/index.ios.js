/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

var React = require('react-native');
var Modal = require('react-native-fs-modal');
var Overlay = require('react-native-overlay');
var Button = require('react-native-icon-button');
var {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  TouchableHighlight,
} = React;
//return (里面是对象)-----{里面是结构体}


var Demo = React.createClass({
turnToView () {
  this.refs.modal._myShow();
},
hideModal () {
  this.refs.modal._myClose();
},
 getDefaultProps(): StateObject {
    return {
      isVisible: true
    }
  },
  render: function() {
    return (
    	// <Overlay isVisible={this.props.isVisible}></Overlay>
    	<View style={{backgroundColor:'white',flex:1}}>
    	<TouchableHighlight onPress={this.turnToView.bind(this)}>
    	    <View style={{backgroundColor:'black',width:100,height:20,margin:40}}>
    	    </View>
    	    
    	</TouchableHighlight>
      <Modal 
      ref={'modal'}
      duration={1000}
      tween={'easeOutElastic'}
      modalStyle={{borderRadius: 0}}
      hideStatusBar={true}
      >
      <Button 
          style={styles.button}
          onPress={this.hideModal}
          iconSize={20}
          color={"white"}
          text={"Press me!"}
        />
      </Modal>
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
  button: {
  	padding: 10,
  	borderRadius: 5,
  	width:100,
  	alignItems: 'center',
  	backgroundColor: '#272822',
  	color: 'white',
  	
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

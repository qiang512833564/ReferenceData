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
  Image,
  ScrollView,
  PanResponder,
} = React;

var Demo = React.createClass({
    componentWillMount: function() {
      this._panResponder = PanResponder.create({
        // Ask to be the responder:
        onStartShouldSetPanResponder: (evt, gestureState) => true,
        onStartShouldSetPanResponderCapture: (evt, gestureState) => true,
        //下面这两个方法，返回值为true->是使手势不会往子组件进行传递
        onMoveShouldSetPanResponder: (evt, gestureState) => true,
        onMoveShouldSetPanResponderCapture: (evt, gestureState) => true,
 
        onPanResponderGrant: (evt, gestureState) => {
          // The guesture has started. Show visual feedback so the user knows
          // what is happening!
          // alert('start');
          // gestureState.{x,y}0 will be set to zero now
          //alert(gestureState.x0);x0----表示起始点距离屏幕左上角的x值,貌似moveX也是一样的
        },
        onPanResponderMove: (evt, gestureState) => {
          // The most recent move distance is gestureState.move{X,Y}
 //dx,dy是距离其实位置的x,y距离
          // The accumulated gesture distance since becoming responder is
          gestureState.dx = gestureState.dx-this.state.oldX;
          gestureState.dy = gestureState.dy-this.state.oldY;
          console.log(gestureState.dx);
          
          this.setState({
          	top:gestureState.dy+this.state.top,
          	left:gestureState.dx+this.state.left,
          	oldX:gestureState.dx,
          	oldY:gestureState.dy,
          });
        },
        onPanResponderTerminationRequest: (evt, gestureState) => true,
        onPanResponderRelease: (evt, gestureState) => {
          // The user has released all touches while this view is the
          // responder. This typically means a gesture has succeeded
        },
        onPanResponderTerminate: (evt, gestureState) => {
         // Another component has become the responder, so this gesture
          // should be cancelled
        },
        onShouldBlockNativeResponder: (evt, gestureState) => {
          // Returns whether this component should block native components from becoming the JS
          // responder. Returns true by default. Is currently only supported on android.
          return true;
        },
      });
    },
  getInitialState:function(){
  	return {
  		top:0,
  		left:0,
  		oldX:0,
  		oldY:0,
  	};
  },
  render: function() {
  	var {top,left}=this.state;
    return (
      <View style={styles.container} >
        <Image {...this._panResponder.panHandlers} style={{top:top,left:left,height:100,width:100,backgroundColor:'red',position:"absolute"}} source={{uri:'http://c.hiphotos.baidu.com/image/h%3D200/sign=7d7718f9bc99a90124355c362d940a58/359b033b5bb5c9ea7789c70ed139b6003bf3b3e1.jpg'}}/>
      </View>
    );
  }
});
/*
 * 
 */
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

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

var ButtonDemo = React.createClass({
  _test1:function(){
  	[0,1,2,3,4].reduce(function(previousValue,currentValue,currentIndex,array){
  		//console.log(previousValue,currentValue,currentIndex,array);//currentValue就是当前数组存放的元素值
  		/*
  		 *  0, 1, 1, [ 0, 1, 2, 3, 4 ]
            undefined, 2, 2, [ 0, 1, 2, 3, 4 ]
            undefined, 3, 3, [ 0, 1, 2, 3, 4 ]
            undefined, 4, 4, [ 0, 1, 2, 3, 4 ]
  		 */
  	});
  	var total = [0,1,2,3].reduce(function(a,b){
  		return a+b;
  	});
  	alert(total);
  },
  render: function() {
  	this._test1();
    return (
      <View style={styles.container}>
       
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

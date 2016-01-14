/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

var React = require('react-native');
var {NativeAppEventEmitter} = React;
var {
  AppRegistry,
  DatePickerIOS,
  StyleSheet,
  Text,
  View,
  DeviceEventEmitter,
} = React;

//这里相当于添加观察者
 var subscription = NativeAppEventEmitter.addListener(
 	'Demo',
 	(reminder)=>alert(reminder.name)
 );
 
 //subscription.remove();--这个是把事件移除，，，这句话一般写在组件挂载的情况下
 // Don't forget to unsubscribe, typically in componentWillUnmount

var CalendarManager = require('NativeModules').CalendarManager;//这里会相应的去调用OC里面的对象init方法
    CalendarManager.addEventWithName('Birthday Party', '4 Privet Drive, Surrey',new Date());
    //CalendarManager.addEventWithDateFromString("YYYY-MM-DD'T'HH:mm:ss.sssZ");
    CalendarManager.addEvent("myname",{
    	location:'北京',
    	time:'10:26',
    });
    //这里的RCTResponseSenderBlock回调block，是block函数的实现部分
    CalendarManager.findEvents((error,events)=>{
    	if(error){
    		console.error(error);
    	}else{
    		//this.setState({events:events});要想用到this，就必须把这行代码写在组件里面
    		console.log(events);
    	}
    });
    CalendarManager.doSomethingExpensive("param",()=>{
    	
    });
    //枚举调用
    CalendarManager.updateStatusBarAnimation(CalendarManager.statusBarAnimationFade,()=>{
    	
    });
    CalendarManager.addEventDelay(0.5);

var Demo = React.createClass({
  getInitialState:function(){
  	return {
  		date: new Date(),
  	};
  },
  render: function() {
  	console.log(CalendarManager.firstDayOfTheWeek);
  	
  	
  	//alert(this.state.date);
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

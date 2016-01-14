'use strict';

var React = require('react-native');
var {
  StyleSheet,
  Text,
  View,
  Image,
} = React;

var Swiper = require('react-native-swiper');
var Dimensions = require('Dimensions');
var TimerMixin = require('react-timer-mixin');
var { width, height, scale } = Dimensions.get('window');
var _uniqueId = 1;
 var   mylog = function mylog(){
  	console.log('输出语句');
 };
// 类别分组
var Types = React.createClass({
  
  mixins:[TimerMixin],
	//貌似系统的方法才这样写function componentDidMount
	//()=>{ console.log('I do not leak!\n') },貌似是简写的方法{里面是执行语句}
	//定时器的时间是以毫秒为单位的
	//定时器的开始与结束，都调用对方，这样可以实现循环
  // scheduleBegin:function(){
  	// this.setTimeout(
  		// function () {console.log('I do not leak!\n'),this.scheduleEnd()},
  		// 500
  	// );
  // },
  // scheduleEnd (){
  	// this.setTimeout(
  		// function(){console.log('I do not leak!\n',new Date()),this.scheduleBegin()},
  		// 1000
  	// );
  // },
  // Props:{
  	// myValue:100
  // },
   getDefaultProps: function() {
    return {
      value: 'default value'
    };
   },
  
  getInitialState() {
    return { all: [
        {icon: 'http://d.hiphotos.baidu.com/image/h%3D360/sign=9619182147166d222777139276210945/5882b2b7d0a20cf4f24f613572094b36adaf9979.jpg'},
        {icon: 'http://a.hiphotos.baidu.com/image/h%3D360/sign=0b1876b88f1001e9513c1209880f7b06/a71ea8d3fd1f41343fde3a2f271f95cad0c85ef1.jpg'},
      ]
    }
  },
  render() {
  	//this.scheduleBegin();
    var all = this.state.all.map(function(item){
          return (
          <View style={styles.item}>
            <Image 
  		    style={{flex:1,width:width,height:167,backgroundColor:'red'}}
  		    source={{uri:item.icon}}
  		    />
          </View>)
      });

    return (
      <Swiper height="167" index="0" width={width}  showsHorizontalScrollIndicator={true} pagingEnabled={true} showsButtons={true} autoplay={true} 
             autoplayTimeout = "1" 
      >
        {all}
      </Swiper>
    )
  }
})

var styles = StyleSheet.create({
  flex: {flexDirection: 'row'},
  row: {marginBottom: 6, backgroundColor: '#fff'},
  block: {flex: 1, padding: 5},
  item: {flex: 1, alignItems: 'center', padding: 5,backgroundColor:'green'},
  icon: {justifyContent: 'center', width: 50, height: 50},
});

module.exports = Types;

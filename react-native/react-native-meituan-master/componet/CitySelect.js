'use strict';

var React = require('react-native');
var {
  StyleSheet,
  Text,
  View,
  TouchableOpacity,
  AnimationExperimental,
} = React;

var Icon = require('FAKIconImage');

// 搜索栏
var CitySelect = React.createClass({

  animationView:function(){
  	return (
  		<View style={styles.animation}>
  		</View>
  	);
  },
  handleClick: function() {  
	   console.log('大大大大大大');
       this.props.onPress();  
    } ,
  
  render() {
  	var title = "深圳南山区";
    return (
    	////点击时间的背景色与透明度
     <TouchableOpacity onPress={this.handleClick.bind(this)} style={{activeOpacity:1}}>
      <View style={[styles.flex, {paddingBottom: 10}]}>
        <Text style={{color: '#fff', paddingRight: 3, paddingLeft: 3, fontWeight: 'bold'}}>{title}</Text>
        <Icon
          name='fontawesome|chevron-down'
          size={13}
          color='#fff'
          style={{height: 13, width: 13}}
        />
        {this.animationView}
      </View>
      </TouchableOpacity>
    )
  }
})

var styles = StyleSheet.create({
  flex: {flexDirection: 'row' },
  row: {marginBottom: 6, backgroundColor: '#fff'},
  block: {flex: 1, padding: 5},
  item: {flex: 1, alignItems: 'center', padding: 5},
  icon: {justifyContent: 'center', color: "#900", width: 50, height: 50},
  animation:{height:200,backgroundColor:'red'},
});

module.exports = CitySelect;

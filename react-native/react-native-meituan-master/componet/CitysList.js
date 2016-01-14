'use strict';
var React = require('react-native');
var tweenState = require('react-tween-state');
var {
  StyleSheet,
  Text,
  View,
  TouchableHighlight,
  LayoutAnimation,
  Animated,
  TouchableWithoutFeedback,
  ListView,

} = React;
var endvalue =0;
var  CityLists = React.createClass({
   mixins: [tweenState.Mixin],
   // transform:[{translateY:}]}}>
   animatedAction(){
   	//alert('animation');
   	this.tweenState('top', {
      easing: tweenState.easingTypes.easeInOutQuad,
      duration: 500,
      endValue: this.state.top === -120 ? 0 : -120
    });
   },
   componentWillMount:function(){
   	var data = ['','',,'','','','','','','','','','','',,'','','','','','','','',''];
   	this.setState({
      dataSource: this.state.dataSource.cloneWithRows(data)
    });
   },
   componentWillReceiveProps(nextProps) {//在接收到新的props参数时调用，如果用其他的更新方法调用，就会陷入死循环
   	//alert(this.props.animated);
   	this.animatedAction();
   },
   getInitialState: function() {
   	var ds = new ListView.DataSource({
        rowHasChanged: (r1, r2) => r1 !== r2});
  	// var rows = makeSequence(100).map((n) => ({text: 'not refreshed '+n}))
    return {top: -120,dataSource: ds};
  },
  renderRow:function(person){
  	return (<Text>text</Text>);
  },
	render(){
		if(this.props.animated&&endvalue===0)
		{
			//alert('animated');
			//
			endvalue = 1;		
		}
		
		return (//onPress={this.animatedAction}
			<TouchableWithoutFeedback >
		<View style={{backgroundColor:'red',
  	                  width:88,
  	                  height:120,
  	                  top:this.getTweeningValue('top'),
  	                  opacity:1-((-1*this.getTweeningValue('top'))/120),
  	                  }}>
   			  <ListView
        dataSource={this.state.dataSource}
        renderRow={this.renderRow}
      />
			</View>
	    </TouchableWithoutFeedback>
	    );	     	
	}
});
var styles = StyleSheet.create({
	listStyle:{
  	
  },
});
module.exports = CityLists;
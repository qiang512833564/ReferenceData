var React = require('react-native');
var tweenState = require('react-tween-state');
var {
	View,
	Text,
	StyleSheet,
	Image,
}=React;
var AnimatedView = React.createClass({
	mixins:[tweenState.Mixin],
	getInitialState(){
		return {rotating:0};
	},
	_animateRotating() {
    this.tweenState('rotating', {
      easing: tweenState.easingTypes.linear,
      duration: 3500,
      beginValue:0,
      endValue: 360,
      });
    },
    
    componentWillMount(){
    	// alert('nodte');
    	this._animateRotating();
    },
    componentWillReceiveProps(nextProps){
    	//alert('nodte');
    	//alert(this.getTweeningValue('rotating'));
    	this._animateRotating();
    },
	render:function(){
		var string = new String(this.getTweeningValue('rotating'));
		var center = {
		backgroundColor:'black',
		width:250,
		height:250,
		marginBottom:180,
		borderRadius:250/2.0,
		borderWidth:8,
		borderColor:'#ded8d3',
		transform:[{rotate:string+'deg'}]
		//top:this.getTweeningValue('rotating')
        };
		return (<Image style={center}  
        source={{uri:'http://a.hiphotos.baidu.com/image/pic/item/4bed2e738bd4b31c57419f5183d6277f9f2ff8df.jpg'}}/>);
	}
})
module.exports = AnimatedView;

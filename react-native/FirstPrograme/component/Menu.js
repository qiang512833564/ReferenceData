var React = require('react-native');

var Dimensions = require('Dimensions');
var { width, height, scale } = Dimensions.get('window');//应该是获取屏幕的宽，高，比例

var PersonView = require('./menu/Person');
var RadioView = require('./menu/Radio');
var LoginView = require('./menu/Login');
var ExitView = require('./menu/Exit');

var tweenState = require('react-tween-state');
var {
	View,
	Text,
	StyleSheet,
} = React;
var Menu = React.createClass({
	mixins :[tweenState.Mixin],
	_animatedTransform(){//this.state.x === 0? 120: 0
		this.tweenState('x',{
			easing: tweenState.easingTypes.easeOutQuad,
			duration:500,
			endValue:this.state.x === 0? -100: 0,
		});
	},
	componentWillMount(){
		//alert('componentDidMount'+this.state.x);
		//this._animatedTransform();
	},//componentWillReceiveProps
	componentWillReceiveProps(nextProps){
		this._animatedTransform();
	},
	getInitialState:function(){
		return {
			x : 0,
		};
	},
	render(){
		
		var container = {
		width : 100,
		height : height,
		left : width,
		top:0,
		position:'absolute',
		backgroundColor:'white',
		opacity:0.5,
		transform:[{translateX:this.getTweeningValue('x')}],
	};
		return (<View style={container}>
			      <PersonView isShowing={this.props.isShowing}/>
			      <RadioView isShowing={this.props.isShowing}/>
			      <LoginView isShowing={this.props.isShowing}/>
			      <ExitView isShowing={this.props.isShowing}/>
			    </View>);
	}
})
var styles = StyleSheet.create({
	
});
module.exports = Menu;
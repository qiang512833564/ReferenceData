var React = require('react-native');
var tweenState = require('react-tween-state');
var {
	Image,
	Text,
	View,
	StyleSheet,
	TouchableOpacity,
}=React;
//style={styles.menuIcon} source={require('image!menuIcon')
var scale = 0.7;

var Button = React.createClass({
	mixins:[tweenState.Mixin],
	_onPressButton(){
	
		 this._animatedX();
		 
		    
	    	this.props.onPress();
	},
	getInitialState:function(){
		return {
			x:0,
		};
	},
	componentWillReceiveProps(newProps){
		this._animatedX();
	},
	_animatedX(){
		this.tweenState('x',{
			easing: tweenState.easingTypes.easeOutQuad,
			duration:500,
			endValue:this.state.x === 0? -100: 0,
		})
	},
	componentWillMount(){
		 
	},
	render:function(){
        
		var container = {
		 // position: 'absolute',
		 flex:1,
		 //resizeMode:'contain',//背景居中适应未拉伸但是被截断也就是cover
		                      //contain 模式容器完全容纳图片，图片自适应宽高
		                      //stretch模式图片被拉伸适应屏幕
		 width:this.props.width,
		 height:this.props.height,
		// backgroundColor:'blue',
		transform:[{translateX:this.getTweeningValue('x')}],
	    }; 
	    this.props.text = 'text';
	    var height = null;
	    if(this.props.text)
	    {
	    	scale = 0.7;
	    }
	    else
	    {
	    	scale = 1;
	    }
	    var image = {
	    	width:this.props.width,
	    	height:this.props.height*scale,
	    	
	    }; 
	    var text = {
	    	width:this.props.width,
	    	height:this.props.height*(1-scale),
	    	textAlign:'center',
	    }; // 
	    
	    var name = this.props.image;
	    //alert(name);
		return (
			
			<TouchableOpacity onPress={this._onPressButton} style={{position: 'absolute',}}>
			<View style={container}>
			      <Image style={image} source={require('image!menuIcon')} />
			      <Text style={text}>text</Text>
			    </View>
			 </TouchableOpacity>
			    );
	}
})
var styles = StyleSheet.create({
	// image:{
		// height
	// },
	
});
module.exports = Button;

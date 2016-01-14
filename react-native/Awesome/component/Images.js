var React=require('react-native');
var tweenState=require('react-tween-state');
var Easing = require('Easing');
var TimerMixin=require('react-timer-mixin');
var MyImage=require('./image');
var Dimensions=require('Dimensions');
var {width, height} = Dimensions.get('window');
var Lightbox = require('react-native-lightbox');
var AudioPlayer = require('react-native-audio-player');
AudioPlayer.play('music');
var {
	View,
	Image,
	Text,
	StyleSheet,
	Animated,
	TouchableWithoutFeedback,
	PropTypes,
	PixelRatio,
}=React;
const arrayObj=new Array();
const arrayTitls=new Array("呆呆的你","呆萌的你","清澈的你","淘气的你","懒虫的你","。。。。","懵懂的你","贪吃的你","开心的你","阳光的你","犹豫的你","胡思乱想的你","搞乱的你","逗比的你","美丽的你");
var text;
var component = React.createClass({
	mixins:[[tweenState.Mixin],TimerMixin],
	getInitialState(){
		return {
			positionX:new Animated.Value(0),
			num:0,
		
		};
	},
	propTypes:{
		onPress:PropTypes.func,
	},
	childrenViews:function(){
			arrayObj.splice(0,arrayObj.length);//移除所有元素
			for(var i=0; i<this.state.num; i++)
			{//,[{left:0,top:0}]
				//
				var position={
					
				};
				if(i!=this.state.num-1)
				{
					position={
						left:10+(i%3)*120,top:(parseInt(i/3))*120
					};
				}
				
				//transparent
				//arrayObj.push(<Text style={{color:'blue'}}>{parseInt(5/2)}+{(i%3)*120}+{(i/3)*120}</Text>);
				//丢弃小数部分,保留整数部分--resizeMode="contain"
				let string = 'p'+(i+1);
				let image=MyImage.getImage(string);
				arrayObj.push(//
					//<TouchableWithoutFeedback onPress={this.onPressAction.bind(this,'p'+(i+1))}>
					<View style={[{left:0,top:0,height:100,backgroundColor:'transparent',position:'absolute',width:100,},position]}>
					<Lightbox navigator={this.props.navigator}>
					<Image source={image} style={{flex:1,width:100,height:100}}  resizeMode="cover"/>
					</Lightbox>
					<Text style={{position:"absolute",top:80,left:0,width:100,height:20,color:'#779c2d',fontFamily:"华文彩云",fontSize:18,textAlign:"center"}}>{arrayTitls[i]}</Text>
					</View>
					//</TouchableWithoutFeedback>
					);
			}
	},
	onPressAction(string){
		this.props.onPress(string);
	},
	componentWillMount(){
		
	   this.timer=this.setInterval(()=>{
	   	
	   	this.state.positionX.setValue(0);
	   	
	   	Animated.timing(this.state.positionX,
			{
				toValue:(this.state.num%3)*120+10,
				duration:1000,
				//easing:Easing.inOut(Easing.ease),
			}).start(this.setState({num:this.state.num+1}));//需要启动动画
	   },1500);
	   
	},
	render(){
		
		var {num}=this.state;
		if(num>0)
		{
			num=num-1;
		}
		
		let {positionX}=this.state;
		
		this.childrenViews();
		let lastChildren = arrayObj.pop();
	
	    var top=positionX.interpolate({inputRange:[0,(num%3)*120+10],outputRange:[0,(parseInt(num/3))*120]});
	    //这里我理解top也就只是个指针，可以把它直接写在Animated.View的参数上。
	    if(parseInt(num/3)>0&&top==0)
	    {
	    	top=parseInt(num/3)*120; //这里这样子设值，也没用，因为此时positionX的动画位移，已不存在  	
	    }
	   if(num==14)
	   {
	   	  clearInterval(this.timer);
	   }
		return (//<View style={{flex:1,backgroundColor:'red'}}/>
			<View style={styles.container}>
			
			<Image source={{uri:"http://d.hiphotos.baidu.com/image/h%3D200/sign=912082f50d24ab18ff16e63705fbe69a/267f9e2f07082838dc76bbc7bc99a9014d08f1ee.jpg"}} resizeMode="cover" style={{flex:1,flexDirection:"row",}}>
			<View>
			{arrayObj}
			</View>
			<Animated.View style={{height:100,width:100,position:"absolute",left:this.state.positionX,top:top,backgroundColor:'transparent'}}>		
			{lastChildren}
			</Animated.View>
			</Image>
			</View>
			);
	}
});
var styles=StyleSheet.create({
	container:{
		margin:0,
		backgroundColor:"transparent",
		width:width,
		height:height+100,
		
	},
});
module.exports=component;
var React=require('react-native');
var ImageView=require('./Images.js');
var MyImage=require('./image');
var Lightbox = require('react-native-lightbox');
var {
	ScrollView,
	View,
	StyleSheet,
	Text,
	Image,
	Navigator,
}=React;
var LightboxView = React.createClass({
  render: function() {
    return (
      //resizeMode="contain"
         <ScrollView style={styles.container}>
           <ImageView navigator={this.props.navigator}/>
		</ScrollView>
      
    );
  },
});
var scrollView=React.createClass({
	getInitialState:function(){
		return {
			showingBigImage:false,
		};
	},
	onPressAction:function(string){
		text=string;
		this.setState({
			showingBigImage:(this.state.showingBigImage==false?true:false),
		});
	},
	renderScene:function(route,navigator){
		var Component=route.component;
		return (
			<Component navigator={navigator} route={route} {...route.passProps}/>
		);
	},
	/*
	 *
	 */
	render:function(){//<ImageView onPress={this.onPressAction.bind(this)}/>
		return (
			<Navigator 
			   ref="navigator"
			   style={styles.container}
			   renderScene={this.renderScene}
			   initialRoute={{component:LightboxView}}
			/>
			);
	}
});
var styles=StyleSheet.create({
	container:{
		flex:1,
	}
});
module.exports=scrollView;

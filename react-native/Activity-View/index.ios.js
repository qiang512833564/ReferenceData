/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

var React = require('react-native');
var ActionButton = require('react-native-action-button'),
    Icon = require('react-native-vector-icons/Ionicons');
var {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  TouchableOpacity,
  Component,
  Image,
} = React;
var MyButton = React.createClass({
	_action:function(){
		this.props.onPress()
	},
	render(){
		return (//
		<TouchableOpacity onPress={this._action}>
			<View style={butStyles.borderStyle}>
			   <Text>{this.props.text}</Text>
			</View>
		</TouchableOpacity>
		);
	},
	
});
var butStyles = StyleSheet.create({
		borderStyle : {
			width:100,
			height:40,
			backgroundColor:'yellow',
			borderRadius:5,
			alignItems:'center',//水平居中
			justifyContent:'center',//垂直居中
		},
});
class ButtonDemo extends Component{
  constructor(props){
  	super(props);
  }
  _pressAction(){
  	
  }
  render() {
    return (//// Rest of App come ABOVE the action button component!
       <View style={{flex:1, backgroundColor: '#f3f3f3'}}>
        <ActionButton buttonColor="rgba(231,76,60,1)">
          <ActionButton.Item buttonColor='#9b59b6' title="New Task" onPress={() => console.log("notes tapped!")}>
            <Image style={styles.icon} source={require('image!android-create')}/>
          </ActionButton.Item>
          <ActionButton.Item buttonColor='#3498db' title="Notifications" onPress={() => {}}>
            <Image style={styles.icon} source={require('image!android-notifications-none')}/>
          </ActionButton.Item>
          <ActionButton.Item buttonColor='#1abc9c' title="All Tasks" onPress={() => {}}>
            <Image style={styles.icon} source={require('image!android-done-all')}/>
          </ActionButton.Item>
        </ActionButton>
      </View>
    );
  }
}

var styles = StyleSheet.create({
  container: {
    flex: 1,
    justifyContent: 'center',
    alignItems: 'center',
    marginLeft: 20,
    marginRight: 20,
  },
  textStyle: {
    color: 'white'
  },
  actionButtonIcon: {
    fontSize: 20,
    height: 22,
    color: 'white',
  },
  icon: {
    width: 35,
    height: 35,
    borderRadius:45/2.0,
  },
 
});

AppRegistry.registerComponent('ButtonDemo', () => ButtonDemo);

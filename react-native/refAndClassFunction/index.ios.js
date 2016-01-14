/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

var React = require('react-native');
var Modal = require('./component/ref.js');
var TestClass = require('./component/class.js');

var {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  TouchableHighlight,
  ScrollView,
  Dimensions,
} = React;
var WINDOW_WIDTH = Dimensions.get('window').width;
var refAndClassFunction = React.createClass({

  onPressAction(){
  	//this.refs.modal.test();
  	this.refAlias.test();
  	this.canshu ="我是一个参数";//这样子是自定义属性
  	TestClass.showClass(this.canshu);
  },
  render: function() {//<TouchableHighlight onPress={this.onPressAction.bind(this)}></TouchableHighlight>
    return (//<Modal ref={'modal'}>这里添加了ref={'modal'}，可以在其他方法里访问到子节点即子组件
     <View style={styles.container}>
    	
     <ScrollView style={{backgroundColor:'white',flex:1,width:WINDOW_WIDTH,height:667,
                        }}>
        <Modal ref={component=>this.refAlias=component}>{/*<Modal ref={component=>this.refAlias=component}>这个貌似是取别名
                               ---可以用this.refAlias去调用该节点组件*/}
        </Modal>
        
      </ScrollView>
      
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

AppRegistry.registerComponent('refAndClassFunction', () => refAndClassFunction);

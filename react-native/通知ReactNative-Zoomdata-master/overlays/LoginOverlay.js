'use strict';

var React = require('react-native');
var Overlay = require('react-native-overlay');
var Dimensions = require('Dimensions');

var {
  AppRegistry,
  StyleSheet,
  Image,
  Text,
  TextInput,
  TouchableOpacity,
  View,
} = React;

var RNTAnimation = require('react-native-tween-animation');

var width = Dimensions.get('window').width;
var height = Dimensions.get('window').height;

var LoginOverlay = React.createClass({
  getDefaultProps(): StateObject {
    return {
      isVisible: false
    };
  },

  getInitialState: function() {
    return {
      top: 0
    };
  },

  render() {
    return (
      <Overlay isVisible={this.props.isVisible}>
        <View style={[{top: this.state.top}, styles.container]}>
          <Image source={require('image!loginBackground')} style={[{height: height, position: 'absolute', resizeMode: 'cover'}]}></Image>
          <View style={[{height: height, width: width, position: 'absolute', backgroundColor: '#323232', opacity: 0.9}]}></View>

          <Image style={styles.logo} source={require('image!loginLogo')} />
          <View style={[styles.textInputWrapperTop, styles.textInputWrapper]}>
            <TextInput style={[styles.usernameInput, styles.textInput]} placeholder="User Name" value="admin" placeholderTextColor="#939393" />
          </View>
          <View style={[styles.textInputWrapperBottom, styles.textInputWrapper]}>
            <TextInput style={styles.textInput} placeholder="Password" placeholderTextColor="#939393" password={true} value="Z00mda1a" />
          </View>
          <TouchableOpacity onPress={this._handlePress}>
            <View style={[{marginTop: 20}, styles.button]}>
                <Text style={[styles.buttonText]}>LOG IN</Text>
            </View>
          </TouchableOpacity>
        </View>
      </Overlay>
    )
  },

  _handlePress(event) {
    var hideAnimation = new RNTAnimation({
      start: {
        top: 0
      },

      end: {
        top: height
      },

      duration: 500,

      tween: 'easeOutBack',

      frame: (tweenFrame) => {
        this.setState(tweenFrame);
      },

      done: () => {
        this.props.updateLoginStatus(true);
      }
    });
    hideAnimation.start();
  },
});

var styles = StyleSheet.create({
  container: {
    flex: 1,
    height: height,
    alignItems: 'center'
  },
  logo: {
    marginTop: 80,
    marginBottom: 30,
    width: width - 95,
    height: 100
  },
  textInputWrapper: {
    height: 50,
    width: width - 55,
    backgroundColor: 'white',
    borderWidth: 2,
    borderColor: '#D2D2D2'
  },
  textInputWrapperTop: {
    borderTopLeftRadius: 12,
    borderTopRightRadius: 12,
    borderBottomLeftRadius: 0,
    borderBottomRightRadius: 0
  },
  textInputWrapperBottom: {
    borderTopLeftRadius: 0,
    borderTopRightRadius: 0,
    borderBottomLeftRadius: 12,
    borderBottomRightRadius: 12,
    borderTopColor: 'transparent'
  },
  textInput: {
    height: 50,
    width: width - 55,
    paddingLeft: 10,
    color: '#979797',
    justifyContent: 'center',
    alignSelf: 'center',
    backgroundColor: 'transparent',
    fontFamily: 'Arial'
  },
  button: {
    width: width - 55,
    height: 50,
    borderRadius: 12,
    backgroundColor: '#0095B6',
  },
  buttonText: {
    color: 'white',
    textAlign: 'center',
    alignSelf: 'center',
    fontSize: 18,
    top: 15,
    fontWeight: 'bold',
    fontFamily: 'Arial'
  },
  backgroundImage: {
    flex: 1,
    resizeMode: 'cover', // or 'stretch'
  }
});

module.exports = LoginOverlay;
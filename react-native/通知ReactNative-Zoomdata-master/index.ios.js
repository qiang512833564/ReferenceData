/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
'use strict';

var React = require('react-native');
var Router = require('react-native-router');

var VisualizationGridPage = require('./pages/VisualizationGridPage');

var {
  AppRegistry,
  StyleSheet,
  AlertIOS,
  PushNotificationIOS
} = React;

var ZoomdataMobileNative = React.createClass({
  componentWillMount() {
    PushNotificationIOS.addEventListener('notification', this._onNotification);
  },

  componentWillUnmount() {
    PushNotificationIOS.removeEventListener('notification', this._onNotification);
  },

  componentDidMount() {
  },

  render: function() {
    PushNotificationIOS.requestPermissions();

    return (
      <Router firstRoute={{
        name: 'Zoomdata Mobile',
        component: VisualizationGridPage
      }} headerStyle={{backgroundColor: '#323232'}} />
    );
  },

  _onNotification(notification) {
    AlertIOS.alert(
      'Notification Received',
      'Alert message: ' + notification.getMessage(),
      [{
        text: 'Dismiss',
        onPress: null,
      }]
    );
  }
});

AppRegistry.registerComponent('ZoomdataMobileNative', () => ZoomdataMobileNative);

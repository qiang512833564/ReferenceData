

'use strict';

var React = require('react-native');
var {
  StyleSheet,
  Text,
  View,
  Image,
  ListView,
  PixelRatio,
  NavigatorIOS,
  TouchableHighlight
  } = React;

var MessageView = require('./MessageView');

function prettyTime(timestamp) {
  var createdDate = new Date(timestamp);//根据毫秒，创建日期对象
  var distance = Math.round( ( +new Date() - timestamp ) / 60000 );//Math.round是初始化一个数学方法，
  //new Date是Date类型的，前面加上+可以转成毫秒
  //new Date().getTime()也是返回的毫秒
  //1s = 1000ms，，，这里除以60000代表每分钟
  var hours = ('0' + createdDate.getHours()).slice(-2);
  //slice()方法主要是拿来复制用的，可以传入1或者2个参数，如果传入两个，表示复制从第一个参数到第二个参数为止的数组项，但不包括最后一项；如果传入一个参数，则表示复制从该位置到数组结尾的数组项。
  //如果是负数，则该参数规定的是从字符串的尾部开始算起的位置。也就是说，-1 指字符串的最后一个字符，-2 指倒数第二个字符，以此类推。
  var minutes = ('0' + createdDate.getMinutes()).slice(-2);
  var month = ('0' + (createdDate.getMonth() + 1)).slice(-2);
  var date = ('0' + createdDate.getDate()).slice(-2);
  var year = createdDate.getFullYear();

  var string;
  if (distance < 1440) {
    string = [hours, minutes].join(':');
  } else if (distance < 2879) {
    string = 'Yesterday';
  } else {
    string = [date, month, year].join('/');
  }

  return string;
}

var messageList = React.createClass({
  componentWillMount: function() {
    fetch('http://localhost:8081/rest/messages.json')
      .then(res => res.json())
      .then(res => this.updateDataSource(res));
  },
  getInitialState: function() {
    return {
      dataSource: new ListView.DataSource({
        rowHasChanged: (r1, r2) => r1 !== r2
      })
    };
  },
  updateDataSource: function(data){
    this.setState({
      dataSource: this.state.dataSource.cloneWithRows(data)
    })
  },
  openChat: function (user){
    this.props.navigator.push({
      title: `${user.firstName} ${user.lastName}`,//'大头',设置导航栏上面的title
      component: MessageView,//push展示的组件
      passProps: { user }//传递的参数
    });
  },
  renderrows: function (person){
    var time = prettyTime(person.lastMessage.timestamp);
    return (
      <View>
        <TouchableHighlight onPress={ this.openChat.bind(this, person.user) }>
          <View>
            <View style={ styles.row }>
              <Image
                source={ { uri: person.user.picture } }
                style={ styles.cellImage }
                />
              <View style={ styles.textContainer }>
                <Text style={ styles.name } numberOfLines={ 1 }>
                  { person.user.firstName } { person.user.lastName }
                </Text>
                <Text style={ styles.time } numberOfLines={ 1 }>
                  { time }
                </Text>
                <Text style={ styles.lastMessage } numberOfLines={ 1 }>
                  { person.lastMessage.contents }
                </Text>
              </View>
            </View>
            <View style={ styles.cellBorder } />
          </View>
        </TouchableHighlight>
      </View>
    );
  },
  render: function(){
    return (
      <View style={ styles.container }>
        <ListView dataSource={ this.state.dataSource } renderRow={ this.renderrows } />
      </View>
    );
  }
});

var messagesTab = React.createClass({
  render: function() {
    return (
      <NavigatorIOS
        style={ styles.container }
        initialRoute={
          {
            title: 'Messages',
            component: messageList
          }
        }
        />
    );
  }
});

var styles = StyleSheet.create({
  container: {
    flex: 1,
    backgroundColor: '#fff'
  },
  row: {
    flex: 1,
    alignItems: 'center',
    backgroundColor: 'white',
    flexDirection: 'row',
    padding: 10
  },
  textContainer: {
    flex: 1
  },
  cellImage: {
    height: 60,
    borderRadius: 30,
    marginRight: 10,
    width: 60
  },
  time: {
    position: 'absolute',
    top: 0,
    right: 0,
    fontSize: 12,
    color: '#cccccc'
  },
  name: {
    flex: 1,
    fontSize: 16,
    fontWeight: 'bold',
    marginBottom: 2
  },
  lastMessage: {
    color: '#999999',
    fontSize: 12
  },
  cellBorder: {
    backgroundColor: '#F2F2F2',
    height: 1 / PixelRatio.get(),
    marginLeft: 4
  }
});

module.exports = messagesTab;
/*
 *iOS 导航器

iOS 导航器包装了 UIKit 导航，并且允许你添加跨应用程序的 back-swipe 功能。

路线

路线是用于描述导航器每个页面的一个对象。第一个提供给 NavigatorIOS 的路线是 initialRoute：

render: function() {
  return (
    <NavigatorIOS
      initialRoute={{
        component: MyView,
        title: 'My View Title',
        passProps: { myProp: 'foo' },
      }}
    />
  );
},
现在将由导航器呈现 MyView。它将在 route 道具，导航器及所有的 passProps 指定的道具中接受一个路线对象。

路线完整的定义请看 initialRoute propType。

导航器

Navigator 是视图能够调用的导航函数的一个对象。它作为一个道具会被传递给任何由 NavigatorIOS 呈现的组件。

var MyView = React.createClass({
  _handleBackButtonPress: function() {
    this.props.navigator.pop();
  },
  _handleNextButtonPress: function() {
    this.props.navigator.push(nextRoute);
  },
  ...
});
一个导航对象包含以下功能:

push(route)——导航到一个新的路线
pop()——返回一个页面
popN(n)——一次返回 N 页。当 N=1 时，该行为相当于 pop()
replace(route)——取代当前页面的路线，并立即为新路线加载视图
replacePrevious(route)——取代前一页的路线/视图
replacePreviousAndPop(route)——取代了以前的路线/视图并转换回去
resetTo(route)——取代顶级的项目并 popToTop
popToRoute(route)——为特定的路线对象回到项目
popToTop()——回到顶级项目
导航功能在 NavigatorIOS 组件中也是可用的：

var MyView = React.createClass({
  _handleNavigationRequest: function() {
    this.refs.nav.push(otherRoute);
  },
  render: () => (
    <NavigatorIOS
      ref="nav"
      initialRoute={...}
    />
  ),
});
Props
Edit on GitHub

initialRoute {组件：函数型，标题：字符串型，passProps：对象型，backButtonTitle：字符串型，rightButtonTitle：字符串型，onRightButtonPress：函数型，wrapperStyle：[对象型Object]}

NavigatorIOS 使用“路线”对象来识别子视图，道具，及导航栏的配置。“push”和所有其他的导航操作预计路线是这样的：

itemWrapperStyle View#style

默认的包为 navigator 中的组件设置样式。一个常见的用例是为每一页设置 backgroundColor

tintColor 字符串型

在导航栏中的按钮使用的颜色

例子
Edit on GitHub

'use strict';
var React = require('react-native');
var ViewExample = require('./ViewExample');
var createExamplePage = require('./createExamplePage');
var {
  PixelRatio,
  ScrollView,
  StyleSheet,
  Text,
  TouchableHighlight,
  View,
} = React;
var EmptyPage = React.createClass({
  render: function() {
    return (
      <View style={styles.emptyPage}>
        <Text style={styles.emptyPageText}>
          {this.props.text}
        </Text>
      </View>
    );
  },
});
var NavigatorIOSExample = React.createClass({
  statics: {
    title: '<NavigatorIOS>',
    description: 'iOS navigation capabilities',
  },
  render: function() {
    var recurseTitle = 'Recurse Navigation';
    if (!this.props.topExampleRoute) {
      recurseTitle += ' - more examples here';
    }
    return (
      <ScrollView style={styles.list}>
        <View style={styles.line}/>
        <View style={styles.group}>
          <View style={styles.row}>
            <Text style={styles.rowNote}>
              See &lt;UIExplorerApp&gt; for top-level usage.
            </Text>
          </View>
        </View>
        <View style={styles.line}/>
        <View style={styles.groupSpace}/>
        <View style={styles.line}/>
        <View style={styles.group}>
          {this._renderRow(recurseTitle, () => {
            this.props.navigator.push({
              title: NavigatorIOSExample.title,
              component: NavigatorIOSExample,
              backButtonTitle: 'Custom Back',
              passProps: {topExampleRoute: this.props.topExampleRoute || this.props.route},
            });
          })}
          {this._renderRow('Push View Example', () => {
            this.props.navigator.push({
              title: 'Very Long Custom View Example Title',
              component: createExamplePage(null, ViewExample),
            });
          })}
          {this._renderRow('Custom Right Button', () => {
            this.props.navigator.push({
              title: NavigatorIOSExample.title,
              component: EmptyPage,
              rightButtonTitle: 'Cancel',
              onRightButtonPress: () => this.props.navigator.pop(),
              passProps: {
                text: 'This page has a right button in the nav bar',
              }
            });
          })}
          {this._renderRow('Pop', () => {
            this.props.navigator.pop();
          })}
          {this._renderRow('Pop to top', () => {
            this.props.navigator.popToTop();
          })}
          {this._renderRow('Replace here', () => {
            var prevRoute = this.props.route;
            this.props.navigator.replace({
              title: 'New Navigation',
              component: EmptyPage,
              rightButtonTitle: 'Undo',
              onRightButtonPress: () => this.props.navigator.replace(prevRoute),
              passProps: {
                text: 'The component is replaced, but there is currently no ' +
                  'way to change the right button or title of the current route',
              }
            });
          })}
          {this._renderReplacePrevious()}
          {this._renderReplacePreviousAndPop()}
          {this._renderPopToTopNavExample()}
        </View>
        <View style={styles.line}/>
      </ScrollView>
    );
  },
  _renderPopToTopNavExample: function() {
    if (!this.props.topExampleRoute) {
      return null;
    }
    return this._renderRow('Pop to top NavigatorIOSExample', () => {
      this.props.navigator.popToRoute(this.props.topExampleRoute);
    });
  },
  _renderReplacePrevious: function() {
    if (!this.props.topExampleRoute) {
      // this is to avoid replacing the UIExplorerList at the top of the stack
      return null;
    }
    return this._renderRow('Replace previous', () => {
      this.props.navigator.replacePrevious({
        title: 'Replaced',
        component: EmptyPage,
        passProps: {
          text: 'This is a replaced "previous" page',
        },
        wrapperStyle: styles.customWrapperStyle,
      });
    });
  },
  _renderReplacePreviousAndPop: function() {
    if (!this.props.topExampleRoute) {
      // this is to avoid replacing the UIExplorerList at the top of the stack
      return null;
    }
    return this._renderRow('Replace previous and pop', () => {
      this.props.navigator.replacePreviousAndPop({
        title: 'Replaced and Popped',
        component: EmptyPage,
        passProps: {
          text: 'This is a replaced "previous" page',
        },
        wrapperStyle: styles.customWrapperStyle,
      });
    });
  },
  _renderRow: function(title: string, onPress: Function) {
    return (
      <View>
        <TouchableHighlight onPress={onPress}>
          <View style={styles.row}>
            <Text style={styles.rowText}>
              {title}
            </Text>
          </View>
        </TouchableHighlight>
        <View style={styles.separator} />
      </View>
    );
  },
});
var styles = StyleSheet.create({
  customWrapperStyle: {
    backgroundColor: '#bbdddd',
  },
  emptyPage: {
    flex: 1,
    paddingTop: 64,
  },
  emptyPageText: {
    margin: 10,
  },
  list: {
    backgroundColor: '#eeeeee',
    marginTop: 10,
  },
  group: {
    backgroundColor: 'white',
  },
  groupSpace: {
    height: 15,
  },
  line: {
    backgroundColor: '#bbbbbb',
    height: 1 / PixelRatio.get(),
  },
  row: {
    backgroundColor: 'white',
    justifyContent: 'center',
    paddingHorizontal: 15,
    paddingVertical: 15,
  },
  separator: {
    height: 1 / PixelRatio.get(),
    backgroundColor: '#bbbbbb',
    marginLeft: 15,
  },
  rowNote: {
    fontSize: 17,
  },
  rowText: {
    fontSize: 17,
    fontWeight: '500',
  },
});
module.exports = NavigatorIOSExample;
 */
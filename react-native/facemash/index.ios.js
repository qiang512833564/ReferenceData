/**
 * Sample React Native App
 * https://github.com/facebook/react-native
 */
//个人总结：（）后面基本都加；
//一句：<View></View>
//<View />首字母都应该大写
/*
 * 在使用 React 开发中，可以仅使用 ReactElement 实例，但是，要充分利用 React，就要使用 ReactComponent 来封装状态化的组件。

一个 ReactComponent 类就是一个简单的 JavaScript 类（或者说是“构造函数”）。

所有 React component 都可以采用自闭和的形式：<div />. <div></div> 它们是等价的。
 */
'use strict';

var React = require('react-native');

var {
  AppRegistry,
  StyleSheet,
  Text,
  View,
  TabBarIOS,
  StatusBarIOS
} = React;
var FacemashTab = require('./componet/FaceMash');//这里的FacemashTab命名最好要与类名保持一致
var MessagesTab = require('./componet/Messages');
var facemash = React.createClass({
  getInitialState() {
    return {
      selectedTab: 'messages'//设置tabBar默认选中的item
    }
  },
  changeTabbarItem(tabName){
  	StatusBarIOS.setStyle(tabName == 'faceMash'?1:0);//设置为1（白色），设置为0(黑色).
  	this.setState({
  		selectedTab:tabName
  	});
  },
  render: function() {
    return (
      <TabBarIOS>
        <TabBarIOS.Item
        //每个<TabBarIOS.Item默认就生成了一个属于自己的子视图，然后我们所需要进行的操作，就是往里面加控件和视图
          title="FaceMash"//出现在图标下的文本。当定义了系统图标时，它会被忽略。
          icon={ require('image!facemash') }//为了在 React Native 中引入本地的图片资源，你可以使用 require 后面带上图片的资源名称！
          onPress={()=>this.changeTabbarItem('faceMash')}//当标记被选中时，该函数回调，你应该改变组件的状态来设置 selected={true}
          //selectedIcon--当标记被选中时，自定义的图标。当定义了系统图标时，它会被忽略。如果为空，那么图标会呈现蓝色。
          /*systemIcon 枚举（'bookmarks'，'contacts'，'downloads'，'favorites'，'featured'，'history'，'more'，'most-recent'，'most-viewed'，'recents'，'search'，'top-rated'） 
           项目有一些预定义的系统图标。请注意如果你正在使用它们，标题和选中的图标将被系统图标覆盖。
           */
          //下一行目前加备注报错
          ////理解：this.state会调用getInitialState方法
          selected={ this.state.selectedTab === 'faceMash' }>
          <FacemashTab />
        </TabBarIOS.Item>
        <TabBarIOS.Item
          title="Messages"
          icon={ require('image!messages') }
          onPress={()=>this.changeTabbarItem('messages')}
          selected={ this.state.selectedTab === 'messages' }>
          <MessagesTab />
        </TabBarIOS.Item>
        <TabBarIOS.Item
          title="Settings"
          icon={ require('image!settings') }
          onPress={()=>this.changeTabbarItem('settings')}
          selected={ this.state.selectedTab === 'settings' }>
          <View style={ styles.itemView }>
            <Text>Settings</Text>
          </View>
        </TabBarIOS.Item>
      </TabBarIOS>
    );
  }
});
var styles = StyleSheet.create({
  itemView: {
    backgroundColor: '#fff',
    flex: 1
  }
});
AppRegistry.registerComponent('facemash', () => facemash);

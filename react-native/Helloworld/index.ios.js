
'use strict';
var React = require('react-native');
var {  
  AppRegistry,  
  StyleSheet,  
  View,  
  TextInput,  
} = React; 
class SearchBar extends React.Component {  
  render() {  
    return (  
      <View style={styles.searchRow}>  
          <TextInput  
            autoCapitalize="none"  
            autoCorrect={false}  
            clearButtonMode="always"  
            placeholder="Please input your name..."  
            style={styles.searchTextInput}  
          />  
        </View>  
      );  
  }  
}  
class Helloworld extends React.Component {  
  render() {  
    return (  
      <React.NavigatorIOS  
        style={styles.container}  
        initialRoute={{  
          title: 'My App',  
          component: SearchBar,  
        }}/>  
    );  
  }  
}  
var styles = React.StyleSheet.create(
{
  container: {  
    flex: 1  
  },  
  searchRow: {  
    backgroundColor: '#eeeeee',  
    paddingTop: 75,  
    paddingLeft: 10,  
    paddingRight: 10,  
    paddingBottom: 10,  
  },  
  searchTextInput: {  
    backgroundColor: 'white',  
    borderColor: '#cccccc',  
    borderRadius: 3,  
    borderWidth: 1,  
    height: 30,  
    paddingLeft: 8,  
  }, 
}
);
// class Helloworld extends React.Component {//这里的Helloworld要与app名字一样
  // render() {
// /*
   // return(<React.NavigatorIOS style={styles.container}>initialRoute={{
          // title: 'Property Finder',
          // component: Helloworld,
        // }}/>
    // );
// */
// 
    // return <React.Text style={styles.text}>Hello World (Again)</React.Text>;
// /*
// 这是 JSX ，或 JavaScript 语法扩展,它直接在你的 JavaScript 代码中混合了类似 HTML 的语法;如果你是一个 web 开发人员,应该对此不陌生。在本篇文章中你将一直使用 JSX 。
// */    
  // //return React.createElement(React.Text, {style: styles.text}, "Hello World!");
  // }
// 
// }
React.AppRegistry.registerComponent('Helloworld', function() { return Helloworld });
//这里的两个Helloworld要与app名字一样
/*
把你的改动保存到 index.ios.js 中，并返回到模拟器。按下 Cmd + R ,你将看到你的应用程序刷新,并显示更新的消息 “Hello World(again)”。

重新运行一个 React Native 应用程序像刷新 web 浏览器一样简单!:]

因为你会使用相同的一系列 JavaScript 文件,您可以让应用程序一直运行,只在更改和保存 PropertyFinderApp.js 后刷新即可
*/
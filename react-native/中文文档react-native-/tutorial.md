# 教程

## 前言

本教程的目的是让你利用 React Native 快速编写 iOS 应用程序。如果你想知道 React Native 是什么,为什么 Facebook 建立它，[这篇博客](https://code.facebook.com/posts/1014532261909640/react-native-bringing-modern-web-techniques-to-mobile/)解释了这个问题。

我们假设您有使用 React 编写网站的经验。如果没有，你可以在 [React 网站](http://facebook.github.io/react/)上了解它。

## 设置

React Native 需要 OSX，Xcode，Homebrew，node，npm 和 [watchman](https://facebook.github.io/watchman/docs/install.html)。[Flow](https://github.com/facebook/flow) 是可选的。

在安装这些依赖项之后，有两个简单的命令来获取开发所需的 React Native 项目的全部设置。

1. `npm install -g react-native-cli` 

	react-native-cli 是一个命令行接口，做设置之余的工作。它通过 npm 安装。这将在您的终端作为命令安装 `react-native`。这项工作你只需要做一次。 

2. `react-native init AwesomeProject`

	这个命令获取 React Native 源代码和依赖项，然后在 `AwesomeProject/AwesomeProject.xcodeproj` 上创建一个新的 Xcode 项目。 


## 发展

你现在可以在 Xcode 中打开这个新项目(`AwesomeProject / AwesomeProject.xcodeproj`)，并且使用 cmd+R 简单的创建和运行。这样做也将启动一个 node 服务器，能够重新加载有用的代码。有了这个，你可以通过在模拟器中按 cmd+R 看到变化，而不是在 Xcode 中重新编译。

本教程中,我们将构建一个电影应用程序的简单版本，它能获取影院中的 25 部电影，并将它们在一个列表视图中显示出来。

### Hello World

`react-native init` 将把 `Examples/SampleProject` 复制到你的项目中，无论你项目的命名是什么，在这种情况下，项目就是 AwesomeProject。这是一个简单的 hello world 应用程序。您可以编辑 `index.ios.js` 来更改应用程序,然后按模拟器中的 cmd+R 来查看变化。

### 模拟数据

在我们写代码来获取实际的 Rotten Tomatoes 数据之前，让我们模拟一些数据，这样我们可以用 React Native 来做一些实践。在 Facebook 中，我们通常在 JS 文件的顶部，略低于 requires 的位置声明常量，但是可以随时在任何你喜欢的地方添加以下常量。在 `index.ios.js` ：

>
``` 
var MOCKED_MOVIES_DATA = [
  {title: 'Title', year: '2015', posters: {thumbnail: 'http://i.imgur.com/UePbdph.jpg'}},
];
``` 

### 呈现一部电影

我们将为电影呈现标题，年份及缩略图。因为缩略图在 React Native 中是图像组件，所以下面是将图像添加到 React requires 列表。

>
```
    var { 
		AppRegistry, 
		Image, 
		StyleSheet, 
		Text, 
		View, 
    } = React;
```

现在修改 render 功能,以便我们呈现上述数据而不是 hello world。

>
```
    render: function() { 
		var movie = MOCKED_MOVIES_DATA[0]; 
		return ( 
		<View style={styles.container}>
	 	<Text>{movie.title}</Text> 
		<Text>{movie.year}</Text> 
		<Image source={{uri: movie.posters.thumbnail}} /> 
	   </View> 
	 ); 
    }
``` 

按下 cmd+R，你应该看到“2015”上面的“标题”。注意，图像没有呈现任何东西。这是因为我们还没有指定我们想要呈现的图像的宽度和高度。这是通过样式实现的。当我们改变样式时让我们也清理我们不再使用的样式。

>
```
    var styles = StyleSheet.create({ 
		container: { 
		flex: 1, justifyContent: 'center', 
		alignItems: 'center', 
		backgroundColor: '#F5FCFF', 
	}, 
	thumbnail: { 
		width: 53, 
		height: 81, 
	  }, 
    });
``` 

最后，我们需要将这个样式应用到图片组件中：

>
```
    <Image 
	   source={{uri: movie.posters.thumbnail}} 
	   style={styles.thumbnail} 
    />
``` 

按下 cmd+R，图像就会呈现。

![totorial](../images/Tutorial1.png)

### 添加一些样式

很好，我们已经将数据呈现出来了。现在让我们来把它变得更好。我想把文本放到图像的右边，使标题更大，并且集中在那个范围中:

>
```
    +---------------------------------+
	|+-------++----------------------+|
	||       ||        Title         ||
	|| Image ||                      ||
	||       ||        Year          ||
	|+-------++----------------------+|
    +---------------------------------+    
``` 

我们需要添加另一个容器来在竖直方向和水平方向上布置组件。

>
```
    return ( 
	<View style={styles.container}> 
	  <Image 
		source={{uri: movie.posters.thumbnail}} 
		style={styles.thumbnail} 
	  /> 
	  <View style={styles.rightContainer}> 
		<Text style={styles.title}>{movie.title}</Text> 
		<Text style={styles.year}>{movie.year}</Text> 
	  </View> 
    </View> );
``` 

目前没有太大改变,我们在文本周围添加了一个容器，然后在图像后移动了文本(因为它们在图像的右边)。让我们看看样式变化:

>
```
    container: { 
		flex: 1, 
		flexDirection: 'row', 
		justifyContent: 'center', 
		alignItems: 'center', 
		backgroundColor: '#F5FCFF', 
    },
``` 

我们为布局使用了 FlexBox——想要学习关于 FlexBox 更多的知识，看 [this great guide](https://css-tricks.com/snippets/css/a-guide-to-flexbox/)。

在上面的代码片段中,我们只添加了 `flexDirection:’row’`，这将使我们主要容器的子容器水平布局而不是竖直布局。

现在在 JS `style` 对象中，添加另一个样式：

>
```
    rightContainer: { 
		flex: 1, 
    },
``` 

这意味着 `rightContainer` 占用了没有被图像占用的父容器的剩余空间。如果这没有意义，给 `rightContainer` 添加一个 `backgroundColor`，然后试着删除 `flex:1`。你会发现这使得容器的尺寸是适合其子容器的最小尺寸。

为文本设置样式非常简单:
 
>
```
    title: { 
		fontSize: 20, 
		marginBottom: 8, 
		textAlign: 'center', 
	}, 
	year: { 
	textAlign: 'center', 
    },
``` 

继续按 cmd+R，你就会看到更新的视图。

![totorial](../images/Tutorial2.png)

### 获取真实数据

从 Rotten Tomatoes 的 API 中获取数据与学习 React Native 不太相关，所以在这一部分不要紧张。

在文件的顶部(通常在 requires 下方)添加以下常量，来创建用于请求数据的 REQUEST_URL。

>
```
    /** 
	* For quota reasons we replaced the Rotten Tomatoes' API with a sample data of 
	* their very own API that lives in React Native's Github repo. 
	*/ 
	var REQUEST_URL = 'https://raw.githubusercontent.com/facebook/react-
    native/master/docs/MoviesExample.json';
```
在我们的应用程序中添加一些初始状态，以便我们可以检查 `this.state.movies === null` 来确定电影数据是否已经被加载。当用 `this.setState({movies: moviesData})` 传回响应时，我们可以设置该数据。在 React 类中略高于 render 函数的位置添加此代码。

>
```
    getInitialState: function() { 
		return { 
			movies: null, 
		}; 
    },
```

当组件完成加载后，我们想要发送请求。`componentDidMountis` 是 React 组件的函数，在组件加载刚好完成后，React 将调用它一次。

>
```
    componentDidMount: function() { 
		this.fetchData(); 
    },
``` 

现在将上面使用的 `fetchData` 功能添加到我们的主要组件中。该方法将负责处理数据抓取。你所需要做的就是在解决承诺链之后调用 `this.setState({movies: data})`，因为 React 的工作方式是 `setState` 触发一个 re-render，然后 render 函数会发现 `this.state.movies` 不再是 `null`。注意,我们在结束承诺链时调用 `done()`——总是确保调用 `done()`，否则抛出的任何错误都将会被掩盖。

> 
```
fetchData: function() { 
		fetch(REQUEST_URL) 
			.then((response) => response.json()) 
			.then((responseData) => { 
				this.setState({ 
					movies: responseData.movies, 
				}); 
			}) 
			.done(); 
    },
```

如果我们没有任何电影数据，现在修改 render 函数来呈现一个加载的视图，如果有电影数据，那就修改 render 函数呈现第一部电影。

>
``` 
render: function() { 
		if (!this.state.movies) { 
			return this.renderLoadingView(); 
		} 
		var movie = this.state.movies[0]; 
		return this.renderMovie(movie); 
		}, 
	renderLoadingView: function() { 
		return ( 
			<View style={styles.container}> 
				<Text> 
					Loading movies... 
				</Text> </View> 
			); 
		}, 
	renderMovie: function(movie) { 
		return ( 
			<View style={styles.container}> 
			<Image 
				source={{uri: movie.posters.thumbnail}} 
				style={styles.thumbnail} 
			/> 
			<View style={styles.rightContainer}> 
				<Text style={styles.title}>{movie.title}</Text> 
				<Text style={styles.year}>{movie.year}</Text> 
			</View> 	
		</View> 
	); 
},
``` 

现在按下 cmd+R，你应该就能看到“loading movies…”直到传回响应，然后它就会呈现出它从 Rotten Tomatoes 上获取的第一部电影。

![totorial](../images/Tutorial3.png)

### 列表视图

现在让我们修改这个应用程序来在一个 `ListView` 组件中呈现这些数据,而不是仅仅呈现第一部电影。

为什么 `ListView` 比仅仅呈现所有这些元素或把它们放在 `ScrollView` 中好呢?尽管 React 快速,但是呈现一个元素的可能的无穷大的列表有可能是缓慢的。`ListView` 计划呈现视图，这样你打开屏幕电影就会在屏幕上显示，但是关掉屏幕，电影就会从本地视图层中删除。

首先:在文件的顶部添加 `ListView` 需求。

>
``` 
var {
  AppRegistry,
  Image,
  ListView,
  StyleSheet,
  Text,
  View,
} = React;
```

现在修改 render 函数,一旦我们有数据,它就会呈现电影的列表视图,而不是一部电影。

>
``` 
render: function() {
    if (!this.state.loaded) {
      return this.renderLoadingView();
    }
    return (
      <ListView
        dataSource={this.state.dataSource}
        renderRow={this.renderMovie}
        style={styles.listView}
      />
    );
  },
```

`DataSource` 是一个接口,`ListView` 使用它来确定哪些行在更新的过程中发生了改变。

你会注意到我们使用 `this.state` 的 `dataSource`。下一步是在由 `getInitialState` 返回的对象中添加一个 `emptydataSource`。另外，由于我们在 `dataSource` 中存储数据，我们不应该再使用 `this.state.movies`，以避免两次存储数据。我们可以使用状态(this.state.loaded) 的布尔属性，来显示数据抓取是否已经完成。

>
``` 
getInitialState: function() {
    return {
      dataSource: new ListView.DataSource({
        rowHasChanged: (row1, row2) => row1 !== row2,
      }),
      loaded: false,
    };
  },
```

这是修改后的 `fetchData` 方法相应地更新了状态: 

>
``` 
fetchData: function() {
    fetch(REQUEST_URL)
      .then((response) => response.json())
      .then((responseData) => {
        this.setState({
          dataSource: this.state.dataSource.cloneWithRows(responseData.movies),
          loaded: true,
        });
      })
      .done();
  },
```

最后，我们在 `style` JS 对象中为 `ListView` 添加样式：

>
``` 
listView: {
    paddingTop: 20,
    backgroundColor: '#F5FCFF',
  },
```

这是最终的结果：

![totorial](../images/Tutorial4.png)

要使它成为一个功能齐全的应用，还有一些工作要做,如:添加导航、搜索、无限滚动加载等。查询 [Movies Example](https://github.com/facebook/react-native/tree/master/Examples/Movies) 来看它所有工作的例子。

### 最终的源代码


    /**
	* Sample React Native App
 	* https://github.com/facebook/react-native
 	*/
	'use strict';

	var React = require('react-native');
	var {
  		AppRegistry,
  		Image,
  		ListView,
  		StyleSheet,
  		Text,
  		View,
	} = React;

	var API_KEY = '7waqfqbprs7pajbz28mqf6vz';
	var API_URL = 'http://api.rottentomatoes.com/api/public/v1.0/lists/movies/in_theaters.json';
	var PAGE_SIZE = 25;
	var PARAMS = '?apikey=' + API_KEY + '&page_limit=' + PAGE_SIZE;
	var REQUEST_URL = API_URL + PARAMS;

	var AwesomeProject = React.createClass({
  		getInitialState: function() {
    		return {
      			dataSource: new ListView.DataSource({
        		rowHasChanged: (row1, row2) => row1 !== row2,
      		}),
      	loaded: false,
      };
  	},

  	componentDidMount: function() {
    	this.fetchData();
  	},

  	fetchData: function() {
    	fetch(REQUEST_URL)
      	.then((response) => response.json())
      	.then((responseData) => {
        	this.setState({
          	dataSource: this.state.dataSource.cloneWithRows(responseData.movies),
          	loaded: true,
        	});
      	})
      	.done();
  	},

  	render: function() {
    	if (!this.state.loaded) {
      		return this.renderLoadingView();
    	}

    	return (
      		<ListView
        	dataSource={this.state.dataSource}
        	renderRow={this.renderMovie}
        	style={styles.listView}
      		/>
    	);
  	},

  	renderLoadingView: function() {
    	return (
      		<View style={styles.container}>
        		<Text>
          			Loading movies...
        		</Text>
      		</View>
    	);
  	},

  	renderMovie: function(movie) {
    	return (
      		<View style={styles.container}>
        		<Image
          			source={{uri: movie.posters.thumbnail}}
          			style={styles.thumbnail}
        		/>
        		<View style={styles.rightContainer}>
          			<Text style={styles.title}>{movie.title}</Text>
          			<Text style={styles.year}>{movie.year}</Text>
        		</View>
      		</View>
    		);
  		},
	});

	var styles = StyleSheet.create({
  		container: {
    		flex: 1,
    		flexDirection: 'row',
    		justifyContent: 'center',
    		alignItems: 'center',
    		backgroundColor: '#F5FCFF',
  		},
  		rightContainer: {
    		flex: 1,
  		},
  		title: {
    		fontSize: 20,
    		marginBottom: 8,
    		textAlign: 'center',
  		},
  		year: {
    		textAlign: 'center',
  		},
  		thumbnail: {
    		width: 53,
    		height: 81,
  		},
  		listView: {
    		paddingTop: 20,
    		backgroundColor: '#F5FCFF',
  		},
	});

    AppRegistry.registerComponent('AwesomeProject', () => AwesomeProject); 


[下一页](http://facebook.github.io/react-native/docs/videos.html#content)

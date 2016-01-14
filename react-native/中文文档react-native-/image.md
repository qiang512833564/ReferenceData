# 图像

React 组件用于显示不同类型的图像，包括网络图像，静态资源，临时本地图像，及来自本地磁盘，如相机等，的图像。

使用的例子：

``` 
renderImages: function() {
  return (
    <View>
      <Image
        style={styles.icon}
        source={require('image!myIcon')}
      />
      <Image
        style={styles.logo}
        source={{uri: 'http://facebook.github.io/react/img/logo_og.png'}}
      />
    </View>
  );
},
```

## Props  [Edit on GitHub]( https://github.com/facebook/react-native/blob/master/Libraries/Image/Image.ios.js)

**accessibilityLabel** 字符串型

自定义字符串显示为可访问性。

**accessible** 布尔型

这个元素是否应该显示为一个可访问的元素。

**capInsets** {顶部：数字型，左侧：数字型，底部：数字型，右侧：数字型}

当重新定义图像大小时，由 capInsets 指定的角落的尺寸将保持在一个固定的大小，但中心内容和图像的边界将会被拉伸。这对创建可调整大小的圆形按钮，阴影，和其他可调整大小的资源是有用的。更多信息在 [Apple 文档中]( https://developer.apple.com/library/ios/documentation/UIKit/Reference/UIImage_Class/index.html#//apple_ref/occ/instm/UIImage/resizableImageWithCapInsets)

**source** {uri:字符串型}

`uri` 的是一个字符串，代表图像的资源标识符，这可能是一个 http 地址，一个本地文件路径，或者静态图像资源的名称(应该包装在 `required('image!name')` 函数中)。

**style** style 型

[**Flexbox…**]( http://facebook.github.io/react-native/docs/flexbox.html#proptypes)

**backgroundColor** 字符串型

**borderColor** 字符串型

**borderRadius** 数字型

**borderWidth** 数字型

**opacity** 数字型

**resizeMode** Object.keys(ImageResizeMode)

**tintColor** 字符串型

**testID** 字符串型

该元素用于 UI 自动化测试脚本中的一个惟一的标识符。

## 描述  [Edit on GitHub]( https://github.com/facebook/react-native/blob/master/docs/Image.md)

显示图像是一个吸引人的课题；React Native 使用一些很酷的技巧使它成为一个更美好的体验。

# 没有自动给定大小

如果你没有给定一个图像大小，浏览器将呈现一个 0x0 元素，下载图片，然后呈现图像的正确的大小。这种行为的一个大问题是，在图像加载的过程中，你的 UI 将来回跳动，这造成了一个非常糟糕的用户体验。

在 React Native 中，这种行为是故意没有实现的。要想使开发人员知道图像的尺寸(或只是长宽比)需要更多的工作，但是我们相信，它会产生一个更好的用户体验。

#通过嵌套实现背景图像

一个来自熟悉网络的开发人员的常见的特性需求是 `background-image`。要处理这个用例，简单地创建一个正常的 `<Image>` 组件，并添加任何你想在上面添加的子组件。

``` 
return (
  <Image source={...}>
    <Text>Inside</Text>
  </Image>
);
```

# Off-thread 解码

图像解码可能会超过一个 frame-worth 时间。这是网络中框架的主要来源之一，因为解码是在主线程中完成的。在 React Native 中，图像解码是在一个不同的线程来完成的。在实践中,当图像还没有下载时，你已经需要处理这个情形了，所以当它解码时，多为几个框架显示占位符，不需要任何代码更改。

# 静态资产

在一个项目的过程中，添加或删除许多图像以及意外结束你在应用程序中不再使用的 shipping iamges 并不少见。为了克服它，我们需要找到一个方法来静态的知道哪些图像是在应用程序中正在使用的。要做到这一点，我们在需求中引入一个标记。在包中引用图像的唯一的允许方法是在源代码中逐字的写下 `require('image!name-of-the-asset')`。

``` 
// GOOD
<Image source={require('image!my-icon')} />
// BAD
var icon = this.props.active ? 'my-icon-active' : 'my-icon-inactive';
<Image source={require('image!' + icon)} />
// GOOD
var icon = this.props.active ? require('image!my-icon-active') : require('image!my-icon-inactive');
<Image source={icon} /> 
```

当你整个代码库都遵守这个协议时，你可以做有趣的事情比如自动的包装在你的应用程序使用的资产。请注意，在当前的形式中，什么也没有执行，但是将来会被执行。

# 最好的 Camera Roll 图像

iOS 为你的 Camera Roll 中相同的图像保存了许多尺寸，为性能选取一个尽可能接近的是非常重要的。当显示一个 200 x200 的缩略图时，你不想使用整个的 3264 x2448 图像作为来源。如果有一个精确的匹配，React Native 将选取它，否则当从接近的尺寸中重新调整大小时，为了避免模糊，它会使用至少大了 50% 的图像。所有的这些是在默认的情况下完成的，所以你不用担心为了实现它而写繁琐的(和容易出错的)代码。

# Source 是一个对象

在 React Native 中，一个有趣的决定是 `src` 属性被命名为 `source`，且不需要字符串，但是带有 `uri` 属性的对象则需要。

``` 
<Image source={{uri: 'something.jpg'}} />
```

在基础设施方面，原因在于它允许把元数据附加到这个对象上。例如如果你在使用 `require('image!icon')`，然后我们添加一个 `isStatic` 属性来标记它为本地文件(不要依赖于这个事实，它有可能在未来发生改变!)。这也是未来的试验，例如我们可能想在某种程度上支持 sprites，而不是输出 `{ uri:…}`，我们可以输出 `{uri: ..., crop: {left: 10, top: 50, width: 20, height: 40}}`，并且透明地支持所有现存的网站。

在用户方面，这可以使你用有用的属性注释对象，如图像的尺寸，为了计算它将要显示的大小。当你的数据结构存储更多关于你的图像的信息时，请随意使用它。

## 例子 [Edit on GitHub]( https://github.com/facebook/react-native/blob/master/Examples/UIExplorer/ImageExample.js)

``` 
'use strict';
var React = require('react-native');
var {
  Image,
  StyleSheet,
  Text,
  View,
} = React;
var ImageCapInsetsExample = require('./ImageCapInsetsExample');
exports.framework = 'React';
exports.title = '<Image>';
exports.description = 'Base component for displaying different types of images.';
exports.examples = [
  {
    title: 'Plain Network Image',
    description: 'If the `source` prop `uri` property is prefixed with ' +
    '"http", then it will be downloaded from the network.',
    render: function() {
      return (
        <Image
          source={{uri: 'http://facebook.github.io/react/img/logo_og.png'}}
          style={styles.base}
        />
      );
    },
  },
  {
    title: 'Plain Static Image',
    description: 'Static assets should be required by prefixing with `image!` ' +
      'and are located in the app bundle.',
    render: function() {
      return (
        <View style={styles.horizontal}>
          <Image source={require('image!uie_thumb_normal')} style={styles.icon} />
          <Image source={require('image!uie_thumb_selected')} style={styles.icon} />
          <Image source={require('image!uie_comment_normal')} style={styles.icon} />
          <Image source={require('image!uie_comment_highlighted')} style={styles.icon} />
        </View>
      );
    },
  },
  {
    title: 'Border Color',
    render: function() {
      return (
        <View style={styles.horizontal}>
          <Image
            source={smallImage}
            style={[
              styles.base,
              styles.background,
              {borderWidth: 3, borderColor: '#f099f0'}
            ]}
          />
        </View>
      );
    },
  },
  {
    title: 'Border Width',
    render: function() {
      return (
        <View style={styles.horizontal}>
          <Image
            source={smallImage}
            style={[
              styles.base,
              styles.background,
              {borderWidth: 5, borderColor: '#f099f0'}
            ]}
          />
        </View>
      );
    },
  },
  {
    title: 'Border Radius',
    render: function() {
      return (
        <View style={styles.horizontal}>
          <Image
            style={[styles.base, styles.background, {borderRadius: 5}]}
            source={smallImage}
          />
          <Image
            style={[
              styles.base,
              styles.background,
              styles.leftMargin,
              {borderRadius: 19}
            ]}
            source={smallImage}
          />
        </View>
      );
    },
  },
  {
    title: 'Background Color',
    render: function() {
      return (
        <View style={styles.horizontal}>
          <Image source={smallImage} style={styles.base} />
          <Image
            style={[
              styles.base,
              styles.leftMargin,
              {backgroundColor: 'rgba(0, 0, 100, 0.25)'}
            ]}
            source={smallImage}
          />
          <Image
            style={[styles.base, styles.leftMargin, {backgroundColor: 'red'}]}
            source={smallImage}
          />
          <Image
            style={[styles.base, styles.leftMargin, {backgroundColor: 'black'}]}
            source={smallImage}
          />
        </View>
      );
    },
  },
  {
    title: 'Opacity',
    render: function() {
      return (
        <View style={styles.horizontal}>
          <Image
            style={[styles.base, {opacity: 1}]}
            source={fullImage}
          />
          <Image
            style={[styles.base, styles.leftMargin, {opacity: 0.8}]}
            source={fullImage}
          />
          <Image
            style={[styles.base, styles.leftMargin, {opacity: 0.6}]}
            source={fullImage}
          />
          <Image
            style={[styles.base, styles.leftMargin, {opacity: 0.4}]}
            source={fullImage}
          />
          <Image
            style={[styles.base, styles.leftMargin, {opacity: 0.2}]}
            source={fullImage}
          />
          <Image
            style={[styles.base, styles.leftMargin, {opacity: 0}]}
            source={fullImage}
          />
        </View>
      );
    },
  },
  {
    title: 'Nesting',
    render: function() {
      return (
        <Image
          style={{width: 60, height: 60, backgroundColor: 'transparent'}}
          source={fullImage}>
          <Text style={styles.nestedText}>
            React
          </Text>
        </Image>
      );
    },
  },
  {
    title: 'Tint Color',
    description: 'The `tintColor` style prop changes all the non-alpha ' +
      'pixels to the tint color.',
    render: function() {
      return (
        <View style={styles.horizontal}>
          <Image
            source={require('image!uie_thumb_normal')}
            style={[styles.icon, {tintColor: 'blue' }]}
          />
          <Image
            source={require('image!uie_thumb_normal')}
            style={[styles.icon, styles.leftMargin, {tintColor: 'green' }]}
          />
          <Image
            source={require('image!uie_thumb_normal')}
            style={[styles.icon, styles.leftMargin, {tintColor: 'red' }]}
          />
          <Image
            source={require('image!uie_thumb_normal')}
            style={[styles.icon, styles.leftMargin, {tintColor: 'black' }]}
          />
        </View>
      );
    },
  },
  {
    title: 'Resize Mode',
    description: 'The `resizeMode` style prop controls how the image is ' +
      'rendered within the frame.',
    render: function() {
      return (
        <View style={styles.horizontal}>
          <View>
            <Text style={[styles.resizeModeText]}>
              Contain
            </Text>
            <Image
              style={[
                styles.resizeMode,
                {resizeMode: Image.resizeMode.contain}
              ]}
              source={fullImage}
            />
          </View>
          <View style={styles.leftMargin}>
            <Text style={[styles.resizeModeText]}>
              Cover
            </Text>
            <Image
              style={[
                styles.resizeMode,
                {resizeMode: Image.resizeMode.cover}
              ]}
              source={fullImage}
            />
          </View>
          <View style={styles.leftMargin}>
            <Text style={[styles.resizeModeText]}>
              Stretch
            </Text>
            <Image
              style={[
                styles.resizeMode,
                {resizeMode: Image.resizeMode.stretch}
              ]}
              source={fullImage}
            />
          </View>
        </View>
      );
    },
  },
  {
    title: 'Cap Insets',
    description:
      'When the image is resized, the corners of the size specified ' +
      'by capInsets will stay a fixed size, but the center content and ' +
      'borders of the image will be stretched. This is useful for creating ' +
      'resizable rounded buttons, shadows, and other resizable assets.',
    render: function() {
      return <ImageCapInsetsExample />;
    },
  },
];
var fullImage = {uri: 'http://facebook.github.io/react/img/logo_og.png'};
var smallImage = {uri: 'http://facebook.github.io/react/img/logo_small.png'};
var styles = StyleSheet.create({
  base: {
    width: 38,
    height: 38,
  },
  leftMargin: {
    marginLeft: 10,
  },
  background: {
    backgroundColor: '#222222'
  },
  nestedText: {
    marginLeft: 12,
    marginTop: 20,
    backgroundColor: 'transparent',
    color: 'white'
  },
  resizeMode: {
    width: 90,
    height: 60,
    borderWidth: 0.5,
    borderColor: 'black'
  },
  resizeModeText: {
    fontSize: 11,
    marginBottom: 3,
  },
  icon: {
    width: 15,
    height: 15,
  },
  horizontal: {
    flexDirection: 'row',
  }
});
```

[下一页]( http://facebook.github.io/react-native/docs/listview.html#content)

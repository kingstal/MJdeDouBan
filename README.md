MJdeDouBan是我独立开发的一个关于豆瓣的iOS客户端，融合了豆瓣电影、读书和音乐，内容主要通过爬虫抓取豆瓣数据。

以下是涉及到的几个关键技术：

- 服务器使用Python的Flask Web框架搭建，部署在新浪云上，通过`Requests`库请求网页，然后使用`Beautiful Soup`来对获得的网页进行解析获取想要的数据。
  
- 客户端为TabBar的形式，使用了[RAMAnimatedTabBarController](https://github.com/Ramotion/animated-tab-bar)开源库让TabBarItem具有动画效果。同时，对其在NavigationController中TabBar的隐藏问题进行了修正，使得ViewController在被push和pop时能够正确的隐藏和显示TabBar。
  
- 客户端与服务器的通信采用[AFNetworking](https://github.com/AFNetworking/AFNetworking)，数据交互的格式为json，采用[MJExtension](https://github.com/CoderMJLee/MJExtension)实现json到模型的转换。
  
  客户端使用[SDWebImage](https://github.com/rs/SDWebImage)异步加载缓存图片，使用[MJRefresh](https://github.com/CoderMJLee/MJRefresh)实现数据的下拉刷新。
  
  客户端各个Tab页的布局方式为TableView，部分UITableViewCell的高度并不确定，需要在程序运行时计算它的高度，这里主要使用了[UITableView+FDTemplateLayoutCell](https://github.com/forkingdog/UITableView-FDTemplateLayoutCell)来优化UITableViewCell高度的计算。
  
  客户端使用`NSURLProtocol`和`NSURLCache`实现数据缓存。

待完成：

- 添加用户登录模块，实现用户的收藏功能
- 实现音乐模块
- 完善细节
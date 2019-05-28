/*
Navicat MySQL Data Transfer

Source Server         : local
Source Server Version : 50725
Source Host           : localhost:3306
Source Database       : vhr

Target Server Type    : MYSQL
Target Server Version : 50725
File Encoding         : 65001

Date: 2019-05-28 18:00:30
*/

SET FOREIGN_KEY_CHECKS=0;

-- ----------------------------
-- Table structure for adjustsalary
-- ----------------------------
DROP TABLE IF EXISTS `adjustsalary`;
CREATE TABLE `adjustsalary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eid` int(11) DEFAULT NULL,
  `asDate` date DEFAULT NULL COMMENT '调薪日期',
  `beforeSalary` int(11) DEFAULT NULL COMMENT '调前薪资',
  `afterSalary` int(11) DEFAULT NULL COMMENT '调后薪资',
  `reason` varchar(255) DEFAULT NULL COMMENT '调薪原因',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `pid` (`eid`),
  CONSTRAINT `adjustsalary_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of adjustsalary
-- ----------------------------

-- ----------------------------
-- Table structure for appraise
-- ----------------------------
DROP TABLE IF EXISTS `appraise`;
CREATE TABLE `appraise` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eid` int(11) DEFAULT NULL,
  `appDate` date DEFAULT NULL COMMENT '考评日期',
  `appResult` varchar(32) DEFAULT NULL COMMENT '考评结果',
  `appContent` varchar(255) DEFAULT NULL COMMENT '考评内容',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `pid` (`eid`),
  CONSTRAINT `appraise_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of appraise
-- ----------------------------

-- ----------------------------
-- Table structure for article
-- ----------------------------
DROP TABLE IF EXISTS `article`;
CREATE TABLE `article` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(255) DEFAULT NULL,
  `mdContent` text COMMENT 'md文件源码',
  `htmlContent` text COMMENT 'html源码',
  `summary` text,
  `cid` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  `publishDate` datetime DEFAULT NULL,
  `editTime` datetime DEFAULT NULL,
  `state` int(11) DEFAULT NULL COMMENT '0表示草稿箱，1表示已发表，2已删除，3屏蔽，4置顶',
  `pageView` int(11) DEFAULT '0',
  PRIMARY KEY (`id`),
  KEY `cid` (`cid`) USING BTREE,
  KEY `uid` (`uid`) USING BTREE
) ENGINE=InnoDB AUTO_INCREMENT=127 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article
-- ----------------------------
INSERT INTO `article` VALUES ('108', 'Linux中安装zookeeper', '最近打算出一个系列，介绍Dubbo的使用。\n\n---\n分布式应用现在已经越来越广泛，Spring Could也是一个不错的一站式解决方案，不过据我了解国内目前貌似使用阿里Dubbo的公司比较多，一方面这个框架也确实很OK，另一方面可能也是因为Dubbo的中文文档比较全的缘故，据Dubbo官网上的消息，阿里已经重新开始了对Dubbo的维护，这也算是使用Dubbo的互联网公司的福音了吧。OK，废话不多说，今天我们就先来看看如何在Linux上安装zookeeper。\n\n---\n\n了解过Dubbo的小伙伴都知道，Dubbo官方建议我们使用的注册中心就是zookeeper，zookeeper本来是Hadoop的一个子项目，现在发展成了Apache的顶级项目，看名字就知道Zookeeper就是动物园管理员，管理Hadoop(大象)、Hive(蜂房/蜜蜂)等动物。Apache上的Zookeeper分Linux版和Windows版，但是考虑到实际生产环境都是Linux，所以我们这里主要介绍Linux上Zookeeper的安装，Windows上Zookeeper的安装则比较简单，下载解压即可，和Tomcat差不多。\n\nOK，废话不多说，接下来我们就来看看zookeeper的安装步骤。\n\n---\n环境：\n>1.VMware® Workstation 12 Pro  \n>2.CentOS7  \n>3.zookeeper-3.4.10(本文写作时的最新稳定版)  \n\n---\n# 安装步骤\n1.下载zookeeper\n\nzookeeper下载地址如下，小伙伴们可以在第一个地址中选择适合自己的zookeeper版本，也可以直接点击第二个地址下载我们本文使用的zookeeper。\n\n>1.[http://mirrors.hust.edu.cn/apache/zookeeper/](http://mirrors.hust.edu.cn/apache/zookeeper/)  \n\n>2.[http://mirrors.hust.edu.cn/apache/zookeeper/zookeeper-3.4.10/zookeeper-3.4.10.tar.gz](http://mirrors.hust.edu.cn/apache/zookeeper/zookeeper-3.4.10/zookeeper-3.4.10.tar.gz)\n\n\n\n2.将下载好的zookeeper上传到Linux服务器上\n\n上传方式多种多样，我这里采用了xftp，小伙伴们也可以直接使用putty上传，上传结果如下：\n![这里写图片描述](http://img.blog.csdn.net/20170825114622362?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n3.将文件解压到/opt目录下  \n\n![这里写图片描述](http://img.blog.csdn.net/20170825115122378?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n4.进入到刚刚解压好的目录中，创建两个文件夹，分别是data和logs，如下：\n\n![这里写图片描述](http://img.blog.csdn.net/20170825115324970?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n5.将解压后zookeeper-3.4.10文件夹下的zoo_sample.cfg文件拷贝一份命名为zoo.cfg，如下：\n\n![这里写图片描述](http://img.blog.csdn.net/20170825115426251?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n6.修改zoo.cfg文件，添加data和log目录，如下：\n\n![这里写图片描述](http://img.blog.csdn.net/20170825115527367?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n>1.2888 端口号是zookeeper服务之间通信的端口   \n>2.3888 是zookeeper 与其他应用程序通信的端口  \n>3.initLimit：这个配置项是用来配置 Zookeeper 接受客户端（这里所说的客户端不是用户连接 Zookeeper服务器的客户端，而是 Zookeeper 服务器集群中连接到 Leader 的 Follower 服务器）初始化连接时最长能忍受多少个心跳时间间隔数。当已经超过 10 个心跳的时间（也就是 tickTime）长度后 Zookeeper 服务器还没有收到客户端的返回信息，那么表明这个客户端连接失败。总的时间长度就是 5*2000=10 秒。  \n>4.syncLimit：这个配置项标识 Leader 与 Follower 之间发送消息，请求和应答时间长度，最长不能超过多少个 tickTime 的时间长度，总的时间长度就是 2*2000=4 秒  \n>5.server.A=B:C:D：其中 A 是一个数字，表示这个是第几号服务器；B 是这个服务器的IP地址或/etc/hosts文件中映射了IP的主机名；C 表示的是这个服务器与集群中的 Leader 服务器交换信息的端口；D 表示的是万一集群中的 Leader 服务器挂了，需要一个端口来重新进行选举，选出一个新的 Leader，而这个端口就是用来执行选举时服务器相互通信的端口。如果是伪集群的配置方式，由于 B 都是一样，所以不同的 Zookeeper 实例通信端口号不能一样，所以要给它们分配不同的端口号。\n\n7.在 dataDir=/opt/zookeeper-3.4.10/data下创建 myid文件 编辑myid文件，并在对应的IP的机器上输入对应的编号。如在zookeeper上，myid文件内容就是1。如果只在单点上进行安装配置，那么只有一个server.1。如下：\n\n![这里写图片描述](http://img.blog.csdn.net/20170825115647920?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n8.在.bash_profile文件中增加zookeeper配置：\n\n![这里写图片描述](http://img.blog.csdn.net/20170825115729473?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n9.使配置生效\n\n![这里写图片描述](http://img.blog.csdn.net/20170825115807787?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n10.关闭防火墙\n\n![这里写图片描述](http://img.blog.csdn.net/20170825115848488?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n11.启动并测试\n\n![这里写图片描述](http://img.blog.csdn.net/20170825115938795?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n>启动之后如果能看到Mode:standalone就表示启动成功了。\n\n12.关闭zookeeper\n\n![这里写图片描述](http://img.blog.csdn.net/20170825121021364?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n13.配置开机启动zookeeper\n\n![这里写图片描述](http://img.blog.csdn.net/20170825121059827?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n>**注意注意** 在centos7中，/etc/rc.local的权限被降低了，所以需要执行如下命令赋予其可执行权限\n```chmod +x /etc/rc.d/rc.local```\n\n\nOK,以上就是我们在CentOS7中安装zookeeper的全过程，做好这一切之后我们就可以在Dubbo中使用这个注册中心了，这个我们放在下一篇博客中介绍。\n\n更多JavaEE资料请关注公众号：\n\n![](http://img.blog.csdn.net/20170823174820001?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)', '<p>最近打算出一个系列，介绍Dubbo的使用。</p>\n<hr />\n<p>分布式应用现在已经越来越广泛，Spring Could也是一个不错的一站式解决方案，不过据我了解国内目前貌似使用阿里Dubbo的公司比较多，一方面这个框架也确实很OK，另一方面可能也是因为Dubbo的中文文档比较全的缘故，据Dubbo官网上的消息，阿里已经重新开始了对Dubbo的维护，这也算是使用Dubbo的互联网公司的福音了吧。OK，废话不多说，今天我们就先来看看如何在Linux上安装zookeeper。</p>\n<hr />\n<p>了解过Dubbo的小伙伴都知道，Dubbo官方建议我们使用的注册中心就是zookeeper，zookeeper本来是Hadoop的一个子项目，现在发展成了Apache的顶级项目，看名字就知道Zookeeper就是动物园管理员，管理Hadoop(大象)、Hive(蜂房/蜜蜂)等动物。Apache上的Zookeeper分Linux版和Windows版，但是考虑到实际生产环境都是Linux，所以我们这里主要介绍Linux上Zookeeper的安装，Windows上Zookeeper的安装则比较简单，下载解压即可，和Tomcat差不多。</p>\n<p>OK，废话不多说，接下来我们就来看看zookeeper的安装步骤。</p>\n<hr />\n<p>环境：</p>\n<blockquote>\n<p>1.VMware® Workstation 12 Pro<br />\n2.CentOS7<br />\n3.zookeeper-3.4.10(本文写作时的最新稳定版)</p>\n</blockquote>\n<hr />\n<h1>安装步骤</h1>\n<p>1.下载zookeeper</p>\n<p>zookeeper下载地址如下，小伙伴们可以在第一个地址中选择适合自己的zookeeper版本，也可以直接点击第二个地址下载我们本文使用的zookeeper。</p>\n<blockquote>\n<p>1.<a href=\"http://mirrors.hust.edu.cn/apache/zookeeper/\" target=\"_blank\">http://mirrors.hust.edu.cn/apache/zookeeper/</a></p>\n</blockquote>\n<blockquote>\n<p>2.<a href=\"http://mirrors.hust.edu.cn/apache/zookeeper/zookeeper-3.4.10/zookeeper-3.4.10.tar.gz\" target=\"_blank\">http://mirrors.hust.edu.cn/apache/zookeeper/zookeeper-3.4.10/zookeeper-3.4.10.tar.gz</a></p>\n</blockquote>\n<p>2.将下载好的zookeeper上传到Linux服务器上</p>\n<p>上传方式多种多样，我这里采用了xftp，小伙伴们也可以直接使用putty上传，上传结果如下：<br />\n<img src=\"http://img.blog.csdn.net/20170825114622362?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<p>3.将文件解压到/opt目录下</p>\n<p><img src=\"http://img.blog.csdn.net/20170825115122378?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<p>4.进入到刚刚解压好的目录中，创建两个文件夹，分别是data和logs，如下：</p>\n<p><img src=\"http://img.blog.csdn.net/20170825115324970?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<p>5.将解压后zookeeper-3.4.10文件夹下的zoo_sample.cfg文件拷贝一份命名为zoo.cfg，如下：</p>\n<p><img src=\"http://img.blog.csdn.net/20170825115426251?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<p>6.修改zoo.cfg文件，添加data和log目录，如下：</p>\n<p><img src=\"http://img.blog.csdn.net/20170825115527367?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<blockquote>\n<p>1.2888 端口号是zookeeper服务之间通信的端口<br />\n2.3888 是zookeeper 与其他应用程序通信的端口<br />\n3.initLimit：这个配置项是用来配置 Zookeeper 接受客户端（这里所说的客户端不是用户连接 Zookeeper服务器的客户端，而是 Zookeeper 服务器集群中连接到 Leader 的 Follower 服务器）初始化连接时最长能忍受多少个心跳时间间隔数。当已经超过 10 个心跳的时间（也就是 tickTime）长度后 Zookeeper 服务器还没有收到客户端的返回信息，那么表明这个客户端连接失败。总的时间长度就是 5<em>2000=10 秒。<br />\n4.syncLimit：这个配置项标识 Leader 与 Follower 之间发送消息，请求和应答时间长度，最长不能超过多少个 tickTime 的时间长度，总的时间长度就是 2</em>2000=4 秒<br />\n5.server.A=B:C:D：其中 A 是一个数字，表示这个是第几号服务器；B 是这个服务器的IP地址或/etc/hosts文件中映射了IP的主机名；C 表示的是这个服务器与集群中的 Leader 服务器交换信息的端口；D 表示的是万一集群中的 Leader 服务器挂了，需要一个端口来重新进行选举，选出一个新的 Leader，而这个端口就是用来执行选举时服务器相互通信的端口。如果是伪集群的配置方式，由于 B 都是一样，所以不同的 Zookeeper 实例通信端口号不能一样，所以要给它们分配不同的端口号。</p>\n</blockquote>\n<p>7.在 dataDir=/opt/zookeeper-3.4.10/data下创建 myid文件 编辑myid文件，并在对应的IP的机器上输入对应的编号。如在zookeeper上，myid文件内容就是1。如果只在单点上进行安装配置，那么只有一个server.1。如下：</p>\n<p><img src=\"http://img.blog.csdn.net/20170825115647920?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<p>8.在.bash_profile文件中增加zookeeper配置：</p>\n<p><img src=\"http://img.blog.csdn.net/20170825115729473?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<p>9.使配置生效</p>\n<p><img src=\"http://img.blog.csdn.net/20170825115807787?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<p>10.关闭防火墙</p>\n<p><img src=\"http://img.blog.csdn.net/20170825115848488?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<p>11.启动并测试</p>\n<p><img src=\"http://img.blog.csdn.net/20170825115938795?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<blockquote>\n<p>启动之后如果能看到Mode:standalone就表示启动成功了。</p>\n</blockquote>\n<p>12.关闭zookeeper</p>\n<p><img src=\"http://img.blog.csdn.net/20170825121021364?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<p>13.配置开机启动zookeeper</p>\n<p><img src=\"http://img.blog.csdn.net/20170825121059827?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<blockquote>\n<p><strong>注意注意</strong> 在centos7中，/etc/rc.local的权限被降低了，所以需要执行如下命令赋予其可执行权限<br />\n<code>chmod +x /etc/rc.d/rc.local</code></p>\n</blockquote>\n<p>OK,以上就是我们在CentOS7中安装zookeeper的全过程，做好这一切之后我们就可以在Dubbo中使用这个注册中心了，这个我们放在下一篇博客中介绍。</p>\n<p>更多JavaEE资料请关注公众号：</p>\n<p><img src=\"http://img.blog.csdn.net/20170823174820001?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"\" /></p>\n', '最近打算出一个系列，介绍Dubbo的使用。\n\n分布式应用现在已经越来越广泛，Spring Could', '1', '3', '2017-12-24 10:05:20', '2017-12-24 10:05:20', '1', '3');
INSERT INTO `article` VALUES ('109', 'Ajax上传图片以及上传之前先预览', '手头上有几个小项目用到了easyUI，一开始决定使用easyUI就注定了项目整体上前后端分离，基本上所有的请求都采用Ajax来完成。在文件上传的时候用到了Ajax上传文件，以及图片在上传之前的预览效果，解决了这两个小问题，和小伙伴们分享下。\n\n---\n# 上传之前的预览\n\n## 方式一\n先来说说图片上传之前的预览问题。这里主要采用了HTML5中的FileReader对象来实现，关于FileReader对象，如果小伙伴们不了解，可以查看这篇博客[HTML5学习之FileReader接口](http://blog.csdn.net/zk437092645/article/details/8745647/)。我们来看看实现方式：\n```\n<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n    <meta charset=\"UTF-8\">\n    <title>Ajax上传文件</title>\n    <script src=\"jquery-3.2.1.js\"></script>\n</head>\n<body>\n用户名：<input id=\"username\" type=\"text\"><br>\n用户图像：<input id=\"userface\" type=\"file\" onchange=\"preview(this)\"><br>\n<div id=\"preview\"></div>\n<input type=\"button\" id=\"btnClick\" value=\"上传\">\n<script>\n    $(\"#btnClick\").click(function () {\n        var formData = new FormData();\n        formData.append(\"username\", $(\"#username\").val());\n        formData.append(\"file\", $(\"#userface\")[0].files[0]);\n        $.ajax({\n            url: \'/fileupload\',\n            type: \'post\',\n            data: formData,\n            processData: false,\n            contentType: false,\n            success: function (msg) {\n                alert(msg);\n            }\n        });\n    });\n    function preview(file) {\n        var prevDiv = document.getElementById(\'preview\');\n        if (file.files && file.files[0]) {\n            var reader = new FileReader();\n            reader.onload = function (evt) {\n                prevDiv.innerHTML = \'<img src=\"\' + evt.target.result + \'\" />\';\n            }\n            reader.readAsDataURL(file.files[0]);\n        } else {\n            prevDiv.innerHTML = \'<div class=\"img\" style=\"filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src=\\\'\' + file.value + \'\\\'\"></div>\';\n        }\n    }\n</script>\n</body>\n</html>\n```\n\n这里对于支持FileReader的浏览器直接使用FileReader来实现，不支持FileReader的浏览器则采用微软的滤镜来实现（注意给图片上传的input标签设置onchange函数）。\n实现效果如下：\n![这里写图片描述](http://img.blog.csdn.net/20170825184056537?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n\n## 方式二\n\n除了这种方式之外我们也可以采用网上现成的一个jQuery实现的方式。这里主要参考了[这里](http://keleyi.com/keleyi/phtml/image/16.htm)。\n不过由于原文年代久远，里边使用的```$.browser.msie```从jQuery1.9就被移除掉了，所以如果我们想使用这个得做一点额外的处理，我修改后的uploadPreview.js文件内容如下：\n```\njQuery.browser={};(function(){jQuery.browser.msie=false; jQuery.browser.version=0;if(navigator.userAgent.match(/MSIE ([0-9]+)./)){ jQuery.browser.msie=true;jQuery.browser.version=RegExp.$1;}})();\njQuery.fn.extend({\n    uploadPreview: function (opts) {\n        var _self = this,\n            _this = $(this);\n        opts = jQuery.extend({\n            Img: \"ImgPr\",\n            Width: 100,\n            Height: 100,\n            ImgType: [\"gif\", \"jpeg\", \"jpg\", \"bmp\", \"png\"],\n            Callback: function () {}\n        }, opts || {});\n        _self.getObjectURL = function (file) {\n            var url = null;\n            if (window.createObjectURL != undefined) {\n                url = window.createObjectURL(file)\n            } else if (window.URL != undefined) {\n                url = window.URL.createObjectURL(file)\n            } else if (window.webkitURL != undefined) {\n                url = window.webkitURL.createObjectURL(file)\n            }\n            return url\n        };\n        _this.change(function () {\n            if (this.value) {\n                if (!RegExp(\"\\.(\" + opts.ImgType.join(\"|\") + \")$\", \"i\").test(this.value.toLowerCase())) {\n                    alert(\"选择文件错误,图片类型必须是\" + opts.ImgType.join(\"，\") + \"中的一种\");\n                    this.value = \"\";\n                    return false\n                }\n                if ($.browser.msie) {\n                    try {\n                        $(\"#\" + opts.Img).attr(\'src\', _self.getObjectURL(this.files[0]))\n                    } catch (e) {\n                        var src = \"\";\n                        var obj = $(\"#\" + opts.Img);\n                        var div = obj.parent(\"div\")[0];\n                        _self.select();\n                        if (top != self) {\n                            window.parent.document.body.focus()\n                        } else {\n                            _self.blur()\n                        }\n                        src = document.selection.createRange().text;\n                        document.selection.empty();\n                        obj.hide();\n                        obj.parent(\"div\").css({\n                            \'filter\': \'progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)\',\n                            \'width\': opts.Width + \'px\',\n                            \'height\': opts.Height + \'px\'\n                        });\n                        div.filters.item(\"DXImageTransform.Microsoft.AlphaImageLoader\").src = src\n                    }\n                } else {\n                    $(\"#\" + opts.Img).attr(\'src\', _self.getObjectURL(this.files[0]))\n                }\n                opts.Callback()\n            }\n        })\n    }\n});\n```\n\n然后在我们的html文件中引入这个js文件即可：\n```\n<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n    <meta charset=\"UTF-8\">\n    <title>Ajax上传文件</title>\n    <script src=\"jquery-3.2.1.js\"></script>\n    <script src=\"uploadPreview.js\"></script>\n</head>\n<body>\n用户名：<input id=\"username\" type=\"text\"><br>\n用户图像：<input id=\"userface\" type=\"file\" onchange=\"preview(this)\"><br>\n<div><img id=\"ImgPr\" width=\"200\" height=\"200\"/></div>\n<input type=\"button\" id=\"btnClick\" value=\"上传\">\n<script>\n    $(\"#btnClick\").click(function () {\n        var formData = new FormData();\n        formData.append(\"username\", $(\"#username\").val());\n        formData.append(\"file\", $(\"#userface\")[0].files[0]);\n        $.ajax({\n            url: \'/fileupload\',\n            type: \'post\',\n            data: formData,\n            processData: false,\n            contentType: false,\n            success: function (msg) {\n                alert(msg);\n            }\n        });\n    });\n    $(\"#userface\").uploadPreview({Img: \"ImgPr\", Width: 120, Height: 120});\n</script>\n</body>\n</html>\n```\n\n这里有如下几点需要注意：\n>1.HTML页面中要引入我们自定义的uploadPreview.js文件\n>2.预先定义好要显示预览图片的img标签，该标签要有id。\n>3.查找到img标签然后调用uploadPreview函数\n\n执行效果如下：  \n![这里写图片描述](http://img.blog.csdn.net/20170825190203757?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n# Ajax上传图片文件\n\nAjax上传图片文件就简单了，没有那么多方案，核心代码如下：\n```\n        var formData = new FormData();\n        formData.append(\"username\", $(\"#username\").val());\n        formData.append(\"file\", $(\"#userface\")[0].files[0]);\n        $.ajax({\n            url: \'/fileupload\',\n            type: \'post\',\n            data: formData,\n            processData: false,\n            contentType: false,\n            success: function (msg) {\n                alert(msg);\n            }\n        });\n```\n核心就是定义一个FormData对象，将要上传的数据包装到这个对象中去。然后在ajax上传数据的时候设置data属性就为formdata，processData属性设置为false，表示jQuery不要去处理发送的数据，然后设置contentType属性的值为false，表示不要设置请求头的contentType属性。OK，主要就是设置这三个，设置成功之后，其他的处理就和常规的ajax用法一致了。\n\n后台的处理代码大家可以在文末的案例中下载，这里我就不展示不出来了。\n\nOK，以上就是我们对Ajax上传图片以及图片预览的一个简介，有问题的小伙伴欢迎留言讨论。\n\n案例下载地址[http://download.csdn.net/download/u012702547/9950813](http://download.csdn.net/download/u012702547/9950813)\n\n由于CSDN下载现在必须要积分，不得已设置了1分，如果小伙伴没有积分，文末留言我发给你。\n\n以上。\n', '<p>手头上有几个小项目用到了easyUI，一开始决定使用easyUI就注定了项目整体上前后端分离，基本上所有的请求都采用Ajax来完成。在文件上传的时候用到了Ajax上传文件，以及图片在上传之前的预览效果，解决了这两个小问题，和小伙伴们分享下。</p>\n<hr />\n<h1>上传之前的预览</h1>\n<h2>方式一</h2>\n<p>先来说说图片上传之前的预览问题。这里主要采用了HTML5中的FileReader对象来实现，关于FileReader对象，如果小伙伴们不了解，可以查看这篇博客<a href=\"http://blog.csdn.net/zk437092645/article/details/8745647/\" target=\"_blank\">HTML5学习之FileReader接口</a>。我们来看看实现方式：</p>\n<pre><code class=\"lang-\">&lt;!DOCTYPE html&gt;\n&lt;html lang=&quot;en&quot;&gt;\n&lt;head&gt;\n    &lt;meta charset=&quot;UTF-8&quot;&gt;\n    &lt;title&gt;Ajax上传文件&lt;/title&gt;\n    &lt;script src=&quot;jquery-3.2.1.js&quot;&gt;&lt;/script&gt;\n&lt;/head&gt;\n&lt;body&gt;\n用户名：&lt;input id=&quot;username&quot; type=&quot;text&quot;&gt;&lt;br&gt;\n用户图像：&lt;input id=&quot;userface&quot; type=&quot;file&quot; onchange=&quot;preview(this)&quot;&gt;&lt;br&gt;\n&lt;div id=&quot;preview&quot;&gt;&lt;/div&gt;\n&lt;input type=&quot;button&quot; id=&quot;btnClick&quot; value=&quot;上传&quot;&gt;\n&lt;script&gt;\n    $(&quot;#btnClick&quot;).click(function () {\n        var formData = new FormData();\n        formData.append(&quot;username&quot;, $(&quot;#username&quot;).val());\n        formData.append(&quot;file&quot;, $(&quot;#userface&quot;)[0].files[0]);\n        $.ajax({\n            url: \'/fileupload\',\n            type: \'post\',\n            data: formData,\n            processData: false,\n            contentType: false,\n            success: function (msg) {\n                alert(msg);\n            }\n        });\n    });\n    function preview(file) {\n        var prevDiv = document.getElementById(\'preview\');\n        if (file.files &amp;&amp; file.files[0]) {\n            var reader = new FileReader();\n            reader.onload = function (evt) {\n                prevDiv.innerHTML = \'&lt;img src=&quot;\' + evt.target.result + \'&quot; /&gt;\';\n            }\n            reader.readAsDataURL(file.files[0]);\n        } else {\n            prevDiv.innerHTML = \'&lt;div class=&quot;img&quot; style=&quot;filter:progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale,src=\\\'\' + file.value + \'\\\'&quot;&gt;&lt;/div&gt;\';\n        }\n    }\n&lt;/script&gt;\n&lt;/body&gt;\n&lt;/html&gt;\n</code></pre>\n<p>这里对于支持FileReader的浏览器直接使用FileReader来实现，不支持FileReader的浏览器则采用微软的滤镜来实现（注意给图片上传的input标签设置onchange函数）。<br />\n实现效果如下：<br />\n<img src=\"http://img.blog.csdn.net/20170825184056537?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<h2>方式二</h2>\n<p>除了这种方式之外我们也可以采用网上现成的一个jQuery实现的方式。这里主要参考了<a href=\"http://keleyi.com/keleyi/phtml/image/16.htm\" target=\"_blank\">这里</a>。<br />\n不过由于原文年代久远，里边使用的<code>$.browser.msie</code>从jQuery1.9就被移除掉了，所以如果我们想使用这个得做一点额外的处理，我修改后的uploadPreview.js文件内容如下：</p>\n<pre><code class=\"lang-\">jQuery.browser={};(function(){jQuery.browser.msie=false; jQuery.browser.version=0;if(navigator.userAgent.match(/MSIE ([0-9]+)./)){ jQuery.browser.msie=true;jQuery.browser.version=RegExp.$1;}})();\njQuery.fn.extend({\n    uploadPreview: function (opts) {\n        var _self = this,\n            _this = $(this);\n        opts = jQuery.extend({\n            Img: &quot;ImgPr&quot;,\n            Width: 100,\n            Height: 100,\n            ImgType: [&quot;gif&quot;, &quot;jpeg&quot;, &quot;jpg&quot;, &quot;bmp&quot;, &quot;png&quot;],\n            Callback: function () {}\n        }, opts || {});\n        _self.getObjectURL = function (file) {\n            var url = null;\n            if (window.createObjectURL != undefined) {\n                url = window.createObjectURL(file)\n            } else if (window.URL != undefined) {\n                url = window.URL.createObjectURL(file)\n            } else if (window.webkitURL != undefined) {\n                url = window.webkitURL.createObjectURL(file)\n            }\n            return url\n        };\n        _this.change(function () {\n            if (this.value) {\n                if (!RegExp(&quot;\\.(&quot; + opts.ImgType.join(&quot;|&quot;) + &quot;)$&quot;, &quot;i&quot;).test(this.value.toLowerCase())) {\n                    alert(&quot;选择文件错误,图片类型必须是&quot; + opts.ImgType.join(&quot;，&quot;) + &quot;中的一种&quot;);\n                    this.value = &quot;&quot;;\n                    return false\n                }\n                if ($.browser.msie) {\n                    try {\n                        $(&quot;#&quot; + opts.Img).attr(\'src\', _self.getObjectURL(this.files[0]))\n                    } catch (e) {\n                        var src = &quot;&quot;;\n                        var obj = $(&quot;#&quot; + opts.Img);\n                        var div = obj.parent(&quot;div&quot;)[0];\n                        _self.select();\n                        if (top != self) {\n                            window.parent.document.body.focus()\n                        } else {\n                            _self.blur()\n                        }\n                        src = document.selection.createRange().text;\n                        document.selection.empty();\n                        obj.hide();\n                        obj.parent(&quot;div&quot;).css({\n                            \'filter\': \'progid:DXImageTransform.Microsoft.AlphaImageLoader(sizingMethod=scale)\',\n                            \'width\': opts.Width + \'px\',\n                            \'height\': opts.Height + \'px\'\n                        });\n                        div.filters.item(&quot;DXImageTransform.Microsoft.AlphaImageLoader&quot;).src = src\n                    }\n                } else {\n                    $(&quot;#&quot; + opts.Img).attr(\'src\', _self.getObjectURL(this.files[0]))\n                }\n                opts.Callback()\n            }\n        })\n    }\n});\n</code></pre>\n<p>然后在我们的html文件中引入这个js文件即可：</p>\n<pre><code class=\"lang-\">&lt;!DOCTYPE html&gt;\n&lt;html lang=&quot;en&quot;&gt;\n&lt;head&gt;\n    &lt;meta charset=&quot;UTF-8&quot;&gt;\n    &lt;title&gt;Ajax上传文件&lt;/title&gt;\n    &lt;script src=&quot;jquery-3.2.1.js&quot;&gt;&lt;/script&gt;\n    &lt;script src=&quot;uploadPreview.js&quot;&gt;&lt;/script&gt;\n&lt;/head&gt;\n&lt;body&gt;\n用户名：&lt;input id=&quot;username&quot; type=&quot;text&quot;&gt;&lt;br&gt;\n用户图像：&lt;input id=&quot;userface&quot; type=&quot;file&quot; onchange=&quot;preview(this)&quot;&gt;&lt;br&gt;\n&lt;div&gt;&lt;img id=&quot;ImgPr&quot; width=&quot;200&quot; height=&quot;200&quot;/&gt;&lt;/div&gt;\n&lt;input type=&quot;button&quot; id=&quot;btnClick&quot; value=&quot;上传&quot;&gt;\n&lt;script&gt;\n    $(&quot;#btnClick&quot;).click(function () {\n        var formData = new FormData();\n        formData.append(&quot;username&quot;, $(&quot;#username&quot;).val());\n        formData.append(&quot;file&quot;, $(&quot;#userface&quot;)[0].files[0]);\n        $.ajax({\n            url: \'/fileupload\',\n            type: \'post\',\n            data: formData,\n            processData: false,\n            contentType: false,\n            success: function (msg) {\n                alert(msg);\n            }\n        });\n    });\n    $(&quot;#userface&quot;).uploadPreview({Img: &quot;ImgPr&quot;, Width: 120, Height: 120});\n&lt;/script&gt;\n&lt;/body&gt;\n&lt;/html&gt;\n</code></pre>\n<p>这里有如下几点需要注意：</p>\n<blockquote>\n<p>1.HTML页面中要引入我们自定义的uploadPreview.js文件<br />\n2.预先定义好要显示预览图片的img标签，该标签要有id。<br />\n3.查找到img标签然后调用uploadPreview函数</p>\n</blockquote>\n<p>执行效果如下：<br />\n<img src=\"http://img.blog.csdn.net/20170825190203757?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<h1>Ajax上传图片文件</h1>\n<p>Ajax上传图片文件就简单了，没有那么多方案，核心代码如下：</p>\n<pre><code class=\"lang-\">        var formData = new FormData();\n        formData.append(&quot;username&quot;, $(&quot;#username&quot;).val());\n        formData.append(&quot;file&quot;, $(&quot;#userface&quot;)[0].files[0]);\n        $.ajax({\n            url: \'/fileupload\',\n            type: \'post\',\n            data: formData,\n            processData: false,\n            contentType: false,\n            success: function (msg) {\n                alert(msg);\n            }\n        });\n</code></pre>\n<p>核心就是定义一个FormData对象，将要上传的数据包装到这个对象中去。然后在ajax上传数据的时候设置data属性就为formdata，processData属性设置为false，表示jQuery不要去处理发送的数据，然后设置contentType属性的值为false，表示不要设置请求头的contentType属性。OK，主要就是设置这三个，设置成功之后，其他的处理就和常规的ajax用法一致了。</p>\n<p>后台的处理代码大家可以在文末的案例中下载，这里我就不展示不出来了。</p>\n<p>OK，以上就是我们对Ajax上传图片以及图片预览的一个简介，有问题的小伙伴欢迎留言讨论。</p>\n<p>案例下载地址<a href=\"http://download.csdn.net/download/u012702547/9950813\" target=\"_blank\">http://download.csdn.net/download/u012702547/9950813</a></p>\n<p>由于CSDN下载现在必须要积分，不得已设置了1分，如果小伙伴没有积分，文末留言我发给你。</p>\n<p>以上。</p>\n', '手头上有几个小项目用到了easyUI，一开始决定使用easyUI就注定了项目整体上前后端分离，基本上', '1', '3', '2017-12-24 09:34:29', '2017-12-24 09:34:29', '1', '7');
INSERT INTO `article` VALUES ('110', '一个简单的案例带你入门Dubbo分布式框架666', '相信有很多小伙伴都知道，dubbo是一个分布式、高性能、透明化的RPC服务框架，提供服务自动注册、自动发现等高效服务治理方案，dubbo的中文文档也是非常全的，中文文档可以参考这里**[dubbo.io](http://dubbo.io/)**。由于官网的介绍比较简洁，我这里打算通过Maven多模块工程再给小伙伴们演示一下用法。\n\n\n![Image 003.png](http://localhost:80/blogimg/20171224/f301f919-f191-4e12-9a19-bce8f82a00f0_Image003.png)\n\n---\n环境：IntelliJ IDEA2017.1\n\n---\n关于如何在IntelliJ IDEA中创建Maven多模块项目，小伙伴们可以参考之前的博客[ IntelliJ IDEA中创建Web聚合项目(Maven多模块项目) ](http://blog.csdn.net/u012702547/article/details/77431765)，这里我就不再赘述。\n这里我还是以dubbo官方文档中的例子作为基准，我们来详细的看看运行过程。\n# 创建一个Maven工程\nIntelliJ中创建Maven工程的方式我这里就不再多说了，这里只说一点，工程创建成功之后，将src目录删除，因为我们不需要在这个工程下面写代码，我们将以这个工程为父工程，然后给它创建多个模块。\n# 向创建好的工程中添加模块\n当我们第一步成功创建了要给Maven工程之后，第二步我们就向这个Maven工程中添加三个模块，分别是common，provider和consumer三个模块，添加完成之后效果如下：\n![这里写图片描述](http://img.blog.csdn.net/20170826153752910?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\nprovider将作为我们的服务提供者，consumer将作为服务消费者，这两个好理解，除了这两个之外我们还需要要给common模块，common模块主要是提供公共接口，供服务提供者和服务消费者使用。\n\n# 向common模块中添加接口\n\n在common模块中，添加一个SayHello接口，如下：\n\n![这里写图片描述](http://img.blog.csdn.net/20170826154808445?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n# provider模块依赖common并提供服务\n\n1.首先打开provider的pom.xml文件，在其中添加依赖，要添加的依赖有如下四个小类：\n>1.添加对common模块的依赖\n>2.添加对spring的依赖\n>3.添加对dubbo的依赖\n>4.添加对zookeeper的依赖\n\n如下：\n\n```\n<dependencies>\n        <dependency>\n            <groupId>org.sang</groupId>\n            <artifactId>common</artifactId>\n            <version>1.0-SNAPSHOT</version>\n        </dependency>\n        <dependency>\n            <groupId>org.springframework</groupId>\n            <artifactId>spring-web</artifactId>\n            <version>4.3.10.RELEASE</version>\n        </dependency>\n        <dependency>\n            <groupId>com.alibaba</groupId>\n            <artifactId>dubbo</artifactId>\n            <version>2.5.3</version>\n            <exclusions>\n                <exclusion>\n                    <groupId>org.springframework</groupId>\n                    <artifactId>spring</artifactId>\n                </exclusion>\n                <exclusion>\n                    <artifactId>netty</artifactId>\n                    <groupId>org.jboss.netty</groupId>\n                </exclusion>\n            </exclusions>\n        </dependency>\n        <dependency>\n            <groupId>org.apache.zookeeper</groupId>\n            <artifactId>zookeeper</artifactId>\n            <version>3.4.10</version>\n        </dependency>\n        <dependency>\n            <groupId>com.101tec</groupId>\n            <artifactId>zkclient</artifactId>\n            <version>0.10</version>\n        </dependency>\n    </dependencies>\n```\n然后在provider中实现common模块的接口，如下：\n```\npublic class SayHelloImpl implements SayHello {\n    public String sayHello(String name) {\n        return \"Hello \"+name;\n    }\n}\n```\n\n然后我们需要在provider的spring配置文件中暴露服务，如下：\n```\n<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<beans xmlns=\"http://www.springframework.org/schema/beans\"\n       xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:dubbo=\"http://code.alibabatech.com/schema/dubbo\"\n       xsi:schemaLocation=\"http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://code.alibabatech.com/schema/dubbo http://code.alibabatech.com/schema/dubbo/dubbo.xsd\">\n<dubbo:application name=\"hello-world-app\"></dubbo:application>\n    <!--<dubbo:registry address=\"multicast://224.5.6.7:2181\"/>-->\n    <dubbo:registry address=\"zookeeper://192.168.248.128:2181\"/>\n    <dubbo:protocol name=\"dubbo\" port=\"20880\"/>\n    <dubbo:service interface=\"org.sang.SayHello\" ref=\"sayHelloImpl\"/>\n    <bean id=\"sayHelloImpl\" class=\"org.sang.SayHelloImpl\"/>\n</beans>\n```\n\n这里我采用了dubbo推荐的注册中心zookeeper，关于Linux上zookeeper的安装小伙伴们可以参考[Linux上安装Zookeeper以及一些注意事项](http://blog.csdn.net/u012702547/article/details/77569325)。\n注册地址就是你安装zookeeper的服务器地址，然后将服务的接口暴露出来即可。\n\n最后我们采用一个main方法将provider跑起来，如下：\n```\npublic class Main {\n    public static void main(String[] args) throws IOException {\n        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext(\"applicationContext.xml\");\n        ctx.start();\n        System.in.read();\n    }\n}\n```\n\nOK,如此之后我们的provider模块就算开发完成了。\n\n# 在consumer模块中消费服务\n\n首先在consumer模块中添加相关依赖，要依赖的东西和provider的依赖一样，这里我就不再重复贴出代码。\n然后我们在consumer的spring配置文件中订阅服务，订阅方式如下：\n```\n<?xml version=\"1.0\" encoding=\"UTF-8\"?>\n<beans xmlns=\"http://www.springframework.org/schema/beans\"\n       xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" xmlns:dubbo=\"http://code.alibabatech.com/schema/dubbo\"\n       xsi:schemaLocation=\"http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://code.alibabatech.com/schema/dubbo http://code.alibabatech.com/schema/dubbo/dubbo.xsd\">\n    <dubbo:application name=\"consumer-of-helloworld-app\"/>\n    <!--<dubbo:registry address=\"multicast://224.5.6.7:2181\" check=\"false\"/>-->\n    <dubbo:registry address=\"zookeeper://192.168.248.128:2181\" check=\"false\"/>\n    <dubbo:reference id=\"sayHello\" interface=\"org.sang.SayHello\" check=\"false\"/>\n</beans>\n```\n首先订阅地址依然是zookeeper的地址，然后注册一个SayHello的bean，这个bean可以直接在我们的工程中使用。\n一样，我们还是通过一个main方法来启动服务消费端：\n```\npublic class Main {\n    public static void main(String[] args) {\n        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext(\"applicationContext.xml\");\n        SayHello sayHello = (SayHello) ctx.getBean(\"sayHello\");\n        String s = sayHello.sayHello(\"张三\");\n        System.out.println(s);\n    }\n}\n```\n运行结果如下：\n![这里写图片描述](http://img.blog.csdn.net/20170826173218470?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\nOk，至此，一个简单的案例就完成了，有问题欢迎小伙伴留言讨论。\n\n案例下载：[-----------]()（CSDN下载必须设置积分，如果小伙伴们没有积分，留下邮箱我私发你）\n\n参考资料：http://dubbo.io\n\n更多JavaEE资料请关注公众号：\n\n![这里写图片描述](http://img.blog.csdn.net/20170826173440218?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n以上。\n\n', '<p>相信有很多小伙伴都知道，dubbo是一个分布式、高性能、透明化的RPC服务框架，提供服务自动注册、自动发现等高效服务治理方案，dubbo的中文文档也是非常全的，中文文档可以参考这里**<a href=\"http://dubbo.io/\" target=\"_blank\">dubbo.io</a>**。由于官网的介绍比较简洁，我这里打算通过Maven多模块工程再给小伙伴们演示一下用法。</p>\n<p><img src=\"http://localhost:80/blogimg/20171224/f301f919-f191-4e12-9a19-bce8f82a00f0_Image003.png\" alt=\"Image 003.png\" /></p>\n<hr />\n<p>环境：IntelliJ IDEA2017.1</p>\n<hr />\n<p>关于如何在IntelliJ IDEA中创建Maven多模块项目，小伙伴们可以参考之前的博客<a href=\"http://blog.csdn.net/u012702547/article/details/77431765\" target=\"_blank\"> IntelliJ IDEA中创建Web聚合项目(Maven多模块项目) </a>，这里我就不再赘述。<br />\n这里我还是以dubbo官方文档中的例子作为基准，我们来详细的看看运行过程。</p>\n<h1>创建一个Maven工程</h1>\n<p>IntelliJ中创建Maven工程的方式我这里就不再多说了，这里只说一点，工程创建成功之后，将src目录删除，因为我们不需要在这个工程下面写代码，我们将以这个工程为父工程，然后给它创建多个模块。</p>\n<h1>向创建好的工程中添加模块</h1>\n<p>当我们第一步成功创建了要给Maven工程之后，第二步我们就向这个Maven工程中添加三个模块，分别是common，provider和consumer三个模块，添加完成之后效果如下：<br />\n<img src=\"http://img.blog.csdn.net/20170826153752910?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<p>provider将作为我们的服务提供者，consumer将作为服务消费者，这两个好理解，除了这两个之外我们还需要要给common模块，common模块主要是提供公共接口，供服务提供者和服务消费者使用。</p>\n<h1>向common模块中添加接口</h1>\n<p>在common模块中，添加一个SayHello接口，如下：</p>\n<p><img src=\"http://img.blog.csdn.net/20170826154808445?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<h1>provider模块依赖common并提供服务</h1>\n<p>1.首先打开provider的pom.xml文件，在其中添加依赖，要添加的依赖有如下四个小类：</p>\n<blockquote>\n<p>1.添加对common模块的依赖<br />\n2.添加对spring的依赖<br />\n3.添加对dubbo的依赖<br />\n4.添加对zookeeper的依赖</p>\n</blockquote>\n<p>如下：</p>\n<pre><code class=\"lang-\">&lt;dependencies&gt;\n        &lt;dependency&gt;\n            &lt;groupId&gt;org.sang&lt;/groupId&gt;\n            &lt;artifactId&gt;common&lt;/artifactId&gt;\n            &lt;version&gt;1.0-SNAPSHOT&lt;/version&gt;\n        &lt;/dependency&gt;\n        &lt;dependency&gt;\n            &lt;groupId&gt;org.springframework&lt;/groupId&gt;\n            &lt;artifactId&gt;spring-web&lt;/artifactId&gt;\n            &lt;version&gt;4.3.10.RELEASE&lt;/version&gt;\n        &lt;/dependency&gt;\n        &lt;dependency&gt;\n            &lt;groupId&gt;com.alibaba&lt;/groupId&gt;\n            &lt;artifactId&gt;dubbo&lt;/artifactId&gt;\n            &lt;version&gt;2.5.3&lt;/version&gt;\n            &lt;exclusions&gt;\n                &lt;exclusion&gt;\n                    &lt;groupId&gt;org.springframework&lt;/groupId&gt;\n                    &lt;artifactId&gt;spring&lt;/artifactId&gt;\n                &lt;/exclusion&gt;\n                &lt;exclusion&gt;\n                    &lt;artifactId&gt;netty&lt;/artifactId&gt;\n                    &lt;groupId&gt;org.jboss.netty&lt;/groupId&gt;\n                &lt;/exclusion&gt;\n            &lt;/exclusions&gt;\n        &lt;/dependency&gt;\n        &lt;dependency&gt;\n            &lt;groupId&gt;org.apache.zookeeper&lt;/groupId&gt;\n            &lt;artifactId&gt;zookeeper&lt;/artifactId&gt;\n            &lt;version&gt;3.4.10&lt;/version&gt;\n        &lt;/dependency&gt;\n        &lt;dependency&gt;\n            &lt;groupId&gt;com.101tec&lt;/groupId&gt;\n            &lt;artifactId&gt;zkclient&lt;/artifactId&gt;\n            &lt;version&gt;0.10&lt;/version&gt;\n        &lt;/dependency&gt;\n    &lt;/dependencies&gt;\n</code></pre>\n<p>然后在provider中实现common模块的接口，如下：</p>\n<pre><code class=\"lang-\">public class SayHelloImpl implements SayHello {\n    public String sayHello(String name) {\n        return &quot;Hello &quot;+name;\n    }\n}\n</code></pre>\n<p>然后我们需要在provider的spring配置文件中暴露服务，如下：</p>\n<pre><code class=\"lang-\">&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot;?&gt;\n&lt;beans xmlns=&quot;http://www.springframework.org/schema/beans&quot;\n       xmlns:xsi=&quot;http://www.w3.org/2001/XMLSchema-instance&quot; xmlns:dubbo=&quot;http://code.alibabatech.com/schema/dubbo&quot;\n       xsi:schemaLocation=&quot;http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://code.alibabatech.com/schema/dubbo http://code.alibabatech.com/schema/dubbo/dubbo.xsd&quot;&gt;\n&lt;dubbo:application name=&quot;hello-world-app&quot;&gt;&lt;/dubbo:application&gt;\n    &lt;!--&lt;dubbo:registry address=&quot;multicast://224.5.6.7:2181&quot;/&gt;--&gt;\n    &lt;dubbo:registry address=&quot;zookeeper://192.168.248.128:2181&quot;/&gt;\n    &lt;dubbo:protocol name=&quot;dubbo&quot; port=&quot;20880&quot;/&gt;\n    &lt;dubbo:service interface=&quot;org.sang.SayHello&quot; ref=&quot;sayHelloImpl&quot;/&gt;\n    &lt;bean id=&quot;sayHelloImpl&quot; class=&quot;org.sang.SayHelloImpl&quot;/&gt;\n&lt;/beans&gt;\n</code></pre>\n<p>这里我采用了dubbo推荐的注册中心zookeeper，关于Linux上zookeeper的安装小伙伴们可以参考<a href=\"http://blog.csdn.net/u012702547/article/details/77569325\" target=\"_blank\">Linux上安装Zookeeper以及一些注意事项</a>。<br />\n注册地址就是你安装zookeeper的服务器地址，然后将服务的接口暴露出来即可。</p>\n<p>最后我们采用一个main方法将provider跑起来，如下：</p>\n<pre><code class=\"lang-\">public class Main {\n    public static void main(String[] args) throws IOException {\n        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext(&quot;applicationContext.xml&quot;);\n        ctx.start();\n        System.in.read();\n    }\n}\n</code></pre>\n<p>OK,如此之后我们的provider模块就算开发完成了。</p>\n<h1>在consumer模块中消费服务</h1>\n<p>首先在consumer模块中添加相关依赖，要依赖的东西和provider的依赖一样，这里我就不再重复贴出代码。<br />\n然后我们在consumer的spring配置文件中订阅服务，订阅方式如下：</p>\n<pre><code class=\"lang-\">&lt;?xml version=&quot;1.0&quot; encoding=&quot;UTF-8&quot;?&gt;\n&lt;beans xmlns=&quot;http://www.springframework.org/schema/beans&quot;\n       xmlns:xsi=&quot;http://www.w3.org/2001/XMLSchema-instance&quot; xmlns:dubbo=&quot;http://code.alibabatech.com/schema/dubbo&quot;\n       xsi:schemaLocation=&quot;http://www.springframework.org/schema/beans http://www.springframework.org/schema/beans/spring-beans.xsd http://code.alibabatech.com/schema/dubbo http://code.alibabatech.com/schema/dubbo/dubbo.xsd&quot;&gt;\n    &lt;dubbo:application name=&quot;consumer-of-helloworld-app&quot;/&gt;\n    &lt;!--&lt;dubbo:registry address=&quot;multicast://224.5.6.7:2181&quot; check=&quot;false&quot;/&gt;--&gt;\n    &lt;dubbo:registry address=&quot;zookeeper://192.168.248.128:2181&quot; check=&quot;false&quot;/&gt;\n    &lt;dubbo:reference id=&quot;sayHello&quot; interface=&quot;org.sang.SayHello&quot; check=&quot;false&quot;/&gt;\n&lt;/beans&gt;\n</code></pre>\n<p>首先订阅地址依然是zookeeper的地址，然后注册一个SayHello的bean，这个bean可以直接在我们的工程中使用。<br />\n一样，我们还是通过一个main方法来启动服务消费端：</p>\n<pre><code class=\"lang-\">public class Main {\n    public static void main(String[] args) {\n        ClassPathXmlApplicationContext ctx = new ClassPathXmlApplicationContext(&quot;applicationContext.xml&quot;);\n        SayHello sayHello = (SayHello) ctx.getBean(&quot;sayHello&quot;);\n        String s = sayHello.sayHello(&quot;张三&quot;);\n        System.out.println(s);\n    }\n}\n</code></pre>\n<p>运行结果如下：<br />\n<img src=\"http://img.blog.csdn.net/20170826173218470?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<p>Ok，至此，一个简单的案例就完成了，有问题欢迎小伙伴留言讨论。</p>\n<p>案例下载：<a href=\"\" target=\"_blank\">-----------</a>（CSDN下载必须设置积分，如果小伙伴们没有积分，留下邮箱我私发你）</p>\n<p>参考资料：http://dubbo.io</p>\n<p>更多JavaEE资料请关注公众号：</p>\n<p><img src=\"http://img.blog.csdn.net/20170826173440218?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<p>以上。</p>\n', '相信有很多小伙伴都知道，dubbo是一个分布式、高性能、透明化的RPC服务框架，提供服务自动注册、自', '1', '3', '2017-12-24 09:35:06', '2017-12-24 09:35:06', '1', '1');
INSERT INTO `article` VALUES ('111', 'WebSocket刨根问底(一)', '年初的时候，写过两篇博客介绍在Spring Boot中如何使用WebSocket发送消息【[在Spring Boot框架下使用WebSocket实现消息推送](http://blog.csdn.net/u012702547/article/details/53816326)】【[在Spring Boot框架下使用WebSocket实现聊天功能](http://blog.csdn.net/u012702547/article/details/53835453)】，最近看到很多小伙伴对WebSocket的讨论还比较火热，so，打算写几篇文章来系统的介绍下websocket。OK，废话不多说，下面开始我们的正文。\n\n---\n# 为什么要有WebSocket这个技术\n\n大家都知道，HTML页面在刚刚开始出现的时候是静态的，不能够进行交互，后来有了JavaScript，在一定程度上解决了这个问题，但是JavaScript刚出现的时候并不能和服务端进行交互，直到Ajax的出现。Ajax有效的解决了页面和服务端进行交互的问题，不过Ajax有一个问题，就是所有的请求都必须由客户端发起，服务端进行响应，如果服务端有最新的消息，难以即时的发送到客户端去，在WebSocket技术出现之前，为了让客户端能够即时的获取服务端的数据，一般采用如下三种方案：\n## 轮询\n这是最简单的一种解决方案， 就是客户端在固定的时间间隔下（一般是1秒）不停的向服务器端发送请求，查看服务端是否有最新的数据，服务端如果有最新的数据则返回给客户端，服务端如果没有则返回一个空的json或者xml文档，这种方式的实现起来简单，但是弊端也很明显，就是会有大量的无效请求，服务端的资源被大大的浪费了。\n## 长连接\n长连接有点类似于轮询，不同的是服务端不是每次都会响应客户端的请求，只有在服务端有最新数据的时候才会响应客户端的请求，这种方式很明显会节省网络资源和服务端资源，但是也存在一些问题，比如：\n>1.如果浏览器在服务器响应之前有新数据要发送就只能创建一个新的并发请求，或者先尝试断掉当前请求然后再创建新的请求。  \n>2.TCP和HTTP规范中都有连接超时一说，所以所谓的长连接并不能一直持续，服务端和客户端的连接需要定期的连接和关闭再连接，当然也有一些技术能够延长每次连接的时间，这是题外话。  \n\n## Applet和Flash\nApplet和Flash都已经是明日黄花了，不过这两个技术在当年除了可以让我们的HTML页面更加绚丽之外，还可以解决消息推送问题。在Ajax这种技术去实现全双工通信已经陷入困境的时候，开发者试图用Applet和Flash来模拟全双工通信，开发者可以创建一个只有1个像素点大小的普通透明的Applet或者Flash，然后将之内嵌在页面中， 然后这个Applet或者Flash中的代码创建出一个Socket连接，这种连接方式消除了HTTP协议中的各种限制，当服务器有消息发送到客户端的时候，开发者可以在Applet或者Flash中调用JavaScript函数，并将服务器传来的消息传递给JavaScript函数，然后更新页面，当浏览器有数据要发送给服务器的时候，也一样，通过Applet或者Flash来传递。这种方式真正的实现了全双工通信，不过也有问题，如下：\n>1.浏览器必须能够运行Java或者Flash  \n>2.无论是Applet还是Flash都存在安全问题  \n>3.随着HTML5在标准在浏览器中广泛支持，Flash下架已经被提上日程([\n终于要放弃，Adobe宣布2020年正式停止支持Flash](http://tech.163.com/17/0726/07/CQ8M4HT200097U7T.html))  \n\n# WebSocket有哪些特点\n\n既然上面这些技术都不行，那么谁行？当然是我WebSocket了！\n\n## HTTP/1.1的升级特性\n要说WebSocket协议，我们得先来说说HTTP协议的一个请求头，事实上，所有的HTTP客户端（浏览器、移动端等）都可以在请求头中包含Connection:Upgrade，这个表示客户端希望升级请求协议，那么希望升级成什么样的协议呢？我们需要在Upgrade头中指定一个或者多个协议的列表，当然这些协议必须兼容HTTP/1.1协议。服务器收到请求之后，如果接受升级请求，那么将会返回一个101的状态码，表示转换请求协议，同时在响应的Upgrade头中使用单个值，这个单个值就是请求协议列表中服务器支持的第一个协议（即请求头的Upgrade字段中列出来的协议列表中服务器支持的第一个协议）。  \nHTTP升级最大的好处是最终使我们可以使用任意的协议，在升级握手完成之后，它就不再使用HTTP连接了，我们甚至可以在升级握手完成之后建立一个Socket连接，理论上我们可以使用HTTP升级在两个端点之间使用任何自己设计的协议，进而创建出各种各样的TCP通信，当然浏览器不会让开发者随意去这么做，而是要指定某些协议，WebSocket应运而生！\n我们来看一个截图：  \n![这里写图片描述](http://img.blog.csdn.net/20170827204229481?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n## 使用HTTP/1.1升级的WebSocket协议\nOK，了解了HTTP/1.1协议的升级特性之后，我们再来详细看看整个过程是怎么样的？  \n一个WebSocket请求首先使用非正常的HTTP请求以特定的模式访问一个URL，这个URL有两种模式，分别是ws和wss，对应HTTP协议中的http和https，请求头中除了Connection:Upgrade之外还有一个Upgrade:websocket,它们两个将共同告诉服务器将连接升级为WebSocket这样一种全双工协议。如此，在握手完成之后，文本消息或者其他二进制消息就可以同时在两个方向上进行发送，而不需要关闭和重建连接。此时的客户端和服务端关系其实是对等的，他们都可以互相向对方主动发消息。那么这里有一点需要注意：那就是ws和wss模式并不能算作HTTP协议的一部分，因为HTTP请求和请求头并不包含URL模式，HTTP请求只在请求的第一行中包含相对于服务器的URL，在Host头中包含域名，而WebSocket中特有的ws和wss模式主要用于通知浏览器和API是希望使用SSL/TLS(wss)，还是希望使用不加密的方式(ws)进行连接。\n## WebSocket协议的优势\n说了这么多，那么接下来我们来看看WebSocket协议都有哪些优势：\n>1.由于WebSocket连接在端口80(ws)或者443(wss)上创建，与HTTP使用的端口相同，这样，基本上所有的防火墙都不会阻塞WebSocket连接  \n\n>2.WebSocket使用HTTP协议进行握手，因此它可以自然而然的集成到网络浏览器和HTTP服务器中  \n\n>3.心跳消息(ping和pong)将被反复的发送，进而保持WebSocket连接几乎一直处于活跃状态。一般来说是这样，一个节点周期性的发送一个小数据包到另外一个节点(ping)，而另一个节点则使用了包含了相同数据的数据包作为响应(pong),这样两个节点都将处于连接状态  \n\n>4.使用该协议，当消息启动或者到达的时候，服务端和客户端都可以知道  \n\n>5.WebSocket连接关闭时将发送一个特殊的关闭消息  \n\n>6.WebSocket支持跨域，可以避免Ajax的限制  \n\n>7.HTTP规范要求浏览器将并发连接数限制为每个主机名两个连接，但是当我们使用WebSocket的时候，当握手完成之后该限制就不存在了，因为此时的连接已经不再是HTTP连接了  \n## WebSocket协议的用途\n\n说了这么多那么WebSocket协议到底可以用在哪些地方呢？事实上，WebSocket协议的用途几乎是没有限制的，比如：\n\n>1.网页上的在线聊天   \n\n>2.多人在线游戏   \n\n>3.在线股票网站   \n\n>4.在线即时新闻网站   \n\n>5.高清视频流   \n\n>6.应用集群之间的通信  \n\n>7.远程系统/软件的状态和性能的实时监控 \n\n\n# 结语  \n\n说了这么多，可能很多小伙伴觉得这个WebSocket貌似用起来很麻烦，其实不麻烦，所有的东西都有对应的API来帮助我们实现，<big>**小伙伴们稍安勿躁，我们将在下篇文章中来介绍WebSocket的实战应用。**</big>\n\n参考资料：《JavaEE 编程》\n\n更多JavaEE资料请关注公众号  \n![这里写图片描述](http://img.blog.csdn.net/20170827204306560?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n以上。\n', '<p>年初的时候，写过两篇博客介绍在Spring Boot中如何使用WebSocket发送消息【<a href=\"http://blog.csdn.net/u012702547/article/details/53816326\" target=\"_blank\">在Spring Boot框架下使用WebSocket实现消息推送</a>】【<a href=\"http://blog.csdn.net/u012702547/article/details/53835453\" target=\"_blank\">在Spring Boot框架下使用WebSocket实现聊天功能</a>】，最近看到很多小伙伴对WebSocket的讨论还比较火热，so，打算写几篇文章来系统的介绍下websocket。OK，废话不多说，下面开始我们的正文。</p>\n<hr />\n<h1>为什么要有WebSocket这个技术</h1>\n<p>大家都知道，HTML页面在刚刚开始出现的时候是静态的，不能够进行交互，后来有了JavaScript，在一定程度上解决了这个问题，但是JavaScript刚出现的时候并不能和服务端进行交互，直到Ajax的出现。Ajax有效的解决了页面和服务端进行交互的问题，不过Ajax有一个问题，就是所有的请求都必须由客户端发起，服务端进行响应，如果服务端有最新的消息，难以即时的发送到客户端去，在WebSocket技术出现之前，为了让客户端能够即时的获取服务端的数据，一般采用如下三种方案：</p>\n<h2>轮询</h2>\n<p>这是最简单的一种解决方案， 就是客户端在固定的时间间隔下（一般是1秒）不停的向服务器端发送请求，查看服务端是否有最新的数据，服务端如果有最新的数据则返回给客户端，服务端如果没有则返回一个空的json或者xml文档，这种方式的实现起来简单，但是弊端也很明显，就是会有大量的无效请求，服务端的资源被大大的浪费了。</p>\n<h2>长连接</h2>\n<p>长连接有点类似于轮询，不同的是服务端不是每次都会响应客户端的请求，只有在服务端有最新数据的时候才会响应客户端的请求，这种方式很明显会节省网络资源和服务端资源，但是也存在一些问题，比如：</p>\n<blockquote>\n<p>1.如果浏览器在服务器响应之前有新数据要发送就只能创建一个新的并发请求，或者先尝试断掉当前请求然后再创建新的请求。<br />\n2.TCP和HTTP规范中都有连接超时一说，所以所谓的长连接并不能一直持续，服务端和客户端的连接需要定期的连接和关闭再连接，当然也有一些技术能够延长每次连接的时间，这是题外话。</p>\n</blockquote>\n<h2>Applet和Flash</h2>\n<p>Applet和Flash都已经是明日黄花了，不过这两个技术在当年除了可以让我们的HTML页面更加绚丽之外，还可以解决消息推送问题。在Ajax这种技术去实现全双工通信已经陷入困境的时候，开发者试图用Applet和Flash来模拟全双工通信，开发者可以创建一个只有1个像素点大小的普通透明的Applet或者Flash，然后将之内嵌在页面中， 然后这个Applet或者Flash中的代码创建出一个Socket连接，这种连接方式消除了HTTP协议中的各种限制，当服务器有消息发送到客户端的时候，开发者可以在Applet或者Flash中调用JavaScript函数，并将服务器传来的消息传递给JavaScript函数，然后更新页面，当浏览器有数据要发送给服务器的时候，也一样，通过Applet或者Flash来传递。这种方式真正的实现了全双工通信，不过也有问题，如下：</p>\n<blockquote>\n<p>1.浏览器必须能够运行Java或者Flash<br />\n2.无论是Applet还是Flash都存在安全问题<br />\n3.随着HTML5在标准在浏览器中广泛支持，Flash下架已经被提上日程(<a href=\"http://tech.163.com/17/0726/07/CQ8M4HT200097U7T.html\" target=\"_blank\"><br />\n终于要放弃，Adobe宣布2020年正式停止支持Flash</a>)</p>\n</blockquote>\n<h1>WebSocket有哪些特点</h1>\n<p>既然上面这些技术都不行，那么谁行？当然是我WebSocket了！</p>\n<h2>HTTP/1.1的升级特性</h2>\n<p>要说WebSocket协议，我们得先来说说HTTP协议的一个请求头，事实上，所有的HTTP客户端（浏览器、移动端等）都可以在请求头中包含Connection:Upgrade，这个表示客户端希望升级请求协议，那么希望升级成什么样的协议呢？我们需要在Upgrade头中指定一个或者多个协议的列表，当然这些协议必须兼容HTTP/1.1协议。服务器收到请求之后，如果接受升级请求，那么将会返回一个101的状态码，表示转换请求协议，同时在响应的Upgrade头中使用单个值，这个单个值就是请求协议列表中服务器支持的第一个协议（即请求头的Upgrade字段中列出来的协议列表中服务器支持的第一个协议）。<br />\nHTTP升级最大的好处是最终使我们可以使用任意的协议，在升级握手完成之后，它就不再使用HTTP连接了，我们甚至可以在升级握手完成之后建立一个Socket连接，理论上我们可以使用HTTP升级在两个端点之间使用任何自己设计的协议，进而创建出各种各样的TCP通信，当然浏览器不会让开发者随意去这么做，而是要指定某些协议，WebSocket应运而生！<br />\n我们来看一个截图：<br />\n<img src=\"http://img.blog.csdn.net/20170827204229481?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<h2>使用HTTP/1.1升级的WebSocket协议</h2>\n<p>OK，了解了HTTP/1.1协议的升级特性之后，我们再来详细看看整个过程是怎么样的？<br />\n一个WebSocket请求首先使用非正常的HTTP请求以特定的模式访问一个URL，这个URL有两种模式，分别是ws和wss，对应HTTP协议中的http和https，请求头中除了Connection:Upgrade之外还有一个Upgrade:websocket,它们两个将共同告诉服务器将连接升级为WebSocket这样一种全双工协议。如此，在握手完成之后，文本消息或者其他二进制消息就可以同时在两个方向上进行发送，而不需要关闭和重建连接。此时的客户端和服务端关系其实是对等的，他们都可以互相向对方主动发消息。那么这里有一点需要注意：那就是ws和wss模式并不能算作HTTP协议的一部分，因为HTTP请求和请求头并不包含URL模式，HTTP请求只在请求的第一行中包含相对于服务器的URL，在Host头中包含域名，而WebSocket中特有的ws和wss模式主要用于通知浏览器和API是希望使用SSL/TLS(wss)，还是希望使用不加密的方式(ws)进行连接。</p>\n<h2>WebSocket协议的优势</h2>\n<p>说了这么多，那么接下来我们来看看WebSocket协议都有哪些优势：</p>\n<blockquote>\n<p>1.由于WebSocket连接在端口80(ws)或者443(wss)上创建，与HTTP使用的端口相同，这样，基本上所有的防火墙都不会阻塞WebSocket连接</p>\n</blockquote>\n<blockquote>\n<p>2.WebSocket使用HTTP协议进行握手，因此它可以自然而然的集成到网络浏览器和HTTP服务器中</p>\n</blockquote>\n<blockquote>\n<p>3.心跳消息(ping和pong)将被反复的发送，进而保持WebSocket连接几乎一直处于活跃状态。一般来说是这样，一个节点周期性的发送一个小数据包到另外一个节点(ping)，而另一个节点则使用了包含了相同数据的数据包作为响应(pong),这样两个节点都将处于连接状态</p>\n</blockquote>\n<blockquote>\n<p>4.使用该协议，当消息启动或者到达的时候，服务端和客户端都可以知道</p>\n</blockquote>\n<blockquote>\n<p>5.WebSocket连接关闭时将发送一个特殊的关闭消息</p>\n</blockquote>\n<blockquote>\n<p>6.WebSocket支持跨域，可以避免Ajax的限制</p>\n</blockquote>\n<blockquote>\n<p>7.HTTP规范要求浏览器将并发连接数限制为每个主机名两个连接，但是当我们使用WebSocket的时候，当握手完成之后该限制就不存在了，因为此时的连接已经不再是HTTP连接了</p>\n</blockquote>\n<h2>WebSocket协议的用途</h2>\n<p>说了这么多那么WebSocket协议到底可以用在哪些地方呢？事实上，WebSocket协议的用途几乎是没有限制的，比如：</p>\n<blockquote>\n<p>1.网页上的在线聊天</p>\n</blockquote>\n<blockquote>\n<p>2.多人在线游戏</p>\n</blockquote>\n<blockquote>\n<p>3.在线股票网站</p>\n</blockquote>\n<blockquote>\n<p>4.在线即时新闻网站</p>\n</blockquote>\n<blockquote>\n<p>5.高清视频流</p>\n</blockquote>\n<blockquote>\n<p>6.应用集群之间的通信</p>\n</blockquote>\n<blockquote>\n<p>7.远程系统/软件的状态和性能的实时监控</p>\n</blockquote>\n<h1>结语</h1>\n<p>说了这么多，可能很多小伙伴觉得这个WebSocket貌似用起来很麻烦，其实不麻烦，所有的东西都有对应的API来帮助我们实现，<big><strong>小伙伴们稍安勿躁，我们将在下篇文章中来介绍WebSocket的实战应用。</strong></big></p>\n<p>参考资料：《JavaEE 编程》</p>\n<p>更多JavaEE资料请关注公众号<br />\n<img src=\"http://img.blog.csdn.net/20170827204306560?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<p>以上。</p>\n', '年初的时候，写过两篇博客介绍在Spring Boot中如何使用WebSocket发送消息【在Spri', '2', '3', '2017-12-21 22:33:31', '2017-12-21 22:33:31', '1', '0');
INSERT INTO `article` VALUES ('112', 'WebSocket刨根问底(二)', '上篇文章【[WebSocket刨根问底(一)](http://blog.csdn.net/u012702547/article/details/77621195)】中我们对WebSocket的一些基本理论进行了介绍，但是并没有过多的涉及到一些实战的内容，今天我希望能够用几个简单的案例来向小伙伴们展示下WebSocket的一些具体用法。\n# WebSocket API有哪些\n首先有一点小伙伴们需要明确，那就是WebSocket并不总是用在浏览器和服务器的通信中，只要任意两个使用框架编写，支持WebSocket的应用程序都可以创建WebSocket连接进行通信，基于此，许多WebSocket实现在客户端或者服务器终端工具中都是可用的，比如Java或者***.***NET等。我们这里主要是介绍Java WebSocket和javascript中的websocket的使用，js中websocket的使用这个好理解，就是扮演一个客户端的角色，Java中的WebSocket分两种角色，一种是Java客户端终端的WebSocket（作用类似于JavaScript中的WebSocket），还有一种角色是Java服务器终端。本文主要介绍javascript中websocket的使用以及java服务器终端中websocket的使用，java客户端使用websocket这种情形并不多见，不在本文讨论的范围之内。\n# JavaScript中WebSocket的使用\n目前基本上只要的浏览器不是古董级的，基本上都支持WebSocket了，w3c目前已经统一了浏览器中websocket通信的标准和接口，所有的浏览器都通过WebSocket接口的实现提供WebSocket通信。举几个简单的API我们来看看：  \n\n## 1.创建一个WebSocket对象  \n```\nvar webSocket = new WebSocket(\"ws://localhost/myws\");\n```  \n## 2.WebSocket中几个常见属性  \nreadyState表示当前WebSocket的连接状态，有四种不同的取值,分别是CONNECTING(0),OPEN(1),CLOSING(2)和CLOSED(3)  \n```if(webSocket.readyState==WebSocket.OPEN){/*do something*/}```  \n\n\n## 3.几个常见方法 \n\n``` \n	\n	webSocket.onopen=function (event) {\n    	//连接成功时触发    \n    }\n    webSocket.onclose=function (event) {\n    	//连接关闭时触发    \n    }\n    webSocket.onerror=function (event) {\n    	//连接出错时触发    \n    }\n    webSocket.onmessage=function (event) {\n    	//收到消息时触发    \n    }\n\n\n```\n\n# Java服务端中WebSocket的使用\n\nJava服务端中WebSocket 的使用有几个点需要注意下，首先Java服务端的WebSocket想要使用，你的Tomcat必须得是Tomcat7以上的版本，Tomcat7才开始了对WebSocket的支持，不过这个条件想必小伙伴们都能满足吧！Java服务端WebSocket的使用主要是有几个注解需要我们了解下用法。如下：  \n\n```\n\n    @ServerEndpoint(\"/myws\")\n    public class WebSocketServer {\n	    @OnMessage\n	    public void onMessage(String message, Session session) throws IOException {\n	        System.out.println(\"收到了客户端发来的消息：\" + message);\n	        session.getBasicRemote().sendText(\"服务端返回：\" + message);\n	    }\n	\n	    @OnOpen\n	    public void onOpen(Session session) throws IOException {\n	        System.out.println(\"客户端连接成功\");\n	    }\n	\n	    @OnClose\n	    public void onClose(Session session) throws IOException {\n	        session.getBasicRemote().sendText(\"连接关闭\");\n	        System.out.println(\"连接关闭\");\n	    }\n    }\n\n```\n\n关于这个类我说如下几点：\n>1.@ServerEndPoint注解表示将该类升级为一个WebSocket服务端点  \n>2.@OnMessage注解表示收到客户端发来的消息时触发  \n>3.@OnOpen注解表示当客户端连接上服务端时触发  \n>4.@OnClose注解表示当连接关闭时触发  \n\n---\nOK，经过上面的介绍，我们对WebSocket的API已经有了一个大概的了解，那么接下来我们就来通过一个简单的案例来看看WebSocket的使用。\n\n# 一个简单的互发消息的案例\n## 创建工程\n首先创建一个普通的Java Web工程，正常情况下我们创建一个Java Web工程，这个工程如下：  \n\n![这里写图片描述](http://img.blog.csdn.net/20170828205157703?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n大家看到这个工程中是引用的Tomcat是只引用了Tomcat中的两个Jar包，websocket的jar默认情况下并没有引入，这个需要我们自己手动引入，引入方式也很简单，如下：\n\n1.选中当前工程，右键单击，点击open module setting，打开工程的设置页面：  \n\n![这里写图片描述](http://img.blog.csdn.net/20170828205247335?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n2.找到Tomcat文件夹下的lib包中的websocket的jar添加进来即可，如下：  \n\n![这里写图片描述](http://img.blog.csdn.net/20170828205434340?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n3.添加之后，我们的现在的工程是这个样子的：  \n\n![这里写图片描述](http://img.blog.csdn.net/20170828205612465?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n## 创建HTML页面\n创建HTML页面，编写JavaScript中的websocket逻辑，页面显示如下：  \n\n![这里写图片描述](http://img.blog.csdn.net/20170828205917224?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n首先我们点击连接按钮连接上服务端，然后再点击发送按钮向服务端发送消息，代码如下：\n\n```\n<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n    <meta charset=\"UTF-8\">\n    <title>ws页面</title>\n    <script src=\"jquery-3.2.1.js\"></script>\n</head>\n<body>\n<input type=\"button\" value=\"连接\" id=\"btnClick1\"><br>\n<input type=\"text\" id=\"msg\"><input type=\"button\" value=\"发送\" id=\"btnClick2\">\n</div>\n<div id=\"resultDiv\"></div>\n<script>\n    var webSocket;\n\n    $(\"#btnClick2\").click(function () {\n        var msg = $(\"#msg\").val();\n        $(\"#resultDiv\").append(\"<p>发送消息:\" + msg+\"</p>\");\n        webSocket.send(msg)\n    });\n    $(\"#btnClick1\").click(function () {\n        $(\"#resultDiv\").append(\"<p>开始连接服务端!</p>\");\n        webSocket = new WebSocket(\"ws://localhost/myws\");\n        webSocket.onerror = function (event) {\n            $(\"#resultDiv\").append(\"<p>onerror:\" + event.data + \"</p>\");\n        }\n        webSocket.onopen = function (event) {\n            $(\"#resultDiv\").append(\"<p>连接成功！</p>\");\n        }\n        webSocket.onmessage = function (event) {\n            $(\"#resultDiv\").append(\"<p>onmessage:\" + event.data + \"</p>\");\n        }\n    });\n\n</script>\n</body>\n</html>\n```\n\n这里涉及到的API的含义我们在上文已经介绍过，这里就不再赘述。\n\n## 创建服务端  \n服务端也比较简单，如下：\n\n```\n@ServerEndpoint(\"/myws\")\npublic class WebSocketServer {\n    @OnMessage\n    public void onMessage(String message, Session session) throws IOException {\n        System.out.println(\"收到了客户端发来的消息：\" + message);\n        session.getBasicRemote().sendText(\"服务端返回：\" + message);\n    }\n\n    @OnOpen\n    public void onOpen(Session session) throws IOException {\n        System.out.println(\"客户端连接成功\");\n    }\n\n    @OnClose\n    public void onClose(Session session) throws IOException {\n        session.getBasicRemote().sendText(\"连接关闭\");\n        System.out.println(\"连接关闭\");\n    }\n}\n```\n\n服务端API的含义我们上文也已经介绍过了，这里我再补充一个小问题，小伙伴们可能看到我们不同的方法里边都有参数，参数的个数和类型都有差异，实际上这里的参数是可变的，这里的具体信息我们会在下一篇文章中详说，这里先这样来写。  \n\nOk，我们的代码写完了。\n\n## 部署测试\n工程的运行就像普通的JavaWeb工程那样，直接运行即可，运行之后，打开html页面，效果如下：  \n\n![这里写图片描述](http://img.blog.csdn.net/20170828211153828?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\nOK，本文先说到这里，下篇文章我们再来详细介绍一个群聊的应用，继续深入使用WebSocket。\n\n工程下载：（由于CSDN下载现在必须要积分，不得已设置了1分，如果小伙伴没有积分，文末留言我发给你。）\n\n更多JavaEE资料请关注公众号：  \n\n![这里写图片描述](http://img.blog.csdn.net/20170828211355113?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n\n以上。。\n\n', '<p>上篇文章【<a href=\"http://blog.csdn.net/u012702547/article/details/77621195\" target=\"_blank\">WebSocket刨根问底(一)</a>】中我们对WebSocket的一些基本理论进行了介绍，但是并没有过多的涉及到一些实战的内容，今天我希望能够用几个简单的案例来向小伙伴们展示下WebSocket的一些具体用法。</p>\n<h1>WebSocket API有哪些</h1>\n<p>首先有一点小伙伴们需要明确，那就是WebSocket并不总是用在浏览器和服务器的通信中，只要任意两个使用框架编写，支持WebSocket的应用程序都可以创建WebSocket连接进行通信，基于此，许多WebSocket实现在客户端或者服务器终端工具中都是可用的，比如Java或者***.***NET等。我们这里主要是介绍Java WebSocket和javascript中的websocket的使用，js中websocket的使用这个好理解，就是扮演一个客户端的角色，Java中的WebSocket分两种角色，一种是Java客户端终端的WebSocket（作用类似于JavaScript中的WebSocket），还有一种角色是Java服务器终端。本文主要介绍javascript中websocket的使用以及java服务器终端中websocket的使用，java客户端使用websocket这种情形并不多见，不在本文讨论的范围之内。</p>\n<h1>JavaScript中WebSocket的使用</h1>\n<p>目前基本上只要的浏览器不是古董级的，基本上都支持WebSocket了，w3c目前已经统一了浏览器中websocket通信的标准和接口，所有的浏览器都通过WebSocket接口的实现提供WebSocket通信。举几个简单的API我们来看看：</p>\n<h2>1.创建一个WebSocket对象</h2>\n<pre><code class=\"lang-\">var webSocket = new WebSocket(&quot;ws://localhost/myws&quot;);\n</code></pre>\n<h2>2.WebSocket中几个常见属性</h2>\n<p>readyState表示当前WebSocket的连接状态，有四种不同的取值,分别是CONNECTING(0),OPEN(1),CLOSING(2)和CLOSED(3)<br />\n<code>if(webSocket.readyState==WebSocket.OPEN){/*do something*/}</code></p>\n<h2>3.几个常见方法</h2>\n<pre><code class=\"lang-\">	\n	webSocket.onopen=function (event) {\n    	//连接成功时触发    \n    }\n    webSocket.onclose=function (event) {\n    	//连接关闭时触发    \n    }\n    webSocket.onerror=function (event) {\n    	//连接出错时触发    \n    }\n    webSocket.onmessage=function (event) {\n    	//收到消息时触发    \n    }\n\n\n</code></pre>\n<h1>Java服务端中WebSocket的使用</h1>\n<p>Java服务端中WebSocket 的使用有几个点需要注意下，首先Java服务端的WebSocket想要使用，你的Tomcat必须得是Tomcat7以上的版本，Tomcat7才开始了对WebSocket的支持，不过这个条件想必小伙伴们都能满足吧！Java服务端WebSocket的使用主要是有几个注解需要我们了解下用法。如下：</p>\n<pre><code class=\"lang-\">\n    @ServerEndpoint(&quot;/myws&quot;)\n    public class WebSocketServer {\n	    @OnMessage\n	    public void onMessage(String message, Session session) throws IOException {\n	        System.out.println(&quot;收到了客户端发来的消息：&quot; + message);\n	        session.getBasicRemote().sendText(&quot;服务端返回：&quot; + message);\n	    }\n	\n	    @OnOpen\n	    public void onOpen(Session session) throws IOException {\n	        System.out.println(&quot;客户端连接成功&quot;);\n	    }\n	\n	    @OnClose\n	    public void onClose(Session session) throws IOException {\n	        session.getBasicRemote().sendText(&quot;连接关闭&quot;);\n	        System.out.println(&quot;连接关闭&quot;);\n	    }\n    }\n\n</code></pre>\n<p>关于这个类我说如下几点：</p>\n<blockquote>\n<p>1.@ServerEndPoint注解表示将该类升级为一个WebSocket服务端点<br />\n2.@OnMessage注解表示收到客户端发来的消息时触发<br />\n3.@OnOpen注解表示当客户端连接上服务端时触发<br />\n4.@OnClose注解表示当连接关闭时触发</p>\n</blockquote>\n<hr />\n<p>OK，经过上面的介绍，我们对WebSocket的API已经有了一个大概的了解，那么接下来我们就来通过一个简单的案例来看看WebSocket的使用。</p>\n<h1>一个简单的互发消息的案例</h1>\n<h2>创建工程</h2>\n<p>首先创建一个普通的Java Web工程，正常情况下我们创建一个Java Web工程，这个工程如下：</p>\n<p><img src=\"http://img.blog.csdn.net/20170828205157703?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<p>大家看到这个工程中是引用的Tomcat是只引用了Tomcat中的两个Jar包，websocket的jar默认情况下并没有引入，这个需要我们自己手动引入，引入方式也很简单，如下：</p>\n<p>1.选中当前工程，右键单击，点击open module setting，打开工程的设置页面：</p>\n<p><img src=\"http://img.blog.csdn.net/20170828205247335?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<p>2.找到Tomcat文件夹下的lib包中的websocket的jar添加进来即可，如下：</p>\n<p><img src=\"http://img.blog.csdn.net/20170828205434340?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<p>3.添加之后，我们的现在的工程是这个样子的：</p>\n<p><img src=\"http://img.blog.csdn.net/20170828205612465?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<h2>创建HTML页面</h2>\n<p>创建HTML页面，编写JavaScript中的websocket逻辑，页面显示如下：</p>\n<p><img src=\"http://img.blog.csdn.net/20170828205917224?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<p>首先我们点击连接按钮连接上服务端，然后再点击发送按钮向服务端发送消息，代码如下：</p>\n<pre><code class=\"lang-\">&lt;!DOCTYPE html&gt;\n&lt;html lang=&quot;en&quot;&gt;\n&lt;head&gt;\n    &lt;meta charset=&quot;UTF-8&quot;&gt;\n    &lt;title&gt;ws页面&lt;/title&gt;\n    &lt;script src=&quot;jquery-3.2.1.js&quot;&gt;&lt;/script&gt;\n&lt;/head&gt;\n&lt;body&gt;\n&lt;input type=&quot;button&quot; value=&quot;连接&quot; id=&quot;btnClick1&quot;&gt;&lt;br&gt;\n&lt;input type=&quot;text&quot; id=&quot;msg&quot;&gt;&lt;input type=&quot;button&quot; value=&quot;发送&quot; id=&quot;btnClick2&quot;&gt;\n&lt;/div&gt;\n&lt;div id=&quot;resultDiv&quot;&gt;&lt;/div&gt;\n&lt;script&gt;\n    var webSocket;\n\n    $(&quot;#btnClick2&quot;).click(function () {\n        var msg = $(&quot;#msg&quot;).val();\n        $(&quot;#resultDiv&quot;).append(&quot;&lt;p&gt;发送消息:&quot; + msg+&quot;&lt;/p&gt;&quot;);\n        webSocket.send(msg)\n    });\n    $(&quot;#btnClick1&quot;).click(function () {\n        $(&quot;#resultDiv&quot;).append(&quot;&lt;p&gt;开始连接服务端!&lt;/p&gt;&quot;);\n        webSocket = new WebSocket(&quot;ws://localhost/myws&quot;);\n        webSocket.onerror = function (event) {\n            $(&quot;#resultDiv&quot;).append(&quot;&lt;p&gt;onerror:&quot; + event.data + &quot;&lt;/p&gt;&quot;);\n        }\n        webSocket.onopen = function (event) {\n            $(&quot;#resultDiv&quot;).append(&quot;&lt;p&gt;连接成功！&lt;/p&gt;&quot;);\n        }\n        webSocket.onmessage = function (event) {\n            $(&quot;#resultDiv&quot;).append(&quot;&lt;p&gt;onmessage:&quot; + event.data + &quot;&lt;/p&gt;&quot;);\n        }\n    });\n\n&lt;/script&gt;\n&lt;/body&gt;\n&lt;/html&gt;\n</code></pre>\n<p>这里涉及到的API的含义我们在上文已经介绍过，这里就不再赘述。</p>\n<h2>创建服务端</h2>\n<p>服务端也比较简单，如下：</p>\n<pre><code class=\"lang-\">@ServerEndpoint(&quot;/myws&quot;)\npublic class WebSocketServer {\n    @OnMessage\n    public void onMessage(String message, Session session) throws IOException {\n        System.out.println(&quot;收到了客户端发来的消息：&quot; + message);\n        session.getBasicRemote().sendText(&quot;服务端返回：&quot; + message);\n    }\n\n    @OnOpen\n    public void onOpen(Session session) throws IOException {\n        System.out.println(&quot;客户端连接成功&quot;);\n    }\n\n    @OnClose\n    public void onClose(Session session) throws IOException {\n        session.getBasicRemote().sendText(&quot;连接关闭&quot;);\n        System.out.println(&quot;连接关闭&quot;);\n    }\n}\n</code></pre>\n<p>服务端API的含义我们上文也已经介绍过了，这里我再补充一个小问题，小伙伴们可能看到我们不同的方法里边都有参数，参数的个数和类型都有差异，实际上这里的参数是可变的，这里的具体信息我们会在下一篇文章中详说，这里先这样来写。</p>\n<p>Ok，我们的代码写完了。</p>\n<h2>部署测试</h2>\n<p>工程的运行就像普通的JavaWeb工程那样，直接运行即可，运行之后，打开html页面，效果如下：</p>\n<p><img src=\"http://img.blog.csdn.net/20170828211153828?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<p>OK，本文先说到这里，下篇文章我们再来详细介绍一个群聊的应用，继续深入使用WebSocket。</p>\n<p>工程下载：（由于CSDN下载现在必须要积分，不得已设置了1分，如果小伙伴没有积分，文末留言我发给你。）</p>\n<p>更多JavaEE资料请关注公众号：</p>\n<p><img src=\"http://img.blog.csdn.net/20170828211355113?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<p>以上。。</p>\n', '上篇文章【WebSocket刨根问底(一)】中我们对WebSocket的一些基本理论进行了介绍，但是', '2', '3', '2017-12-21 22:34:02', '2017-12-21 22:34:02', '2', '0');
INSERT INTO `article` VALUES ('113', 'WebSocket刨根问底(三)之群聊', '前两篇文章【[WebSocket刨根问底(一) ](http://blog.csdn.net/u012702547/article/details/77621195)】【[WebSocket刨根问底(二) ](http://blog.csdn.net/u012702547/article/details/77655826)】我们介绍了WebSocket的一些基本理论，以及一个简单的案例，那么今天继续，我们来看一个简单的群聊的案例，来进一步了解WebSocket这个东东。  \n\nOK，开始之前，我们先来看看我们今天要实现的效果：  \n\n![这里写图片描述](http://img.blog.csdn.net/20170829152915575?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)  \n\n好了，废话不多说，我们进来看看这个东西要怎么样实现吧！\n\n# 创建Web项目\n这里和上文（[WebSocket刨根问底(二) ](http://blog.csdn.net/u012702547/article/details/77655826)）一样，web项目创建成功之后，还是要我们先手动添加websocket的jar包进来，添加方式如果小伙伴不懂的话可以参考我们上篇文章，这里我就不再赘述。\n\n# 创建HTML页面\n\n页面的效果效果小伙伴们刚才都看到了，我这里就直接上代码：  \n```\n<!DOCTYPE html>\n<html lang=\"en\">\n<head>\n    <meta charset=\"UTF-8\">\n    <title>ws页面</title>\n    <script src=\"jquery-3.2.1.js\"></script>\n</head>\n<body>\n<input type=\"text\" placeholder=\"请输入您的昵称\" id=\"nickname\"><input type=\"button\" value=\"连接\" id=\"btnClick1\">\n</div>\n<div id=\"resultDiv\"></div>\n<div><input type=\"text\" id=\"msg\"><input type=\"button\" value=\"发送\" id=\"btnClick2\" disabled=\"disabled\"></div>\n<script>\n    var webSocket;\n    $(\"#btnClick2\").click(function () {\n        var msg = $(\"#msg\").val();\n        $(\"#msg\").val(\'\');\n        webSocket.send(msg)\n    });\n    $(\"#btnClick1\").click(function () {\n        var nickname = $(\"#nickname\").val();\n        if(nickname==null||nickname==\'\') {\n            alert(\"必须输入昵称\");\n            return;\n        }\n        $(\"#btnClick2\").removeAttr(\"disabled\");\n        $(this).attr(\"disabled\", \"disabled\");\n        $(\"#resultDiv\").append(\"<p>开始连接服务端!</p>\");\n        webSocket = new WebSocket(\"ws://localhost/myws2/\"+nickname);\n        webSocket.onerror = function (event) {\n            $(\"#resultDiv\").append(\"<p>onerror:\" + event.data + \"</p>\");\n        }\n        webSocket.onopen = function (event) {\n            $(\"#resultDiv\").append(\"<p>连接成功！</p>\");\n        }\n        webSocket.onmessage = function (event) {\n            $(\"#resultDiv\").append(\"<p>\" + event.data + \"</p>\");\n        }\n    });\n</script>\n</body>\n</html>\n```\n\n关于这段HTML代码，我说如下几点：\n>1.一开始发送按钮处于不可用状态，必须先连接  \n>2.连接时必须先输入昵称，如果不输入昵称则弹出提示  \n>3.连接成功之后连接按钮处于不可点击状态而发送按钮处于可点击状态  \n>4.在连接按钮的点击事件中初始化WebSocket对象以及WebSocket中涉及到的一些方法的初始化  \n>5.所有的信息（连接成功，连接出错以及接收到消息）最后都显示在resultDiv中  \n>6.连接地址是动态变化的，最后的字符是连接的用户名  \n\nOK，这里的代码都很简单，我就不一一解释了。\n\n# 创建WebSocket服务端\n\n由于我们这里要做的是群聊，所以服务端的主要功能就是接收客户端传来的消息并将之广播给所有的客户端。服务端代码如下：  \n```\n@ServerEndpoint(\"/myws2/{nickname}\")\npublic class WebSocketServer2 {\n    private String nickname;\n    private Session session;\n    private static final Set<WebSocketServer2> WEB_SOCKET_SERVER_2_SET = new CopyOnWriteArraySet<WebSocketServer2>();\n\n    @OnMessage\n    public void onMessage(String message, @PathParam(value = \"nickname\") String nickname) throws IOException {\n        System.out.println(\"收到了客户端发来的消息：\" + message);\n        sendText(nickname+\"发来了:\"+message);\n    }\n\n    private static void sendText(String msg) {\n        for (WebSocketServer2 webSocketServer2 : WEB_SOCKET_SERVER_2_SET) {\n            try {\n                synchronized (webSocketServer2) {\n                    webSocketServer2.session.getBasicRemote().sendText(msg);\n                }\n            } catch (IOException e) {\n                WEB_SOCKET_SERVER_2_SET.remove(webSocketServer2);\n                try {\n                    webSocketServer2.session.close();\n                } catch (IOException e1) {\n                }\n                sendText(webSocketServer2.nickname + \"同学已经下线\");\n            }\n        }\n    }\n\n    @OnOpen\n    public void onOpen(Session session, @PathParam(value = \"nickname\") String nickname) throws IOException {\n        this.nickname = nickname;\n        this.session = session;\n        WEB_SOCKET_SERVER_2_SET.add(this);\n        sendText(nickname + \"进入房间\");\n        StringBuffer sb = new StringBuffer();\n        for (WebSocketServer2 webSocketServer2 : WEB_SOCKET_SERVER_2_SET) {\n            sb.append(webSocketServer2.nickname).append(\";\");\n        }\n        sendText(\"当前房间有：\"+sb.toString());\n    }\n\n    @OnClose\n    public void onClose(Session session) throws IOException {\n        WEB_SOCKET_SERVER_2_SET.remove(this);\n        sendText(this.nickname+\"童鞋已下线\");\n    }\n}\n```\n\n关于这个服务端我解释如下几点：  \n>1.第一行的代码表示服务端的名字，但是名字里边有一个{nickname},表示获取服务端传递来的最后一个参数，在方法里边可以通过@PathParam来获取，这个和SpringMVC的参数注解如出一辙  \n>2.第三行和第四行创建了两个对象，因为当客户端脸上服务端之后，一个客户端将对应一个WebSocketServer2对象，我需要将每一个客户端的有关信息保存下来，因此创建出nickname表示该对象对应的客户端的用户昵称，session表示该对象对应的客户端的session  \n>3.第五行创建一个Set集合，该集合是static final类型的，表示不管WebSocketServer2的对象有多少个，WEB_SOCKET_SERVER_2_SET集合始终是同一个，该集合主要用来保存所有连接的客户端对应的WebSocketServer2对象  \n>4.第30行到41行是open方法的逻辑，该方法有两个参数，第一个session，第二个nickname，nickname参数有一个注解@PathParam表示该参数的值就是连接地址里边的最后一个字符串，这个参数是可选的。在该方法里，首先将nickname和session赋值给对应的全局变量，然后将当前对象添加到set集合中，然后调用sendText方法发送一条消息，告诉所有的客户端XXX进入房间啦，最后遍历set集合中的所有用户，拿到所有用户的用户名，再告诉所有客户端当前的房间都有谁谁谁。   \n>5.第13-28行的sendText方法是一个自定义的静态方法，该方法主要用来向所有的客户端广播消息，该方法的基本逻辑就是遍历set集合，拿到set集合中的每一个对象和每一个对象中的session，再利用session向对应的客户端发送消息，如果消息发送失败，则将该用户从集合中移除，同时告诉剩余的客户端某某人已经下线。  \n>6.第7-10行的代码主要用来处理客户端发送来的消息，默认的String类型的参数表示客户端发送来的消息，其他的String类型参数都要加上注解才可以，我们这里第一个参数表示客户端发送来的消息，第二个参数表示发送客户端消息的用户昵称，这里收到消息之后，再利用sendText广播给所有用户。  \n>7.第43行到47行表示当其中一个用户下线了了会回调的close方法，在这里方法里首先从集合中移除该客户端对应的WebSocketServer2对象，然后广播一条消息将该用户下线的事告诉所有人。  \n\nOK，经过以上7点的讲解，小伙伴们对服务端的代码应该是非常熟悉了吧~\n\n好了，那我们今天的案例就先说到这里，下篇文章我们来看一个五子棋的案例，进一步学习websocket的使用。  \n\n\n案例下载：[http://download.csdn.net/download/u012702547/9954347](http://download.csdn.net/download/u012702547/9954347)（由于CSDN下载现在必须要积分，不得已设置了1分，如果小伙伴没有积分，文末留言我发给你。）\n\n更多JavaEE资料请关注公众号：\n\n![这里写图片描述](http://img.blog.csdn.net/20170829163124775?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast)\n \n 以上。\n', '<p>前两篇文章【<a href=\"http://blog.csdn.net/u012702547/article/details/77621195\" target=\"_blank\">WebSocket刨根问底(一) </a>】【<a href=\"http://blog.csdn.net/u012702547/article/details/77655826\" target=\"_blank\">WebSocket刨根问底(二) </a>】我们介绍了WebSocket的一些基本理论，以及一个简单的案例，那么今天继续，我们来看一个简单的群聊的案例，来进一步了解WebSocket这个东东。</p>\n<p>OK，开始之前，我们先来看看我们今天要实现的效果：</p>\n<p><img src=\"http://img.blog.csdn.net/20170829152915575?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<p>好了，废话不多说，我们进来看看这个东西要怎么样实现吧！</p>\n<h1>创建Web项目</h1>\n<p>这里和上文（<a href=\"http://blog.csdn.net/u012702547/article/details/77655826\" target=\"_blank\">WebSocket刨根问底(二) </a>）一样，web项目创建成功之后，还是要我们先手动添加websocket的jar包进来，添加方式如果小伙伴不懂的话可以参考我们上篇文章，这里我就不再赘述。</p>\n<h1>创建HTML页面</h1>\n<p>页面的效果效果小伙伴们刚才都看到了，我这里就直接上代码：</p>\n<pre><code class=\"lang-\">&lt;!DOCTYPE html&gt;\n&lt;html lang=&quot;en&quot;&gt;\n&lt;head&gt;\n    &lt;meta charset=&quot;UTF-8&quot;&gt;\n    &lt;title&gt;ws页面&lt;/title&gt;\n    &lt;script src=&quot;jquery-3.2.1.js&quot;&gt;&lt;/script&gt;\n&lt;/head&gt;\n&lt;body&gt;\n&lt;input type=&quot;text&quot; placeholder=&quot;请输入您的昵称&quot; id=&quot;nickname&quot;&gt;&lt;input type=&quot;button&quot; value=&quot;连接&quot; id=&quot;btnClick1&quot;&gt;\n&lt;/div&gt;\n&lt;div id=&quot;resultDiv&quot;&gt;&lt;/div&gt;\n&lt;div&gt;&lt;input type=&quot;text&quot; id=&quot;msg&quot;&gt;&lt;input type=&quot;button&quot; value=&quot;发送&quot; id=&quot;btnClick2&quot; disabled=&quot;disabled&quot;&gt;&lt;/div&gt;\n&lt;script&gt;\n    var webSocket;\n    $(&quot;#btnClick2&quot;).click(function () {\n        var msg = $(&quot;#msg&quot;).val();\n        $(&quot;#msg&quot;).val(\'\');\n        webSocket.send(msg)\n    });\n    $(&quot;#btnClick1&quot;).click(function () {\n        var nickname = $(&quot;#nickname&quot;).val();\n        if(nickname==null||nickname==\'\') {\n            alert(&quot;必须输入昵称&quot;);\n            return;\n        }\n        $(&quot;#btnClick2&quot;).removeAttr(&quot;disabled&quot;);\n        $(this).attr(&quot;disabled&quot;, &quot;disabled&quot;);\n        $(&quot;#resultDiv&quot;).append(&quot;&lt;p&gt;开始连接服务端!&lt;/p&gt;&quot;);\n        webSocket = new WebSocket(&quot;ws://localhost/myws2/&quot;+nickname);\n        webSocket.onerror = function (event) {\n            $(&quot;#resultDiv&quot;).append(&quot;&lt;p&gt;onerror:&quot; + event.data + &quot;&lt;/p&gt;&quot;);\n        }\n        webSocket.onopen = function (event) {\n            $(&quot;#resultDiv&quot;).append(&quot;&lt;p&gt;连接成功！&lt;/p&gt;&quot;);\n        }\n        webSocket.onmessage = function (event) {\n            $(&quot;#resultDiv&quot;).append(&quot;&lt;p&gt;&quot; + event.data + &quot;&lt;/p&gt;&quot;);\n        }\n    });\n&lt;/script&gt;\n&lt;/body&gt;\n&lt;/html&gt;\n</code></pre>\n<p>关于这段HTML代码，我说如下几点：</p>\n<blockquote>\n<p>1.一开始发送按钮处于不可用状态，必须先连接<br />\n2.连接时必须先输入昵称，如果不输入昵称则弹出提示<br />\n3.连接成功之后连接按钮处于不可点击状态而发送按钮处于可点击状态<br />\n4.在连接按钮的点击事件中初始化WebSocket对象以及WebSocket中涉及到的一些方法的初始化<br />\n5.所有的信息（连接成功，连接出错以及接收到消息）最后都显示在resultDiv中<br />\n6.连接地址是动态变化的，最后的字符是连接的用户名</p>\n</blockquote>\n<p>OK，这里的代码都很简单，我就不一一解释了。</p>\n<h1>创建WebSocket服务端</h1>\n<p>由于我们这里要做的是群聊，所以服务端的主要功能就是接收客户端传来的消息并将之广播给所有的客户端。服务端代码如下：</p>\n<pre><code class=\"lang-\">@ServerEndpoint(&quot;/myws2/{nickname}&quot;)\npublic class WebSocketServer2 {\n    private String nickname;\n    private Session session;\n    private static final Set&lt;WebSocketServer2&gt; WEB_SOCKET_SERVER_2_SET = new CopyOnWriteArraySet&lt;WebSocketServer2&gt;();\n\n    @OnMessage\n    public void onMessage(String message, @PathParam(value = &quot;nickname&quot;) String nickname) throws IOException {\n        System.out.println(&quot;收到了客户端发来的消息：&quot; + message);\n        sendText(nickname+&quot;发来了:&quot;+message);\n    }\n\n    private static void sendText(String msg) {\n        for (WebSocketServer2 webSocketServer2 : WEB_SOCKET_SERVER_2_SET) {\n            try {\n                synchronized (webSocketServer2) {\n                    webSocketServer2.session.getBasicRemote().sendText(msg);\n                }\n            } catch (IOException e) {\n                WEB_SOCKET_SERVER_2_SET.remove(webSocketServer2);\n                try {\n                    webSocketServer2.session.close();\n                } catch (IOException e1) {\n                }\n                sendText(webSocketServer2.nickname + &quot;同学已经下线&quot;);\n            }\n        }\n    }\n\n    @OnOpen\n    public void onOpen(Session session, @PathParam(value = &quot;nickname&quot;) String nickname) throws IOException {\n        this.nickname = nickname;\n        this.session = session;\n        WEB_SOCKET_SERVER_2_SET.add(this);\n        sendText(nickname + &quot;进入房间&quot;);\n        StringBuffer sb = new StringBuffer();\n        for (WebSocketServer2 webSocketServer2 : WEB_SOCKET_SERVER_2_SET) {\n            sb.append(webSocketServer2.nickname).append(&quot;;&quot;);\n        }\n        sendText(&quot;当前房间有：&quot;+sb.toString());\n    }\n\n    @OnClose\n    public void onClose(Session session) throws IOException {\n        WEB_SOCKET_SERVER_2_SET.remove(this);\n        sendText(this.nickname+&quot;童鞋已下线&quot;);\n    }\n}\n</code></pre>\n<p>关于这个服务端我解释如下几点：</p>\n<blockquote>\n<p>1.第一行的代码表示服务端的名字，但是名字里边有一个{nickname},表示获取服务端传递来的最后一个参数，在方法里边可以通过@PathParam来获取，这个和SpringMVC的参数注解如出一辙<br />\n2.第三行和第四行创建了两个对象，因为当客户端脸上服务端之后，一个客户端将对应一个WebSocketServer2对象，我需要将每一个客户端的有关信息保存下来，因此创建出nickname表示该对象对应的客户端的用户昵称，session表示该对象对应的客户端的session<br />\n3.第五行创建一个Set集合，该集合是static final类型的，表示不管WebSocketServer2的对象有多少个，WEB_SOCKET_SERVER_2_SET集合始终是同一个，该集合主要用来保存所有连接的客户端对应的WebSocketServer2对象<br />\n4.第30行到41行是open方法的逻辑，该方法有两个参数，第一个session，第二个nickname，nickname参数有一个注解@PathParam表示该参数的值就是连接地址里边的最后一个字符串，这个参数是可选的。在该方法里，首先将nickname和session赋值给对应的全局变量，然后将当前对象添加到set集合中，然后调用sendText方法发送一条消息，告诉所有的客户端XXX进入房间啦，最后遍历set集合中的所有用户，拿到所有用户的用户名，再告诉所有客户端当前的房间都有谁谁谁。<br />\n5.第13-28行的sendText方法是一个自定义的静态方法，该方法主要用来向所有的客户端广播消息，该方法的基本逻辑就是遍历set集合，拿到set集合中的每一个对象和每一个对象中的session，再利用session向对应的客户端发送消息，如果消息发送失败，则将该用户从集合中移除，同时告诉剩余的客户端某某人已经下线。<br />\n6.第7-10行的代码主要用来处理客户端发送来的消息，默认的String类型的参数表示客户端发送来的消息，其他的String类型参数都要加上注解才可以，我们这里第一个参数表示客户端发送来的消息，第二个参数表示发送客户端消息的用户昵称，这里收到消息之后，再利用sendText广播给所有用户。<br />\n7.第43行到47行表示当其中一个用户下线了了会回调的close方法，在这里方法里首先从集合中移除该客户端对应的WebSocketServer2对象，然后广播一条消息将该用户下线的事告诉所有人。</p>\n</blockquote>\n<p>OK，经过以上7点的讲解，小伙伴们对服务端的代码应该是非常熟悉了吧~</p>\n<p>好了，那我们今天的案例就先说到这里，下篇文章我们来看一个五子棋的案例，进一步学习websocket的使用。</p>\n<p>案例下载：<a href=\"http://download.csdn.net/download/u012702547/9954347\" target=\"_blank\">http://download.csdn.net/download/u012702547/9954347</a>（由于CSDN下载现在必须要积分，不得已设置了1分，如果小伙伴没有积分，文末留言我发给你。）</p>\n<p>更多JavaEE资料请关注公众号：</p>\n<p><img src=\"http://img.blog.csdn.net/20170829163124775?watermark/2/text/aHR0cDovL2Jsb2cuY3Nkbi5uZXQvdTAxMjcwMjU0Nw==/font/5a6L5L2T/fontsize/400/fill/I0JBQkFCMA==/dissolve/70/gravity/SouthEast\" alt=\"这里写图片描述\" /></p>\n<p>以上。</p>\n', '前两篇文章【WebSocket刨根问底(一) 】【WebSocket刨根问底(二) 】我们介绍了We', '3', '3', '2017-12-21 22:34:35', '2017-12-21 22:34:35', '2', '4');
INSERT INTO `article` VALUES ('114', '一点点Github上的学习资料', '## 缘起\n从年初到现在，在GitHub上也积累了几个开源项目，从我个人的角度来看，我觉得这些开源项目对于JavaEE初学者是有很大的参考价值的，因此我将这些项目和案例分享出来，希望能够给初学者一些帮助。  \n\n## 三个完整的开源项目\n\n### CoolMeeting会议管理系统\n\n项目简介：[一个开源的会议管理系统献给给位小伙伴！](http://mp.weixin.qq.com/s/JMGuiftZcEG-0yed2jkDQA)  \n项目地址：https://github.com/lenve/CoolMeeting  \n项目二维码（长按二维码进入项目主页）：  \n![](https://mmbiz.qpic.cn/mmbiz_png/GvtDGKK4uYn9lpXK5EuBzEbK8b7qCE7eCyDJbibdel15VKxacxVZGwdWBibmMUI8n7H9NeX2yWmfrPpHuVHGt42w/0?wx_fmt=png)  \n\n### 个人博客系统\n\n项目简介：[一个JavaWeb搭建的开源Blog系统，整合SSM框架](http://mp.weixin.qq.com/s/m85v_EPdGnOILGJMv5Cz3g)  \n项目地址：https://github.com/lenve/JavaEETest/tree/master/MyBlog    \n项目二维码（长按二维码进入项目主页）：  \n\n![](https://mmbiz.qpic.cn/mmbiz_png/GvtDGKK4uYn9lpXK5EuBzEbK8b7qCE7e8icuibRHFAaiaDr24lkBAwGOeFbYswWcJ8NOY4s23eTCk4xrBibiadWtLuQ/0?wx_fmt=png)  \n\n\n### 五子棋大比武\n\n项目简介：[一个开源的五子棋大战送给各位小伙伴!](http://mp.weixin.qq.com/s/8FjP2LgzadHeGA27HfWCHw)  \n项目地址：https://github.com/lenve/GobangGame  \n项目二维码（长按二维码进入项目主页）：  \n\n![](https://mmbiz.qpic.cn/mmbiz_png/GvtDGKK4uYn9lpXK5EuBzEbK8b7qCE7e9czbiad3AWdxblRuABabpe0nIATLe4ppLZjib2Xfbm7kBgn69yzWrcbA/0?wx_fmt=png)\n\n\n## 框架案例\n\n框架案例主要包括了Spring案例、SpringMVC案例、MyBatis案例以及Spring Boot案例。  \n项目地址：https://github.com/lenve/JavaEETest  \n项目二维码（长按二维码进入项目主页）：  \n\n![](https://mmbiz.qpic.cn/mmbiz_png/GvtDGKK4uYn9lpXK5EuBzEbK8b7qCE7e8aBAeeHCTHDNe4p5hWKKXTDLa3llbJxWQibPd1zlOPoH5aDicDcUNlJg/0?wx_fmt=png)  \n\n\n这些资料和开源项目都会不定期更新，我手头上还有一个ERP项目，整理好了之后也会开源给小伙伴们学习。  \n\n关注公众号可以接收到最新通知。  \n\n希望上面这些资料能够给大家的学习带来帮助，有问题欢迎留言交流。', '<h2>缘起</h2>\n<p>从年初到现在，在GitHub上也积累了几个开源项目，从我个人的角度来看，我觉得这些开源项目对于JavaEE初学者是有很大的参考价值的，因此我将这些项目和案例分享出来，希望能够给初学者一些帮助。</p>\n<h2>三个完整的开源项目</h2>\n<h3>CoolMeeting会议管理系统</h3>\n<p>项目简介：<a href=\"http://mp.weixin.qq.com/s/JMGuiftZcEG-0yed2jkDQA\" target=\"_blank\">一个开源的会议管理系统献给给位小伙伴！</a><br />\n项目地址：https://github.com/lenve/CoolMeeting<br />\n项目二维码（长按二维码进入项目主页）：<br />\n<img src=\"https://mmbiz.qpic.cn/mmbiz_png/GvtDGKK4uYn9lpXK5EuBzEbK8b7qCE7eCyDJbibdel15VKxacxVZGwdWBibmMUI8n7H9NeX2yWmfrPpHuVHGt42w/0?wx_fmt=png\" alt=\"\" /></p>\n<h3>个人博客系统</h3>\n<p>项目简介：<a href=\"http://mp.weixin.qq.com/s/m85v_EPdGnOILGJMv5Cz3g\" target=\"_blank\">一个JavaWeb搭建的开源Blog系统，整合SSM框架</a><br />\n项目地址：https://github.com/lenve/JavaEETest/tree/master/MyBlog<br />\n项目二维码（长按二维码进入项目主页）：</p>\n<p><img src=\"https://mmbiz.qpic.cn/mmbiz_png/GvtDGKK4uYn9lpXK5EuBzEbK8b7qCE7e8icuibRHFAaiaDr24lkBAwGOeFbYswWcJ8NOY4s23eTCk4xrBibiadWtLuQ/0?wx_fmt=png\" alt=\"\" /></p>\n<h3>五子棋大比武</h3>\n<p>项目简介：<a href=\"http://mp.weixin.qq.com/s/8FjP2LgzadHeGA27HfWCHw\" target=\"_blank\">一个开源的五子棋大战送给各位小伙伴!</a><br />\n项目地址：https://github.com/lenve/GobangGame<br />\n项目二维码（长按二维码进入项目主页）：</p>\n<p><img src=\"https://mmbiz.qpic.cn/mmbiz_png/GvtDGKK4uYn9lpXK5EuBzEbK8b7qCE7e9czbiad3AWdxblRuABabpe0nIATLe4ppLZjib2Xfbm7kBgn69yzWrcbA/0?wx_fmt=png\" alt=\"\" /></p>\n<h2>框架案例</h2>\n<p>框架案例主要包括了Spring案例、SpringMVC案例、MyBatis案例以及Spring Boot案例。<br />\n项目地址：https://github.com/lenve/JavaEETest<br />\n项目二维码（长按二维码进入项目主页）：</p>\n<p><img src=\"https://mmbiz.qpic.cn/mmbiz_png/GvtDGKK4uYn9lpXK5EuBzEbK8b7qCE7e8aBAeeHCTHDNe4p5hWKKXTDLa3llbJxWQibPd1zlOPoH5aDicDcUNlJg/0?wx_fmt=png\" alt=\"\" /></p>\n<p>这些资料和开源项目都会不定期更新，我手头上还有一个ERP项目，整理好了之后也会开源给小伙伴们学习。</p>\n<p>关注公众号可以接收到最新通知。</p>\n<p>希望上面这些资料能够给大家的学习带来帮助，有问题欢迎留言交流。</p>\n', '缘起\n从年初到现在，在GitHub上也积累了几个开源项目，从我个人的角度来看，我觉得这些开源项目对于', '3', '3', '2017-12-21 22:35:20', '2017-12-21 22:35:20', '1', '55');
INSERT INTO `article` VALUES ('115', '投稿指南', '年初做这个公号的初衷是希望能够和各位JavaEE同行有一个交流的平台，但是慢慢的就发现一篇不那么像样的文章都需要耗费许多光景，因此文章的更新频率和技术点的深度一直显得力不从心，思忖再三，决定开放投稿。  \n\n---\n\n### 我能给你什么\n有付出当然就要有回报，这是最基本的原则。但是作为一枚苦逼的程序员，在我个人能力之上能够提供的回报非常有限，这一点希望大家能够谅解。我目前能够想到的回报主要有如下几点：  \n>1.赞赏。本公号很早之前就已经具备了开通赞赏的权限，但我一直认为这个功能要慎用，所以只在刚开始测试的两篇文章中开通了赞赏功能，后来的文章都没有启用赞赏功能。对于小伙伴们的投稿，如果审核通过了决定要发，我会开通赞赏功能，赞赏收入都归投稿的小伙伴所有。  \n>2.引流。可能有的小伙伴有写博客的习惯，那么你可以在投稿时注明要求，我会在排版时在文章开头注明原文地址，这样可以向你的博客导入一部分流量。  \n>3.每个月我会从投稿的小伙伴中选出一人，送一本技术图书作为支持。  \n\n暂时能够想到的回报就是这些，以后可能会有更多回报，但是目前也不确定。  \n\n### 投稿要求\n\n>1.文章必须原创。这算是最最最基本的要求了。  \n>2.微信公号有原创保护功能，所以如果有已经在其他公号上发表过的文章，就不建议再投了，避免不必要的纠纷。  \n>3.文章内容不求新颖，但是要翔实，也就是要干货。  \n\n### 投稿地址\n\n稿件发送到邮箱pine-tree@foxmail.com\n\n谢谢。', '<p>年初做这个公号的初衷是希望能够和各位JavaEE同行有一个交流的平台，但是慢慢的就发现一篇不那么像样的文章都需要耗费许多光景，因此文章的更新频率和技术点的深度一直显得力不从心，思忖再三，决定开放投稿。</p>\n<hr />\n<h3>我能给你什么</h3>\n<p>有付出当然就要有回报，这是最基本的原则。但是作为一枚苦逼的程序员，在我个人能力之上能够提供的回报非常有限，这一点希望大家能够谅解。我目前能够想到的回报主要有如下几点：</p>\n<blockquote>\n<p>1.赞赏。本公号很早之前就已经具备了开通赞赏的权限，但我一直认为这个功能要慎用，所以只在刚开始测试的两篇文章中开通了赞赏功能，后来的文章都没有启用赞赏功能。对于小伙伴们的投稿，如果审核通过了决定要发，我会开通赞赏功能，赞赏收入都归投稿的小伙伴所有。<br />\n2.引流。可能有的小伙伴有写博客的习惯，那么你可以在投稿时注明要求，我会在排版时在文章开头注明原文地址，这样可以向你的博客导入一部分流量。<br />\n3.每个月我会从投稿的小伙伴中选出一人，送一本技术图书作为支持。</p>\n</blockquote>\n<p>暂时能够想到的回报就是这些，以后可能会有更多回报，但是目前也不确定。</p>\n<h3>投稿要求</h3>\n<blockquote>\n<p>1.文章必须原创。这算是最最最基本的要求了。<br />\n2.微信公号有原创保护功能，所以如果有已经在其他公号上发表过的文章，就不建议再投了，避免不必要的纠纷。<br />\n3.文章内容不求新颖，但是要翔实，也就是要干货。</p>\n</blockquote>\n<h3>投稿地址</h3>\n<p>稿件发送到邮箱pine-tree@foxmail.com</p>\n<p>谢谢。</p>\n', '年初做这个公号的初衷是希望能够和各位JavaEE同行有一个交流的平台，但是慢慢的就发现一篇不那么像样', '3', '3', '2017-12-21 22:40:16', '2017-12-21 22:40:16', '2', '99');
INSERT INTO `article` VALUES ('116', 'SpringBoot+SpringSecurity处理Ajax登录请求', '最近在项目中遇到了这样一个问题：前后端分离，前端用Vue来做，所有的数据请求都使用vue-resource，没有使用表单，因此数据交互都是使用JSON，后台使用Spring Boot，权限验证使用了Spring Security，因为之前用Spring Security都是处理页面的，这次单纯处理Ajax请求，因此记录下遇到的一些问题。这里的解决方案不仅适用于Ajax请求，也可以解决移动端请求验证。   \n\n### 创建工程\n\n首先我们需要创建一个Spring Boot工程，创建时需要引入Web、Spring Security、MySQL和MyBatis(数据库框架其实随意，我这里使用MyBatis)，创建好之后，依赖文件如下：  \n\n```\n<dependency>\n    <groupId>org.mybatis.spring.boot</groupId>\n    <artifactId>mybatis-spring-boot-starter</artifactId>\n    <version>1.3.1</version>\n</dependency>\n<dependency>\n    <groupId>org.springframework.boot</groupId>\n    <artifactId>spring-boot-starter-security</artifactId>\n</dependency>\n<dependency>\n    <groupId>org.springframework.boot</groupId>\n    <artifactId>spring-boot-starter-web</artifactId>\n</dependency>\n<dependency>\n    <groupId>mysql</groupId>\n    <artifactId>mysql-connector-java</artifactId>\n    <scope>runtime</scope>\n</dependency>\n<dependency>\n    <groupId>commons-codec</groupId>\n    <artifactId>commons-codec</artifactId>\n    <version>1.11</version>\n</dependency>\n```  \n\n注意最后一个**commons-codec**依赖是我手动加入进来的，这是一个Apache的开源项目，可以用来生成MD5消息摘要，我在后文中将对密码进行简单的处理。  \n\n### 创建数据库并配置\n\n为了简化逻辑，我这里创建了三个表，分别是用户表、角色表、用户角色关联表，如下：  \n\n![p271]()  \n\n接下来我们需要在application.properties中对自己的数据库进行简单的配置，这里各位小伙伴视自己的具体情况而定。  \n\n```\nspring.datasource.url=jdbc:mysql:///vueblog\nspring.datasource.username=root\nspring.datasource.password=123\n```  \n\n### 构造实体类\n\n这里主要是指构造用户类，这里的用户类比较特殊，必须实现UserDetails接口，如下：  \n\n```\npublic class User implements UserDetails {\n    private Long id;\n    private String username;\n    private String password;\n    private String nickname;\n    private boolean enabled;\n    private List<Role> roles;\n\n    @Override\n    public boolean isAccountNonExpired() {\n        return true;\n    }\n\n    @Override\n    public boolean isAccountNonLocked() {\n        return true;\n    }\n\n    @Override\n    public boolean isCredentialsNonExpired() {\n        return true;\n    }\n\n    @Override\n    public boolean isEnabled() {\n        return enabled;\n    }\n\n    @Override\n    public List<GrantedAuthority> getAuthorities() {\n        List<GrantedAuthority> authorities = new ArrayList<>();\n        for (Role role : roles) {\n            authorities.add(new SimpleGrantedAuthority(\"ROLE_\" + role.getName()));\n        }\n        return authorities;\n    }\n    //getter/setter省略...\n}\n```  \n\n实现了UserDetails接口之后，该接口中有几个方法需要我们实现，四个返回Boolean的方法都是见名知意，enabled表示档期账户是否启用，这个我数据库中确实有该字段，因此根据查询结果返回，其他的为了简单期间都直接返回true，getAuthorities方法返回当前用户的角色信息，用户的角色其实就是roles中的数据，将roles中的数据转换为List<GrantedAuthority>之后返回即可，**这里有一个要注意的地方，由于我在数据库中存储的角色名都是诸如‘超级管理员’、‘普通用户’之类的，并不是以```ROLE_```这样的字符开始的，因此需要在这里手动加上```ROLE_```,切记**。  \n\n另外还有一个Role实体类，比较简单，按照数据库的字段创建即可，这里不再赘述。  \n\n### 创建UserService\n\n这里的UserService也比较特殊，需要实现UserDetailsService接口，如下：  \n\n```\n@Service\npublic class UserService implements UserDetailsService {\n    @Autowired\n    UserMapper userMapper;\n    @Autowired\n    RolesMapper rolesMapper;\n\n    @Override\n    public UserDetails loadUserByUsername(String s) throws UsernameNotFoundException {\n        User user = userMapper.loadUserByUsername(s);\n        if (user == null) {\n            //避免返回null，这里返回一个不含有任何值的User对象，在后期的密码比对过程中一样会验证失败\n            return new User();\n        }\n        //查询用户的角色信息，并返回存入user中\n        List<Role> roles = rolesMapper.getRolesByUid(user.getId());\n        user.setRoles(roles);\n        return user;\n    }\n}\n```  \n\n实现了UserDetailsService接口之后，我们需要实现该接口中的loadUserByUsername方法，即根据用户名查询用户。这里注入了两个MyBatis中的Mapper，UserMapper用来查询用户，RolesMapper用来查询角色。在loadUserByUsername方法中，首先根据传入的参数（参数就是用户登录时输入的用户名）去查询用户，如果查到的用户为null，可以直接抛一个UsernameNotFoundException异常，但是我为了处理方便，返回了一个没有任何值的User对象，这样在后面的密码比对过程中一样会发现登录失败的（这里大家根据自己的业务需求调整即可），如果查到的用户不为null，此时我们根据查到的用户id再去查询该用户的角色，并将查询结果放入到user对象中，这个查询结果将在user对象的getAuthorities方法中用上。  \n\n### Security配置\n\n我们先来看一下我的Security配置，然后我再来一一解释：  \n\n```\n@Configuration\npublic class WebSecurityConfig extends WebSecurityConfigurerAdapter {\n    @Autowired\n    UserService userService;\n\n    @Override\n    protected void configure(AuthenticationManagerBuilder auth) throws Exception {\n        auth.userDetailsService(userService).passwordEncoder(new PasswordEncoder() {\n            @Override\n            public String encode(CharSequence charSequence) {\n                return DigestUtils.md5DigestAsHex(charSequence.toString().getBytes());\n            }\n\n            /**\n             * @param charSequence 明文\n             * @param s 密文\n             * @return\n             */\n            @Override\n            public boolean matches(CharSequence charSequence, String s) {\n                return s.equals(DigestUtils.md5DigestAsHex(charSequence.toString().getBytes()));\n            }\n        });\n    }\n\n    @Override\n    protected void configure(HttpSecurity http) throws Exception {\n        http.authorizeRequests()\n                .antMatchers(\"/admin/**\").hasRole(\"超级管理员\")\n                .anyRequest().authenticated()//其他的路径都是登录后即可访问\n                .and().formLogin().loginPage(\"/login_page\").successHandler(new AuthenticationSuccessHandler() {\n            @Override\n            public void onAuthenticationSuccess(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Authentication authentication) throws IOException, ServletException {\n                httpServletResponse.setContentType(\"application/json;charset=utf-8\");\n                PrintWriter out = httpServletResponse.getWriter();\n                out.write(\"{\\\"status\\\":\\\"ok\\\",\\\"msg\\\":\\\"登录成功\\\"}\");\n                out.flush();\n                out.close();\n            }\n        })\n                .failureHandler(new AuthenticationFailureHandler() {\n                    @Override\n                    public void onAuthenticationFailure(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, AuthenticationException e) throws IOException, ServletException {\n                        httpServletResponse.setContentType(\"application/json;charset=utf-8\");\n                        PrintWriter out = httpServletResponse.getWriter();\n                        out.write(\"{\\\"status\\\":\\\"error\\\",\\\"msg\\\":\\\"登录失败\\\"}\");\n                        out.flush();\n                        out.close();\n                    }\n                }).loginProcessingUrl(\"/login\")\n                .usernameParameter(\"username\").passwordParameter(\"password\").permitAll()\n                .and().logout().permitAll().and().csrf().disable();\n    }\n\n    @Override\n    public void configure(WebSecurity web) throws Exception {\n        web.ignoring().antMatchers(\"/reg\");\n    }\n}\n```  \n\n这是我们配置的核心，小伙伴们听我一一道来：   \n\n1.首先这是一个配置类，因此记得加上@Configuration注解，又因为这是Spring Security的配置，因此记得继承WebSecurityConfigurerAdapter。  \n2.将刚刚创建好的UserService注入进来，一会我们要用。  \n3.configure(AuthenticationManagerBuilder auth)方法中用来配置我们的认证方式，在auth.userDetailsService()方法中传入userService，这样userService中的loadUserByUsername方法在用户登录时将会被自动调用。后面的passwordEncoder是可选项，可写可不写，因为我是将用户的明文密码生成了MD5消息摘要后存入数据库的，因此在登录时也需要对明文密码进行处理，所以就加上了passwordEncoder，加上passwordEncoder后，直接new一个PasswordEncoder匿名内部类即可，这里有两个方法要实现，看名字就知道方法的含义，第一个方法encode显然是对明文进行加密，这里我使用了MD5消息摘要，具体的实现方法是由commons-codec依赖提供的；第二个方法matches是密码的比对，两个参数，第一个参数是明文密码，第二个是密文，这里只需要对明文加密后和密文比较即可（小伙伴如果对此感兴趣可以继续考虑密码加盐）。   \n4.configure(HttpSecurity http)用来配置我们的认证规则等，authorizeRequests方法表示开启了认证规则配置，antMatchers(\"/admin/**\").hasRole(\"超级管理员\")表示```/admin/**```的路径需要有‘超级管理员’角色的用户才能访问，我在网上看到小伙伴对hasRole方法中要不要加```ROLE_```前缀有疑问,这里是不要加的，如果用hasAuthority方法才需要加。anyRequest().authenticated()表示其他所有路径都是需要认证/登录后才能访问。接下来我们配置了登录页面为login_page，登录处理路径为/login，登录用户名为username，密码为password，并配置了这些路径都可以直接访问，注销登陆也可以直接访问，最后关闭csrf。在successHandler中，使用response返回登录成功的json即可，切记不可以使用defaultSuccessUrl，defaultSuccessUrl是只登录成功后重定向的页面，failureHandler也是由于相同的原因不使用failureUrl。    \n5.configure(WebSecurity web)方法中我配置了一些过滤规则，不赘述。  \n6.另外，对于静态文件，如```/images/**```、```/css/**```、```/js/**```这些路径，这里默认都是不拦截的。  \n\n### Controller\n\n最后来看看我们的Controller，如下：  \n\n```\n@RestController\npublic class LoginRegController {\n\n    /**\n     * 如果自动跳转到这个页面，说明用户未登录，返回相应的提示即可\n     * <p>\n     * 如果要支持表单登录，可以在这个方法中判断请求的类型，进而决定返回JSON还是HTML页面\n     *\n     * @return\n     */\n    @RequestMapping(\"/login_page\")\n    public RespBean loginPage() {\n        return new RespBean(\"error\", \"尚未登录，请登录!\");\n    }\n}\n```  \n\n这个Controller整体来说还是比较简单的，RespBean一个响应bean，返回一段简单的json，不赘述，这里需要小伙伴注意的是```login_page```,我们配置的登录页面是一个```login_page```,但实际上```login_page```并不是一个页面，而是返回一段JSON，这是因为当我未登录就去访问其他页面时Spring Security会自动跳转到到```login_page```页面，但是在Ajax请求中，不需要这种跳转，我要的只是是否登录的提示，所以这里返回json即可。  \n\n### 测试\n\n最后小伙伴可以使用POSTMAN或者RESTClient等工具来测试登录和权限问题，我就不演示了。  \n\nOk，经过上文的介绍，想必小伙伴们对Spring Boot+Spring Security处理Ajax登录请求已经有所了解了，好了，本文就说到这里，有问题欢迎留言讨论。  \n\n更多资料请关注公众号：   \n\n![公众号二维码](https://mmbiz.qpic.cn/mmbiz_jpg/GvtDGKK4uYkO6VEW6XfkovAic6oA5LegzZKeRj0OwOZZQ8ic1tEoBOVBBOreAB9Dz32CN9MU19slrjn5qvxbR7pQ/0?wx_fmt=jpeg)  ', '<p>最近在项目中遇到了这样一个问题：前后端分离，前端用Vue来做，所有的数据请求都使用vue-resource，没有使用表单，因此数据交互都是使用JSON，后台使用Spring Boot，权限验证使用了Spring Security，因为之前用Spring Security都是处理页面的，这次单纯处理Ajax请求，因此记录下遇到的一些问题。这里的解决方案不仅适用于Ajax请求，也可以解决移动端请求验证。</p>\n<h3>创建工程</h3>\n<p>首先我们需要创建一个Spring Boot工程，创建时需要引入Web、Spring Security、MySQL和MyBatis(数据库框架其实随意，我这里使用MyBatis)，创建好之后，依赖文件如下：</p>\n<pre><code class=\"lang-\">&lt;dependency&gt;\n    &lt;groupId&gt;org.mybatis.spring.boot&lt;/groupId&gt;\n    &lt;artifactId&gt;mybatis-spring-boot-starter&lt;/artifactId&gt;\n    &lt;version&gt;1.3.1&lt;/version&gt;\n&lt;/dependency&gt;\n&lt;dependency&gt;\n    &lt;groupId&gt;org.springframework.boot&lt;/groupId&gt;\n    &lt;artifactId&gt;spring-boot-starter-security&lt;/artifactId&gt;\n&lt;/dependency&gt;\n&lt;dependency&gt;\n    &lt;groupId&gt;org.springframework.boot&lt;/groupId&gt;\n    &lt;artifactId&gt;spring-boot-starter-web&lt;/artifactId&gt;\n&lt;/dependency&gt;\n&lt;dependency&gt;\n    &lt;groupId&gt;mysql&lt;/groupId&gt;\n    &lt;artifactId&gt;mysql-connector-java&lt;/artifactId&gt;\n    &lt;scope&gt;runtime&lt;/scope&gt;\n&lt;/dependency&gt;\n&lt;dependency&gt;\n    &lt;groupId&gt;commons-codec&lt;/groupId&gt;\n    &lt;artifactId&gt;commons-codec&lt;/artifactId&gt;\n    &lt;version&gt;1.11&lt;/version&gt;\n&lt;/dependency&gt;\n</code></pre>\n<p>注意最后一个<strong>commons-codec</strong>依赖是我手动加入进来的，这是一个Apache的开源项目，可以用来生成MD5消息摘要，我在后文中将对密码进行简单的处理。</p>\n<h3>创建数据库并配置</h3>\n<p>为了简化逻辑，我这里创建了三个表，分别是用户表、角色表、用户角色关联表，如下：</p>\n<p><img src=\"\" alt=\"p271\" /></p>\n<p>接下来我们需要在application.properties中对自己的数据库进行简单的配置，这里各位小伙伴视自己的具体情况而定。</p>\n<pre><code class=\"lang-\">spring.datasource.url=jdbc:mysql:///vueblog\nspring.datasource.username=root\nspring.datasource.password=123\n</code></pre>\n<h3>构造实体类</h3>\n<p>这里主要是指构造用户类，这里的用户类比较特殊，必须实现UserDetails接口，如下：</p>\n<pre><code class=\"lang-\">public class User implements UserDetails {\n    private Long id;\n    private String username;\n    private String password;\n    private String nickname;\n    private boolean enabled;\n    private List&lt;Role&gt; roles;\n\n    @Override\n    public boolean isAccountNonExpired() {\n        return true;\n    }\n\n    @Override\n    public boolean isAccountNonLocked() {\n        return true;\n    }\n\n    @Override\n    public boolean isCredentialsNonExpired() {\n        return true;\n    }\n\n    @Override\n    public boolean isEnabled() {\n        return enabled;\n    }\n\n    @Override\n    public List&lt;GrantedAuthority&gt; getAuthorities() {\n        List&lt;GrantedAuthority&gt; authorities = new ArrayList&lt;&gt;();\n        for (Role role : roles) {\n            authorities.add(new SimpleGrantedAuthority(&quot;ROLE_&quot; + role.getName()));\n        }\n        return authorities;\n    }\n    //getter/setter省略...\n}\n</code></pre>\n<p>实现了UserDetails接口之后，该接口中有几个方法需要我们实现，四个返回Boolean的方法都是见名知意，enabled表示档期账户是否启用，这个我数据库中确实有该字段，因此根据查询结果返回，其他的为了简单期间都直接返回true，getAuthorities方法返回当前用户的角色信息，用户的角色其实就是roles中的数据，将roles中的数据转换为List<GrantedAuthority>之后返回即可，<strong>这里有一个要注意的地方，由于我在数据库中存储的角色名都是诸如‘超级管理员’、‘普通用户’之类的，并不是以<code>ROLE_</code>这样的字符开始的，因此需要在这里手动加上<code>ROLE_</code>,切记</strong>。</p>\n<p>另外还有一个Role实体类，比较简单，按照数据库的字段创建即可，这里不再赘述。</p>\n<h3>创建UserService</h3>\n<p>这里的UserService也比较特殊，需要实现UserDetailsService接口，如下：</p>\n<pre><code class=\"lang-\">@Service\npublic class UserService implements UserDetailsService {\n    @Autowired\n    UserMapper userMapper;\n    @Autowired\n    RolesMapper rolesMapper;\n\n    @Override\n    public UserDetails loadUserByUsername(String s) throws UsernameNotFoundException {\n        User user = userMapper.loadUserByUsername(s);\n        if (user == null) {\n            //避免返回null，这里返回一个不含有任何值的User对象，在后期的密码比对过程中一样会验证失败\n            return new User();\n        }\n        //查询用户的角色信息，并返回存入user中\n        List&lt;Role&gt; roles = rolesMapper.getRolesByUid(user.getId());\n        user.setRoles(roles);\n        return user;\n    }\n}\n</code></pre>\n<p>实现了UserDetailsService接口之后，我们需要实现该接口中的loadUserByUsername方法，即根据用户名查询用户。这里注入了两个MyBatis中的Mapper，UserMapper用来查询用户，RolesMapper用来查询角色。在loadUserByUsername方法中，首先根据传入的参数（参数就是用户登录时输入的用户名）去查询用户，如果查到的用户为null，可以直接抛一个UsernameNotFoundException异常，但是我为了处理方便，返回了一个没有任何值的User对象，这样在后面的密码比对过程中一样会发现登录失败的（这里大家根据自己的业务需求调整即可），如果查到的用户不为null，此时我们根据查到的用户id再去查询该用户的角色，并将查询结果放入到user对象中，这个查询结果将在user对象的getAuthorities方法中用上。</p>\n<h3>Security配置</h3>\n<p>我们先来看一下我的Security配置，然后我再来一一解释：</p>\n<pre><code class=\"lang-\">@Configuration\npublic class WebSecurityConfig extends WebSecurityConfigurerAdapter {\n    @Autowired\n    UserService userService;\n\n    @Override\n    protected void configure(AuthenticationManagerBuilder auth) throws Exception {\n        auth.userDetailsService(userService).passwordEncoder(new PasswordEncoder() {\n            @Override\n            public String encode(CharSequence charSequence) {\n                return DigestUtils.md5DigestAsHex(charSequence.toString().getBytes());\n            }\n\n            /**\n             * @param charSequence 明文\n             * @param s 密文\n             * @return\n             */\n            @Override\n            public boolean matches(CharSequence charSequence, String s) {\n                return s.equals(DigestUtils.md5DigestAsHex(charSequence.toString().getBytes()));\n            }\n        });\n    }\n\n    @Override\n    protected void configure(HttpSecurity http) throws Exception {\n        http.authorizeRequests()\n                .antMatchers(&quot;/admin/**&quot;).hasRole(&quot;超级管理员&quot;)\n                .anyRequest().authenticated()//其他的路径都是登录后即可访问\n                .and().formLogin().loginPage(&quot;/login_page&quot;).successHandler(new AuthenticationSuccessHandler() {\n            @Override\n            public void onAuthenticationSuccess(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, Authentication authentication) throws IOException, ServletException {\n                httpServletResponse.setContentType(&quot;application/json;charset=utf-8&quot;);\n                PrintWriter out = httpServletResponse.getWriter();\n                out.write(&quot;{\\&quot;status\\&quot;:\\&quot;ok\\&quot;,\\&quot;msg\\&quot;:\\&quot;登录成功\\&quot;}&quot;);\n                out.flush();\n                out.close();\n            }\n        })\n                .failureHandler(new AuthenticationFailureHandler() {\n                    @Override\n                    public void onAuthenticationFailure(HttpServletRequest httpServletRequest, HttpServletResponse httpServletResponse, AuthenticationException e) throws IOException, ServletException {\n                        httpServletResponse.setContentType(&quot;application/json;charset=utf-8&quot;);\n                        PrintWriter out = httpServletResponse.getWriter();\n                        out.write(&quot;{\\&quot;status\\&quot;:\\&quot;error\\&quot;,\\&quot;msg\\&quot;:\\&quot;登录失败\\&quot;}&quot;);\n                        out.flush();\n                        out.close();\n                    }\n                }).loginProcessingUrl(&quot;/login&quot;)\n                .usernameParameter(&quot;username&quot;).passwordParameter(&quot;password&quot;).permitAll()\n                .and().logout().permitAll().and().csrf().disable();\n    }\n\n    @Override\n    public void configure(WebSecurity web) throws Exception {\n        web.ignoring().antMatchers(&quot;/reg&quot;);\n    }\n}\n</code></pre>\n<p>这是我们配置的核心，小伙伴们听我一一道来：</p>\n<p>1.首先这是一个配置类，因此记得加上@Configuration注解，又因为这是Spring Security的配置，因此记得继承WebSecurityConfigurerAdapter。<br />\n2.将刚刚创建好的UserService注入进来，一会我们要用。<br />\n3.configure(AuthenticationManagerBuilder auth)方法中用来配置我们的认证方式，在auth.userDetailsService()方法中传入userService，这样userService中的loadUserByUsername方法在用户登录时将会被自动调用。后面的passwordEncoder是可选项，可写可不写，因为我是将用户的明文密码生成了MD5消息摘要后存入数据库的，因此在登录时也需要对明文密码进行处理，所以就加上了passwordEncoder，加上passwordEncoder后，直接new一个PasswordEncoder匿名内部类即可，这里有两个方法要实现，看名字就知道方法的含义，第一个方法encode显然是对明文进行加密，这里我使用了MD5消息摘要，具体的实现方法是由commons-codec依赖提供的；第二个方法matches是密码的比对，两个参数，第一个参数是明文密码，第二个是密文，这里只需要对明文加密后和密文比较即可（小伙伴如果对此感兴趣可以继续考虑密码加盐）。<br />\n4.configure(HttpSecurity http)用来配置我们的认证规则等，authorizeRequests方法表示开启了认证规则配置，antMatchers(&quot;/admin/**&quot;).hasRole(“超级管理员”)表示<code>/admin/**</code>的路径需要有‘超级管理员’角色的用户才能访问，我在网上看到小伙伴对hasRole方法中要不要加<code>ROLE_</code>前缀有疑问,这里是不要加的，如果用hasAuthority方法才需要加。anyRequest().authenticated()表示其他所有路径都是需要认证/登录后才能访问。接下来我们配置了登录页面为login_page，登录处理路径为/login，登录用户名为username，密码为password，并配置了这些路径都可以直接访问，注销登陆也可以直接访问，最后关闭csrf。在successHandler中，使用response返回登录成功的json即可，切记不可以使用defaultSuccessUrl，defaultSuccessUrl是只登录成功后重定向的页面，failureHandler也是由于相同的原因不使用failureUrl。<br />\n5.configure(WebSecurity web)方法中我配置了一些过滤规则，不赘述。<br />\n6.另外，对于静态文件，如<code>/images/**</code>、<code>/css/**</code>、<code>/js/**</code>这些路径，这里默认都是不拦截的。</p>\n<h3>Controller</h3>\n<p>最后来看看我们的Controller，如下：</p>\n<pre><code class=\"lang-\">@RestController\npublic class LoginRegController {\n\n    /**\n     * 如果自动跳转到这个页面，说明用户未登录，返回相应的提示即可\n     * &lt;p&gt;\n     * 如果要支持表单登录，可以在这个方法中判断请求的类型，进而决定返回JSON还是HTML页面\n     *\n     * @return\n     */\n    @RequestMapping(&quot;/login_page&quot;)\n    public RespBean loginPage() {\n        return new RespBean(&quot;error&quot;, &quot;尚未登录，请登录!&quot;);\n    }\n}\n</code></pre>\n<p>这个Controller整体来说还是比较简单的，RespBean一个响应bean，返回一段简单的json，不赘述，这里需要小伙伴注意的是<code>login_page</code>,我们配置的登录页面是一个<code>login_page</code>,但实际上<code>login_page</code>并不是一个页面，而是返回一段JSON，这是因为当我未登录就去访问其他页面时Spring Security会自动跳转到到<code>login_page</code>页面，但是在Ajax请求中，不需要这种跳转，我要的只是是否登录的提示，所以这里返回json即可。</p>\n<h3>测试</h3>\n<p>最后小伙伴可以使用POSTMAN或者RESTClient等工具来测试登录和权限问题，我就不演示了。</p>\n<p>Ok，经过上文的介绍，想必小伙伴们对Spring Boot+Spring Security处理Ajax登录请求已经有所了解了，好了，本文就说到这里，有问题欢迎留言讨论。</p>\n<p>更多资料请关注公众号：</p>\n<p><img src=\"https://mmbiz.qpic.cn/mmbiz_jpg/GvtDGKK4uYkO6VEW6XfkovAic6oA5LegzZKeRj0OwOZZQ8ic1tEoBOVBBOreAB9Dz32CN9MU19slrjn5qvxbR7pQ/0?wx_fmt=jpeg\" alt=\"公众号二维码\" /></p>\n', '最近在项目中遇到了这样一个问题：前后端分离，前端用Vue来做，所有的数据请求都使用vue-resou', '1', '3', '2017-12-21 23:34:33', '2017-12-21 23:34:33', '1', '15');
INSERT INTO `article` VALUES ('117', '人生感悟', '人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟', '<p>人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟</p>\n', '人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生感悟人生', '2', '3', '2019-05-16 12:19:06', '2017-12-22 10:22:33', '2', '0');
INSERT INTO `article` VALUES ('118', '初识MongoDB中的索引', '索引就像图书的目录一样，可以让我们快速定位到需要的内容，关系型数据库中有索引，NoSQL中当然也有，本文我们就先来简单介绍下MongoDB中的索引。  \n\n本文是MongoDB系列的第九篇文章，了解前面的文章有助于更好的理解本文：  \n\n\n![Image 083.png](http://localhost:80/blogimg/20171223/b13e845a-29f7-402c-a2d4-cc7830fd767e_Image083.png)\n---\n1.[Linux上安装MongoDB](http://mp.weixin.qq.com/s/R4HpFO60BQ0-dnTMVQOvhw)  \n2.[MongoDB基本操作](http://mp.weixin.qq.com/s/qhCrjbEgH4FpDv-2sjFEAQ)  \n3.[MongoDB数据类型](http://mp.weixin.qq.com/s/tVC2Uq30qWx4o3eB2aXlmQ)  \n4.[MongoDB文档更新操作](http://mp.weixin.qq.com/s/wM-xmd4Al0zk4hGTEfr8LQ)  \n5.[MongoDB文档查询操作(一)](http://mp.weixin.qq.com/s/VfdZ5QX5I4blMTsMl-IEbg)  \n6.[MongoDB文档查询操作(二)](http://mp.weixin.qq.com/s/_JWWvBzdDUCtzdjcIMfcQQ)  \n7.[MongoDB文档查询操作(三)](http://mp.weixin.qq.com/s/hkSP-i-_vzLy1-hkdq3o4w)  \n8.[MongoDB查看执行计划](http://mp.weixin.qq.com/s/sH3eN7IF6zMedDeC_Vpcww)  \n\n---  \n\n## 索引创建\n\n默认情况下，集合中的```_id```字段就是索引，我们可以通过getIndexes()方法来查看一个集合中的索引：  \n\n```\ndb.sang_collect.getIndexes()\n```  \n\n结果如下：  \n\n```\n[\n    {\n        \"v\" : 2,\n        \"key\" : {\n            \"_id\" : 1\n        },\n        \"name\" : \"_id_\",\n        \"ns\" : \"sang.sang_collect\"\n    }\n]\n```  \n\n我们看到这里只有一个索引，就是```_id```。   \n\n现在我的集合中有10000个文档，我想要查询x为1的文档，我的查询操作如下：  \n\n```\ndb.sang_collect.find({x:1})\n```  \n\n这种查询默认情况下会做全表扫描，我们可以用上篇文章介绍的explain()来查看一下查询计划，如下：  \n\n```\ndb.sang_collect.find({x:1}).explain(\"executionStats\")\n```  \n\n结果如下：  \n\n```\n{\n    \"queryPlanner\" : {\n    },\n    \"executionStats\" : {\n        \"executionSuccess\" : true,\n        \"nReturned\" : 1,\n        \"executionTimeMillis\" : 15,\n        \"totalKeysExamined\" : 0,\n        \"totalDocsExamined\" : 10000,\n        \"executionStages\" : {\n            \"stage\" : \"COLLSCAN\",\n            \"filter\" : {\n                \"x\" : {\n                    \"$eq\" : 1.0\n                }\n            },\n            \"nReturned\" : 1,\n            \"executionTimeMillisEstimate\" : 29,\n            \"works\" : 10002,\n            \"advanced\" : 1,\n            \"needTime\" : 10000,\n            \"needYield\" : 0,\n            \"saveState\" : 78,\n            \"restoreState\" : 78,\n            \"isEOF\" : 1,\n            \"invalidates\" : 0,\n            \"direction\" : \"forward\",\n            \"docsExamined\" : 10000\n        }\n    },\n    \"serverInfo\" : {\n    },\n    \"ok\" : 1.0\n}\n```  \n\n结果比较长，我摘取了关键的一部分。我们可以看到查询方式是全表扫描，一共扫描了10000个文档才查出来我要的结果。实际上我要的文档就排第二个，但是系统不知道这个集合中一共有多少个x为1的文档，所以会把全表扫描完，这种方式当然很低效，但是如果我加上limit，如下：  \n\n```\ndb.sang_collect.find({x:1}).limit(1)\n```  \n\n此时再看查询计划发现只扫描了两个文档就有结果了，但是如果我要查询x为9999的记录，那还是得把全表扫描一遍，此时，我们就可以给该字段建立索引，索引建立方式如下：  \n\n```\ndb.sang_collect.ensureIndex({x:1})\n```  \n\n1表示升序，-1表示降序。当我们给x字段建立索引之后，再根据x字段去查询，速度就非常快了，我们看下面这个查询操作的执行计划：  \n\n```\ndb.sang_collect.find({x:9999}).explain(\"executionStats\")\n```  \n\n这个查询计划过长我就不贴出来了，我们可以重点关注查询要耗费的时间大幅度下降。  \n\n此时调用getIndexes()方法可以看到我们刚刚创建的索引，如下：  \n\n```\n[\n    {\n        \"v\" : 2,\n        \"key\" : {\n            \"_id\" : 1\n        },\n        \"name\" : \"_id_\",\n        \"ns\" : \"sang.sang_collect\"\n    },\n    {\n        \"v\" : 2,\n        \"key\" : {\n            \"x\" : 1.0\n        },\n        \"name\" : \"x_1\",\n        \"ns\" : \"sang.sang_collect\"\n    }\n]\n```  \n我们看到每个索引都有一个名字，默认的索引名字为```字段名_排序值```，当然我们也可以在创建索引时自定义索引名字，如下：  \n\n```\ndb.sang_collect.ensureIndex({x:1},{name:\"myfirstindex\"})\n```  \n\n此时创建好的索引如下：  \n\n```\n{\n    \"v\" : 2,\n    \"key\" : {\n        \"x\" : 1.0\n    },\n    \"name\" : \"myfirstindex\",\n    \"ns\" : \"sang.sang_collect\"\n}\n```  \n\n当然索引在创建的过程中还有许多其他可选参数，如下：  \n\n```\ndb.sang_collect.ensureIndex({x:1},{name:\"myfirstindex\",dropDups:true,background:true,unique:true,sparse:true,v:1,weights:99999})\n```  \n\n关于这里的参数，我说一下：  \n\n>1.name表示索引的名称  \n>2.dropDups表示创建唯一性索引时如果出现重复，则将重复的删除，只保留第一个  \n>3.background是否在后台创建索引，在后台创建索引不影响数据库当前的操作，默认为false  \n>4.unique是否创建唯一索引，默认false  \n>5.sparse对文档中不存在的字段是否不起用索引，默认false\n>6.v表示索引的版本号，默认为2  \n>7.weights表示索引的权重  \n\n此时创建好的索引如下：  \n\n```\n{\n    \"v\" : 1,\n    \"unique\" : true,\n    \"key\" : {\n        \"x\" : 1.0\n    },\n    \"name\" : \"myfirstindex\",\n    \"ns\" : \"sang.sang_collect\",\n    \"background\" : true,\n    \"sparse\" : true,\n    \"weights\" : 99999.0\n}\n```  \n\n## 查看索引\n\n上文我们介绍了getIndexes()可以用来查看索引，我们还可以通过totalIndexSize()来查看索引的大小，如下：  \n\n```\ndb.sang_collect.totalIndexSize()\n```  \n\n## 删除索引\n\n我们可以按名称删除索引，如下：  \n\n```\ndb.sang_collect.dropIndex(\"xIndex\")\n```  \n\n表示删除一个名为xIndex的索引，当然我们也可以删除所有索引，如下：  \n\n```\ndb.sang_collect.dropIndexes()\n```  \n\n## 总结\n\n索引是个好东西，可以有效的提高查询速度，但是索引会降低插入、更新和删除的速度，因为这些操作不仅要更新文档，还要更新索引，MongoDB限制每个集合上最多有64个索引，我们在创建索引时要仔细斟酌索引的字段。   \n\n好了，MongoDB中的索引入门我们就说到这里，小伙伴们有问题欢迎留言讨论。   \n\n参考资料：  \n\n1.《MongoDB权威指南第2版》  \n\n更多资料请关注公众号：  \n\n![公众号二维码](https://mmbiz.qpic.cn/mmbiz_jpg/GvtDGKK4uYkO6VEW6XfkovAic6oA5LegzZKeRj0OwOZZQ8ic1tEoBOVBBOreAB9Dz32CN9MU19slrjn5qvxbR7pQ/0?wx_fmt=jpeg)   ', '<p>索引就像图书的目录一样，可以让我们快速定位到需要的内容，关系型数据库中有索引，NoSQL中当然也有，本文我们就先来简单介绍下MongoDB中的索引。</p>\n<p>本文是MongoDB系列的第九篇文章，了解前面的文章有助于更好的理解本文：</p>\n<h2><img src=\"http://localhost:80/blogimg/20171223/b13e845a-29f7-402c-a2d4-cc7830fd767e_Image083.png\" alt=\"Image 083.png\" /></h2>\n<p>1.<a href=\"http://mp.weixin.qq.com/s/R4HpFO60BQ0-dnTMVQOvhw\" target=\"_blank\">Linux上安装MongoDB</a><br />\n2.<a href=\"http://mp.weixin.qq.com/s/qhCrjbEgH4FpDv-2sjFEAQ\" target=\"_blank\">MongoDB基本操作</a><br />\n3.<a href=\"http://mp.weixin.qq.com/s/tVC2Uq30qWx4o3eB2aXlmQ\" target=\"_blank\">MongoDB数据类型</a><br />\n4.<a href=\"http://mp.weixin.qq.com/s/wM-xmd4Al0zk4hGTEfr8LQ\" target=\"_blank\">MongoDB文档更新操作</a><br />\n5.<a href=\"http://mp.weixin.qq.com/s/VfdZ5QX5I4blMTsMl-IEbg\" target=\"_blank\">MongoDB文档查询操作(一)</a><br />\n6.<a href=\"http://mp.weixin.qq.com/s/_JWWvBzdDUCtzdjcIMfcQQ\" target=\"_blank\">MongoDB文档查询操作(二)</a><br />\n7.<a href=\"http://mp.weixin.qq.com/s/hkSP-i-_vzLy1-hkdq3o4w\" target=\"_blank\">MongoDB文档查询操作(三)</a><br />\n8.<a href=\"http://mp.weixin.qq.com/s/sH3eN7IF6zMedDeC_Vpcww\" target=\"_blank\">MongoDB查看执行计划</a></p>\n<hr />\n<h2>索引创建</h2>\n<p>默认情况下，集合中的<code>_id</code>字段就是索引，我们可以通过getIndexes()方法来查看一个集合中的索引：</p>\n<pre><code class=\"lang-\">db.sang_collect.getIndexes()\n</code></pre>\n<p>结果如下：</p>\n<pre><code class=\"lang-\">[\n    {\n        &quot;v&quot; : 2,\n        &quot;key&quot; : {\n            &quot;_id&quot; : 1\n        },\n        &quot;name&quot; : &quot;_id_&quot;,\n        &quot;ns&quot; : &quot;sang.sang_collect&quot;\n    }\n]\n</code></pre>\n<p>我们看到这里只有一个索引，就是<code>_id</code>。</p>\n<p>现在我的集合中有10000个文档，我想要查询x为1的文档，我的查询操作如下：</p>\n<pre><code class=\"lang-\">db.sang_collect.find({x:1})\n</code></pre>\n<p>这种查询默认情况下会做全表扫描，我们可以用上篇文章介绍的explain()来查看一下查询计划，如下：</p>\n<pre><code class=\"lang-\">db.sang_collect.find({x:1}).explain(&quot;executionStats&quot;)\n</code></pre>\n<p>结果如下：</p>\n<pre><code class=\"lang-\">{\n    &quot;queryPlanner&quot; : {\n    },\n    &quot;executionStats&quot; : {\n        &quot;executionSuccess&quot; : true,\n        &quot;nReturned&quot; : 1,\n        &quot;executionTimeMillis&quot; : 15,\n        &quot;totalKeysExamined&quot; : 0,\n        &quot;totalDocsExamined&quot; : 10000,\n        &quot;executionStages&quot; : {\n            &quot;stage&quot; : &quot;COLLSCAN&quot;,\n            &quot;filter&quot; : {\n                &quot;x&quot; : {\n                    &quot;$eq&quot; : 1.0\n                }\n            },\n            &quot;nReturned&quot; : 1,\n            &quot;executionTimeMillisEstimate&quot; : 29,\n            &quot;works&quot; : 10002,\n            &quot;advanced&quot; : 1,\n            &quot;needTime&quot; : 10000,\n            &quot;needYield&quot; : 0,\n            &quot;saveState&quot; : 78,\n            &quot;restoreState&quot; : 78,\n            &quot;isEOF&quot; : 1,\n            &quot;invalidates&quot; : 0,\n            &quot;direction&quot; : &quot;forward&quot;,\n            &quot;docsExamined&quot; : 10000\n        }\n    },\n    &quot;serverInfo&quot; : {\n    },\n    &quot;ok&quot; : 1.0\n}\n</code></pre>\n<p>结果比较长，我摘取了关键的一部分。我们可以看到查询方式是全表扫描，一共扫描了10000个文档才查出来我要的结果。实际上我要的文档就排第二个，但是系统不知道这个集合中一共有多少个x为1的文档，所以会把全表扫描完，这种方式当然很低效，但是如果我加上limit，如下：</p>\n<pre><code class=\"lang-\">db.sang_collect.find({x:1}).limit(1)\n</code></pre>\n<p>此时再看查询计划发现只扫描了两个文档就有结果了，但是如果我要查询x为9999的记录，那还是得把全表扫描一遍，此时，我们就可以给该字段建立索引，索引建立方式如下：</p>\n<pre><code class=\"lang-\">db.sang_collect.ensureIndex({x:1})\n</code></pre>\n<p>1表示升序，-1表示降序。当我们给x字段建立索引之后，再根据x字段去查询，速度就非常快了，我们看下面这个查询操作的执行计划：</p>\n<pre><code class=\"lang-\">db.sang_collect.find({x:9999}).explain(&quot;executionStats&quot;)\n</code></pre>\n<p>这个查询计划过长我就不贴出来了，我们可以重点关注查询要耗费的时间大幅度下降。</p>\n<p>此时调用getIndexes()方法可以看到我们刚刚创建的索引，如下：</p>\n<pre><code class=\"lang-\">[\n    {\n        &quot;v&quot; : 2,\n        &quot;key&quot; : {\n            &quot;_id&quot; : 1\n        },\n        &quot;name&quot; : &quot;_id_&quot;,\n        &quot;ns&quot; : &quot;sang.sang_collect&quot;\n    },\n    {\n        &quot;v&quot; : 2,\n        &quot;key&quot; : {\n            &quot;x&quot; : 1.0\n        },\n        &quot;name&quot; : &quot;x_1&quot;,\n        &quot;ns&quot; : &quot;sang.sang_collect&quot;\n    }\n]\n</code></pre>\n<p>我们看到每个索引都有一个名字，默认的索引名字为<code>字段名_排序值</code>，当然我们也可以在创建索引时自定义索引名字，如下：</p>\n<pre><code class=\"lang-\">db.sang_collect.ensureIndex({x:1},{name:&quot;myfirstindex&quot;})\n</code></pre>\n<p>此时创建好的索引如下：</p>\n<pre><code class=\"lang-\">{\n    &quot;v&quot; : 2,\n    &quot;key&quot; : {\n        &quot;x&quot; : 1.0\n    },\n    &quot;name&quot; : &quot;myfirstindex&quot;,\n    &quot;ns&quot; : &quot;sang.sang_collect&quot;\n}\n</code></pre>\n<p>当然索引在创建的过程中还有许多其他可选参数，如下：</p>\n<pre><code class=\"lang-\">db.sang_collect.ensureIndex({x:1},{name:&quot;myfirstindex&quot;,dropDups:true,background:true,unique:true,sparse:true,v:1,weights:99999})\n</code></pre>\n<p>关于这里的参数，我说一下：</p>\n<blockquote>\n<p>1.name表示索引的名称<br />\n2.dropDups表示创建唯一性索引时如果出现重复，则将重复的删除，只保留第一个<br />\n3.background是否在后台创建索引，在后台创建索引不影响数据库当前的操作，默认为false<br />\n4.unique是否创建唯一索引，默认false<br />\n5.sparse对文档中不存在的字段是否不起用索引，默认false<br />\n6.v表示索引的版本号，默认为2<br />\n7.weights表示索引的权重</p>\n</blockquote>\n<p>此时创建好的索引如下：</p>\n<pre><code class=\"lang-\">{\n    &quot;v&quot; : 1,\n    &quot;unique&quot; : true,\n    &quot;key&quot; : {\n        &quot;x&quot; : 1.0\n    },\n    &quot;name&quot; : &quot;myfirstindex&quot;,\n    &quot;ns&quot; : &quot;sang.sang_collect&quot;,\n    &quot;background&quot; : true,\n    &quot;sparse&quot; : true,\n    &quot;weights&quot; : 99999.0\n}\n</code></pre>\n<h2>查看索引</h2>\n<p>上文我们介绍了getIndexes()可以用来查看索引，我们还可以通过totalIndexSize()来查看索引的大小，如下：</p>\n<pre><code class=\"lang-\">db.sang_collect.totalIndexSize()\n</code></pre>\n<h2>删除索引</h2>\n<p>我们可以按名称删除索引，如下：</p>\n<pre><code class=\"lang-\">db.sang_collect.dropIndex(&quot;xIndex&quot;)\n</code></pre>\n<p>表示删除一个名为xIndex的索引，当然我们也可以删除所有索引，如下：</p>\n<pre><code class=\"lang-\">db.sang_collect.dropIndexes()\n</code></pre>\n<h2>总结</h2>\n<p>索引是个好东西，可以有效的提高查询速度，但是索引会降低插入、更新和删除的速度，因为这些操作不仅要更新文档，还要更新索引，MongoDB限制每个集合上最多有64个索引，我们在创建索引时要仔细斟酌索引的字段。</p>\n<p>好了，MongoDB中的索引入门我们就说到这里，小伙伴们有问题欢迎留言讨论。</p>\n<p>参考资料：</p>\n<p>1.《MongoDB权威指南第2版》</p>\n<p>更多资料请关注公众号：</p>\n<p><img src=\"https://mmbiz.qpic.cn/mmbiz_jpg/GvtDGKK4uYkO6VEW6XfkovAic6oA5LegzZKeRj0OwOZZQ8ic1tEoBOVBBOreAB9Dz32CN9MU19slrjn5qvxbR7pQ/0?wx_fmt=jpeg\" alt=\"公众号二维码\" /></p>\n', '索引就像图书的目录一样，可以让我们快速定位到需要的内容，关系型数据库中有索引，NoSQL中当然也有，', '2', '3', '2017-12-23 21:42:59', '2017-12-23 21:42:59', '1', '999');
INSERT INTO `article` VALUES ('119', 'Git学习资料', '关于Git的用法我们已经写七篇文章，介绍了Git的不少用法，这些足以应付工作中90%的需求了，剩下的10%就需要小伙伴们在工作中自己慢慢总结了，我这里再给小伙伴们推荐一点Git学习资料，为我们的Git系列画上一个句号。  \n\n\n![Image 012.png](http://localhost:80/blogimg/20171224/9f628a1d-2acd-412f-b9a6-b52acf779138_Image012.png)\n\n## 书\n\n推荐两本个人觉得很不错的书：  \n\n1.《GitHub入门与实践》  \n2.《Pro Git》  \n\n《GitHub入门与实践》秉承了日系技术书刊一贯的“手把手教学”风格，作者用亲切的语言，简明扼要的介绍，配以生动详实的示例一步步讲解GitHub和Git的使用方法。《Pro Git》作为Git官方推荐书籍，《Pro Git》值得Git初学者和爱好者认真阅读一遍。  \n\n## 网站\n\n1.https://learngitbranching.js.org  \n\n链接是一个git学习网站，我们可以直接在上面练习git命令。  \n\n## 博客\n\n推荐本公号前面的几篇教程:  \n\n---\n1.[Git概述](https://mp.weixin.qq.com/s/3RheAJ9LYKK5BnVr331h5A)  \n2.[Git基本操作](https://mp.weixin.qq.com/s/S1T4wy3srmLvXgIjvpVEwg)  \n3.[Git中的各种后悔药](https://mp.weixin.qq.com/s/WiLnRQfDVITHMYzGl9pAzQ)  \n4.[Git分支管理](https://mp.weixin.qq.com/s/9OZY7x9DSyRO7T56TyDJ8Q)  \n5.[Git关联远程仓库](https://mp.weixin.qq.com/s/x5bRe4QBMoVFKv5jNl9iRw)  \n6.[Git工作区储藏兼谈分支管理中的一个小问题](https://mp.weixin.qq.com/s/S5rrBQoWwof7n3ZRTrZGWQ)  \n7.[Git标签管理](https://mp.weixin.qq.com/s/Jwr4fjCw7MBUD-CalVXhZQ)  \n\n---  \n\n更多JavaEE和Git资料请关注公众号：   \n\n![公众号二维码](https://mmbiz.qpic.cn/mmbiz_jpg/GvtDGKK4uYkO6VEW6XfkovAic6oA5LegzZKeRj0OwOZZQ8ic1tEoBOVBBOreAB9Dz32CN9MU19slrjn5qvxbR7pQ/0?wx_fmt=jpeg)   ', '<p>关于Git的用法我们已经写七篇文章，介绍了Git的不少用法，这些足以应付工作中90%的需求了，剩下的10%就需要小伙伴们在工作中自己慢慢总结了，我这里再给小伙伴们推荐一点Git学习资料，为我们的Git系列画上一个句号。</p>\n<p><img src=\"http://localhost:80/blogimg/20171224/9f628a1d-2acd-412f-b9a6-b52acf779138_Image012.png\" alt=\"Image 012.png\" /></p>\n<h2>书</h2>\n<p>推荐两本个人觉得很不错的书：</p>\n<p>1.《GitHub入门与实践》<br />\n2.《Pro Git》</p>\n<p>《GitHub入门与实践》秉承了日系技术书刊一贯的“手把手教学”风格，作者用亲切的语言，简明扼要的介绍，配以生动详实的示例一步步讲解GitHub和Git的使用方法。《Pro Git》作为Git官方推荐书籍，《Pro Git》值得Git初学者和爱好者认真阅读一遍。</p>\n<h2>网站</h2>\n<p>1.https://learngitbranching.js.org</p>\n<p>链接是一个git学习网站，我们可以直接在上面练习git命令。</p>\n<h2>博客</h2>\n<p>推荐本公号前面的几篇教程:</p>\n<hr />\n<p>1.<a href=\"https://mp.weixin.qq.com/s/3RheAJ9LYKK5BnVr331h5A\" target=\"_blank\">Git概述</a><br />\n2.<a href=\"https://mp.weixin.qq.com/s/S1T4wy3srmLvXgIjvpVEwg\" target=\"_blank\">Git基本操作</a><br />\n3.<a href=\"https://mp.weixin.qq.com/s/WiLnRQfDVITHMYzGl9pAzQ\" target=\"_blank\">Git中的各种后悔药</a><br />\n4.<a href=\"https://mp.weixin.qq.com/s/9OZY7x9DSyRO7T56TyDJ8Q\" target=\"_blank\">Git分支管理</a><br />\n5.<a href=\"https://mp.weixin.qq.com/s/x5bRe4QBMoVFKv5jNl9iRw\" target=\"_blank\">Git关联远程仓库</a><br />\n6.<a href=\"https://mp.weixin.qq.com/s/S5rrBQoWwof7n3ZRTrZGWQ\" target=\"_blank\">Git工作区储藏兼谈分支管理中的一个小问题</a><br />\n7.<a href=\"https://mp.weixin.qq.com/s/Jwr4fjCw7MBUD-CalVXhZQ\" target=\"_blank\">Git标签管理</a></p>\n<hr />\n<p>更多JavaEE和Git资料请关注公众号：</p>\n<p><img src=\"https://mmbiz.qpic.cn/mmbiz_jpg/GvtDGKK4uYkO6VEW6XfkovAic6oA5LegzZKeRj0OwOZZQ8ic1tEoBOVBBOreAB9Dz32CN9MU19slrjn5qvxbR7pQ/0?wx_fmt=jpeg\" alt=\"公众号二维码\" /></p>\n', '关于Git的用法我们已经写七篇文章，介绍了Git的不少用法，这些足以应付工作中90%的需求了，剩下的', '1', '3', '2017-12-24 09:00:05', '2017-12-24 09:00:05', '1', '2');
INSERT INTO `article` VALUES ('120', '人生感悟2222666666666', '人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2', '<p>人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2</p>\n', '人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2人生感悟2', '2', '3', '2017-12-24 10:10:33', '2017-12-24 10:10:33', '1', '12');
INSERT INTO `article` VALUES ('121', '感悟感悟', '啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊', '<p>啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊</p>\n', '啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊啊', '3', '3', '2017-12-24 22:32:20', '2017-12-24 22:32:20', '1', '6');
INSERT INTO `article` VALUES ('123', '423', '33342', '<p>33342</p>\n', '33342\n', '1', '3', null, '2019-05-17 09:19:41', '0', '0');
INSERT INTO `article` VALUES ('124', 'fdgbfdgcchgf', 'tyrhgfhfghfgdhfgdhfdghdfg<embed src=\'http://player.youku.com/player.php/sid/XNDE2Njg3MTI2OA==/v.swf\' allowFullScreen=\'true\' quality=\'high\' width=\'480\' height=\'400\' align=\'middle\' allowScriptAccess=\'always\' type=\'application/x-shockwave-flash\'></embed>**粗体**', '<p>tyrhgfhfghfgdhfgdhfdghdfg<embed src=\'http://player.youku.com/player.php/sid/XNDE2Njg3MTI2OA==/v.swf\' allowFullScreen=\'true\' quality=\'high\' width=\'480\' height=\'400\' align=\'middle\' allowScriptAccess=\'always\' type=\'application/x-shockwave-flash\'></embed><strong>粗体</strong></p>\n', 'tyrhgfhfghfgdhfgdhfdghdfg粗体\n', '2', '3', '2019-05-28 12:46:12', '2019-05-28 12:46:12', '1', '1');
INSERT INTO `article` VALUES ('125', 'sadfasdfsdafsdafsda', 'tyrhgfhfghfgdhfgdhfdghdfg<embed src=\'http://player.youku.com/player.php/sid/XNDE2Njg3MTI2OA==/v.swf\' allowFullScreen=\'true\' quality=\'high\' width=\'480\' height=\'400\' align=\'middle\' allowScriptAccess=\'always\' type=\'application/x-shockwave-flash\'></embed>**粗体**', '<p>tyrhgfhfghfgdhfgdhfdghdfg<embed src=\'http://player.youku.com/player.php/sid/XNDE2Njg3MTI2OA==/v.swf\' allowFullScreen=\'true\' quality=\'high\' width=\'480\' height=\'400\' align=\'middle\' allowScriptAccess=\'always\' type=\'application/x-shockwave-flash\'></embed><strong>粗体</strong></p>\n', 'tyrhgfhfghfgdhfgdhfdghdfg粗体\n', '2', '3', '2019-05-28 12:46:22', '2019-05-28 12:46:22', '1', '1');
INSERT INTO `article` VALUES ('126', 'sadfasdfsdafsdafsda', 'tyrhgfhfghfgdhfgdhfdghdfg<embed src=\'http://player.youku.com/player.php/sid/XNDE2Njg3MTI2OA==/v.swf\' allowFullScreen=\'true\' quality=\'high\' width=\'480\' height=\'400\' align=\'middle\' allowScriptAccess=\'always\' type=\'application/x-shockwave-flash\'></embed>**粗体**', '<p>tyrhgfhfghfgdhfgdhfdghdfg<embed src=\'http://player.youku.com/player.php/sid/XNDE2Njg3MTI2OA==/v.swf\' allowFullScreen=\'true\' quality=\'high\' width=\'480\' height=\'400\' align=\'middle\' allowScriptAccess=\'always\' type=\'application/x-shockwave-flash\'></embed><strong>粗体</strong></p>\n', 'tyrhgfhfghfgdhfgdhfdghdfg粗体\n', '2', '3', '2019-05-28 12:46:28', '2019-05-28 12:46:28', '1', '3');

-- ----------------------------
-- Table structure for article_tags
-- ----------------------------
DROP TABLE IF EXISTS `article_tags`;
CREATE TABLE `article_tags` (
  `id` int(11) NOT NULL,
  `aid` int(11) DEFAULT NULL,
  `tid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of article_tags
-- ----------------------------

-- ----------------------------
-- Table structure for category
-- ----------------------------
DROP TABLE IF EXISTS `category`;
CREATE TABLE `category` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `cateName` varchar(255) DEFAULT NULL,
  `date` date DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=5 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of category
-- ----------------------------
INSERT INTO `category` VALUES ('1', '政策', '2019-05-16');
INSERT INTO `category` VALUES ('2', '文化', '2019-05-16');
INSERT INTO `category` VALUES ('3', '教育', '2019-05-16');
INSERT INTO `category` VALUES ('4', '农技', '2019-05-16');

-- ----------------------------
-- Table structure for comments
-- ----------------------------
DROP TABLE IF EXISTS `comments`;
CREATE TABLE `comments` (
  `id` int(11) NOT NULL,
  `aid` int(11) DEFAULT NULL,
  `content` text,
  `publishDae` datetime DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  `hid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of comments
-- ----------------------------

-- ----------------------------
-- Table structure for department
-- ----------------------------
DROP TABLE IF EXISTS `department`;
CREATE TABLE `department` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL COMMENT '部门名称',
  `parentId` int(11) DEFAULT NULL,
  `depPath` varchar(255) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT '1',
  `isParent` tinyint(1) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=157 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of department
-- ----------------------------
INSERT INTO `department` VALUES ('1', '固原市', '-1', '.1', '1', '1');
INSERT INTO `department` VALUES ('4', '隆德县', '1', '.1.4', '1', '1');
INSERT INTO `department` VALUES ('5', '城关镇', '4', '.1.4.5', '1', '1');
INSERT INTO `department` VALUES ('8', '城关', '5', '.1.4.5.8', '1', '0');
INSERT INTO `department` VALUES ('78', '白衣坝', '5', '.1.4.5.78', '1', '0');
INSERT INTO `department` VALUES ('91', '鹄衣坝', '5', '.1.4.5.91', '1', '0');
INSERT INTO `department` VALUES ('92', '大渡坝', '5', '.1.4.5.92', '1', '0');
INSERT INTO `department` VALUES ('94', '原州区', '1', '.1.94', '1', '1');
INSERT INTO `department` VALUES ('95', '泾源县', '1', '.1.95', '1', '1');
INSERT INTO `department` VALUES ('96', '彭阳县', '1', '.1.96', '1', '1');
INSERT INTO `department` VALUES ('97', '西吉县', '1', '.1.97', '1', '1');
INSERT INTO `department` VALUES ('99', '三营镇', '94', '.1.94.99', '1', '1');
INSERT INTO `department` VALUES ('100', '头营镇', '94', '.1.94.100', '1', '0');
INSERT INTO `department` VALUES ('101', '官厅镇', '94', '.1.94.101', '1', '0');
INSERT INTO `department` VALUES ('102', '张易镇', '94', '.1.94.102', '1', '0');
INSERT INTO `department` VALUES ('103', '开城镇', '94', '.1.94.103', '1', '0');
INSERT INTO `department` VALUES ('104', '彭堡镇', '94', '.1.94.104', '1', '0');
INSERT INTO `department` VALUES ('105', '黄铎堡镇', '94', '.1.94.105', '1', '0');
INSERT INTO `department` VALUES ('106', '寨科乡', '94', '.1.94.106', '1', '0');
INSERT INTO `department` VALUES ('107', '炭山乡', '94', '.1.94.107', '1', '0');
INSERT INTO `department` VALUES ('108', '中河乡', '94', '.1.94.108', '1', '0');
INSERT INTO `department` VALUES ('109', '河川乡', '94', '.1.94.109', '1', '0');
INSERT INTO `department` VALUES ('110', '南关街道', '94', '.1.94.110', '1', '0');
INSERT INTO `department` VALUES ('111', '古雁街道', '94', '.1.94.111', '1', '0');
INSERT INTO `department` VALUES ('112', '北塬街道', '94', '.1.94.112', '1', '0');
INSERT INTO `department` VALUES ('113', '第一居委会', '99', '.1.94.99.113', '1', '0');
INSERT INTO `department` VALUES ('114', '第二居委会', '99', '.1.94.99.114', '1', '0');
INSERT INTO `department` VALUES ('115', '东塬村', '99', '.1.94.99.115', '1', '0');
INSERT INTO `department` VALUES ('116', '西台村', '99', '.1.94.99.116', '1', '0');
INSERT INTO `department` VALUES ('117', '香水镇', '95', '.1.95.117', '1', '0');
INSERT INTO `department` VALUES ('118', '泾河源镇', '95', '.1.95.118', '1', '0');
INSERT INTO `department` VALUES ('119', '六盘山镇', '95', '.1.95.119', '1', '0');
INSERT INTO `department` VALUES ('120', '黄花乡', '95', '.1.95.120', '1', '0');
INSERT INTO `department` VALUES ('121', '大湾乡', '95', '.1.95.121', '1', '0');
INSERT INTO `department` VALUES ('122', '兴盛乡', '95', '.1.95.122', '1', '0');
INSERT INTO `department` VALUES ('124', '新民乡', '95', '.1.95.124', '1', '0');
INSERT INTO `department` VALUES ('125', '白阳镇', '96', '.1.96.125', '1', '0');
INSERT INTO `department` VALUES ('126', '王洼镇', '96', '.1.96.126', '1', '0');
INSERT INTO `department` VALUES ('127', '古城镇', '96', '.1.96.127', '1', '0');
INSERT INTO `department` VALUES ('128', '红河镇', '96', '.1.96.128', '1', '0');
INSERT INTO `department` VALUES ('129', '新集乡', '96', '.1.96.129', '1', '0');
INSERT INTO `department` VALUES ('130', '城阳乡', '96', '.1.96.130', '1', '0');
INSERT INTO `department` VALUES ('131', '冯庄乡', '96', '.1.96.131', '1', '0');
INSERT INTO `department` VALUES ('132', '小岔乡', '96', '.1.96.132', '1', '0');
INSERT INTO `department` VALUES ('133', '孟塬乡', '96', '.1.96.133', '1', '0');
INSERT INTO `department` VALUES ('134', '罗洼乡', '96', '.1.96.134', '1', '0');
INSERT INTO `department` VALUES ('135', '交岔乡', '96', '.1.96.135', '1', '0');
INSERT INTO `department` VALUES ('136', '交岔乡', '96', '.1.96.136', '1', '0');
INSERT INTO `department` VALUES ('137', '吉强镇', '97', '.1.97.137', '1', '0');
INSERT INTO `department` VALUES ('138', '兴隆镇', '97', '.1.97.138', '1', '0');
INSERT INTO `department` VALUES ('139', '平峰镇', '97', '.1.97.139', '1', '0');
INSERT INTO `department` VALUES ('140', '将台堡镇', '97', '.1.97.140', '1', '0');
INSERT INTO `department` VALUES ('141', '新营乡', '97', '.1.97.141', '1', '0');
INSERT INTO `department` VALUES ('142', '红耀乡', '97', '.1.97.142', '1', '0');
INSERT INTO `department` VALUES ('143', '田坪乡', '97', '.1.97.143', '1', '0');
INSERT INTO `department` VALUES ('144', '马建乡', '97', '.1.97.144', '1', '0');
INSERT INTO `department` VALUES ('145', '震湖乡', '97', '.1.97.145', '1', '0');
INSERT INTO `department` VALUES ('146', '兴平乡', '97', '.1.97.146', '1', '0');
INSERT INTO `department` VALUES ('147', '西滩乡', '97', '.1.97.147', '1', '0');
INSERT INTO `department` VALUES ('148', '王民乡', '97', '.1.97.148', '1', '0');
INSERT INTO `department` VALUES ('149', '什字乡', '97', '.1.97.149', '1', '0');
INSERT INTO `department` VALUES ('150', '马莲乡', '97', '.1.97.150', '1', '0');
INSERT INTO `department` VALUES ('151', '硝河乡', '97', '.1.97.151', '1', '0');
INSERT INTO `department` VALUES ('152', '偏城乡', '97', '.1.97.152', '1', '0');
INSERT INTO `department` VALUES ('153', '沙沟乡', '97', '.1.97.153', '1', '0');
INSERT INTO `department` VALUES ('154', '白崖乡', '97', '.1.97.154', '1', '0');
INSERT INTO `department` VALUES ('155', '火石寨乡', '97', '.1.97.155', '1', '0');
INSERT INTO `department` VALUES ('156', '大发发发', '5', '.1.4.5.156', '1', '0');

-- ----------------------------
-- Table structure for employee
-- ----------------------------
DROP TABLE IF EXISTS `employee`;
CREATE TABLE `employee` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '员工编号',
  `name` varchar(10) DEFAULT NULL COMMENT '员工姓名',
  `gender` char(4) DEFAULT NULL COMMENT '性别',
  `birthday` date DEFAULT NULL COMMENT '出生日期',
  `idCard` char(18) DEFAULT NULL COMMENT '身份证号',
  `wedlock` enum('已婚','未婚','离异') DEFAULT NULL COMMENT '婚姻状况',
  `nationId` int(8) DEFAULT NULL COMMENT '民族',
  `nativePlace` varchar(20) DEFAULT NULL COMMENT '籍贯',
  `politicId` int(8) DEFAULT NULL COMMENT '政治面貌',
  `email` varchar(20) DEFAULT NULL COMMENT '邮箱',
  `phone` varchar(11) DEFAULT NULL COMMENT '电话号码',
  `address` varchar(64) DEFAULT NULL COMMENT '联系地址',
  `departmentId` int(11) DEFAULT NULL COMMENT '所属部门',
  `jobLevelId` int(11) DEFAULT NULL COMMENT '职称ID',
  `posId` int(11) DEFAULT NULL COMMENT '职位ID',
  `engageForm` varchar(8) DEFAULT NULL COMMENT '聘用形式',
  `tiptopDegree` enum('博士','硕士','本科','大专','高中','初中','小学','其他') DEFAULT NULL COMMENT '最高学历',
  `specialty` varchar(32) DEFAULT NULL COMMENT '所属专业',
  `school` varchar(32) DEFAULT NULL COMMENT '毕业院校',
  `beginDate` date DEFAULT NULL COMMENT '入职日期',
  `workState` enum('在职','离职') DEFAULT '在职' COMMENT '在职状态',
  `workID` char(8) DEFAULT NULL COMMENT '工号',
  `contractTerm` double DEFAULT NULL COMMENT '合同期限',
  `conversionTime` date DEFAULT NULL COMMENT '转正日期',
  `notWorkDate` date DEFAULT NULL COMMENT '离职日期',
  `beginContract` date DEFAULT NULL COMMENT '合同起始日期',
  `endContract` date DEFAULT NULL COMMENT '合同终止日期',
  `workAge` int(11) DEFAULT NULL COMMENT '工龄',
  PRIMARY KEY (`id`),
  KEY `departmentId` (`departmentId`),
  KEY `jobId` (`jobLevelId`),
  KEY `dutyId` (`posId`),
  KEY `nationId` (`nationId`),
  KEY `politicId` (`politicId`),
  KEY `workID_key` (`workID`),
  CONSTRAINT `employee_ibfk_1` FOREIGN KEY (`departmentId`) REFERENCES `department` (`id`),
  CONSTRAINT `employee_ibfk_2` FOREIGN KEY (`jobLevelId`) REFERENCES `joblevel` (`id`),
  CONSTRAINT `employee_ibfk_3` FOREIGN KEY (`posId`) REFERENCES `position` (`id`),
  CONSTRAINT `employee_ibfk_4` FOREIGN KEY (`nationId`) REFERENCES `nation` (`id`),
  CONSTRAINT `employee_ibfk_5` FOREIGN KEY (`politicId`) REFERENCES `politicsstatus` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=21 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of employee
-- ----------------------------
INSERT INTO `employee` VALUES ('1', '江南一点雨', '男', '1990-01-01', '610122199001011256', '已婚', '1', '陕西', '13', 'laowang@qq.com', '18565558897', '深圳市南山区', '5', '9', '29', '劳务合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000001', '2', '2018-04-01', null, '2018-01-01', '2020-01-01', null);
INSERT INTO `employee` VALUES ('2', '陈静', '女', '1989-02-01', '421288198902011234', '已婚', '1', '海南', '1', 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', '8', '12', '30', '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000002', '3', '2015-09-10', null, '2015-06-09', '2018-06-08', null);
INSERT INTO `employee` VALUES ('3', '赵琳浩', '男', '1993-03-04', '610122199303041456', '未婚', '1', '陕西', '3', 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', '91', '12', '33', '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000003', '3.5', '2018-04-01', null, '2018-01-01', '2021-07-14', null);
INSERT INTO `employee` VALUES ('4', '鹿存亮', '男', '1990-01-03', '610122199001031456', '已婚', '1', '陕西', '3', 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', '92', '12', '34', '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000004', '3.5', '2018-04-01', null, '2018-01-01', '2021-07-14', null);
INSERT INTO `employee` VALUES ('5', '姚森', '男', '1991-02-05', '610122199102058952', '已婚', '1', '河南', '3', 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', '92', '15', '34', '劳动合同', '硕士', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000005', '7', '2017-04-02', null, '2017-01-02', '2024-01-17', null);
INSERT INTO `employee` VALUES ('6', '云星', '女', '1993-01-05', '610122199301054789', '已婚', '1', '陕西西安', '1', 'yunxing@qq.com', '15644442252', '陕西西安新城区', '92', '16', '34', '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000006', '5.25', '2018-04-01', null, '2018-01-01', '2023-04-13', null);
INSERT INTO `employee` VALUES ('7', '贾旭明', '男', '1993-11-11', '610122199311111234', '已婚', '1', '广东广州', '4', 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', '78', '15', '33', '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000007', '5.25', '2018-04-01', null, '2018-01-01', '2023-04-13', null);
INSERT INTO `employee` VALUES ('8', '张黎明', '男', '1991-02-01', '610144199102014569', '已婚', '1', '广东', '6', 'zhangliming@qq.com', '18979994478', '广东珠海', '91', '15', '33', '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000008', '7', '2018-04-01', null, '2018-01-01', '2025-01-30', null);
INSERT INTO `employee` VALUES ('9', '薛磊', '男', '1992-07-01', '610144199207017895', '已婚', '1', '陕西西安', '13', 'xuelei@qq.com', '15648887741', '西安市雁塔区', '92', '14', '34', '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000009', '6', '2018-04-01', null, '2018-01-01', '2024-01-17', null);
INSERT INTO `employee` VALUES ('10', '张洁', '女', '1990-10-09', '420177199010093652', '未婚', '1', '海南', '5', 'zhangjie@qq.com', '13695557742', '海口市美兰区', '92', '16', '34', '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000010', '1', '2018-01-31', null, '2018-01-01', '2019-01-01', null);
INSERT INTO `employee` VALUES ('11', '江南一点雨2', '男', '1990-01-01', '610122199001011256', '已婚', '1', '陕西', '13', 'laowang@qq.com', '18565558897', '深圳市南山区', '91', '9', '29', '劳动合同', '本科', '信息管理与信息系统', '深圳大学', '2018-01-01', '在职', '00000011', '1', '2018-04-01', null, '2018-01-01', '2019-01-01', null);
INSERT INTO `employee` VALUES ('12', '陈静2', '女', '1989-02-01', '421288198902011234', '已婚', '1', '海南', '1', 'chenjing@qq.com', '18795556693', '海南省海口市美兰区', '78', '12', '30', '劳动合同', '高中', '市场营销', '武汉大学', '2015-06-09', '在职', '00000012', '3', '2015-09-10', null, '2015-06-09', '2018-06-08', null);
INSERT INTO `employee` VALUES ('13', '赵琳浩2', '男', '1993-03-04', '610122199303041456', '未婚', '1', '陕西', '3', 'zhao@qq.com', '15698887795', '陕西省西安市莲湖区', '91', '12', '33', '劳动合同', '博士', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000013', '3.5', '2018-04-01', null, '2018-01-01', '2021-07-14', null);
INSERT INTO `employee` VALUES ('14', '鹿存亮2', '男', '1990-01-03', '610122199001031456', '已婚', '1', '陕西', '3', 'zhao@qq.com', '15612347795', '陕西省西安市莲湖区', '92', '12', '34', '劳动合同', '高中', '电子工程', '哈尔滨理工大学', '2018-01-01', '在职', '00000014', '3.5', '2018-04-01', null, '2018-01-01', '2021-07-14', null);
INSERT INTO `employee` VALUES ('15', '姚森2', '男', '1991-02-05', '610122199102058952', '已婚', '1', '河南', '3', 'yaosen@qq.com', '14785559936', '河南洛阳人民大道58号', '92', '15', '34', '劳动合同', '初中', '室内装修设计', '西北大学', '2017-01-02', '在职', '00000015', '7', '2017-04-02', null, '2017-01-02', '2024-01-17', null);
INSERT INTO `employee` VALUES ('16', '云星2', '女', '1993-01-05', '610122199301054789', '已婚', '1', '陕西西安', '1', 'yunxing@qq.com', '15644442252', '陕西西安新城区', '92', '16', '34', '劳务合同', '硕士', '通信工程', '西安电子科技学校', '2018-01-01', '在职', '00000016', '5.25', '2018-04-01', null, '2018-01-01', '2023-04-13', null);
INSERT INTO `employee` VALUES ('17', '贾旭明2', '男', '1993-11-11', '610122199311111234', '已婚', '1', '广东广州', '4', 'jiaxuming@qq.com', '15644441234', '广东省广州市天河区冼村路', '78', '15', '33', '劳务合同', '初中', '通信工程', '西北大学', '2018-01-01', '在职', '00000017', '5.25', '2018-04-01', null, '2018-01-01', '2023-04-13', null);
INSERT INTO `employee` VALUES ('18', '王一亭', '男', '1991-02-01', '610144199102014569', '已婚', '1', '广东', '6', 'zhangliming@qq.com', '18979994478', '广东珠海', '91', '15', '33', '劳动合同', '高中', '考古', '清华大学', '2018-01-01', '在职', '00000018', '7', '2018-04-01', null, '2018-01-01', '2025-01-30', null);
INSERT INTO `employee` VALUES ('19', '薛磊2', '男', '1992-07-01', '610144199207017895', '已婚', '1', '陕西西安', '13', 'xuelei@qq.com', '15648887741', '西安市雁塔区', '92', '14', '34', '劳动合同', '初中', '无', '华胥中学', '2018-01-01', '在职', '00000019', '1', '2018-04-01', null, '2018-01-01', '2019-01-01', null);
INSERT INTO `employee` VALUES ('20', '张洁2', '女', '1990-10-09', '420177199010093652', '未婚', '1', '海南', '5', 'zhangjie@qq.com', '13695557742', '海口市美兰区', '92', '16', '34', '劳动合同', '高中', '无', '海南侨中', '2018-01-01', '在职', '00000020', '1', '2018-01-31', null, '2018-01-01', '2019-01-01', null);

-- ----------------------------
-- Table structure for employeeec
-- ----------------------------
DROP TABLE IF EXISTS `employeeec`;
CREATE TABLE `employeeec` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eid` int(11) DEFAULT NULL COMMENT '员工编号',
  `ecDate` date DEFAULT NULL COMMENT '奖罚日期',
  `ecReason` varchar(255) DEFAULT NULL COMMENT '奖罚原因',
  `ecPoint` int(11) DEFAULT NULL COMMENT '奖罚分',
  `ecType` int(11) DEFAULT NULL COMMENT '奖罚类别，0：奖，1：罚',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `pid` (`eid`),
  CONSTRAINT `employeeec_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of employeeec
-- ----------------------------

-- ----------------------------
-- Table structure for employeeremove
-- ----------------------------
DROP TABLE IF EXISTS `employeeremove`;
CREATE TABLE `employeeremove` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eid` int(11) DEFAULT NULL,
  `afterDepId` int(11) DEFAULT NULL COMMENT '调动后部门',
  `afterJobId` int(11) DEFAULT NULL COMMENT '调动后职位',
  `removeDate` date DEFAULT NULL COMMENT '调动日期',
  `reason` varchar(255) DEFAULT NULL COMMENT '调动原因',
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pid` (`eid`),
  CONSTRAINT `employeeremove_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of employeeremove
-- ----------------------------

-- ----------------------------
-- Table structure for employeetrain
-- ----------------------------
DROP TABLE IF EXISTS `employeetrain`;
CREATE TABLE `employeetrain` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eid` int(11) DEFAULT NULL COMMENT '员工编号',
  `trainDate` date DEFAULT NULL COMMENT '培训日期',
  `trainContent` varchar(255) DEFAULT NULL COMMENT '培训内容',
  `remark` varchar(255) DEFAULT NULL COMMENT '备注',
  PRIMARY KEY (`id`),
  KEY `pid` (`eid`),
  CONSTRAINT `employeetrain_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `employee` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of employeetrain
-- ----------------------------

-- ----------------------------
-- Table structure for empsalary
-- ----------------------------
DROP TABLE IF EXISTS `empsalary`;
CREATE TABLE `empsalary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `eid` int(11) DEFAULT NULL,
  `sid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `eid` (`eid`),
  KEY `empsalary_ibfk_2` (`sid`),
  CONSTRAINT `empsalary_ibfk_1` FOREIGN KEY (`eid`) REFERENCES `employee` (`id`),
  CONSTRAINT `empsalary_ibfk_2` FOREIGN KEY (`sid`) REFERENCES `salary` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=17 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of empsalary
-- ----------------------------
INSERT INTO `empsalary` VALUES ('6', '4', '10');
INSERT INTO `empsalary` VALUES ('7', '3', '9');
INSERT INTO `empsalary` VALUES ('8', '1', '10');
INSERT INTO `empsalary` VALUES ('10', '5', '9');
INSERT INTO `empsalary` VALUES ('11', '6', '13');
INSERT INTO `empsalary` VALUES ('12', '7', '13');
INSERT INTO `empsalary` VALUES ('13', '2', '13');
INSERT INTO `empsalary` VALUES ('14', '8', '10');
INSERT INTO `empsalary` VALUES ('15', '9', '10');
INSERT INTO `empsalary` VALUES ('16', '10', '13');

-- ----------------------------
-- Table structure for hr
-- ----------------------------
DROP TABLE IF EXISTS `hr`;
CREATE TABLE `hr` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT 'hrID',
  `name` varchar(32) DEFAULT NULL COMMENT '姓名',
  `phone` char(11) DEFAULT NULL COMMENT '手机号码',
  `telephone` varchar(16) DEFAULT NULL COMMENT '住宅电话',
  `address` varchar(64) DEFAULT NULL COMMENT '联系地址',
  `departmentId` int(11) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT '1',
  `username` varchar(255) DEFAULT NULL COMMENT '用户名',
  `password` varchar(255) DEFAULT NULL COMMENT '密码',
  `userface` varchar(255) DEFAULT NULL,
  `remark` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `hr_ibfk_1` (`departmentId`),
  CONSTRAINT `hr_ibfk_1` FOREIGN KEY (`departmentId`) REFERENCES `department` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hr
-- ----------------------------
INSERT INTO `hr` VALUES ('3', '系统管理员', '18568887789', '029-82881234', '深圳南山', '1', '1', 'admin', '$2a$10$ySG2lkvjFHY5O0./CPIE1OI8VJsuKYEzOYzqIa7AJR6sEgSzUFOAm', 'http://bpic.588ku.com/element_pic/01/40/00/64573ce2edc0728.jpg', null);
INSERT INTO `hr` VALUES ('5', '李白', '18568123489', '029-82123434', '海口美兰', '1', '1', 'libai', '$2a$10$oE39aG10kB/rFu2vQeCJTu/V/v4n6DRR0f8WyXRiAYvBpmadoOBE.', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1514093920321&di=913e88c23f382933ef430024afd9128a&imgtype=0&src=http%3A%2F%2Fp.3761.com%2Fpic%2F9771429316733.jpg', null);
INSERT INTO `hr` VALUES ('10', '韩愈', '18568123666', '029-82111555', '广州番禺', '4', '1', 'hanyu', '$2a$10$oE39aG10kB/rFu2vQeCJTu/V/v4n6DRR0f8WyXRiAYvBpmadoOBE.', 'https://ss3.bdstatic.com/70cFv8Sh_Q1YnxGkpoWK1HF6hhy/it/u=1406745149,1563524794&fm=27&gp=0.jpg', null);
INSERT INTO `hr` VALUES ('11', '柳宗元', '18568123377', '029-82111333', '广州天河', '5', '1', 'liuzongyuan', '$2a$10$oE39aG10kB/rFu2vQeCJTu/V/v4n6DRR0f8WyXRiAYvBpmadoOBE.', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1515233756&di=0856d923a0a37a87fd26604a2c871370&imgtype=jpg&er=1&src=http%3A%2F%2Fwww.qqzhi.com%2Fuploadpic%2F2014-09-27%2F041716704.jpg', null);
INSERT INTO `hr` VALUES ('12', '曾巩', '18568128888', '029-82111222', '广州越秀', '8', '1', 'zenggong', '$2a$10$oE39aG10kB/rFu2vQeCJTu/V/v4n6DRR0f8WyXRiAYvBpmadoOBE.', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1517070040185&di=be0375e0c3db6c311b837b28c208f318&imgtype=0&src=http%3A%2F%2Fimg2.soyoung.com%2Fpost%2F20150213%2F6%2F20150213141918532.jpg', null);
INSERT INTO `hr` VALUES ('13', '李玉', '18568128888', '029-82111222', '广州越秀', '1', '1', 'liyu', '$2a$10$oE39aG10kB/rFu2vQeCJTu/V/v4n6DRR0f8WyXRiAYvBpmadoOBE.', 'https://timgsa.baidu.com/timg?image&quality=80&size=b9999_10000&sec=1514093920321&di=913e88c23f382933ef430024afd9128a&imgtype=0&src=http%3A%2F%2Fp.3761.com%2Fpic%2F9771429316733.jpg', null);

-- ----------------------------
-- Table structure for hr_role
-- ----------------------------
DROP TABLE IF EXISTS `hr_role`;
CREATE TABLE `hr_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `hrid` int(11) DEFAULT NULL,
  `rid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `rid` (`rid`),
  KEY `hr_role_ibfk_1` (`hrid`),
  CONSTRAINT `hr_role_ibfk_1` FOREIGN KEY (`hrid`) REFERENCES `hr` (`id`) ON DELETE CASCADE,
  CONSTRAINT `hr_role_ibfk_2` FOREIGN KEY (`rid`) REFERENCES `role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=51 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of hr_role
-- ----------------------------
INSERT INTO `hr_role` VALUES ('1', '3', '6');
INSERT INTO `hr_role` VALUES ('35', '12', '4');
INSERT INTO `hr_role` VALUES ('36', '12', '3');
INSERT INTO `hr_role` VALUES ('37', '12', '2');
INSERT INTO `hr_role` VALUES ('43', '11', '3');
INSERT INTO `hr_role` VALUES ('44', '11', '2');
INSERT INTO `hr_role` VALUES ('45', '11', '4');
INSERT INTO `hr_role` VALUES ('46', '11', '5');
INSERT INTO `hr_role` VALUES ('48', '10', '3');
INSERT INTO `hr_role` VALUES ('49', '10', '4');
INSERT INTO `hr_role` VALUES ('50', '5', '1');

-- ----------------------------
-- Table structure for joblevel
-- ----------------------------
DROP TABLE IF EXISTS `joblevel`;
CREATE TABLE `joblevel` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL COMMENT '职称名称',
  `titleLevel` enum('正高级','副高级','中级','初级','员级') DEFAULT NULL,
  `createDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `enabled` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=18 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of joblevel
-- ----------------------------
INSERT INTO `joblevel` VALUES ('9', '教授', '正高级', '2018-01-11 21:19:14', '1');
INSERT INTO `joblevel` VALUES ('10', '副教授', '副高级', '2018-01-11 21:19:20', '1');
INSERT INTO `joblevel` VALUES ('12', '助教', '初级', '2018-01-11 21:35:39', '1');
INSERT INTO `joblevel` VALUES ('13', '讲师', '中级', '2018-01-11 22:42:12', '1');
INSERT INTO `joblevel` VALUES ('14', '初级工程师', '初级', '2018-01-14 16:18:50', '1');
INSERT INTO `joblevel` VALUES ('15', '中级工程师', '中级', '2018-01-14 16:19:00', '1');
INSERT INTO `joblevel` VALUES ('16', '高级工程师', '副高级', '2018-01-14 16:19:14', '1');
INSERT INTO `joblevel` VALUES ('17', '骨灰级工程师', '正高级', '2018-01-14 16:19:24', '1');

-- ----------------------------
-- Table structure for menu
-- ----------------------------
DROP TABLE IF EXISTS `menu`;
CREATE TABLE `menu` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `url` varchar(64) DEFAULT NULL,
  `path` varchar(64) DEFAULT NULL,
  `component` varchar(64) DEFAULT NULL,
  `name` varchar(64) DEFAULT NULL,
  `iconCls` varchar(64) DEFAULT NULL,
  `keepAlive` tinyint(1) DEFAULT NULL,
  `requireAuth` tinyint(1) DEFAULT NULL,
  `parentId` int(11) DEFAULT NULL,
  `enabled` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  KEY `parentId` (`parentId`),
  CONSTRAINT `menu_ibfk_1` FOREIGN KEY (`parentId`) REFERENCES `menu` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=34 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu
-- ----------------------------
INSERT INTO `menu` VALUES ('1', '/', null, null, '所有', null, null, null, null, '1');
INSERT INTO `menu` VALUES ('2', '/', '/home', 'Home', '学员资料', 'fa fa-user-circle-o', null, '1', '1', '1');
INSERT INTO `menu` VALUES ('3', '/', '/home', 'Home', '学习资料', 'fa fa-address-card-o', null, '1', '1', '1');
INSERT INTO `menu` VALUES ('4', '/', '/home', 'Home', '排班管理', 'fa fa-money', null, '1', '1', '1');
INSERT INTO `menu` VALUES ('5', '/', '/home', 'Home', '统计管理', 'fa fa-bar-chart', null, '1', '1', '0');
INSERT INTO `menu` VALUES ('6', '/', '/home', 'Home', '系统管理', 'fa fa-windows', null, '1', '1', '1');
INSERT INTO `menu` VALUES ('7', '/employee/basic/**', '/emp/basic', 'EmpBasic', '基本资料', null, null, '1', '2', '1');
INSERT INTO `menu` VALUES ('8', '/employee/advanced/**', '/emp/adv', 'EmpAdv', '高级资料', null, null, '1', '2', '1');
INSERT INTO `menu` VALUES ('9', '/personnel/emp/**', '/per/emp', 'PerEmp', '员工资料', null, null, '1', '3', '0');
INSERT INTO `menu` VALUES ('10', '/personnel/ec/**', '/per/ec', 'PerEc', '文章管理', null, null, '1', '3', '1');
INSERT INTO `menu` VALUES ('11', '/personnel/train/**', '/per/train', 'PerTrain', '文章发布', null, null, '1', '3', '1');
INSERT INTO `menu` VALUES ('12', '/personnel/salary/**', '/per/salary', 'PerSalary', '文章详情', null, null, '1', '3', '1');
INSERT INTO `menu` VALUES ('13', '/personnel/remove/**', '/per/mv', 'PerMv', '员工调动', null, null, '1', '3', '0');
INSERT INTO `menu` VALUES ('14', '/salary/sob/**', '/sal/sob', 'SalSob', '工资账套管理', null, null, '1', '4', '0');
INSERT INTO `menu` VALUES ('15', '/salary/sobcfg/**', '/sal/sobcfg', 'SalSobCfg', '员工账套设置', null, null, '1', '4', '0');
INSERT INTO `menu` VALUES ('16', '/salary/table/**', '/sal/table', 'SalTable', '排班管理', null, null, '1', '4', '1');
INSERT INTO `menu` VALUES ('17', '/salary/month/**', '/sal/month', 'SalMonth', '排班计划', null, null, '1', '4', '1');
INSERT INTO `menu` VALUES ('18', '/salary/search/**', '/sal/search', 'SalSearch', '工资表查询', null, null, '1', '4', '0');
INSERT INTO `menu` VALUES ('19', '/statistics/all/**', '/sta/all', 'StaAll', '综合信息统计', null, null, '1', '5', '0');
INSERT INTO `menu` VALUES ('20', '/statistics/score/**', '/sta/score', 'StaScore', '员工积分统计', null, null, '1', '5', '0');
INSERT INTO `menu` VALUES ('21', '/statistics/personnel/**', '/sta/pers', 'StaPers', '人事信息统计', null, null, '1', '5', '0');
INSERT INTO `menu` VALUES ('22', '/statistics/recored/**', '/sta/record', 'StaRecord', '人事记录统计', null, null, '1', '5', '0');
INSERT INTO `menu` VALUES ('23', '/system/basic/**', '/sys/basic', 'SysBasic', '基础信息设置', null, null, '1', '6', '1');
INSERT INTO `menu` VALUES ('24', '/system/cfg/**', '/sys/cfg', 'SysCfg', '系统管理', null, null, '1', '6', '0');
INSERT INTO `menu` VALUES ('25', '/system/log/**', '/sys/log', 'SysLog', '操作日志管理', null, null, '1', '6', '1');
INSERT INTO `menu` VALUES ('26', '/system/hr/**', '/sys/hr', 'SysHr', '操作员管理', null, null, '1', '6', '1');
INSERT INTO `menu` VALUES ('27', '/system/data/**', '/sys/data', 'SysData', '备份恢复数据库', null, null, '1', '6', '0');
INSERT INTO `menu` VALUES ('28', '/system/init/**', '/sys/init', 'SysInit', '初始化数据库', null, null, '1', '6', '0');
INSERT INTO `menu` VALUES ('29', '/employee/basic/**', '/emp/att', 'EmpAtt', '考勤信息', null, null, '1', '2', '1');
INSERT INTO `menu` VALUES ('30', '/article/**', '/per/blogDetail', 'BlogDetail', '文章详情1', null, null, '1', '3', '1');
INSERT INTO `menu` VALUES ('31', '/information/**', '/info', 'BlogDetail', '教员信息', '', null, '1', '1', '1');
INSERT INTO `menu` VALUES ('32', '/', '/home', 'Home', '个人中心', 'fa fa-windows', null, '1', '1', '1');
INSERT INTO `menu` VALUES ('33', '', null, null, null, null, null, null, null, '1');

-- ----------------------------
-- Table structure for menu_role
-- ----------------------------
DROP TABLE IF EXISTS `menu_role`;
CREATE TABLE `menu_role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mid` int(11) DEFAULT NULL,
  `rid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `mid` (`mid`),
  KEY `rid` (`rid`),
  CONSTRAINT `menu_role_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `menu` (`id`),
  CONSTRAINT `menu_role_ibfk_2` FOREIGN KEY (`rid`) REFERENCES `role` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=293 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of menu_role
-- ----------------------------
INSERT INTO `menu_role` VALUES ('161', '7', '3');
INSERT INTO `menu_role` VALUES ('162', '7', '6');
INSERT INTO `menu_role` VALUES ('163', '9', '6');
INSERT INTO `menu_role` VALUES ('164', '10', '6');
INSERT INTO `menu_role` VALUES ('165', '11', '6');
INSERT INTO `menu_role` VALUES ('166', '12', '6');
INSERT INTO `menu_role` VALUES ('167', '13', '6');
INSERT INTO `menu_role` VALUES ('168', '14', '6');
INSERT INTO `menu_role` VALUES ('169', '15', '6');
INSERT INTO `menu_role` VALUES ('170', '16', '6');
INSERT INTO `menu_role` VALUES ('171', '17', '6');
INSERT INTO `menu_role` VALUES ('172', '18', '6');
INSERT INTO `menu_role` VALUES ('173', '19', '6');
INSERT INTO `menu_role` VALUES ('174', '20', '6');
INSERT INTO `menu_role` VALUES ('175', '21', '6');
INSERT INTO `menu_role` VALUES ('176', '22', '6');
INSERT INTO `menu_role` VALUES ('177', '23', '6');
INSERT INTO `menu_role` VALUES ('178', '25', '6');
INSERT INTO `menu_role` VALUES ('179', '26', '6');
INSERT INTO `menu_role` VALUES ('180', '27', '6');
INSERT INTO `menu_role` VALUES ('181', '28', '6');
INSERT INTO `menu_role` VALUES ('182', '24', '6');
INSERT INTO `menu_role` VALUES ('247', '7', '4');
INSERT INTO `menu_role` VALUES ('248', '8', '4');
INSERT INTO `menu_role` VALUES ('249', '11', '4');
INSERT INTO `menu_role` VALUES ('250', '7', '2');
INSERT INTO `menu_role` VALUES ('251', '8', '2');
INSERT INTO `menu_role` VALUES ('252', '9', '2');
INSERT INTO `menu_role` VALUES ('253', '10', '2');
INSERT INTO `menu_role` VALUES ('254', '12', '2');
INSERT INTO `menu_role` VALUES ('255', '13', '2');
INSERT INTO `menu_role` VALUES ('279', '29', '6');
INSERT INTO `menu_role` VALUES ('280', '7', '1');
INSERT INTO `menu_role` VALUES ('281', '8', '1');
INSERT INTO `menu_role` VALUES ('282', '29', '1');
INSERT INTO `menu_role` VALUES ('283', '9', '1');
INSERT INTO `menu_role` VALUES ('284', '10', '1');
INSERT INTO `menu_role` VALUES ('285', '11', '1');
INSERT INTO `menu_role` VALUES ('286', '12', '1');
INSERT INTO `menu_role` VALUES ('287', '13', '1');
INSERT INTO `menu_role` VALUES ('288', '16', '1');
INSERT INTO `menu_role` VALUES ('289', '17', '1');
INSERT INTO `menu_role` VALUES ('290', '23', '1');
INSERT INTO `menu_role` VALUES ('291', '25', '1');
INSERT INTO `menu_role` VALUES ('292', '26', '1');

-- ----------------------------
-- Table structure for msgcontent
-- ----------------------------
DROP TABLE IF EXISTS `msgcontent`;
CREATE TABLE `msgcontent` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `title` varchar(64) DEFAULT NULL,
  `message` varchar(255) DEFAULT NULL,
  `createDate` timestamp NOT NULL DEFAULT CURRENT_TIMESTAMP,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=19 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of msgcontent
-- ----------------------------
INSERT INTO `msgcontent` VALUES ('14', '2222222222', '11111111111111111', '2018-02-02 20:46:19');
INSERT INTO `msgcontent` VALUES ('15', '22222222', '3333333333333333333333', '2018-02-02 21:45:57');
INSERT INTO `msgcontent` VALUES ('16', '通知标题1', '通知内容1', '2018-02-03 11:41:39');
INSERT INTO `msgcontent` VALUES ('17', '通知标题2', '通知内容2', '2018-02-03 11:52:37');
INSERT INTO `msgcontent` VALUES ('18', '通知标题3', '通知内容3', '2018-02-03 12:19:41');

-- ----------------------------
-- Table structure for nation
-- ----------------------------
DROP TABLE IF EXISTS `nation`;
CREATE TABLE `nation` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=57 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of nation
-- ----------------------------
INSERT INTO `nation` VALUES ('1', '汉族');
INSERT INTO `nation` VALUES ('2', '蒙古族');
INSERT INTO `nation` VALUES ('3', '回族');
INSERT INTO `nation` VALUES ('4', '藏族');
INSERT INTO `nation` VALUES ('5', '维吾尔族');
INSERT INTO `nation` VALUES ('6', '苗族');
INSERT INTO `nation` VALUES ('7', '彝族');
INSERT INTO `nation` VALUES ('8', '壮族');
INSERT INTO `nation` VALUES ('9', '布依族');
INSERT INTO `nation` VALUES ('10', '朝鲜族');
INSERT INTO `nation` VALUES ('11', '满族');
INSERT INTO `nation` VALUES ('12', '侗族');
INSERT INTO `nation` VALUES ('13', '瑶族');
INSERT INTO `nation` VALUES ('14', '白族');
INSERT INTO `nation` VALUES ('15', '土家族');
INSERT INTO `nation` VALUES ('16', '哈尼族');
INSERT INTO `nation` VALUES ('17', '哈萨克族');
INSERT INTO `nation` VALUES ('18', '傣族');
INSERT INTO `nation` VALUES ('19', '黎族');
INSERT INTO `nation` VALUES ('20', '傈僳族');
INSERT INTO `nation` VALUES ('21', '佤族');
INSERT INTO `nation` VALUES ('22', '畲族');
INSERT INTO `nation` VALUES ('23', '高山族');
INSERT INTO `nation` VALUES ('24', '拉祜族');
INSERT INTO `nation` VALUES ('25', '水族');
INSERT INTO `nation` VALUES ('26', '东乡族');
INSERT INTO `nation` VALUES ('27', '纳西族');
INSERT INTO `nation` VALUES ('28', '景颇族');
INSERT INTO `nation` VALUES ('29', '柯尔克孜族');
INSERT INTO `nation` VALUES ('30', '土族');
INSERT INTO `nation` VALUES ('31', '达斡尔族');
INSERT INTO `nation` VALUES ('32', '仫佬族');
INSERT INTO `nation` VALUES ('33', '羌族');
INSERT INTO `nation` VALUES ('34', '布朗族');
INSERT INTO `nation` VALUES ('35', '撒拉族');
INSERT INTO `nation` VALUES ('36', '毛难族');
INSERT INTO `nation` VALUES ('37', '仡佬族');
INSERT INTO `nation` VALUES ('38', '锡伯族');
INSERT INTO `nation` VALUES ('39', '阿昌族');
INSERT INTO `nation` VALUES ('40', '普米族');
INSERT INTO `nation` VALUES ('41', '塔吉克族');
INSERT INTO `nation` VALUES ('42', '怒族');
INSERT INTO `nation` VALUES ('43', '乌孜别克族');
INSERT INTO `nation` VALUES ('44', '俄罗斯族');
INSERT INTO `nation` VALUES ('45', '鄂温克族');
INSERT INTO `nation` VALUES ('46', '崩龙族');
INSERT INTO `nation` VALUES ('47', '保安族');
INSERT INTO `nation` VALUES ('48', '裕固族');
INSERT INTO `nation` VALUES ('49', '京族');
INSERT INTO `nation` VALUES ('50', '塔塔尔族');
INSERT INTO `nation` VALUES ('51', '独龙族');
INSERT INTO `nation` VALUES ('52', '鄂伦春族');
INSERT INTO `nation` VALUES ('53', '赫哲族');
INSERT INTO `nation` VALUES ('54', '门巴族');
INSERT INTO `nation` VALUES ('55', '珞巴族');
INSERT INTO `nation` VALUES ('56', '基诺族');

-- ----------------------------
-- Table structure for oplog
-- ----------------------------
DROP TABLE IF EXISTS `oplog`;
CREATE TABLE `oplog` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `addDate` date DEFAULT NULL COMMENT '添加日期',
  `operate` varchar(255) DEFAULT NULL COMMENT '操作内容',
  `hrid` int(11) DEFAULT NULL COMMENT '操作员ID',
  PRIMARY KEY (`id`),
  KEY `hrid` (`hrid`),
  CONSTRAINT `oplog_ibfk_1` FOREIGN KEY (`hrid`) REFERENCES `hr` (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of oplog
-- ----------------------------

-- ----------------------------
-- Table structure for politicsstatus
-- ----------------------------
DROP TABLE IF EXISTS `politicsstatus`;
CREATE TABLE `politicsstatus` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of politicsstatus
-- ----------------------------
INSERT INTO `politicsstatus` VALUES ('1', '中共党员');
INSERT INTO `politicsstatus` VALUES ('2', '中共预备党员');
INSERT INTO `politicsstatus` VALUES ('3', '共青团员');
INSERT INTO `politicsstatus` VALUES ('4', '民革党员');
INSERT INTO `politicsstatus` VALUES ('5', '民盟盟员');
INSERT INTO `politicsstatus` VALUES ('6', '民建会员');
INSERT INTO `politicsstatus` VALUES ('7', '民进会员');
INSERT INTO `politicsstatus` VALUES ('8', '农工党党员');
INSERT INTO `politicsstatus` VALUES ('9', '致公党党员');
INSERT INTO `politicsstatus` VALUES ('10', '九三学社社员');
INSERT INTO `politicsstatus` VALUES ('11', '台盟盟员');
INSERT INTO `politicsstatus` VALUES ('12', '无党派民主人士');
INSERT INTO `politicsstatus` VALUES ('13', '普通公民');

-- ----------------------------
-- Table structure for position
-- ----------------------------
DROP TABLE IF EXISTS `position`;
CREATE TABLE `position` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(32) DEFAULT NULL COMMENT '职位',
  `createDate` timestamp NULL DEFAULT CURRENT_TIMESTAMP,
  `enabled` tinyint(1) DEFAULT '1',
  PRIMARY KEY (`id`),
  UNIQUE KEY `name` (`name`)
) ENGINE=InnoDB AUTO_INCREMENT=35 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of position
-- ----------------------------
INSERT INTO `position` VALUES ('29', '市管理员', '2018-01-11 21:13:42', '1');
INSERT INTO `position` VALUES ('30', '县管理员', '2018-01-11 21:13:48', '1');
INSERT INTO `position` VALUES ('31', '镇管理员', '2018-01-11 21:13:56', '1');
INSERT INTO `position` VALUES ('32', '村管理员', '2018-01-11 21:35:07', '1');
INSERT INTO `position` VALUES ('33', '系统管理员', '2018-01-14 16:07:11', '1');
INSERT INTO `position` VALUES ('34', '运维工程师', '2018-01-14 16:11:41', '1');

-- ----------------------------
-- Table structure for pv
-- ----------------------------
DROP TABLE IF EXISTS `pv`;
CREATE TABLE `pv` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `countDate` date DEFAULT NULL,
  `pv` int(11) DEFAULT NULL,
  `uid` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `pv_ibfk_1` (`uid`),
  CONSTRAINT `pv_ibfk_1` FOREIGN KEY (`uid`) REFERENCES `hr` (`id`) ON DELETE CASCADE
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of pv
-- ----------------------------

-- ----------------------------
-- Table structure for role
-- ----------------------------
DROP TABLE IF EXISTS `role`;
CREATE TABLE `role` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(64) DEFAULT NULL,
  `nameZh` varchar(64) DEFAULT NULL COMMENT '角色名称',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of role
-- ----------------------------
INSERT INTO `role` VALUES ('1', 'ROLE_CITY', '市管理员');
INSERT INTO `role` VALUES ('2', 'ROLE_COUNTY', '县管理员');
INSERT INTO `role` VALUES ('3', 'ROLE_TOWN', '镇管理员');
INSERT INTO `role` VALUES ('4', 'ROLE_VILLAGE', '村管理员');
INSERT INTO `role` VALUES ('5', 'ROLE_TEACHER', '教员');
INSERT INTO `role` VALUES ('6', 'ROLE_admin', '系统管理员');

-- ----------------------------
-- Table structure for salary
-- ----------------------------
DROP TABLE IF EXISTS `salary`;
CREATE TABLE `salary` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `basicSalary` int(11) DEFAULT NULL COMMENT '基本工资',
  `bonus` int(11) DEFAULT NULL COMMENT '奖金',
  `lunchSalary` int(11) DEFAULT NULL COMMENT '午餐补助',
  `trafficSalary` int(11) DEFAULT NULL COMMENT '交通补助',
  `allSalary` int(11) DEFAULT NULL COMMENT '应发工资',
  `pensionBase` int(11) DEFAULT NULL COMMENT '养老金基数',
  `pensionPer` float DEFAULT NULL COMMENT '养老金比率',
  `createDate` timestamp NULL DEFAULT NULL COMMENT '启用时间',
  `medicalBase` int(11) DEFAULT NULL COMMENT '医疗基数',
  `medicalPer` float DEFAULT NULL COMMENT '医疗保险比率',
  `accumulationFundBase` int(11) DEFAULT NULL COMMENT '公积金基数',
  `accumulationFundPer` float DEFAULT NULL COMMENT '公积金比率',
  `name` varchar(32) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=14 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of salary
-- ----------------------------
INSERT INTO `salary` VALUES ('9', '9000', '4000', '800', '500', null, '2000', '0.07', '2018-01-24 00:00:00', '2000', '0.07', '2000', '0.07', '市场部工资账套');
INSERT INTO `salary` VALUES ('10', '2000', '2000', '400', '1000', null, '2000', '0.07', '2018-01-01 00:00:00', '2000', '0.07', '2000', '0.07', '人事部工资账套');
INSERT INTO `salary` VALUES ('13', '10000', '3000', '500', '500', null, '4000', '0.07', '2018-01-25 00:00:00', '4000', '0.07', '4000', '0.07', '运维部工资账套');

-- ----------------------------
-- Table structure for schedules
-- ----------------------------
DROP TABLE IF EXISTS `schedules`;
CREATE TABLE `schedules` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `userId` int(11) DEFAULT NULL,
  `time` datetime DEFAULT NULL,
  `departmentId` int(11) DEFAULT NULL COMMENT '授课地点',
  `theme` varchar(255) DEFAULT NULL,
  `state` int(1) DEFAULT '1' COMMENT '授课状态 1.未授课 2.已授课',
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of schedules
-- ----------------------------
INSERT INTO `schedules` VALUES ('1', '5', '2019-05-28 00:00:00', '1', '水稻防害', '1');
INSERT INTO `schedules` VALUES ('2', '5', '2019-05-13 00:00:00', '1', '122', '1');

-- ----------------------------
-- Table structure for student
-- ----------------------------
DROP TABLE IF EXISTS `student`;
CREATE TABLE `student` (
  `id` int(11) NOT NULL AUTO_INCREMENT COMMENT '员工编号',
  `name` varchar(20) DEFAULT NULL COMMENT '员工姓名',
  `gender` char(4) DEFAULT NULL COMMENT '性别',
  `birthday` date DEFAULT NULL COMMENT '出生日期',
  `idCard` char(18) DEFAULT NULL COMMENT '身份证号',
  `wedlock` enum('已婚','未婚','离异') DEFAULT NULL COMMENT '婚姻状况',
  `nationId` int(8) DEFAULT NULL COMMENT '民族',
  `nativePlace` varchar(20) DEFAULT NULL COMMENT '籍贯',
  `phone` varchar(11) DEFAULT NULL COMMENT '电话号码',
  `address` varchar(255) DEFAULT NULL COMMENT '联系地址',
  `departmentId` int(11) DEFAULT NULL COMMENT '所属部门',
  `workID` char(10) DEFAULT NULL COMMENT '工号',
  `points` int(20) NOT NULL DEFAULT '0' COMMENT '积分',
  PRIMARY KEY (`id`),
  KEY `departmentId` (`departmentId`),
  KEY `nationId` (`nationId`),
  KEY `workID` (`workID`),
  CONSTRAINT `student_ibfk_1` FOREIGN KEY (`departmentId`) REFERENCES `department` (`id`),
  CONSTRAINT `student_ibfk_2` FOREIGN KEY (`nationId`) REFERENCES `nation` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=7 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of student
-- ----------------------------
INSERT INTO `student` VALUES ('1', '吴语', '男', '2019-05-06', '612328199412129999', '未婚', '1', '陕西', '18829345027', '广东省广州市天河区冼村路', '115', '0000000001', '11');
INSERT INTO `student` VALUES ('3', '尚胡', '男', '2019-05-01', '612328199412120316', '已婚', '3', '固原', '18829345012', '固原市原州区', '95', '0000000003', '15');
INSERT INTO `student` VALUES ('4', '尚玉', '男', '2019-04-29', '612328199412120316', '已婚', '2', '固原', '18829345012', '固原市原州区', '5', '0000000004', '25');

-- ----------------------------
-- Table structure for sysmsg
-- ----------------------------
DROP TABLE IF EXISTS `sysmsg`;
CREATE TABLE `sysmsg` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `mid` int(11) DEFAULT NULL COMMENT '消息id',
  `type` int(11) DEFAULT '0' COMMENT '0表示群发消息',
  `hrid` int(11) DEFAULT NULL COMMENT '这条消息是给谁的',
  `state` int(11) DEFAULT '0' COMMENT '0 未读 1 已读',
  PRIMARY KEY (`id`),
  KEY `hrid` (`hrid`),
  KEY `sysmsg_ibfk_1` (`mid`),
  CONSTRAINT `sysmsg_ibfk_1` FOREIGN KEY (`mid`) REFERENCES `msgcontent` (`id`),
  CONSTRAINT `sysmsg_ibfk_2` FOREIGN KEY (`hrid`) REFERENCES `hr` (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=82 DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of sysmsg
-- ----------------------------
INSERT INTO `sysmsg` VALUES ('57', '14', '0', '3', '1');
INSERT INTO `sysmsg` VALUES ('58', '14', '0', '5', '1');
INSERT INTO `sysmsg` VALUES ('59', '14', '0', '10', '1');
INSERT INTO `sysmsg` VALUES ('60', '14', '0', '11', '0');
INSERT INTO `sysmsg` VALUES ('61', '14', '0', '12', '0');
INSERT INTO `sysmsg` VALUES ('62', '15', '0', '3', '1');
INSERT INTO `sysmsg` VALUES ('63', '15', '0', '5', '1');
INSERT INTO `sysmsg` VALUES ('64', '15', '0', '10', '1');
INSERT INTO `sysmsg` VALUES ('65', '15', '0', '11', '0');
INSERT INTO `sysmsg` VALUES ('66', '15', '0', '12', '0');
INSERT INTO `sysmsg` VALUES ('67', '16', '0', '3', '1');
INSERT INTO `sysmsg` VALUES ('68', '16', '0', '5', '1');
INSERT INTO `sysmsg` VALUES ('69', '16', '0', '10', '1');
INSERT INTO `sysmsg` VALUES ('70', '16', '0', '11', '0');
INSERT INTO `sysmsg` VALUES ('71', '16', '0', '12', '0');
INSERT INTO `sysmsg` VALUES ('72', '17', '0', '3', '1');
INSERT INTO `sysmsg` VALUES ('73', '17', '0', '5', '1');
INSERT INTO `sysmsg` VALUES ('74', '17', '0', '10', '1');
INSERT INTO `sysmsg` VALUES ('75', '17', '0', '11', '0');
INSERT INTO `sysmsg` VALUES ('76', '17', '0', '12', '0');
INSERT INTO `sysmsg` VALUES ('77', '18', '0', '3', '1');
INSERT INTO `sysmsg` VALUES ('78', '18', '0', '5', '1');
INSERT INTO `sysmsg` VALUES ('79', '18', '0', '10', '0');
INSERT INTO `sysmsg` VALUES ('80', '18', '0', '11', '0');
INSERT INTO `sysmsg` VALUES ('81', '18', '0', '12', '0');

-- ----------------------------
-- Table structure for tags
-- ----------------------------
DROP TABLE IF EXISTS `tags`;
CREATE TABLE `tags` (
  `id` int(11) NOT NULL,
  `tagName` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8;

-- ----------------------------
-- Records of tags
-- ----------------------------

-- ----------------------------
-- Procedure structure for addDep
-- ----------------------------
DROP PROCEDURE IF EXISTS `addDep`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `addDep`(in depName varchar(32),in parentId int,in enabled boolean,out result int,out result2 int)
begin
  declare did int;
  declare pDepPath varchar(64);
  insert into department set name=depName,parentId=parentId,enabled=enabled;
  select row_count() into result;
  select last_insert_id() into did;
  set result2=did;
  select depPath into pDepPath from department where id=parentId;
  update department set depPath=concat(pDepPath,'.',did) where id=did;
  update department set isParent=true where id=parentId;
end
;;
DELIMITER ;

-- ----------------------------
-- Procedure structure for deleteDep
-- ----------------------------
DROP PROCEDURE IF EXISTS `deleteDep`;
DELIMITER ;;
CREATE DEFINER=`root`@`localhost` PROCEDURE `deleteDep`(in did int,out result int)
begin
  declare ecount int;
  declare pid int;
  declare pcount int;
  select count(*) into ecount from employee where departmentId=did;
  if ecount>0 then set result=-1;
  else 
  select parentId into pid from department where id=did;
  delete from department where id=did and isParent=false;
  select row_count() into result;
  select count(*) into pcount from department where parentId=pid;
  if pcount=0 then update department set isParent=false where id=pid;
  end if;
  end if;
end
;;
DELIMITER ;

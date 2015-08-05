---
layout: "theme:post"
title: "翻墙 DIY"
date: 2015-07-29T16:04:10+08:00
author: Wantee Wang
comments: true
noprintable: true
categories: [Technology]
---

* list element with functor item
{:toc}

今天，用了一年多的[曲径](https://getqujing.com/)被关闭了。做翻墙的服务总是有这么个悲剧，用的人多了就容易被约谈。还是搭建一个个人的服务，自己用可能会稳定一些。

从昨晚开始，研究了一下怎么能方便的搭一个代理自己用。思路挺简单：找一个国外的VPS主机，搭建一个 [shadowsocks](http://shadowsocks.org/) 服务，然后自己电脑代理设成 VPS，就可以科学上网了。

<!-- more -->

## 配置 shadowsocks 代理

Step1. 申请 VPS。 之前没玩过云主机的东西，先拿 amazon AWS EC2 试试，因为看到有一年的试用。

Step2. 在 VPS 上安装 shadowsocks，把 `ssserver` 启起来。注意要把 shadowsocks 使用的端口在 EC2 中打开。

Step3. Mac 上安装 [GoAgentX](https://github.com/ohdarling/GoAgentX/releases)。配置好对应的服务器地址和密码等。

Step4. Chrome 用 SwitchyOmega 插件添加本地的 SOCKS5 端口代理。

Step5. 配置 HTTP Proxy 给终端工具使用。curl, wget 等工具不会检查 Mac OSX 的系统代理设置，需要自己配一下，简单的方法就是设置 HTTP 代理的环境变量（以前曲径就是用的这种方法）。所以需要把 SOCKS5 搭一个 HTTP 代理。安装 privoxy，`brew install privoxy`，在 `~/.bash_profile` 里面加上

```bash 
function start_ec2 {
  /usr/local/Cellar/privoxy/3.0.23/sbin/privoxy /usr/local/etc/privoxy/config
  export http_proxy='127.0.0.1:8118'
  export HTTPS_PROXY='127.0.0.1:8118'
}
```

这样，需要在终端需要用代理的时候，敲一下 `start_ec2` 就 OK 了。

## 配置 pac 控制

为了访问不被墙的网站时不拖慢速度，曲径用的是 pac 的方式。幸好 SwitchyOmega 之前缓存了我的曲径的 rule list，我就直接复制到新建的 EC2 代理的 profile 里了。

GoAgentX 自带 PAC 功能，可以方便系统全局的配置。从上面的 SwitchyOmega 导出 *.pac 文件，在 GoAgentX 设置里 `Select Local File`， 然后 `Restart PAC server`。Safari 等 APP 就可以按需使用了。


目前用了一会，速度还可以，反正我也多是用 google，不看 youtube，应该没什么大问题。

现在这种用法相比曲径还是麻烦一些，主要是需要装一个客户端。知乎有一个分析曲径的[答案](http://www.zhihu.com/question/22378456)，大概是说，在国内租一些 VPS（阿里云），然后在阿里云上运行客户端，然后本地就只需要一个 pac 配置连客户端就可以了。这样客户端的 VPS 就可以做很多其他的事情了，比如分流，防攻击等。

为了同步 pac 的方便，确实可以采用这种方法，在 VPS 上再搭一个 PAC server，所以客户端都去那里下载。


Update 2015/07/30: 

## 配置 Mail.app

Mac 自带的 Mail.app 不能单独设置代理，用全局的 SOCKS5 代理又没有 pac 的功能。所以下了一个 [Proxifier](https://www.proxifier.com) 配置 SOCKS5 代理。

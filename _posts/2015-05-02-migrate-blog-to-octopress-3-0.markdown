---
layout: "theme:post"
title: Migrate Blog to Octopress 3.0
date: 2015-05-02T00:25:37+08:00
author: Wantee Wang
comments: true
categories: [Technology]
---


After 4 days coding, finally get to migrate this blog to new [Octopress 3.0](http://octopress.org/2015/01/15/octopress-3.0-is-coming/).

Octopress 3.0 is not just a upgraded version of Octopress 2.x. In 3.0, everything is separated into standalone gems, which can be used on any Jekyll site. Thus there will no longer be a division between Octopress and Jekyll.

The migrating process is a bit of suffering, because there is no official guide, and also I'm a newbie to the whole Ruby world. But on the other hand, I learned a lot, including both Ruby programming and open source project tools, such as [RubyGems](https://rubygems.org/) and [Travis CI](https://travis-ci.org/).

In sum, I'm happy to extract the codes generating pdf files from `Rakefile` to a more appropriate [octopress ink plugin](https://github.com/wantee/octopress-printable).

Another thing I impressed is the test framework, the idea is simply but powerful. I'm considering to write or find a test framework for my other C projects.

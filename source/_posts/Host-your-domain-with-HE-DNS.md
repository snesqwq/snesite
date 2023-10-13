title: 使用 HE DNS 托管域名
abbrlink: 56800
tags:
  - Vercel
  - DNS
categories:
  - 建站
date: 2023-08-25 18:39:00
---
当考虑**优化域名解析和加强网络性能**时，你可能会想到一些知名的**DNS解析服务**，比如 [Cloudflare](https://www.cloudflare.com/)。尽管`Cloudflare`在提供*快速和安全的解析*方面表现出色，但需要注意的是，它**无法托管二级域名**，这可能对**构建复杂网络架构**时带来限制。

然而，有一个值得考虑的解决方案是 [Hurricane Electric DNS（HE DNS）](https://dns.he.net)。`HE DNS`不仅提供了**出色的DNS托管服务**，还允许你**轻松地托管包括二级和三级域名在内的各种级别的域名**。这为网络架构提供了更大的灵活性和控制。

以下是一些简单的步骤，帮助快速开始使用`HE DNS`来托管域名：

## 注册账号

1. **前往注册页面**：
   访问 [HE DNS的注册页面](https://ipv6.he.net/certification/register.php) 创建一个账户。填写所需的信息进行注册。注意，必须**如实填写所有信息且不能开启VPN**，否则可能会**无法注册**。

2. **登录到账户**：
   使用你的注册信息登录到 [Hurricane Electric官方网站](https://dns.he.net)。登录后，你将获得访问域名管理面板的权限。

## 配置DNS

1. **添加域名**：
   在`HE DNS`的控制面板中，点击`Add a New Domain`来添加你想要托管的域名。

2. **配置DNS记录**：
   添加域名后，**来到你的域名服务商创建五个NS记录**，`Name`值为`@`或子域名，`Nameserver name`值分别改为下面五个NS。
```NAMESERVER
ns5.he.net
ns4.he.net
ns3.he.net
ns2.he.net
ns1.he.net
```

3. **验证设置**：
   在完成DNS记录的配置后，使用[Google DNS](https://dns.google)查询你的域名的DNS记录，**确保它们与你预期的一致**。
   
4. **创建CNAME记录**
   在某些情况下，`CNAME`记录**并不能直接解析顶级域名**`@`，尤其是**在使用二级或三级域名时**。这可能会受到*某些平台*的限制，因为它们**仅支持`CNAME`记录**。然而，在这种情况下，你可以考虑使用`ALIAS`记录作为解决方案。与`CNAME`记录类似，但`ALIAS`记录允许你对根域名`@`进行解析。这对于满足某些平台的要求**非常有帮助**。


## 总结

通过使用`HE DNS`托管你的域名，你将获得
**快速的解析速度和可靠的性能**。此外，`HE DNS`提供的其他高级功能，如*IPv6支持*，也会为你的网络带来更多优势。虽然`Cloudflare`也有这些功能，但`Cloudflare`并不能托管二级域名

在整个过程中，`HE DNS`的灵活性将使你能够**更好地满足不同级别域名的需求。**
# falcon-message

open-falcon alarm 发送消息组件，注意这个是基于2.0版本新增的im功能定制。

现在实现了钉钉群消息和微信消息

## 注意，需要修改mysql 中 uic库中的user表，把im字段的大小改为4000（防止钉钉token溢出截断，不生效）

## 微信

需要在通讯录的人员名单中的IM配置处配置微信名字。
配置说明请参考 [https://github.com/Yanjunhui/chat](https://github.com/Yanjunhui/chat) 这里，代码也是从这里复制粘贴，进行了适当修改，以适应当前程序。

## 钉钉群

1. 钉钉消息是发送到某个群，而不是针对单个人发送，所以需要在这个群中设置一个机器人，定义的时候，选择自定义机器人，然后将webhook链接中access_token的值拷贝出来，以备待用。
1. 在falcon dashaboar 用户管理中心新建一个用户，填写email，然后在 IM 处填写 `[ding]:access_token`，这里的access_token就是上面的access_token，如果相同消息要发送给多个机器人，则access_token之间用英文分号`;`分隔，保存用户信息。
1. 在dashboard的群组管理中心新建一个群组，把上面的这个用户加入到这个群组。
1. 在要告警的地方把上面的这个群组加入即可。
1. 修改alarm组件中 `api` 下，增加 配置：`"im": "http://localhost:23329/api/v1/message"`，端口按照本项目配置文件中的进行修改。
1. 启动本项目即可。

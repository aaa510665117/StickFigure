//
//  HttpConfig.h
//  SmallCapitalBus
//
//  Created by ZY on 2018/4/16.
//  Copyright © 2018年 ZY. All rights reserved.
//

#ifndef HttpConfig_h
#define HttpConfig_h

//-----------------------------------------服务器配置部分------------------------------------------------//

#define kNetworkNotReachability ([AFNetworkReachabilityManager sharedManager].networkReachabilityStatus <= 0)  //无网

#ifdef DEBUG // 是Debug版本（开发版本）

#define DEFAULT_SEHTTP_ADDRESS @"http://123.207.100.15"
#define SEHTTP_PORT            @"8787"


#else        // 是Release版本（发布版本）

#define DEFAULT_SEHTTP_ADDRESS @"http://123.207.100.15"
#define SEHTTP_PORT            @"8787"

#endif      // END

//Mobile Auto LoginCS Mode
enum _auto_login_cs_mode {
    AUTO_NONE = 0, // 不做任何登录
    AUTO_LOGIN_CS = 1, // Auto Login CS
};

#define HTTP_RETURN_KEY         @"code"                 //服务器返回Key关键字
#define HTTP_RETURN_MSG         @"message"              //服务器返回状态码内容
#define HTTP_RETURN_RESULT      @"result"                 //服务器返回json体Key关键字

//-----------------------------------------服务器配置部分end------------------------------------------------//

#endif /* HttpConfig_h */

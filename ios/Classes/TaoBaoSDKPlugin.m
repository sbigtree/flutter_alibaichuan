//
//  TaoBaoSDKPlugin.m
//  Runner
//
//  Created by tree on 2020/1/18.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//

#import "TaoBaoSDKPlugin.h"
#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import <AlibabaAuthSDK/albbsdk.h>



@implementation TaoBaoSDKPlugin

# pragma mark -- 初始化
+(void)registry{
  // 百川平台基础SDK初始化，加载并初始化各个业务能力插件
  //    [[AlibcTradeSDK sharedInstance] setDebugLogOpen:YES];//开发阶段打开日志开关，方便排查错误信息
  
  //    [[AlibcTradeSDK sharedInstance] setIsvVersion:@"2.2.2"];
  //    [[AlibcTradeSDK sharedInstance] setIsvAppName:@"baichuanDemo"];
  [[AlibcTradeSDK sharedInstance] asyncInitWithSuccess:^{
    //      openSDKSwitchLog(NO);
    TLOG_INFO(@"------百川SDK初始化成功");
  } failure:^(NSError *error) {
    TLOG_INFO(@"------百川SDK初始化失败");
  }];
  
  
}
# pragma mark -- 淘宝授权登录
+ (void) login:(FlutterResult)result {
  
  NSLog(@"登录状态---->%@", [[ALBBSession sharedInstance] isLogin] ?@"YES":@"NO");
  
  if(![[ALBBSession sharedInstance] isLogin]){
    [[ALBBSDK sharedInstance]setAuthOption: NormalAuth];
    UIViewController *rootViewController =
    [UIApplication sharedApplication].delegate.window.rootViewController;
    
    [[ALBBSDK sharedInstance] auth:rootViewController successCallback:^(ALBBSession *session){
      NSString *tip=[NSString stringWithFormat:@"登录的用户信息:%@",[session getUser]];
      NSLog(@"登录----->>%@",tip);

      ALBBUser *userInfo = [session getUser];
      
      NSDictionary *res = @{
        @"errorCode": @0,
        @"statusMsg":@"success",
        @"data":@{
//            @"userid":userInfo.userid,
            @"nick":userInfo.nick,
            @"avatarUrl":userInfo.avatarUrl,
            @"openId":userInfo.openId,
            @"openSid":userInfo.openSid,
            @"topAccessToken":userInfo.topAccessToken,
            @"topAuthCode":userInfo.topAuthCode,
        }
      };
      
      NSLog(@"%@", tip);
      result(res);
//      result(@"ios登录回调");
      
    } failureCallback:^(ALBBSession *session, NSError *error){
      NSString *tip=[NSString stringWithFormat:@"登录失败:%@",@""];
      NSLog(@"%@", tip);
      
      result(@{
        @"errorCode": [NSString stringWithFormat: @"%ld", (long)error.code],
        @"statusMsg":error.localizedDescription
      });
    }];
  }else{
    ALBBSession *session=[ALBBSession sharedInstance];
    NSString *tip=[NSString stringWithFormat:@"登录的用户信息:%@",[session getUser]];
    ALBBUser *userInfo = [session getUser];

    NSLog(@"%@", tip);
    result(@{
      @"errorCode": @"0",
      @"statusMsg":@"success",
      @"data":@{
          @"nick":userInfo.nick,
          @"avatarUrl":userInfo.avatarUrl,
          @"openId":userInfo.openId,
          @"openSid":userInfo.openSid,
          @"topAccessToken":userInfo.topAccessToken,
          @"topAuthCode":userInfo.topAuthCode,
      }
    });

  }
  
}


#pragma mark --退出登录
+(void) logout{
  [[ALBBSDK sharedInstance] logout];
  
}
@end


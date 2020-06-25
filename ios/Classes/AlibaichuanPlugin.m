#import "AlibaichuanPlugin.h"
#if __has_include(<alibaichuan/alibaichuan-Swift.h>)
#import <alibaichuan/alibaichuan-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "alibaichuan-Swift.h"
#endif

#import <AlibcTradeSDK/AlibcTradeSDK.h>
#import <AlibabaAuthSDK/albbsdk.h>

//#import "TaoBaoSDKPlugin.h"
#import "FlutterAlibcHandle.h"


@interface AlibaichuanPlugin()
//一个handle服务
@property(nonatomic,strong)FlutterAlibcHandle *handler;
//一个service服务
@end


@implementation AlibaichuanPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  
  
  FlutterMethodChannel* channel = [FlutterMethodChannel
      methodChannelWithName:@"alibaichuan"
            binaryMessenger:[registrar messenger]];
  AlibaichuanPlugin* instance = [[AlibaichuanPlugin alloc] initWithRegistrar:registrar methodChannel:channel];

  [registrar addMethodCallDelegate:instance channel:channel];
  
  
//  [SwiftAlibaichuanPlugin registerWithRegistrar:registrar];
  
  
//  [[AlibcTradeSDK sharedInstance] asyncInitWithSuccess:^{
//    TLOG_INFO(@"------百川SDK初始化成功");
//  } failure:^(NSError *error) {
//    TLOG_INFO(@"------百川SDK初始化失败-11");
//  }];
  
  
}

- (instancetype)initWithRegistrar:(NSObject <FlutterPluginRegistrar> *)registrar methodChannel:(FlutterMethodChannel *)flutterMethodChannel{
    self = [super init];

    if (self) {
        self.handler = [[FlutterAlibcHandle alloc]init];
    }

    return self;
}



- (void)handleMethodCall:(FlutterMethodCall*)call result:(FlutterResult)result {
  if ([@"getPlatformVersion" isEqualToString:call.method]) {
    TLOG_INFO(@"---channel调用---getPlatformVersion");
    

    result([@"iOS " stringByAppendingString:[[UIDevice currentDevice] systemVersion]]);
  } else if ([@"init" isEqualToString:call.method]){
    TLOG_INFO(@"---初始化中。。。");
//    result(FlutterMethodNotImplemented);

    [_handler initAlibc:call result:result];
    
  }else if([@"login" isEqualToString:call.method]){
    NSLog(@"百川SDK: %@", call.method);
//    [TaoBaoSDKPlugin login:result];
    [_handler loginTaoBao:call result:result];

  }else if([@"logout" isEqualToString:call.method]){
//    [TaoBaoSDKPlugin logout];
    [_handler loginOut];
    result(@{
      @"errorCode": @"0",
      @"statusMsg":@"退出"
    });

  }else {
    result(FlutterMethodNotImplemented);
  }
  
}




@end

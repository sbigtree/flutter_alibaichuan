//
//  TaoBaoSDKPlugin.h
//  Runner
//
//  Created by tree on 2020/1/18.
//  Copyright © 2020 The Chromium Authors. All rights reserved.
//
#import <UIKit/UIKit.h>

#import <Foundation/Foundation.h>
#import <Flutter/Flutter.h>

#ifndef TaoBaoSDKPlugin_h
#define TaoBaoSDKPlugin_h

@interface TaoBaoSDKPlugin : NSObject
+ (void)registry;
+ (void)login:(FlutterResult)result;
+ (void)logout;
@end

#endif /* TaoBaoSDKPlugin_h */

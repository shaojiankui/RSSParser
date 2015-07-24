//
//  AppDelegate.h
//  RSSParser
//
//  Created by Jakey on 15/7/24.
//  Copyright © 2015年 Jakey. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ViewController;
@interface AppDelegate : UIResponder <UIApplicationDelegate>
@property (strong, nonatomic) UIWindow *window;
@property (strong, nonatomic) ViewController *rootViewController;
@property (strong, nonatomic) UINavigationController *navgationController;
+(AppDelegate*)APP;
@end
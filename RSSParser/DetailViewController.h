//
//  DetailViewController.h
//  RSSParser
//
//  Created by Jakey on 15/7/24.
//  Copyright © 2015年 Jakey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DetailViewController : UIViewController
@property (strong, nonatomic)  NSString *urlString;
@property (weak, nonatomic) IBOutlet UIWebView *myWebView;
@end

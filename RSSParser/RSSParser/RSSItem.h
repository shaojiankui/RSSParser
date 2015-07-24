//
//  RSSItem.h
//  RSSParser
//
//  Created by Jakey on 15/7/7.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface RSSItem : NSObject <NSCoding>

@property (strong,nonatomic) NSString *title;
@property (strong,nonatomic) NSString *itemDescription;
@property (strong,nonatomic) NSString *content;
@property (strong,nonatomic) NSURL *link;
@property (strong,nonatomic) NSURL *commentsLink;
@property (strong,nonatomic) NSURL *commentsFeed;
@property (strong,nonatomic) NSNumber *commentsCount;
@property (strong,nonatomic) NSDate *pubDate;
@property (strong,nonatomic) NSString *author;
@property (strong,nonatomic) NSString *guid;
@property (strong,nonatomic) NSString *preview;
-(NSArray *)imagesFromItemDescription;
-(NSArray *)imagesFromContent;

@end

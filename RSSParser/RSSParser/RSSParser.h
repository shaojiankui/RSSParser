//
//  RSSParser.h
//  RSSParser
//
//  Created by Jakey on 15/7/7.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "RSSItem.h"

typedef void(^ParserSuccess)(NSArray *feedItems);
typedef void(^ParserFailure)(NSError *error);

@interface RSSParser : NSObject {
    RSSItem *_currentItem;
    NSMutableArray *_items;
    NSMutableString *_tmpString;
    NSDictionary *_tmpAttrDict;
    ParserSuccess _parserSuccess;
    ParserFailure _parserFailure;
}
/**
 *  解析RSS
 *
 *  @param feedURL RSS NSURL
 *  @param success 成功回调
 *  @param failure 失败回调
 */
+ (void)parseRSSFeed:(NSURL *)feedURL
            success:(ParserSuccess)success
            failure:(ParserFailure)failure;
/**
 *  解析RSS
 *
 *  @param feedURL RSS NSURL
 *  @param success 成功回调
 *  @param failure 失败回调
 */
- (void)parseRSSFeed:(NSURL *)feedURL
            success:(ParserSuccess)success
            failure:(ParserFailure)failure;
@end

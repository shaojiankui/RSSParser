//
//  RSSParser.m
//  RSSParser
//
//  Created by Jakey on 15/7/7.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "RSSParser.h"
#import "NSDate+InternetDateTime.h"
@interface RSSParser() <NSXMLParserDelegate>
@end

@implementation RSSParser
- (id)init {
    self = [super init];
    if (self) {
        _items = [[NSMutableArray alloc] init];
    }
    return self;
}

-(void)showNetWorkIndicator:(BOOL)show{
    [[UIApplication sharedApplication] setNetworkActivityIndicatorVisible:show];
}
#pragma mark parser

+ (void)parseRSSFeed:(NSURL *)feedURL
             success:(ParserSuccess)success
             failure:(ParserFailure)failure
{
    RSSParser *parser = [[RSSParser alloc] init];
    [parser parseRSSFeed:feedURL success:success failure:failure];
}


- (void)parseRSSFeed:(NSURL *)feedURL
             success:(ParserSuccess)success
             failure:(ParserFailure)failure
{
    [self showNetWorkIndicator:YES];
    _parserSuccess = [success copy];
    
    NSURLRequest *request = [[NSURLRequest alloc] initWithURL:feedURL];
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    [NSURLConnection sendAsynchronousRequest:request
                                       queue:queue
                           completionHandler:^(NSURLResponse *response, NSData *data, NSError * connectionError) {
        if (connectionError)
        {
            [self showNetWorkIndicator:NO];
            failure(connectionError);
        }else{
            _parserFailure = [failure copy];
            NSXMLParser *responseObject = [[NSXMLParser alloc]initWithData:data];
            [responseObject setDelegate:self];
            [responseObject parse];
        }
    }];
    
}

#pragma mark -
#pragma mark NSXMLParser delegate

- (void)parser:(NSXMLParser *)parser didStartElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qualifiedName attributes:(NSDictionary *)attributeDict {
    
    if ([elementName isEqualToString:@"item"] || [elementName isEqualToString:@"entry"]) {
        _currentItem = [[RSSItem alloc] init];
    }
    
    _tmpString = [[NSMutableString alloc] init];
    _tmpAttrDict = attributeDict;
}

- (void)parser:(NSXMLParser *)parser didEndElement:(NSString *)elementName namespaceURI:(NSString *)namespaceURI qualifiedName:(NSString *)qName {
    if ([elementName isEqualToString:@"item"] || [elementName isEqualToString:@"entry"]) {
        [_items addObject:_currentItem];
    }
    if (_currentItem != nil && _tmpString != nil) {
        
        if ([elementName isEqualToString:@"title"]) {
            [_currentItem setTitle:_tmpString];
        } else if ([elementName isEqualToString:@"description"]) {
            [_currentItem setItemDescription:_tmpString];
        } else if ([elementName isEqualToString:@"content:encoded"] || [elementName isEqualToString:@"content"]) {
            [_currentItem setContent:_tmpString];
        } else if ([elementName isEqualToString:@"link"]) {
            [_currentItem setLink:[NSURL URLWithString:_tmpString]];
        } else if ([elementName isEqualToString:@"comments"]) {
            [_currentItem setCommentsLink:[NSURL URLWithString:_tmpString]];
        } else if ([elementName isEqualToString:@"wfw:commentRss"]) {
            [_currentItem setCommentsFeed:[NSURL URLWithString:_tmpString]];
        } else if ([elementName isEqualToString:@"slash:comments"]) {
            [_currentItem setCommentsCount:[NSNumber numberWithInt:[_tmpString intValue]]];
        } else if ([elementName isEqualToString:@"pubDate"]) {
           NSDate  *date = [NSDate dateFromInternetDateTimeString:_tmpString formatHint:DateFormatHintRFC3339];
            [_currentItem setPubDate:date];
        } else if ([elementName isEqualToString:@"dc:creator"]) {
            [_currentItem setAuthor:_tmpString];
        } else if ([elementName isEqualToString:@"guid"]) {
            [_currentItem setGuid:_tmpString];
        }else if ([elementName isEqualToString:@"preview"]) {
            [_currentItem setPreview:_tmpString];
        }
        if ([elementName isEqualToString:@"enclosure"] && _tmpAttrDict != nil) {
            NSString *url = [_tmpAttrDict objectForKey:@"url"];
            if(url) {
                [_currentItem setLink:[NSURL URLWithString:url]];
            }
        }
    }
    
    if ([elementName isEqualToString:@"rss"] || [elementName isEqualToString:@"feed"]) {
        dispatch_async(dispatch_get_main_queue(), ^{
            [self showNetWorkIndicator:NO];
            _parserSuccess(_items);
        });

    }
}

- (void)parser:(NSXMLParser *)parser foundCharacters:(NSString *)string {
    [_tmpString appendString:string];
}

- (void)parser:(NSXMLParser *)parser parseErrorOccurred:(NSError *)parseError {
    [self showNetWorkIndicator:NO];
    _parserFailure(parseError);
    [parser abortParsing];
}
@end

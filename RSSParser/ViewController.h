//
//  ViewController.h
//  RSSParser
//
//  Created by Jakey on 15/7/7.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface ViewController : UIViewController
{
    NSMutableArray *parsedItems;

}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@end


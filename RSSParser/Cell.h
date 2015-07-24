//
//  Cell.h
//  RSSParser
//
//  Created by Jakey on 14-7-22.
//  Copyright (c) 2014年 Jakey. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface Cell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *newsDetail;
@property (weak, nonatomic) IBOutlet UILabel *newsTitle;
@property (weak, nonatomic) IBOutlet UIImageView *newsImage;

@end

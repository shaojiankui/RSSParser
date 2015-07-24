//
//  ViewController.m
//  RSSParser
//
//  Created by Jakey on 15/7/7.
//  Copyright (c) 2015年 www.skyfox.org. All rights reserved.
//

#import "ViewController.h"
#import "RSSParser.h"
#import "Cell.h"
#import "DetailViewController.h"
#import "NSString+Trims.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    [self.tableView registerNib:[UINib nibWithNibName:@"Cell" bundle:nil] forCellReuseIdentifier:@"Cell"];

    
    [RSSParser parseRSSFeed:[NSURL URLWithString:@"http:/www.skyfox.org/feed"] success:^(NSArray *feedItems) {
        [self setTitle:@"Blog"];
        parsedItems = [NSMutableArray arrayWithArray:feedItems];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self setTitle:@"Error"];
        NSLog(@"Error: %@",error);
    }];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    // Return YES for supported orientations
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    return [parsedItems count];
}

//默认UITableViewCell
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 90;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    Cell *cell = (Cell*)[tableView dequeueReusableCellWithIdentifier:@"Cell"];
    RSSItem *item = [parsedItems objectAtIndex:indexPath.row];
    
    cell.newsTitle.text = item.title;
    cell.newsDetail.text = [item.itemDescription stringByStrippingHTML];
    [self downImage:item.preview withBlock:^(UIImage *image) {
        cell.imageView.image = image;
    }];
    //config the cell
    
    return cell;
    
}
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    RSSItem *item = [parsedItems objectAtIndex:indexPath.row];
    DetailViewController *detail = [[DetailViewController alloc]init];
    detail.urlString = item.link.description;
    [self.navigationController pushViewController:detail animated:YES];
    NSLog(@"%@:",[item description]);
}

-(void)downImage:(NSString*)url withBlock:(void (^)(UIImage *image))completion{
    dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
        
        NSData *photoData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url?:@""]];
        
        dispatch_async(dispatch_get_main_queue(), ^{
            
            completion([UIImage imageWithData:photoData]);
            
        });
        
    });
}
@end

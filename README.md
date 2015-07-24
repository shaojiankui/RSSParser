# RSSParser
RSSParser,a simple parser for RSS feed,use iOS native xmlparser and network

	 
    [RSSParser parseRSSFeed:[NSURL URLWithString:@"http:/www.skyfox.org/feed"] success:^(NSArray *feedItems) {
        [self setTitle:@"Blog"];
        parsedItems = [NSMutableArray arrayWithArray:feedItems];
        [self.tableView reloadData];
    } failure:^(NSError *error) {
        [self setTitle:@"Error"];
        NSLog(@"Error: %@",error);
    }];

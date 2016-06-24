//
//  RYCaiJingViewController.m
//  20160622001-PresentAndChildViewController-News
//
//  Created by Rainer on 16/6/22.
//  Copyright © 2016年 Rainer. All rights reserved.
//

#import "RYCaiJingViewController.h"

@interface RYCaiJingViewController ()

@end

@implementation RYCaiJingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 20;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *tableViewCellIdentifier = @"tableViewCellIdentifier";
    
    UITableViewCell *tableViewCell = [tableView dequeueReusableCellWithIdentifier:tableViewCellIdentifier];
    
    if (nil == tableViewCell) {
        tableViewCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:tableViewCellIdentifier];
    }
    
    tableViewCell.textLabel.text = [NSString stringWithFormat:@"%@-%ld", self.title, indexPath.row];
    
    return tableViewCell;
}

@end

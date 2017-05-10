//
//  ObjCViewController.m
//  NauraSample
//
//  Created by Rivi Elfenboim on 10/05/2017.
//  Copyright © 2017 Rivi Elfenboim. All rights reserved.
//

#import "ObjCViewController.h"

@interface ObjCViewController ()


@end

@implementation ObjCViewController

 NSArray *tableData;


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    NPermission *item = [tableData objectAtIndex:indexPath.row];
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:simpleTableIdentifier];
    }
    
    
    
    cell.textLabel.text = item.displayName;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}




- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setTintColor:[UIColor whiteColor]];
    _tableView.tableFooterView = [[UIView alloc] initWithFrame:CGRectZero];
    //UINavigationItem *item = self.navigationController.navigationBar.titleView.item
   
    [NeuraSDK.shared getAppPermissionsListWithCallback:^(NeuraPermissionsListResult *result) {
        if (result.success) {
           tableData = result.permissions;
            dispatch_async(dispatch_get_main_queue(), ^{
                [self.tableView reloadData];
            });
            
        } else {
            // Error available in result.error
        }
    }];
    
    
    // Do any additional setup after loading the view.
}


@end

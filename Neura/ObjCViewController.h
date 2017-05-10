//
//  ObjCViewController.h
//  NauraSample
//
//  Created by Rivi Elfenboim on 10/05/2017.
//  Copyright © 2017 Rivi Elfenboim. All rights reserved.
//

#import <UIKit/UIKit.h>
#import  <NeuraSDK/NeuraSDK.h>

@interface ObjCViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

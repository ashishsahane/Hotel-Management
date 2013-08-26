//
//  iEmpMasterViewController.h
//  iHotelManagementSystem_NC
//
//  Created by Ashish Sahane on 14/07/13.
//  Copyright (c) 2013 Ashish Sahane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "HotelDirectory.h"

@class iEmpDetailViewController;

@interface iEmpMasterViewController : UITableViewController<UISearchDisplayDelegate,UITableViewDelegate,UITableViewDataSource>

@property (strong, nonatomic) iEmpDetailViewController *detailViewController;
- (NSString *)itemArchivePath;
@property (retain)HotelDirectory *hotelDirectory;
@property (retain)NSMutableArray *filteredList;

@end

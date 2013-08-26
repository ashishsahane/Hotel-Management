//
//  iEmpDetailViewController.h
//  iHotelManagementSystem_NC
//
//  Created by Ashish Sahane on 14/07/13.
//  Copyright (c) 2013 Ashish Sahane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iEmpDetailViewController : UIViewController

@property (strong, nonatomic) id detailItem;

@property (strong, nonatomic) IBOutlet UITextView *detailDescriptionText;

@property (strong, nonatomic) IBOutlet UIImageView *detailDescriptionImg;
@end

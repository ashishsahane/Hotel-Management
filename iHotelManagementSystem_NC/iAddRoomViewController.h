//
//  iAddRoomViewController.h
//  iHotelManagementSystem_NC
//
//  Created by Ashish Sahane on 19/07/13.
//  Copyright (c) 2013 Ashish Sahane. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface iAddRoomViewController : UIViewController<UITextFieldDelegate>
@property (readwrite,retain) IBOutlet UITextField *hotelRoomInformation;
@property (readwrite,retain) IBOutlet UITextField *hotelRoomNumber;
@property (readwrite,retain) IBOutlet UITextField *hotelRoomDescription;
@property (readwrite,retain) IBOutlet UITextField *hotelRate;
@property (readwrite,retain) IBOutlet UITextField *hotelRoomType;
@property (readwrite,retain) IBOutlet UIScrollView *baseScroll;

-(void)saveRoomInfo:(id)sender;
@property (readwrite,retain) IBOutlet UILabel *bookFrom;
@property (readwrite,retain) IBOutlet UILabel *bookTo;
@property (readwrite,retain) IBOutlet UIDatePicker *bookFromDt;
@property (readwrite,retain) IBOutlet UIDatePicker *bookToDt;

-(IBAction)bookRoom:(id)sender;
-(IBAction)dateAction:(id)sender;
@end

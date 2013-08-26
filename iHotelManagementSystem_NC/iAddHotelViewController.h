//
//  iAddHotelViewController.h
//  iHotelManagementSystem_VC
//
//  Created by Ashish Sahane on 04/07/13.
//  Copyright (c) 2013 Ashish Sahane. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "iHotel.h"

@interface iAddHotelViewController : UIViewController<UIImagePickerControllerDelegate,UINavigationControllerDelegate, UITextFieldDelegate>

@property (readwrite,retain) IBOutlet UITextField *hotelName;
@property (readwrite,retain) IBOutlet UITextField *hotelAddress;
@property (readwrite,retain) IBOutlet UITextField *hotelCity;
@property (readwrite,retain) IBOutlet UITextField *hotelPostalcode;
@property (readwrite,retain) IBOutlet UITextField *hotelTelephone_number;
@property (readwrite,retain) IBOutlet UITextField *hotelRating;
@property (readwrite,retain) IBOutlet UITextField *hotelRoomInformation;
@property (readwrite,retain) IBOutlet UITextField *hotelRoomNumber;
@property (readwrite,retain) IBOutlet UITextField *hotelRoomDescription;
@property (readwrite,retain) IBOutlet UITextField *hotelRate;
@property (readwrite,retain) IBOutlet UITextField *hotelRoomType;

@property (readwrite,retain) IBOutlet UIScrollView *baseScroll;

@property(retain,nonatomic)UIImagePickerController *imagePicker;
@property(nonatomic,retain) IBOutlet UIImageView *imageView;

@property(retain)iHotel *objHotel;

-(IBAction)saveRecoed: (id) sender;
-(IBAction) goBack: (id) sender;
-(IBAction)browseImage:(id)sender;
-(IBAction)insertNewRoom:(id)sender;

- (void)registerForKeyboardNotifications;
-(void)setViewMovedUp:(BOOL)movedUp;

@end

//
//  iAddRoomViewController.m
//  iHotelManagementSystem_NC
//
//  Created by Ashish Sahane on 19/07/13.
//  Copyright (c) 2013 Ashish Sahane. All rights reserved.
//

#import "iAddRoomViewController.h"
#import "iRoom.h"
#import "iAddHotelViewController.h"

@interface iAddRoomViewController ()

@end

@implementation iAddRoomViewController

@synthesize hotelRoomInformation = hotelRoomInformation;
@synthesize hotelRoomNumber = hotelRoomNumber;
@synthesize hotelRoomDescription = hotelRoomDescrption;
@synthesize hotelRate = hotelRate;
@synthesize hotelRoomType = hotelRoomType;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Room Info", @"Room Info");
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(saveRoomInfo:)];
        self.navigationItem.rightBarButtonItem =doneButton;
        [doneButton release];
        
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [_bookFrom setHidden:YES];
    [_bookTo setHidden:YES];
    [_bookFromDt setHidden:YES];
    [_bookToDt setHidden:YES];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)saveRoomInfo:(id)sender
{
    if([[hotelRoomNumber text] isEqualToString:@""] || [[hotelRoomType text] isEqualToString:@""] )
    {
        NSString *msg = @"Enter atleast room number, its type!!!";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    else{
    iRoom *room = [[iRoom alloc] init];
    
    [room setIRoomNumber:[[hotelRoomNumber text] intValue]];
    
    [room setDescription:[hotelRoomDescrption text]];
    
    [room setRate:[[hotelRate text] floatValue]];
    
    [room setType:[[hotelRoomType text] intValue]];

    if([_bookFromDt isHidden])
    {
        [room setIsAvailable:YES];
        [room setBookFromStr:@""];
        [room setBookToStr:@""];
    }
    else
    {
        [room setIsAvailable:NO];
        [room setBookFromStr:[NSDateFormatter localizedStringFromDate:[_bookFromDt date] dateStyle:NSDateFormatterFullStyle timeStyle:NSDateFormatterFullStyle]];
         [room setBookToStr:[NSDateFormatter localizedStringFromDate:[_bookToDt date] dateStyle:NSDateFormatterFullStyle timeStyle:NSDateFormatterFullStyle]];
    }
        
    iAddHotelViewController *parentController = (iAddHotelViewController*)[self.navigationController.viewControllers objectAtIndex:1];
    
    [[parentController.objHotel arrRoom] addObject:room];
    
    [room release];
    room = nil;
    
        NSString *msg = [NSString stringWithFormat:@"Entry for the room number %@ is successfully added to list!",[hotelRoomNumber text]];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
        [self.navigationController popViewControllerAnimated:YES];
    
    }
}
-(IBAction)bookRoom:(id)sender
{
    [_baseScroll endEditing:YES];

    [_bookFrom setHidden:NO];
    [_bookTo setHidden:NO];
    [_bookFromDt setHidden:NO];
    [_bookToDt setHidden:NO];
    
    [_bookFromDt setMinimumDate:[NSDate date]];
    [_bookToDt setMinimumDate:[NSDate date]];
}
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [scrollView endEditing:YES];
}
-(IBAction)dateAction:(id)sender
{
    [_bookToDt setMinimumDate:[_bookFromDt date]];
}
- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    [self.baseScroll setContentSize:CGSizeMake(320, 808)];
}
@end

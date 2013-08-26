//
//  iAddHotelViewController.m
//  iHotelManagementSystem_VC
//
//  Created by Ashish Sahane on 04/07/13.
//  Copyright (c) 2013 Ashish Sahane. All rights reserved.
//

#import "iAddHotelViewController.h"
#import "iRoom.h"
#import "iEmpMasterViewController.h"
#import "iAddRoomViewController.h"
#define kOFFSET_FOR_KEYBOARD 30.0

@interface iAddHotelViewController ()

@end

@implementation iAddHotelViewController

@synthesize hotelName = hotelName;
@synthesize hotelAddress = hotelAddress;
@synthesize hotelCity = hotelCity;
@synthesize hotelPostalcode = hotelPostalcode;
@synthesize hotelTelephone_number = hotelTelephone_number;
@synthesize hotelRating = hotelRating;
@synthesize hotelRoomInformation = hotelRoomInformation;
@synthesize hotelRoomNumber = hotelRoomNumber;
@synthesize hotelRoomDescription = hotelRoomDescrption;
@synthesize hotelRate = hotelRate;
@synthesize hotelRoomType = hotelRoomType;
@synthesize objHotel = objHotel;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Hotel Info", @"Hotel Info");

        // Custom initialization
        objHotel = [[iHotel alloc] init];
        UIBarButtonItem *doneButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemSave target:self action:@selector(saveRecoed:)];
        [doneButton setTitle:@"Save"];
        self.navigationItem.rightBarButtonItem =doneButton;
        [doneButton release];
    }
    return self;
}
-(void)dealloc
{
    [hotelName release];
    [hotelAddress release];
    [hotelCity release];
    [hotelPostalcode release];
    [hotelTelephone_number release];
    [hotelRating release];
    [hotelRoomInformation release];
    [hotelRoomNumber release];
    [hotelRoomDescrption release];
    [hotelRate release];
    [hotelRoomType release];
    [objHotel release];
    [_imagePicker release];
    
    [super dealloc];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    _imagePicker=[[UIImagePickerController alloc]init];
    [self registerForKeyboardNotifications];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(IBAction)saveRecoed: (id) sender
{
    if([[hotelName text] isEqualToString:@""] || [[hotelAddress text] isEqualToString:@""] || [[hotelCity text] isEqualToString:@""])
    {
        NSString *msg = @"Enter atleast Hotel name, its address and city!!!";
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
    }
    else{
   // iHotel *objHotel = [[iHotel alloc] init];
    
    [objHotel setName:[hotelName text]];
    
    [[objHotel address] setAddress:[hotelAddress text]];
    
    [[[objHotel address] city] setName:[hotelCity text]];
    
    [[[objHotel address] city] setPostalCode:[[hotelPostalcode text] intValue]];
    
    [objHotel setTelephone_number:[[hotelTelephone_number text] intValue]];
    
    [objHotel setRating:[[hotelRating text] floatValue]];
    
    [objHotel setNumberOfRooms:objHotel.arrRoom.count];

    [objHotel setHotelImage:[_imageView image]];
  

    iEmpMasterViewController *parentController = (iEmpMasterViewController*)[self.navigationController.viewControllers objectAtIndex:0];
        
    [parentController.hotelDirectory.hotelList addObject:objHotel];

    [NSKeyedArchiver archiveRootObject:parentController.hotelDirectory toFile:[parentController itemArchivePath]];
        
    [objHotel release];
    objHotel = nil;
        
        NSString *msg = [NSString stringWithFormat:@"Entry for the %@ hotel is successfully added to list!",[hotelName text]];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        
       [self.navigationController popViewControllerAnimated:YES];
    
    }
}
-(IBAction) goBack: (id) sender
{
    [self dismissViewControllerAnimated:YES completion:Nil];
}
-(IBAction)browseImage:(id)sender
{
    _imagePicker.delegate=self;
    _imagePicker.sourceType=UIImagePickerControllerSourceTypePhotoLibrary;
    [self presentViewController:_imagePicker animated:YES completion:nil];
    

}

- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info;
{
    UIImage *image;
    NSURL *mediaUrl;
    mediaUrl=(NSURL *)[info valueForKey:UIImagePickerControllerMediaURL];
    image=(UIImage *)[info valueForKey:UIImagePickerControllerOriginalImage];
    _imageView.image=image;
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker;
{
    [picker dismissViewControllerAnimated:YES completion:nil];
    
}

-(IBAction)insertNewRoom:(id)sender
{
    iAddRoomViewController* iAddRoomViewControllerObj = [[[iAddRoomViewController alloc] initWithNibName:@"iAddRoomViewController" bundle:nil] autorelease];
    [self.navigationController pushViewController:iAddRoomViewControllerObj animated:YES];
    
}

/////Textfield delegates--------
- (BOOL)textFieldShouldReturn:(UITextField *)textField
{
    // the user pressed the "Done" button, so dismiss the keyboard
    int nextTag = textField.tag + 1;
    
    // Try to find next responder
    UIResponder* nextResponder = [textField.superview viewWithTag:nextTag];
    if (nextResponder) {
        
        [self setViewMovedUp:YES];
        // Found next responder, so set it.
        [nextResponder becomeFirstResponder];
    } else {
        // Not found, so remove keyboard.
        [textField resignFirstResponder];
        [self setViewMovedUp:NO];
    }
    return NO; // We do not want UITextField to insert line-breaks.
}
- (BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if(textField.keyboardType == UIKeyboardTypeDefault)
    {
        NSString *txt = [textField text];
        if(txt && [txt compare:@"."] == 0)
        {
            NSString *msg = [NSString stringWithFormat:@"You typed : %@, which is not allowed!",[textField text]];
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg
                                                           delegate:self
                                                  cancelButtonTitle:@"OK" otherButtonTitles:nil];
            [alert show];
            [alert release];
            return NO;
        }
        
    }
    if(hotelPostalcode == textField)
        [self setViewMovedUp:YES];
    return YES;
}
- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string
{
    if([textField tag] == 10 || [textField tag] == 4|| [textField tag] == 5|| [textField tag] == 8|| [textField tag] == 11|| [textField tag] == 6)
    {
		NSCharacterSet *NumSet = [NSCharacterSet decimalDigitCharacterSet];
		if([string rangeOfCharacterFromSet:NumSet].length != 0 )
		{
			if (range.location == 1 && [[textField text] doubleValue] == 0)
            {
				[textField setText:@""];
			}
            
			return YES;
		}
        if([string isEqualToString:@"."])
        {
            if(([textField tag] == 10 && ([[textField text] rangeOfString:@"."].length == 0))|| ([textField tag] == 6 && ([[textField text] rangeOfString:@"."].length == 0)))
                return YES;
            else
            {
                NSString *msg = [NSString stringWithFormat:@"You typed : %@ which is not allowed!",string];
                UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg
                                                               delegate:self
                                                      cancelButtonTitle:@"OK" otherButtonTitles:nil];
                [alert show];
                [alert release];
                return NO;
            }
        }
        
        NSString *msg = [NSString stringWithFormat:@"You typed : %@ which is not allowed!",string];
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:nil message:msg
                                                       delegate:self
                                              cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
        [alert release];
        return NO;
    }
    else
        return YES;
}
/////Responder delegates----
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [scrollView endEditing:YES];
}
- (void)registerForKeyboardNotifications
{
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardDidShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillHide)
                                                 name:UIKeyboardWillHideNotification object:nil];
}

// Called when the UIKeyboardDidShowNotification is sent.

-(void)keyboardWillShow:(NSNotification*)aNotification {
    // Animate the current view out of the way
    NSDictionary* keyboardInfo = [aNotification userInfo];
    NSValue* keyboardFrameBegin = [keyboardInfo valueForKey:UIKeyboardFrameBeginUserInfoKey];
    CGRect keyboardFrameBeginRect = [keyboardFrameBegin CGRectValue];
    CGPoint hold = CGPointMake(hotelRating.frame.origin.x,hotelRating.frame.origin.y ) ;
    if(CGRectContainsPoint(keyboardFrameBeginRect,hold))
    {
        [self setViewMovedUp:YES];
    }
    
}

-(void)keyboardWillHide {
    if (self.view.frame.origin.y >= 0)
    {
        [self setViewMovedUp:YES];
    }
    else if (self.view.frame.origin.y < 0)
    {
        [self setViewMovedUp:NO];
    }
}

//method to move the view up/down whenever the keyboard is shown/dismissed
-(void)setViewMovedUp:(BOOL)movedUp
{
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:0.3]; // if you want to slide up the view
    
    CGRect rect = self.view.frame;
    if (movedUp)
    {
        // 1. move the view's origin up so that the text field that will be hidden come above the keyboard
        // 2. increase the size of the view so that the area behind the keyboard is covered up.
        rect.origin.y -= kOFFSET_FOR_KEYBOARD;
        rect.size.height += kOFFSET_FOR_KEYBOARD;
    }
    else
    {
        // revert back to the normal state.
        rect.origin.y += kOFFSET_FOR_KEYBOARD;
        rect.size.height -= kOFFSET_FOR_KEYBOARD;
    }
    self.view.frame = rect;
    
    [UIView commitAnimations];
}

@end

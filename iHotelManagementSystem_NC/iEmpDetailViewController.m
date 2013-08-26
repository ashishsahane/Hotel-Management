//
//  iEmpDetailViewController.m
//  iHotelManagementSystem_NC
//
//  Created by Ashish Sahane on 14/07/13.
//  Copyright (c) 2013 Ashish Sahane. All rights reserved.
//

#import "iEmpDetailViewController.h"
#import "iHotel.h"

@interface iEmpDetailViewController ()
- (void)configureView;
@end

@implementation iEmpDetailViewController

- (void)dealloc
{
    [_detailItem release];
    [_detailDescriptionText release];
    [super dealloc];
}

#pragma mark - Managing the detail item

- (void)setDetailItem:(id)newDetailItem
{
    if (_detailItem != newDetailItem) {
        [_detailItem release];
        _detailItem = [newDetailItem retain];

        // Update the view.
        [self configureView];
    }
}

- (void)configureView
{
    // Update the user interface for the detail item.

    if (self.detailItem) {
        self.detailDescriptionText.text = [self.detailItem description];
        [self.detailDescriptionImg setImage:[(iHotel*)self.detailItem hotelImage]];
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    [self configureView];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Detail", @"Detail");
    }
    return self;
}
							
@end

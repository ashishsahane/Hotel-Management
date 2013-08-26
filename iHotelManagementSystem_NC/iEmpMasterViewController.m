//
//  iEmpMasterViewController.m
//  iHotelManagementSystem_NC
//
//  Created by Ashish Sahane on 14/07/13.
//  Copyright (c) 2013 Ashish Sahane. All rights reserved.
//

#import "iEmpMasterViewController.h"

#import "iEmpDetailViewController.h"
#import "iAddHotelViewController.h"

/*@interface iEmpMasterViewController () {
HotelDirectory *hotelDirectory;
}
@end*/

@implementation iEmpMasterViewController

@synthesize hotelDirectory = hotelDirectory;
@synthesize filteredList = filteredList;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        self.title = NSLocalizedString(@"Hotels", @"Hotels");
        hotelDirectory = [[HotelDirectory alloc] init];
        if([[NSFileManager defaultManager] fileExistsAtPath:[self itemArchivePath]])
        {
            hotelDirectory = [[NSKeyedUnarchiver unarchiveObjectWithFile:[self itemArchivePath]] retain];
        }
        filteredList = [[NSMutableArray alloc] init];
    }
    return self;
}
- (NSString *)itemArchivePath
{
    NSArray *documentDirectories = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    
    NSString *documentDirectory = [documentDirectories objectAtIndex:0];
    return [documentDirectory stringByAppendingPathComponent:@"hotels.archive"];
}
- (void)dealloc
{
    [_detailViewController release];
    [hotelDirectory release];
    [filteredList release];
    [super dealloc];
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    [filteredList release];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
    
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tableView reloadData];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.hotelDirectory.hotelList retain];
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    self.navigationItem.leftBarButtonItem = self.editButtonItem;

    UIBarButtonItem *addButton = [[[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject:)] autorelease];
    self.navigationItem.rightBarButtonItem = addButton;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)insertNewObject:(id)sender
{
     iAddHotelViewController* iAddHotelViewControllerObj = [[[iAddHotelViewController alloc] initWithNibName:@"iAddHotelViewController" bundle:nil] autorelease];
    [self.navigationController pushViewController:iAddHotelViewControllerObj animated:YES];

}
- (void)filterContentForSearchText:(NSString*)searchText
{
    /*
     Update the filtered array based on the search text and scope.
     */
    
    [self.filteredList removeAllObjects]; // First clear the filtered array.
    
    
    for (iHotel *hotel in self.hotelDirectory.hotelList)
    {
    
            NSComparisonResult result = [hotel.Name compare:searchText options:(NSCaseInsensitiveSearch|NSDiacriticInsensitiveSearch) range:NSMakeRange(0, [searchText length])];
            if (result == NSOrderedSame)
            {
                [self.filteredList addObject:hotel];
            }
    }
}

#pragma mark - Table View

/*- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}
*/
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if(tableView == self.searchDisplayController.searchResultsTableView)
    {
        return filteredList.count;
    }
    return hotelDirectory.hotelList.count;
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(tableView == self.searchDisplayController.searchResultsTableView)
    {
        static NSString *CellIdentifier = @"Cell";
        
        UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
        if (cell == nil) {
            cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
            cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
        }
        
        iHotel *object = (iHotel*)self.filteredList[indexPath.row];
        
        cell.textLabel.text = [object Name];
        
        [cell.imageView setImage:[object hotelImage]];
        
        return cell;
    }
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }

    iHotel *object = hotelDirectory.hotelList[indexPath.row];
       
    cell.textLabel.text = [object Name];

    [cell.imageView setImage:[object hotelImage]];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        [hotelDirectory.hotelList removeObjectAtIndex:indexPath.row];
        [NSKeyedArchiver archiveRootObject:hotelDirectory toFile:[self itemArchivePath]];
        
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!self.detailViewController) {
        self.detailViewController = [[[iEmpDetailViewController alloc] initWithNibName:@"iEmpDetailViewController" bundle:nil] autorelease];
    }
    iHotel *object;
    if(tableView == self.searchDisplayController.searchResultsTableView)
    {
        object = (iHotel*)filteredList[indexPath.row];
    }
    else
    {
        object = hotelDirectory.hotelList[indexPath.row];
    }
    self.detailViewController.detailItem = object;
    [self.navigationController pushViewController:self.detailViewController animated:YES];
}

#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString
{
    [self filterContentForSearchText:searchString];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


- (BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption
{
    [self filterContentForSearchText:[self.searchDisplayController.searchBar text]];
    
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

@end

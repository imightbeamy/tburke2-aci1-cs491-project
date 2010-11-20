//
//  RootViewController.m
//  FinalProject
//

#import "RootViewController.h"
#import "FinalProjectAppDelegate.h"
#import	"ConferenceObject.h"
#import "SubMenuViewController.h"

@interface RootViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation RootViewController

@synthesize searchBar;
@synthesize conferenceObjs;
@synthesize menuOptions;

#pragma mark -
#pragma mark Search Bar

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
	//NSLog(@"Text changed %@", searchText);
	
	// TO DO:
	// Change the search code for the UITableView display to show
	// the results of the search.
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
	// TO DO:
	// Put the UITableView back ot the standard list of choices
	
	
	
}

#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.conferenceObjs = [NSMutableArray array];
	FinalProjectAppDelegate *del = ((FinalProjectAppDelegate *)([[UIApplication sharedApplication] delegate]));
	
	for (NSDictionary * dic in del.conferenceObjs) {
		[self.conferenceObjs addObject:[[ConferenceObject ConferenceObjectFromDictionary:dic] retain]];
	}
	
	self.menuOptions = [NSMutableArray arrayWithObjects: @"Events", @"Speakers", @"Sponsors",nil];

	// Set up the edit and add buttons.
    //self.navigationItem.leftBarButtonItem = self.editButtonItem;
    
    //UIBarButtonItem *addButton = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(insertNewObject)];
    //self.navigationItem.rightBarButtonItem = addButton;
    //[addButton release];
	self.navigationItem.title = @"Name";

}


// Implement viewWillAppear: to do additional setup before the view is presented.
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
}



- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];

	// Put the search bar away when returning to this view
	// from a subview.
	[self searchBarCancelButtonClicked:self.searchBar];

}



/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/
/*
- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}
*/

/*
 // Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
    // Return YES for supported orientations.
    return (interfaceOrientation == UIInterfaceOrientationPortrait);
}
 */


#pragma mark -
#pragma mark Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [self.menuOptions count];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	
	cell.textLabel.text =  [self.menuOptions objectAtIndex:indexPath.row];
}
// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier] autorelease];
    }
    
   cell.textLabel.text =  [self.menuOptions objectAtIndex:indexPath.row];
    
    return cell;
}



/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/


- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // The table view should not be re-orderable.
    return NO;
}


#pragma mark -
#pragma mark Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    // Navigation logic may go here -- for example, create and push another view controller.
	NSLog(@"menu stuff %@", [self.menuOptions objectAtIndex:indexPath.row]);
    NSString * menuchoice =  [self.menuOptions objectAtIndex:indexPath.row];
	
	SubMenuViewController *sm = [[SubMenuViewController alloc] initWithNibName:@"SubMenuViewController" bundle:nil];

	if([menuchoice isEqualToString:@"Events"])
	{
		sm.conferenceObjs = [self.conferenceObjs filteredArrayUsingPredicate:[NSPredicate predicateWithFormat: @"type == 0"]];
		sm.navigationItem.title = @"Events";
	}
	else if([menuchoice isEqualToString:@"Speakers"])
	{
		sm.conferenceObjs = [self.conferenceObjs filteredArrayUsingPredicate:[NSPredicate predicateWithFormat: @"type == 2"]];
		sm.navigationItem.title = @"Speakers";
	}
	else if([menuchoice isEqualToString:@"Sponsors"])
	{
		sm.conferenceObjs = [self.conferenceObjs filteredArrayUsingPredicate:[NSPredicate predicateWithFormat: @"type == 1"]];
		sm.navigationItem.title = @"Sponsors";
	}
	else
		sm.conferenceObjs = self.conferenceObjs;
	
	// Pass the selected object to the new view controller.
	[self.navigationController pushViewController:sm animated:YES];
	[sm release];
}

/*
// Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // In the simplest, most efficient, case, reload the table view.
    [self.tableView reloadData];
}
 */


#pragma mark -
#pragma mark Memory management

- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Relinquish ownership any cached data, images, etc that aren't in use.
}




- (void)viewDidUnload {
    // Relinquish ownership of anything that can be recreated in viewDidLoad or on demand.
    // For example: self.myOutlet = nil;
}


- (void)dealloc {
    [super dealloc];
}


@end


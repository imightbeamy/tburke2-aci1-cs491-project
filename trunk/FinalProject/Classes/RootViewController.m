//
//  RootViewController.m
//  FinalProject
//

#import "RootViewController.h"
#import "FinalProjectAppDelegate.h"
#import	"ConferenceObject.h"
#import "SubMenuViewController.h"
#import "SearchViewController.h"

@interface RootViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
@end

@implementation RootViewController

@synthesize conferenceObjs;
@synthesize menuOptions;



#pragma mark -
#pragma mark View lifecycle

- (void)viewDidLoad {
    [super viewDidLoad];

    self.conferenceObjs = [NSMutableArray array];
	FinalProjectAppDelegate *del = ((FinalProjectAppDelegate *)([[UIApplication sharedApplication] delegate]));
	
	for (NSDictionary * dic in del.conferenceObjs) {
		[self.conferenceObjs addObject:[[ConferenceObject ConferenceObjectFromDictionary:dic] retain]];
	}
	[self.conferenceObjs sortUsingComparator:[ConferenceObject getTitleComparator]];
	
	
	self.menuOptions = [NSMutableArray arrayWithObjects: 
						@"Events", 
						@"Speakers", 
						@"Sponsors",
						@"Schedule", 
						@"Favorites",
						@"Search",
						@"Map", nil];

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
	
	if([menuchoice isEqualToString:@"Events"])
	{
		[self loadFilteredSubviewWithName: @"Events" andFilter: @"type == 0"];
	}
	else if([menuchoice isEqualToString:@"Speakers"])
	{
		[self loadFilteredSubviewWithName: @"Speakers" andFilter: @"type == 2"];
	}
	else if([menuchoice isEqualToString:@"Sponsors"])
	{
		[self loadFilteredSubviewWithName: @"Sponsors" andFilter: @"type == 1"];
	}
	else if([menuchoice isEqualToString:@"Favorites"])
	{
		[self loadFilteredSubviewWithName: @"Favorites" andFilter: @"favorite == 1"];
	}
	else if([menuchoice isEqualToString:@"Search"])
	{
		SearchViewController * sv = [[SearchViewController alloc] initWithNibName:@"SearchViewController" bundle:nil];
		sv.navigationItem.title = @"Search";
		sv.conferenceObjs = self.conferenceObjs;
		[self.navigationController pushViewController:sv animated:YES];
	}
	else if([menuchoice isEqualToString:@"Schedule"])
	{
		[self loadScheduleView];
	}
	else if([menuchoice isEqualToString: @"Map"])
	{
		/*LOAD MAP VIEW HERE*/
		//[self.navigationController pushViewController: <mapview> animated:YES];
	}		
}

/*
// Implementing the above methods to update the table view in response to individual changes may have performance implications if a large number of changes are made simultaneously. If this proves to be an issue, you can instead just implement controllerDidChangeContent: which notifies the delegate that all section and object changes have been processed. 
 
 - (void)controllerDidChangeContent:(NSFetchedResultsController *)controller {
    // In the simplest, most efficient, case, reload the table view.
    [self.tableView reloadData];
}
 */

- (void) loadFilteredSubviewWithName:(NSString *) name andFilter: (NSString *) filter
{
	SubMenuViewController *sm = [[SubMenuViewController alloc] initWithNibName:@"SubMenuViewController" bundle:nil];
	sm.conferenceObjs = [self.conferenceObjs filteredArrayUsingPredicate:[NSPredicate predicateWithFormat: filter]];
	sm.navigationItem.title = name;
	[self.navigationController pushViewController:sm animated:YES];
	[sm release];
}

- (void) loadScheduleView
{
	SubMenuViewController *sm = [[SubMenuViewController alloc] initWithNibName:@"SubMenuViewController" bundle:nil];
	NSPredicate * filter = [NSPredicate predicateWithFormat: @"type == 0"];
	NSArray * filted = [self.conferenceObjs filteredArrayUsingPredicate:filter];
	sm.conferenceObjs = [filted sortedArrayUsingComparator:[ConferenceObject getEventTimeComparator]];
	sm.navigationItem.title = @"Schedule";
	sm.scheduleView = YES;
	[self.navigationController pushViewController:sm animated:YES];
	[sm release];
}

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


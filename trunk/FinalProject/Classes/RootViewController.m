//
//  RootViewController.m
//  FinalProject
//

#import "RootViewController.h"
#import "FinalProjectAppDelegate.h"
#import	"ConferenceObject.h"
#import "SubMenuViewController.h"
#import "SearchViewController.h"
#import "MapViewController.h"

@interface RootViewController ()
- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath;
- (void) loadFavoritesView;
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
	
	// Set the first displayed Title
	self.navigationItem.title = @"Conference";
	
	// Use any color for navigation bar, no gradient.  Also sets buttons same color.
	//self.navigationController.navigationBar.tintColor = [UIColor greenColor];
	
	// Alternate Black Style built in with gradient
	//self.navigationController.navigationBar.barStyle = UIBarStyleBlack;

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
		[self loadFavoritesView];
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
		MapViewController *mv = [[MapViewController alloc] initWithNibName:@"MapViewController" bundle:nil];
		mv.confObj = nil; // No object to display location here
		[self.navigationController pushViewController:mv animated:YES];
	}		
}


- (void) loadFilteredSubviewWithName:(NSString *) name andFilter: (NSString *) filter
{
	SubMenuViewController *sm = [[SubMenuViewController alloc] initWithNibName:@"SubMenuViewController" bundle:nil];
	sm.conferenceObjs = [self.conferenceObjs filteredArrayUsingPredicate:[NSPredicate predicateWithFormat: filter]];
	sm.navigationItem.title = name;
	[self.navigationController pushViewController:sm animated:YES];
	[sm release];
}


- (void) loadFavoritesView
{
	SubMenuViewController *sm = [[SubMenuViewController alloc] initWithNibName:@"SubMenuViewController" bundle:nil];
	sm.conferenceObjs = [self.conferenceObjs filteredArrayUsingPredicate:[NSPredicate predicateWithFormat: @"favorite == 1"]];
	sm.navigationItem.title = @"Favorites";
	sm.favsView = YES;
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
	self.conferenceObjs = nil;
	self.menuOptions = nil;
    [super dealloc];
}


@end


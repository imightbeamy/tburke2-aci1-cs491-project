//
//  SearchViewController.m
//  FinalProject
//
//  Amy Ciavolino and Tim Burke
//  CMSC491 - Fall 2010
//
// A Netscape engineer who shan't be named once passed a pointer 
// to JavaScript, stored it as a string and later passed it back 
// to C, killing 30.
//
// - Blake Ross
//

#import "SearchViewController.h"
#import "ConferenceObject.h"
#import "ConferenceObjectViewController.h"

@implementation SearchViewController


@synthesize searchBar, conferenceObjs, filtered;

#pragma mark -
#pragma mark Search Bar


- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
}


- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
}


#pragma mark -
#pragma mark View lifecycle


- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
	[self searchBarCancelButtonClicked:self.searchBar];
}


#pragma mark -
#pragma mark Table view data source


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return self.filtered.count;
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell";
    
	// Always create new cells to clear image contents
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    
	ConferenceObject * co = [self.filtered objectAtIndex:indexPath.row];
	cell.textLabel.text =  [NSString stringWithFormat:@"         %@", co.title];
	cell.detailTextLabel.text = [NSString stringWithFormat:@"           %@", co.typeString];
	
	// Used this method instead of using the imageView that comes with the cell because
	// there is no way to resize that imageView textLabel and detailTextLabel are also
	// read-only so they cannot be repositioned, hence the spaces
	UIImageView *img = [[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.height, cell.frame.size.height)] autorelease];
	[img setImage:co.image];
	[img setContentMode:UIViewContentModeScaleAspectFit];
	[cell.contentView addSubview:img];
	
    return cell;
}

#pragma mark UISearchDisplayController Delegate Methods

- (BOOL)searchDisplayController:(UISearchDisplayController *)controller 
shouldReloadTableForSearchString:(NSString *)searchString
{
	NSPredicate * predicate = [NSPredicate predicateWithFormat:@"searchableText CONTAINS[cd] %@", searchString];
    self.filtered = [self.conferenceObjs filteredArrayUsingPredicate: predicate];
	
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}


#pragma mark -
#pragma mark Table view delegate


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	ConferenceObjectViewController *covc = [[ConferenceObjectViewController alloc] initWithNibName:@"ConferenceObjectViewController" bundle:nil];
	ConferenceObject *co = [self.filtered objectAtIndex:indexPath.row];
	
	covc.confObj = co;
	[self.navigationController pushViewController:covc animated:YES];
	[covc release];
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
	self.searchBar = nil;
	self.conferenceObjs = nil;
	self.filtered = nil;
    [super dealloc];
}


@end


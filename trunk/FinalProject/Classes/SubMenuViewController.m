//
//  SubMenuViewController.m
//  FinalProject
//
//  Created by Amy Ciavolino on 11/20/10.
//  Copyright 2010 UMBC. All rights reserved.
//

#import "SubMenuViewController.h"
#import "ConferenceObject.h"
#import "ConferenceObjectViewController.h"
@implementation SubMenuViewController

@synthesize conferenceObjs,scheduleView, favsView;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
	if(favsView)
	{
		self.conferenceObjs = [self.conferenceObjs filteredArrayUsingPredicate: [NSPredicate predicateWithFormat:@"favorite == 1"]];
		[self.tableView reloadData];
	}
}


- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
}


- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    return [conferenceObjs count];
}


- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath {
	
	ConferenceObject * co = [self.conferenceObjs objectAtIndex:indexPath.row];
    cell.textLabel.text = [NSString stringWithFormat:@"        %@", co.title];

	if (self.scheduleView && co.startTime != nil) {
		NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
		[dateFormatter setDateStyle:NSDateFormatterShortStyle];
		[dateFormatter setTimeStyle:NSDateFormatterShortStyle];
		if(co.endTime != nil)
		{
			NSString * st =  [dateFormatter stringFromDate:co.startTime];
			[dateFormatter setDateStyle:NSDateFormatterNoStyle];
			cell.detailTextLabel.text = [NSString stringWithFormat:@"           %@ - %@", st,
										 [dateFormatter stringFromDate:co.endTime]];
		}
		else {
			cell.detailTextLabel.text = [dateFormatter stringFromDate:co.startTime];
		}
	}
	
	// Used this method instead of using the imageView that comes with the cell because
	// there is no way to resize that imageView textLabel and detailTextLabel are also
	// read-only so they cannot be repositioned, hence the spaces
	UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.height, cell.frame.size.height)];
	[img setImage:co.image];
	[img setContentMode:UIViewContentModeScaleAspectFit];
	[cell.contentView addSubview:img];
}


// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
	// Always use new cells to clear image contents.
    UITableViewCell *cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    
    // Configure the cell.
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	
	ConferenceObjectViewController *covc = [[ConferenceObjectViewController alloc] initWithNibName:@"ConferenceObjectViewController" bundle:nil];
	ConferenceObject *co = [self.conferenceObjs objectAtIndex:indexPath.row];
	
	covc.confObj = co;
	// Pass the selected object to the new view controller.
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
	self.conferenceObjs = nil;
    [super dealloc];
}


@end


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

@synthesize conferenceObjs,scheduleView;

#pragma mark -
#pragma mark View lifecycle


- (void)viewDidLoad {
    [super viewDidLoad];
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}



- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
	
//	[self.tableView reloadData];
//	NSLog(@"reload");
}

/*
- (void)viewDidAppear:(BOOL)animated {
    [super viewDidAppear:animated];
}
*/
/*
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
}
*/

- (void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
	self.scheduleView = NO;
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
	
	UIImageView *img = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, cell.frame.size.height, cell.frame.size.height)];
	[img setImage:co.image];
	[img setContentMode:UIViewContentModeScaleAspectFit];
	[cell.contentView addSubview:img];
	
}

// Customize the appearance of table view cells.
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:CellIdentifier] autorelease];
    }
    
    // Configure the cell.
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
	// Navigation logic may go here -- for example, create and push another view controller.
    
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
    [super dealloc];
}


@end


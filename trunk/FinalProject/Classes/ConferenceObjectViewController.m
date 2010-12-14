//
//  ConferenceObjectViewController.m
//  FinalProject
//
//  Amy Ciavolino and Tim Burke
//  CMSC491 - Fall 2010
//
//  Java is to JavaScript what Car is to Carpet.
//
//  - Chris Heilmann
// 

#import "ConferenceObjectViewController.h"
#import "MapViewController.h"

@implementation ConferenceObjectViewController

#pragma mark -
#pragma mark IVars

@synthesize confObj;
@synthesize textView;
@synthesize scrollView;
@synthesize favoriteButton;

@synthesize lblTime;
@synthesize timeLocationView;
@synthesize locationButton;
@synthesize objTitle;

@synthesize defaults;

#pragma mark -
#pragma mark IBActions

- (void)favoriteButtonPressed {
	// Toggle the state of the objects favorite status and swap the image
	self.confObj.favorite = !self.confObj.favorite;
	if(self.confObj.favorite) {
		self.favoriteButton.image = [UIImage imageNamed:@"FavIcon_T"];
	} else {
		self.favoriteButton.image = [UIImage imageNamed:@"FavIcon_F"];
	}
	
	// Set the setting of that object as a favorite to persist across application runs
	[self.defaults setBool:self.confObj.favorite forKey:[NSString stringWithFormat:@"%d", self.confObj.IDnum]];
	[self.defaults synchronize]; 
}

- (IBAction)locationButtonPressed {
	// Init the map view controller, pass along the conference object and then
	// display the map (with location pin)
	MapViewController *mv = [[[MapViewController alloc] init] autorelease];
	mv.confObj = self.confObj;
	[self.navigationController pushViewController:mv animated:YES];
}

#pragma mark -
#pragma mark Initialization


- (void)viewDidLoad {
	[super viewDidLoad];
	// Set the title of the view to the type of Conference Object (saves space over name)
	switch (self.confObj.type) {
		case kEventType:
			self.title = @"Event";
			break;
		case kSponsorType:
			self.title = @"Sponsor";
			break;
		case kSpeakerType:
			self.title = @"Speaker";
			break;
		default:
			self.title = @"Unknown";
			break;
	}
	
	// Set the text fields (label and textview)
	self.objTitle.text = self.confObj.title;
	self.textView.text = self.confObj.description;
	
	// Start a running total of height
	int scrollViewHeight = 40;
	
	// Calculate the scaled height of the image
	int scaledImageHeight = ((280 * self.confObj.image.size.height) / self.confObj.image.size.width);

	// Init the image with the necessary size and add to the scrollview
	UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(20, scrollViewHeight, 280, scaledImageHeight)];
	image.image = self.confObj.image;
	[self.scrollView addSubview:image];
	
	// Add the height of the image to the running total
	scrollViewHeight += scaledImageHeight;
	
	// If the object type is event, display a subview containing the times of event
	// and a location button to bring up the map of the location
	if(self.confObj.type == kEventType) {
		scrollViewHeight += 5;
		
		// Put the subview in the correct position in the subview
		self.timeLocationView.center = CGPointMake(self.timeLocationView.center.x, scrollViewHeight + (self.timeLocationView.frame.size.height / 2));
		scrollViewHeight += self.timeLocationView.frame.size.height;
		self.timeLocationView.hidden = NO;
		
		// Display time/date
		NSDateFormatter *dateFormatter = [[[NSDateFormatter alloc] init] autorelease];
		[dateFormatter setDateStyle:NSDateFormatterShortStyle];
		[dateFormatter setTimeStyle:NSDateFormatterShortStyle];		
		if(confObj.endTime != nil)
		{
			NSString * st =  [dateFormatter stringFromDate:confObj.startTime];
			[dateFormatter setDateStyle:NSDateFormatterNoStyle];
			self.lblTime.text = [NSString stringWithFormat:@"%@ - %@", st,
										 [dateFormatter stringFromDate:confObj.endTime]];
		}
		else {
			self.lblTime.text = [dateFormatter stringFromDate:confObj.startTime];
		}
		
		// Set the map button to the name of the location
		[self.locationButton setTitle:self.confObj.location forState:UIControlStateNormal];
		[self.locationButton setTitle:self.confObj.location forState:UIControlStateHighlighted];
		
	} else {
		self.timeLocationView.hidden = YES;
	}
	scrollViewHeight += 5;
	
	// Adjust the UITextView to the height of its content so it does not
	// scroll itself, but expands to the size of the text within
	CGRect tempFrame = self.textView.frame;
	tempFrame.size.height = self.textView.contentSize.height;
	self.textView.frame = tempFrame;
	
	// Position the textview accordingly
	self.textView.center = CGPointMake(self.textView.center.x, scrollViewHeight + (self.textView.frame.size.height / 2));
	
	// Add some padding to the bottom
	scrollViewHeight += self.textView.frame.size.height + 20;
	
	// Set the scrolling size of the scrollView
	self.scrollView.contentSize = CGSizeMake(320, scrollViewHeight);
	
}


#pragma mark -
#pragma mark Memory Management

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	NSLog(@"Got here");
	
	// Init and add the favorite button to the navigation controller
	self.favoriteButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"FavIcon_F"] 
															style:UIBarButtonItemStylePlain 
														   target:self 
														   action:@selector(favoriteButtonPressed)] autorelease];
	
	self.navigationItem.rightBarButtonItem = self.favoriteButton;

	if (self.defaults == nil) 
	{
		self.defaults = [NSUserDefaults standardUserDefaults];
	}
	
	self.confObj.favorite = [self.defaults boolForKey:[NSString stringWithFormat:@"%d", self.confObj.IDnum]];
	if(self.confObj.favorite) {
		self.favoriteButton.image = [UIImage imageNamed:@"FavIcon_T"];
	} else {
		self.favoriteButton.image = [UIImage imageNamed:@"FavIcon_F"];
	}
	
}


- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
	
	// Remove the favorite button from the navigation controller
	self.navigationController.navigationItem.rightBarButtonItem = nil;
}


- (void)viewDidUnload {
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}


- (void)dealloc {
	self.confObj = nil;
	self.textView = nil;
	self.scrollView = nil;
	self.favoriteButton = nil;
	self.lblTime = nil;
	self.timeLocationView = nil;
	self.locationButton = nil;
	self.objTitle = nil;
	self.defaults = nil;
    [super dealloc];
}


@end

//
//  ConferenceObjectViewController.m
//  FinalProject
//
//  Created by Amy Ciavolino on 11/19/10.
//  Copyright 2010 UMBC. All rights reserved.
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

#pragma mark -
#pragma mark IBActions

- (void)favoriteButtonPressed {
	self.confObj.favorite = !self.confObj.favorite;
	if(self.confObj.favorite) {
		self.favoriteButton.image = [UIImage imageNamed:@"FavIcon_T"];
	} else {
		self.favoriteButton.image = [UIImage imageNamed:@"FavIcon_F"];
	}
}

- (IBAction)locationButtonPressed {
	MapViewController *mv = [[[MapViewController alloc] init] autorelease];
	mv.confObj = self.confObj;
	[self.navigationController pushViewController:mv animated:YES];
}

#pragma mark -
#pragma mark Initialization

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	self.title = self.confObj.title;
	self.textView.text = self.confObj.description;
	
	int scrollViewHeight = 20;
	
	int scaledImageHeight = ((280 * self.confObj.image.size.height) / self.confObj.image.size.width);
	
	UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 280, scaledImageHeight)];
	image.image = self.confObj.image;
	[self.scrollView addSubview:image];
	scrollViewHeight += scaledImageHeight;
	
	if(self.confObj.type == EventType) {
		scrollViewHeight += 5;
		self.timeLocationView.center = CGPointMake(self.timeLocationView.center.x, scrollViewHeight + (self.timeLocationView.frame.size.height / 2));
		scrollViewHeight += self.timeLocationView.frame.size.height;
		self.timeLocationView.hidden = NO;
		
		// Need to work on time/date code
		self.lblTime.text = @"Time will go here";
		
		[self.locationButton setTitle:@"Location Name" forState:UIControlStateNormal];
		[self.locationButton setTitle:@"Location Name" forState:UIControlStateHighlighted];
		
	} else {
		self.timeLocationView.hidden = YES;
	}
	scrollViewHeight += 5;
	
	CGRect tempFrame = self.textView.frame;
	tempFrame.size.height = self.textView.contentSize.height;
	self.textView.frame = tempFrame;
	
	
	self.textView.center = CGPointMake(self.textView.center.x, scrollViewHeight + (self.textView.frame.size.height / 2));
	
	scrollViewHeight += self.textView.frame.size.height + 20;
	
	self.scrollView.contentSize = CGSizeMake(320, scrollViewHeight);
	
	self.favoriteButton = [[[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"FavIcon_F"] 
															style:UIBarButtonItemStylePlain 
														   target:self 
														   action:@selector(favoriteButtonPressed)] autorelease];
	self.navigationItem.rightBarButtonItem = self.favoriteButton;
	if(self.confObj.favorite) {
		self.favoriteButton.image = [UIImage imageNamed:@"FavIcon_T"];
	} else {
		self.favoriteButton.image = [UIImage imageNamed:@"FavIcon_F"];
	}
}


#pragma mark -
#pragma mark Memory Management

- (void)viewWillDisappear:(BOOL)animated {
	[super viewWillDisappear:animated];
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
    [super dealloc];
}


@end

//
//  ConferenceObjectViewController.m
//  FinalProject
//
//  Created by Amy Ciavolino on 11/19/10.
//  Copyright 2010 UMBC. All rights reserved.
//

#import "ConferenceObjectViewController.h"


@implementation ConferenceObjectViewController

@synthesize confObj;
@synthesize image;
@synthesize textView;
@synthesize scrollView;
@synthesize favoriteButton;

@synthesize lblTime;
@synthesize lblLocation;
@synthesize timeLocationView;

- (void)favoriteButtonPressed {
	self.confObj.favorite = !self.confObj.favorite;
	if(self.confObj.favorite) {
		self.favoriteButton.style = UIBarButtonItemStyleDone;
	} else {
		self.favoriteButton.style = UIBarButtonItemStyleBordered;
	}
}


- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	self.title = self.confObj.title;
	
	int scrollViewHeight = 20;
	
	[self.image initWithImage:self.confObj.image];
	[self.image sizeThatFits:CGSizeMake(280.0, ((280 * self.confObj.image.size.height) / self.confObj.image.size.width) )];
	
	scrollViewHeight += ((280 * self.confObj.image.size.height) / self.confObj.image.size.width);
	//scrollViewHeight += 20;
	
	if(self.confObj.type == EventType) {
		scrollViewHeight += 5;
		self.timeLocationView.center = CGPointMake(self.timeLocationView.center.x, scrollViewHeight + (self.timeLocationView.frame.size.height / 2));
		scrollViewHeight += self.timeLocationView.frame.size.height;
		self.timeLocationView.hidden = NO;
		
		self.lblTime.text = @"Time will go here";
		self.lblLocation.text = @"Location will go here";
		
	} else {
		self.timeLocationView.hidden = YES;
	}
	scrollViewHeight += 5;
	
	[self.textView sizeToFit];
	
	self.textView.center = CGPointMake(self.textView.center.x, scrollViewHeight + (self.textView.frame.size.height / 2));
	
	[self.scrollView sizeToFit];
	
	self.favoriteButton.title = @"F";
	self.favoriteButton.action = @selector(favoriteButtonPressed);
	if(self.confObj.favorite) {
		self.favoriteButton.style = UIBarButtonItemStyleDone;
	} else {
		self.favoriteButton.style = UIBarButtonItemStyleBordered;
	}
	
	self.navigationController.navigationItem.rightBarButtonItem = self.favoriteButton;
}

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
    [super dealloc];
}


@end

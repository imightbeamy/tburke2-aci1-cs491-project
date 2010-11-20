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
	
	int scrollViewHeight = 20;
	
	[self.image initWithImage:self.confObj.image];
	[self.image sizeThatFits:CGSizeMake(280.0, ((280 * self.confObj.image.size.height) / self.confObj.image.size.width) )];
	
	scrollViewHeight += ((280 * self.confObj.image.size.height) / self.confObj.image.size.width);
	scrollViewHeight += 20;
	
	//[NSString stringWithString:[self.confObj class]]
	
	
	if(YES) {
		
	}
	
	
	
	
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

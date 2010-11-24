//
//  MapViewController.m
//  FinalProject
//
//  Created by Timothy Burke on 11/24/10.
//  Copyright 2010 UMBC. All rights reserved.
//

#import "MapViewController.h"


@implementation MapViewController

@synthesize scrollView;

@synthesize confObj;


- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	UIImageView *iv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"map"]] autorelease];
	
	[self.scrollView addSubview:iv];
	
	if(self.confObj) {
		// Code to draw dot will go here
		
	}
	
	
	
}





- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}

- (void)viewDidLoad {
	[super viewDidLoad];
}


- (void)viewDidUnload {
    [super viewDidUnload];
	self.confObj = nil;
}


- (void)dealloc {
	self.confObj = nil;
    [super dealloc];
}


@end

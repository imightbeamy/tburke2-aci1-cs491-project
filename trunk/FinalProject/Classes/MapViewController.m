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
	
	self.scrollView.delegate = self;
	
	UIImageView *iv = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"map"]] autorelease];
	
	[self.scrollView addSubview:iv];
	
	self.scrollView.contentSize = CGSizeMake(iv.image.size.height, iv.image.size.width);
	
	[self.scrollView setContentOffset:CGPointMake((iv.image.size.height - 320) / 2, (iv.image.size.width - 460) / 2)];
	
	
	/*
	UIBarButtonItem *temp = [[[UIBarButtonItem alloc] initWithTitle:@"Zoom" 
															  style:UIBarButtonItemStyleBordered 
															 target:self 
															 action:@selector(myZoom)] autorelease];
	
	self.navigationItem.rightBarButtonItem = temp;
	
	self.scrollView.minimumZoomScale = 0.0;
	self.scrollView.maximumZoomScale = 3.0;
	*/
	
	if(self.confObj) {
		// Code to draw dot will go here
		
	}
	
	
	
}


/*
- (void)myZoom {
	
	if(self.scrollView.zoomScale == 2.0) {
		[self.scrollView setZoomScale:1.0 animated:YES];
		self.scrollView.contentSize = CGSizeMake(1024, 1024);
	} else {
		[self.scrollView setZoomScale:2.0 animated:YES];
		self.scrollView.contentSize = CGSizeMake(1024 * 1.15, 1024 * 1.2);
	}
}
 */



/*
- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollViewt {
	return scrollViewt;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
	
}*/





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

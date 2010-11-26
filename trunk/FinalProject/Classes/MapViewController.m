//
//  MapViewController.m
//  FinalProject
//
//  Created by Timothy Burke on 11/24/10.
//  Copyright 2010 UMBC. All rights reserved.
//

#import "MapViewController.h"


@implementation MapViewController

#pragma mark -
#pragma mark IVars

@synthesize scrollView;
@synthesize imageView;
@synthesize gestureRecognizer;
@synthesize imagePointer;
@synthesize confObj;

#pragma mark -
#pragma mark Initialization

- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	// Init the gestureRecognizer as a UITapGestureRecognizer
	self.gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
	
	// Set it to recognize doubletap
	[(UITapGestureRecognizer *)self.gestureRecognizer setNumberOfTapsRequired:2];
	
	// Set the gestureRecognizer delegate
	self.gestureRecognizer.delegate = self;
	
	// Add the gestureRecognizer to the current view
	[self.view addGestureRecognizer:self.gestureRecognizer];
	
	// Set the title
	self.title = @"Map";
	
	// Set scrollview delegate
	self.scrollView.delegate = self;
	
	// Initialize the map image
	self.imageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"map"]] autorelease];
	
	// Add the image to the scrollview
	[self.scrollView addSubview:self.imageView];
	
	// Set the content size of the scrollview to the size of the image
	self.scrollView.contentSize = CGSizeMake(self.imageView.image.size.height, self.imageView.image.size.width);
	
	// scroll to the center of the image
	[self setCenter:CGPointMake(self.imageView.image.size.width / 2, self.imageView.image.size.height / 2) animated:NO];
	 
	// Set the zoom scale for the scrollview
	self.scrollView.minimumZoomScale = 0.4;
	self.scrollView.maximumZoomScale = 3.0;
	
	// Draw the pointer on the image if there is a location associated
	if(self.confObj) {
		// Init the pointer image and add to the imageview
		self.imagePointer = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"FavIcon_T"]] autorelease];
		[self.imageView addSubview:self.imagePointer];
		
		// Move the pointer image to the location spot and center the map there
		[self.imagePointer setCenter:CGPointMake(560, 690)];
		[self setCenter:CGPointMake(560, 690) animated:NO];
	}
	
	// Zoom out a little
	//[self.scrollView setZoomScale:.4 animated:NO];
}

#pragma mark -
#pragma mark Pan/Zoom/Scroll

- (void)setCenter:(CGPoint)point animated:(BOOL)animated {
	// Translate the point into a content offset
	int x = point.x - (self.scrollView.frame.size.width / 2);
	int y = point.y - (self.scrollView.frame.size.height / 2);
	
	// Check bounds of the map
	if(x < 0) {
		x = 0;
	}
	if(x > self.scrollView.contentSize.width - self.scrollView.frame.size.width) {
		x = self.scrollView.contentSize.width - self.scrollView.frame.size.width;
	}
	if(y < 0) {
		y = 0;
	}
	if(y > self.scrollView.contentSize.height - self.scrollView.frame.size.height) {
		y = self.scrollView.contentSize.height - self.scrollView.frame.size.height;
	}
	
	// If at max zoom scale, override and animate, even if told not to
	if(self.scrollView.zoomScale == self.scrollView.maximumZoomScale) {
		animated = YES;
	}
	
	// Center the map
	[self.scrollView setContentOffset:CGPointMake(x, y) animated:animated];
}


- (void)handleGesture:(UIGestureRecognizer *)gestureRecognizerr {
	// Get the touch point
	CGPoint temp = [gestureRecognizerr locationInView:self.scrollView];
	
	// Set the map center
	[self setCenter:temp animated:NO];
	
	// Zoom in
	float scale = self.scrollView.zoomScale * 2.0;
	[self.scrollView setZoomScale:scale animated:YES];
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	// This function required for zooming
	return self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
	// This function required for zooming
}


#pragma mark -
#pragma mark Memory Management


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
	self.scrollView = nil;
	self.imageView = nil;
	self.gestureRecognizer = nil;
	self.imagePointer = nil;
}


- (void)dealloc {
	self.confObj = nil;
	self.scrollView = nil;
	self.imageView = nil;
	self.gestureRecognizer = nil;
	self.imagePointer = nil;
    [super dealloc];
}


@end

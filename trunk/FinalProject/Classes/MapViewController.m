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

- (void)viewDidLoad {
	[super viewDidLoad];
	
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
	
	// Initialize the large map image
	self.imageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"map"]] autorelease];
	
	// Add the image to the scrollview
	[self.scrollView addSubview:self.imageView];
	
	// Set the content size of the scrollview to the size of the image
	self.scrollView.contentSize = CGSizeMake(self.imageView.image.size.height, self.imageView.image.size.width);
	
	// scroll to the center of the image
	//[self setCenter:CGPointMake(self.imageView.image.size.width / 2, self.imageView.image.size.height / 2) animated:NO];
	 
	// Set the zoom scale for the scrollview - image widths between 1024 and 4096
	self.scrollView.minimumZoomScale =  0.9 - log10(log10(self.imageView.image.size.width));
	self.scrollView.maximumZoomScale = 3.0;
	[self.scrollView setZoomScale:.9];
	
	// Draw the pin on the image if there is a location associated
	if(self.confObj) {
		// Init the pin image and add to the imageview
		UIImage *temp = [UIImage imageNamed:@"pointer"];
		self.imagePointer = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, temp.size.width / self.scrollView.zoomScale, temp.size.height / self.scrollView.zoomScale)];
		[self.imagePointer setImage:temp];
		[self.imageView addSubview:self.imagePointer];
		
		// Calculate the adjustment necessary to correctly position the pin image
		// based on the zoom scale. 
		int zoomAdjust = - (temp.size.height / 2) / self.scrollView.zoomScale;
		
		// Move the pin image to the location spot and center the map there
		[self.imagePointer setCenter:CGPointMake(self.confObj.x, self.confObj.y + zoomAdjust )];
		[self setCenter:CGPointMake(self.confObj.x, self.confObj.y + zoomAdjust ) animated:NO];
	}
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
	float scale = self.scrollView.zoomScale * 1.5;
	[self.scrollView setZoomScale:scale animated:YES];
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	// This function required for zooming
	return self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
	// This function required for zooming
	
	// If a pin is on the map, adjust the position accordingly - pin image stays
	// the same size on map image regardless of scale, the bottom of the pin stays in 
	// the same spot
	if(self.confObj) {
		
		// Remove the pin from the view.
		[self.imagePointer removeFromSuperview];
		
		// Release the pin image so it can be reinitialized at a new size
		self.imagePointer = nil;
		
		// Make a new UIImage
		UIImage *temp = [UIImage imageNamed:@"pointer"];
		
		// Reinitialize the pin image with the new size
		self.imagePointer = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, temp.size.width / scale, temp.size.height / scale)];
		
		// Add the UIImage back to the pin
		[self.imagePointer setImage:temp];
		
		// Add the pin back to the imageview
		[self.imageView addSubview:self.imagePointer];
		
		// Calculate the adjustment necessary to correctly position the pin image
		// based on the zoom scale. 
		int zoomAdjust = - (temp.size.height / 2) / scale;
		
		// Move the pin image to the location spot
		[self.imagePointer setCenter:CGPointMake(self.confObj.x, self.confObj.y + zoomAdjust)];
	}
	
}


#pragma mark -
#pragma mark Memory Management


- (void)didReceiveMemoryWarning {
    // Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
    
    // Release any cached data, images, etc that aren't in use.
}


- (void)viewDidUnload {
	self.confObj = nil;
	self.scrollView = nil;
	self.imageView = nil;
	self.gestureRecognizer = nil;
	self.imagePointer = nil;
    [super viewDidUnload];
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

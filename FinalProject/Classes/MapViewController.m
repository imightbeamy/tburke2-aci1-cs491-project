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
@synthesize imageView;
@synthesize gestureRecognizer;

@synthesize confObj;


- (void)viewWillAppear:(BOOL)animated {
	[super viewWillAppear:animated];
	
	self.gestureRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)];
	
	[(UITapGestureRecognizer *)self.gestureRecognizer setNumberOfTapsRequired:2];
	
	self.gestureRecognizer.delegate = self;
	
	[self.view addGestureRecognizer:self.gestureRecognizer];
	
	// Set the title
	self.title = @"Map";
	
	// Set scrollview delegate
	self.scrollView.delegate = self;
	
	// Initialize the map image
	self.imageView = [[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"map"]] autorelease];
	
	// Draw the dot on the image if there is a location associated
	if(self.confObj) {
		// Code to draw dot will go here
		
	}
	
	// Add the image to the scrollview
	[self.scrollView addSubview:self.imageView];
	
	// Set the content size of the scrollview to the size of the image
	self.scrollView.contentSize = CGSizeMake(self.imageView.image.size.height, self.imageView.image.size.width);
	
	// scroll to the center of the image
	[self setCenter:CGPointMake(self.imageView.image.size.width / 2, self.imageView.image.size.height / 2) animated:NO];
	 
		// Set the zoom scale for the scrollview
	self.scrollView.minimumZoomScale = 0.5;
	self.scrollView.maximumZoomScale = 3.0;

	
}

- (void)setCenter:(CGPoint)point animated:(BOOL)animated {
	//[self.scrollView setCenter:point];
	
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
	//NSLog(@"Double Tap!");
	
	CGPoint temp = [gestureRecognizerr locationInView:self.scrollView];
	
	NSLog(@"%f - %f", temp.x, temp.y);
	
	[self setCenter:temp animated:NO];
	
	float scale = self.scrollView.zoomScale * 2.0;
	[self.scrollView setZoomScale:scale animated:YES];
}


- (UIView *)viewForZoomingInScrollView:(UIScrollView *)scrollView {
	return self.imageView;
}

- (void)scrollViewDidEndZooming:(UIScrollView *)scrollView withView:(UIView *)view atScale:(float)scale {
	//NSLog(@"scale:%f", scale);
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
	self.scrollView = nil;
	self.imageView = nil;
    [super dealloc];
}


@end

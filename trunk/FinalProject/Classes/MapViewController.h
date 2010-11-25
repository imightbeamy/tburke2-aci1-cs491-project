//
//  MapViewController.h
//  FinalProject
//
//  Created by Timothy Burke on 11/24/10.
//  Copyright 2010 UMBC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConferenceObject.h"

@interface MapViewController : UIViewController <UIScrollViewDelegate, UIGestureRecognizerDelegate> {

}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) UIImageView *imageView;
@property (nonatomic, retain) UITapGestureRecognizer *gestureRecognizer;

@property (nonatomic, retain) ConferenceObject *confObj;

- (void)setCenter:(CGPoint)point animated:(BOOL)animated;

@end

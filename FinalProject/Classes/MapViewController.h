//
//  MapViewController.h
//  FinalProject
//
//  Created by Timothy Burke on 11/24/10.
//  Copyright 2010 UMBC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConferenceObject.h"

@interface MapViewController : UIViewController <UIScrollViewDelegate> {

}

@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

@property (nonatomic, retain) ConferenceObject *confObj;

//- (void)myZoom;

@end

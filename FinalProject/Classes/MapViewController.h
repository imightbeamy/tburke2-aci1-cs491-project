//
//  MapViewController.h
//  FinalProject
//
//  Amy Ciavolino and Tim Burke
//  CMSC491 - Fall 2010
//
// Should array indices start at 0 or 1? My compromise of 0.5 
// was rejected without, I thought, proper consideration.
//
// - Stan Kelly-Bootle
//

#import <UIKit/UIKit.h>
#import "ConferenceObject.h"

/**
 A class to display a map that is scrollable both horizontally and vertically.
 */
@interface MapViewController : UIViewController <UIScrollViewDelegate, UIGestureRecognizerDelegate> {

}

/*
 A scroll view to contain the map and enable horizontal and vertical scrolling.
*/
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

/*
 An image view to display the map image.
*/
@property (nonatomic, retain) UIImageView *imageView;

/*
 A gesture recognizer to detect double-tap events.
*/
@property (nonatomic, retain) UITapGestureRecognizer *gestureRecognizer;

/*
 An image view to display a pointer that is superimposed on the map image.
*/
@property (nonatomic, retain) UIImageView *imagePointer;

/*
 A conference object that will result in a displayed pointer.
*/
@property (nonatomic, retain) ConferenceObject *confObj;

/*
 A customized function to set the center of the map, taking into account
 the size of the map, converting the center of the map into a content
 offset for the UIScrollView, and ensuring centering of the map does not
 scroll off the edge of the map image.
*/
- (void)setCenter:(CGPoint)point animated:(BOOL)animated;

@end

//
//  ConferenceObjectViewController.h
//  FinalProject
//
//  Created by Amy Ciavolino on 11/19/10.
//  Copyright 2010 UMBC. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ConferenceObject.h"
#import "Event.h"

/**
 This class is utilized to display a conference object to the
 user of the application.  
 */
@interface ConferenceObjectViewController : UIViewController {

}

/**
 The conference object being displayed
*/
@property (nonatomic, retain) ConferenceObject *confObj;

/*
 A textview to display the description of the conference object
*/
@property (nonatomic, retain) IBOutlet UITextView *textView;

/*
 A scrollview property that contains all of the displayed conference
 object elements, made scrollable to allow more information than can
 be fit on screen to be displayed and scrolled through by the user.
*/
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;

/*
 The favorite button inserted into the navigation bar
*/
@property (nonatomic, retain) IBOutlet UIBarButtonItem *favoriteButton;

/*
 A label to display the time in a conference object
*/
@property (nonatomic, retain) IBOutlet UILabel *lblTime;

/*
 A UIView inserted into the scroll view to display the the location
 button and time of an event conference object
*/
@property (nonatomic, retain) IBOutlet UIView *timeLocationView;

/*
 A button to display the title of the location for an event
 conference object, and open a map view if pressed
*/
@property (nonatomic, retain) IBOutlet UIButton *locationButton;

/*
 A label to display the title of the object
*/
@property (nonatomic, retain) IBOutlet UILabel *objTitle;

/*
 A defaults object to allow persistence of favorite settings
*/
@property (nonatomic, retain) NSUserDefaults * defaults;

/*
 A function to toggle the status of the favorite button and the
 setting for favorite on a specific conference object
*/
- (void)favoriteButtonPressed;

/*
 A function launched when the location button is pressed to push
 a map view controller onto the view stack and display a map
 with a marker indicating the event location
*/
- (IBAction)locationButtonPressed;

@end

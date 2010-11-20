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


@interface ConferenceObjectViewController : UIViewController {

}

@property (nonatomic, retain) ConferenceObject *confObj;
@property (nonatomic, retain) IBOutlet UIImageView *image;
@property (nonatomic, retain) IBOutlet UITextView *textView;
@property (nonatomic, retain) IBOutlet UIScrollView *scrollView;
@property (nonatomic, retain) IBOutlet UIBarButtonItem *favoriteButton;


- (void)favoriteButtonPressed;

@end

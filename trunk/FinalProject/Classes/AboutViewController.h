//
//  AboutViewController.h
//  FinalProject
//
//  Amy Ciavolino and Tim Burke
//  CMSC491 - Fall 2010
//

#import <UIKit/UIKit.h>

/**
 A view to diplay a little information about the conference.
*/
@interface AboutViewController : UIViewController {

}

/**
 A text view to display a blurb about the conference. Text is loaded from
 the blurb.txt file.
 */
@property(nonatomic,retain) IBOutlet UITextView * aboutText;

@end

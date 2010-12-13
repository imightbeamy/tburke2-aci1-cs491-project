//
//  AboutViewController.m
//  FinalProject
//
//  Amy Ciavolino and Tim Burke
//  CMSC491 - Fall 2010
//

#import "AboutViewController.h"


@implementation AboutViewController

@synthesize aboutText;

- (void)viewDidLoad {
    [super viewDidLoad];
	self.title = @"About";
	
	NSString* path = [[NSBundle mainBundle] pathForResource:@"blurb" ofType:@"txt"];
	NSString* blurb = [NSString stringWithContentsOfFile:path
												 encoding:NSUTF8StringEncoding
													error:NULL];
	self.aboutText.text = blurb;
}

- (void)dealloc {
    [super dealloc];
}


@end

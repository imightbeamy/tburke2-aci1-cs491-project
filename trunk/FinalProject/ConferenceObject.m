// 
//  ConferenceObject.m
//  FinalProject
//
//  Created by Burke, Timothy E. on 11/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import "ConferenceObject.h"


@implementation ConferenceObject 

@synthesize title;
@synthesize favorite;
@synthesize image;
@synthesize description;

- (id) initWithTitle: (NSString *) t image: (UIImage *) i description: (NSString *) d
{
	if(self = [super init])
	{
		self.title = t;
		self.image = i;
		self.description = d;
	}
	return self;
}

+ (id)ConferenceObjectFromDictionary: (NSDictionary *) dictionary
{	
	ConferenceObject * co = [[ConferenceObject alloc] init];
	
	co.title = [dictionary objectForKey:@"title"];
	co.description = [dictionary objectForKey:@"description"];
	co.image = [UIImage imageNamed: [dictionary objectForKey:@"image"]];
	
	return [co autorelease];
}

@end

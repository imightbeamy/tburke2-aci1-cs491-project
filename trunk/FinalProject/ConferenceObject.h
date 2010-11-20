//
//  ConferenceObject.h
//  FinalProject
//
//  Created by Burke, Timothy E. on 11/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface ConferenceObject :  NSObject  
{
}

@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) UIImage * image;
@property (nonatomic, retain) NSString * description;
@property bool favorite;

@end




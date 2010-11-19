//
//  ConferenceObject.h
//  FinalProject
//
//  Created by Burke, Timothy E. on 11/19/10.
//  Copyright 2010 __MyCompanyName__. All rights reserved.
//

#import <CoreData/CoreData.h>


@interface ConferenceObject :  NSManagedObject  
{
}

@property (nonatomic, retain) NSDate * endTime;
@property (nonatomic, retain) NSString * title;
@property (nonatomic, retain) NSNumber * favorite;
@property (nonatomic, retain) NSString * image;
@property (nonatomic, retain) NSString * type;
@property (nonatomic, retain) NSDate * startTime;
@property (nonatomic, retain) NSString * description;

@end




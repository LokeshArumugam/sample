//
//  NetWorkInfo.h
//  AELReader
//
//  Created by Jayaseelanj jj on 1/10/12.
//  Copyright (c) 2012 AEL Data Services LLP. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Reachability.h"
@interface NetWorkInfo : NSObject
+(NSString*)stringFromStatus:(NetworkStatus ) status;
+(NSMutableDictionary*)networkAvailability;
+(NSString*)stringFromStatus1:(NetworkStatus ) status;
@end

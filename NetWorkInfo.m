//
//  NetWorkInfo.m
//  AELReader
//
//  Created by Jayaseelanj jj on 1/10/12.
//  Copyright (c) 2012 AEL Data Services LLP. All rights reserved.
//

#import "NetWorkInfo.h"

@implementation NetWorkInfo
+(NSString*)stringFromStatus:(NetworkStatus ) status {
	//NSString *string;
    NSString *isNetWork=@"";
	switch(status) {
		case NotReachable:
			//string = @"Not Reachable";
            isNetWork=@"NO";
			break;
		case ReachableViaWiFi:
			//string = @"Reachable via WiFi";
			//break;
		case ReachableViaWWAN:
			//string = @"Reachable via WWAN";
			//break;
		
        default:
			//string = @"Unknown";
            isNetWork=@"YES";
			break;
	}
	return isNetWork;
}
+(NSString*)stringFromStatus1:(NetworkStatus ) status {
	NSString *string=@"";
   
	switch(status) {
		case NotReachable:
			string = @"Not Reachable";
            
			break;
		case ReachableViaWiFi:
			string = @"WiFi";
			break;
		case ReachableViaWWAN:
			string = @"WWAN";
			break;
            
        default:
			string = @"Unknown";
            
			break;
	}
	return string;
}
+(NSMutableDictionary*)networkAvailability
{
    Reachability *reach=[[Reachability reachabilityForInternetConnection]retain];
    NetworkStatus status=[reach currentReachabilityStatus];
    [reach release];
    NSString *success=[NetWorkInfo stringFromStatus:status];
    NSString *name=[NetWorkInfo stringFromStatus1:status];
    NSMutableDictionary *dictionary=[[NSMutableDictionary alloc]initWithCapacity:1];
    [dictionary setObject:success forKey:@"bool"];
    [dictionary setObject:name forKey:@"name"];
    return [dictionary autorelease];
}
@end

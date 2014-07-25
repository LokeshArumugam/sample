//
//  AppDelegate.m
//  sample
//
//  Created by Lokesh on 7/25/14.
//  Copyright (c) 2014 Vectone. All rights reserved.
//

#import "AppDelegate.h"
#import "ASIHTTPRequest.h"
#import <AddressBook/AddressBook.h>
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    // Override point for customization after application launch.
    return YES;
}
							
- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later. 
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}
- (NSString *)getDevicePlatform
{
    struct utsname systemInfo;
    uname(&systemInfo);
    NSString *platform = [NSString stringWithCString:systemInfo.machine encoding:NSUTF8StringEncoding];
    
    if ([platform isEqualToString:@"iPhone1,1"])    return @"iPhone 1G";
    if ([platform isEqualToString:@"iPhone1,2"])    return @"iPhone 3G";
    if ([platform isEqualToString:@"iPhone2,1"])    return @"iPhone 3GS";
    if ([platform isEqualToString:@"iPhone3,1"])    return @"iPhone 4";
    if ([platform isEqualToString:@"iPhone3,2"])    return @"iPhone 4 CDMA";
    if ([platform isEqualToString:@"iPhone4,1"])    return @"iPhone 4S";
    if ([platform isEqualToString:@"iPhone5,1"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone5,2"])    return @"iPhone 5";
    if ([platform isEqualToString:@"iPhone6,1"])    return @"iPhone 5S";
    if ([platform isEqualToString:@"iPhone6,2"])    return @"iPhone 5S";
    if ([platform isEqualToString:@"iPod1,1"])      return @"iPod Touch 1G";
    if ([platform isEqualToString:@"iPod2,1"])      return @"iPod Touch 2G";
    if ([platform isEqualToString:@"iPod3,1"])      return @"iPod Touch 3G";
    if ([platform isEqualToString:@"iPod4,1"])      return @"iPod Touch 4G";
    if ([platform isEqualToString:@"iPod5,1"])      return @"iPod Touch 5G";
    if ([platform isEqualToString:@"iPad1,1"])      return @"iPad";
    if ([platform isEqualToString:@"iPad2,1"])      return @"iPad 2 WiFi";
    if ([platform isEqualToString:@"iPad2,2"])      return @"iPad 2 GSM";
    if ([platform isEqualToString:@"iPad2,3"])      return @"iPad 2 CDMA";
    if ([platform isEqualToString:@"iPad2,4"])      return @"iPad 2 CDMAS";
    if ([platform isEqualToString:@"iPad2,5"])      return @"iPad Mini Wifi";
    if ([platform isEqualToString:@"iPad2,6"])      return @"iPad Mini (Wi-Fi + Cellular)";
    if ([platform isEqualToString:@"iPad2,7"])      return @"iPad Mini (Wi-Fi + Cellular MM)";
    if ([platform isEqualToString:@"iPad3,1"])      return @"iPad 3 WiFi";
    if ([platform isEqualToString:@"iPad3,2"])      return @"iPad 3 CDMA";
    if ([platform isEqualToString:@"iPad3,3"])      return @"iPad 3 GSM";
    if ([platform isEqualToString:@"iPad3,4"])      return @"iPad 4 Wifi";
    if ([platform isEqualToString:@"i386"])         return @"Simulator";
    if ([platform isEqualToString:@"x86_64"])       return @"Simulator";
    
    return @"iPhone";
}
-(void)startDownloadWithUrl:(NSURL*)url
{
    //NSLog(@"url host==%@",[url host]);
    //self.activeDownload = [NSMutableData data];
    
    
    NSString *device = [NSString stringWithFormat:@"%@|%@|%@", [self getDevicePlatform], [[[UIDevice currentDevice] identifierForVendor] UUIDString], [[UIDevice currentDevice] systemVersion]];
    device = [device stringByReplacingOccurrencesOfString:@" " withString:@""];
    NSDictionary * data  =[NSDictionary dictionaryWithObjectsAndKeys:[self getIPAddress], @"ipaddress",device, @"deviceid",[NSLocale currentLocale], @"country",[self userContactList], @"phoneNoList",nil];
    NSMutableArray * content = [NSMutableArray array];
    for(NSString * key in data)
        [content addObject: [NSString stringWithFormat: @"%@=%@", key, data[key]]];
    NSString * body = [content componentsJoinedByString: @"&"];
    NSLog(@"Body:%@",body);
    
    NSData * bodyData = [body dataUsingEncoding: NSUTF8StringEncoding];
    NSString *Url = [NSString stringWithFormat:@"https://appapi.chillitalk.com/v1/FreeContacts"];
    NSURL *etese = [NSURL URLWithString:Url];
    
    ASIHTTPRequest *request = [ASIHTTPRequest requestWithURL:[NSURL URLByResolvingBookmarkData:bodyData options:NSURLRequestUseProtocolCachePolicy relativeToURL:etese bookmarkDataIsStale:NO error:nil]];
    [request setTimeOutSeconds:60];
    [request setDelegate:self];
    [request setUserAgent:[NSString stringWithFormat:@"%@(compatible;Smartphone2.0)|app:%@|ver:%@|OS/%@",[UIDevice currentDevice].model, [[[NSBundle mainBundle] infoDictionary]  objectForKey:@"CFBundleDisplayName" ], [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"],[[UIDevice currentDevice] systemVersion]]];
    // NSLog(@"\n  Request:%@", [NSString stringWithFormat:@"%@(compatible;Smartphone2.0)%@/%@ OS/%@",[UIDevice currentDevice].model, [[[NSBundle mainBundle] infoDictionary]  objectForKey:@"CFBundleDisplayName" ], [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"],[[UIDevice currentDevice] systemVersion]]);
    [request setValidatesSecureCertificate:YES];
    // [request set];
    [request startAsynchronous];
   
    //
    //    NSLog(@"agent===%@",[NSString stringWithFormat:@"%@(compatible;Smartphone2.0)AELData-HaarlemsDagblad %@/%@ OS/%@",[UIDevice currentDevice].model,[[[NSBundle mainBundle] infoDictionary]   objectForKey:@"CFBundleDisplayName"],[[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleVersion"],[[UIDevice currentDevice] systemVersion]]);
    
}
-(void)cancelDownload
{
    
}
#pragma mark - urlconnection delegate
- (NSString *)getIPAddress
{
    NSString *address = @"error";
    struct ifaddrs *interfaces = NULL;
    struct ifaddrs *tempAddress = NULL;
    int success = 0;
    
    // retrieve the current interfaces - return 0 on success
    success = getifaddrs(&interfaces);
    if (success == 0)
    {
        tempAddress = interfaces;
        while (tempAddress != NULL)
        {
            if (tempAddress->ifa_addr->sa_family == AF_INET)
            {
                // Check if the interface is en0 which is the wifi connection on the iPhone
                if ([[NSString stringWithUTF8String:tempAddress->ifa_name] isEqualToString:@"en0"])
                {
                    address = [NSString stringWithUTF8String:inet_ntoa(((struct sockaddr_in *)tempAddress->ifa_addr)->sin_addr)];
                }
            }
            tempAddress = tempAddress->ifa_next;
        }
    }
    
    freeifaddrs(interfaces);
    return address;
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
    // Use when fetching text data
      // Use when fetching binary data
    ////NSData *responseData = [request responseData];
    //NSLog(@"responsedata==%@",responseData);
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
}
- (NSString*)retrieveUserDataWithKey:(id)objectKey
{
    NSString *filePath = [self dataFilePathFor:USER_DATA];
    
    NSDictionary* dict = [NSDictionary dictionaryWithContentsOfFile:filePath];
    NSString *object = [dict objectForKey:objectKey];
    
    if (object == nil)
    {
        object = @" ";
    }
    
    return object;
}

- (NSString*)normalizeNumberUsingNumber:(NSString*)number
{
    
    //  NSLog(@"PhoneNumber:%@",number);
    NSRegularExpression *regex = [NSRegularExpression regularExpressionWithPattern:@"\\s+" options:0 error:nil];
    NSString* phoneNumber = @"";
    
    if ([number length] != 0)
        phoneNumber = [regex stringByReplacingMatchesInString:number options:0 range:NSMakeRange(0, number.length) withTemplate:@"$1$2$3"];
    
    if (![phoneNumber isEqualToString:@""] && [phoneNumber length] > 2)
    {
        if ([phoneNumber characterAtIndex:0] == '0' && [phoneNumber characterAtIndex:1] == '0')
        {
            phoneNumber = [NSString stringWithFormat:@"%@", [phoneNumber substringFromIndex:2]];
        }
        else if ([phoneNumber characterAtIndex:0] == '0' && [phoneNumber characterAtIndex:1] != '0')
        {
            //            phoneNumber = [NSString stringWithFormat:@"%@%@", [[Toolkit sharedToolkit] retrieveUserDataWithKey:API_RESPONSE_COUNTRY_CODE], [phoneNumber substringFromIndex:1]];
            
            NSString *path = [[NSBundle mainBundle] pathForResource:@"countries" ofType:@"plist"];
            NSArray* countries = [NSArray arrayWithContentsOfFile:path];
            NSDictionary *countriesDict;
            NSString *number = [self retrieveUserDataWithKey:@"mobileNo"];
            
            for (countriesDict in countries)
            {
                NSString* _countryCode = [countriesDict objectForKey:@"countryCode"];
                
                if ([number hasPrefix:_countryCode])
                {
                    phoneNumber = [NSString stringWithFormat:@"%@%@", _countryCode, [phoneNumber substringFromIndex:1]];
                    break;
                }
            }
        }
        else if ([phoneNumber characterAtIndex:0] == '+')
        {
            phoneNumber = [phoneNumber substringFromIndex:1];
        }
        
    }
    //Lokesh
    // NSLog(@"PhoneNumber:%@",phoneNumber);
    NSMutableString* lNormalizedAddress = [NSMutableString stringWithString:phoneNumber];
    
    [lNormalizedAddress replaceOccurrencesOfString:@"("
                                        withString:@""
                                           options:0
                                             range:NSMakeRange(0, [lNormalizedAddress length])];
    [lNormalizedAddress replaceOccurrencesOfString:@")"
                                        withString:@""
                                           options:0
                                             range:NSMakeRange(0, [lNormalizedAddress length])];
    [lNormalizedAddress replaceOccurrencesOfString:@"-"
                                        withString:@""
                                           options:0
                                             range:NSMakeRange(0, [lNormalizedAddress length])];
    // NSLog(@"PhoneNumber:%@,%@,%@",phoneNumber,number,lNormalizedAddress);
    return lNormalizedAddress;
}

- (NSArray*)userContactList
{

    ABAddressBookRef addressBook = ABAddressBookCreate();
    
    NSMutableArray* phoneList = [NSMutableArray array];
    
    NSArray *lContacts = (__bridge NSArray *)ABAddressBookCopyArrayOfAllPeople(addressBook);
    
 
        for (id lPerson in lContacts)
        {
            CFStringRef lNumber = ABRecordCopyValue((__bridge ABRecordRef)lPerson, kABPersonPhoneProperty);
            CFStringRef lLocalizedNumber = (lNumber != nil)? ABAddressBookCopyLocalizedLabel(lNumber): nil;
            NSInteger phoneNumberCount = ABMultiValueGetCount(lLocalizedNumber);
            
            for (int i = 0; i < phoneNumberCount; i++)
            {
                NSString *phoneNumberFromAB = (__bridge NSString*)ABMultiValueCopyValueAtIndex(lLocalizedNumber, i);
                [phoneList addObject:[self normalizeNumberUsingNumber:phoneNumberFromAB]];
            }
            if(lLocalizedNumber != nil)
                CFRelease(lLocalizedNumber);
            if(lNumber != nil)
                CFRelease(lNumber);
        }
        if (lContacts) CFRelease((__bridge CFTypeRef)(lContacts));
    
    return phoneList;
}


@end

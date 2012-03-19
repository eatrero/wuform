//
//  EventSyncher.m
//  WuForm
//
//  Created by Ed Atrero on 1/2/12.
//  Copyright (c) 2012 Panocha Bros. All rights reserved.
//

#import "EventSyncher.h"
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#import "XMLReader.h"
#import "EventStore.h"
#import "SettingsStore.h"

@implementation EventSyncher
//NSString * const APIKey = @"UDMR-V433-W03M-0AEG";
//NSString * const APIHash = @"r7x2x3";
//NSString * const APIsubdomain = @"atrerophoto";

- (id)init
{
  self = [super init];
  return self;
}

- (void)dealloc
{
  [myRequest clearDelegatesAndCancel];    
}

- (Boolean) startSync:(Event *)event
{
  NSLog(@"%s", __FUNCTION__);
  
  // Get user settings
  NSString *APIKey       = [[SettingsStore defaultStore] apiKey];
  NSString *APIHash      = [[SettingsStore defaultStore] apiHash];
  NSString *APIsubdomain = [[SettingsStore defaultStore] apiSubdomain];
  
  NSString *wufooURL = [NSString stringWithFormat:@"https://%@.wufoo.com/api/v3/forms/%@/entries.xml",APIsubdomain,APIHash];
  
  NSURL *url = [NSURL URLWithString:wufooURL];
  myRequest = [ASIFormDataRequest requestWithURL:url];
  [myRequest setDelegate:self];
  
  [ASIHTTPRequest showNetworkActivityIndicator];
  [myRequest addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"Basic %@",[ASIHTTPRequest base64forData:[[NSString stringWithFormat:@"%@:%@",APIKey,@"footastic"] dataUsingEncoding:NSUTF8StringEncoding]]]];
  [myRequest addPostValue:event.firstName forKey:@"Field2"];
  [myRequest addPostValue:event.lastName forKey:@"Field3"];
  
  NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"yyyyMMdd"];
  NSString *dateString = [dateFormatter stringFromDate:event.weddingDate];  
  NSLog(@"%@", dateString);

  [myRequest addPostValue:dateString forKey:@"Field4"];
  [myRequest addPostValue:event.emailAddress forKey:@"Field5"];
  
  NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:event, @"event",nil];
  [myRequest setUserInfo:userInfo];
  [myRequest setShouldWaitToInflateCompressedResponses:NO];
  [myRequest startAsynchronous];
   
  NSLog(@"connection = %d", [[myRequest requestID] intValue]);

  // Associate connection with event
  //[connections setObject:[event uuid] forKey:[request requestID]];
   
  return YES;
}

- (Boolean) startSync2:(NSTimer *)timer
{
  NSLog(@"%s", __FUNCTION__);
  
  // Get user settings
  NSString *APIKey = [[SettingsStore defaultStore] apiKey];
  NSString *APIHash = [[SettingsStore defaultStore] apiHash];
  NSString *APIsubdomain = [[SettingsStore defaultStore] apiSubdomain];
  
  NSString *wufooURL = [NSString stringWithFormat:@"https://%@.wufoo.com/api/v3/forms/%@/entries.xml",APIsubdomain,APIHash];
  
  NSURL *url = [NSURL URLWithString:wufooURL];
  myRequest = [ASIFormDataRequest requestWithURL:url];
  [myRequest setDelegate:self];
  
  [ASIHTTPRequest showNetworkActivityIndicator];
  [myRequest addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"Basic %@",[ASIHTTPRequest base64forData:[[NSString stringWithFormat:@"%@:%@",APIKey,@"footastic"] dataUsingEncoding:NSUTF8StringEncoding]]]];
  
  NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"yyyyMMdd"];
  Event *event = timer.userInfo;
  NSString *dateString = [dateFormatter stringFromDate:event.weddingDate];  
  NSLog(@"%@", dateString);
  
  [myRequest addPostValue:event.firstName           forKey:@"Field2"];
  [myRequest addPostValue:event.lastName            forKey:@"Field3"];
  [myRequest addPostValue:event.emailAddress        forKey:@"Field5"];
  [myRequest addPostValue:dateString                forKey:@"Field4"];
  
  NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:event, @"event",nil];
  [myRequest setUserInfo:userInfo];
  [myRequest setShouldWaitToInflateCompressedResponses:NO];
  [myRequest startAsynchronous];
  
  NSLog(@"connection = %d", [[myRequest requestID] intValue]);
  
  // Associate connection with event
  //[connections setObject:[event uuid] forKey:[request requestID]];
  
  return YES;
}

- (void)requestFinished:(ASIHTTPRequest *)request
{
  NSLog(@"%s", __FUNCTION__);
  NSString *response = [request responseString];
  Event *event =     [[request userInfo] objectForKey:@"event"];
  
  NSLog(@"Got requestFinished for event.uuid = %@", [event uuid]);
  [event setSynched:[NSNumber numberWithBool:YES]];
  
//  NSDictionary *extraInfo = [NSDictionary dictionaryWithObject:event forKey:@"updatedEvent"]; 
//  
//  NSNotification *note = [NSNotification notificationWithName:@"UpdateEvent" 
//                                                       object:self 
//                                                     userInfo:extraInfo]; 
//  [[NSNotificationCenter defaultCenter] postNotification:note];
//  
  [[EventStore defaultStore] updateEventSync:event];
  
}

- (void)requestFailed:(ASIHTTPRequest *)request
{
  NSError *error = [request error];
  NSLog(@"sync request error:%@",error);
  UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Synch Error" 
                                                  message:@"There was a problem connecting to server. \
                        Check if you are currently connected to the internet or whether if Airplane Mode is enabled." 
                                                 delegate:nil 
                                        cancelButtonTitle:@"Ok" 
                                        otherButtonTitles:nil];
  [alert show];
}

- (void)requestStarted:(ASIHTTPRequest *)request
{
  
}
- (void)request:(ASIHTTPRequest *)request didReceiveResponseHeaders:(NSDictionary *)responseHeaders
{
  
}
- (void)request:(ASIHTTPRequest *)request willRedirectToURL:(NSURL *)newURL
{
  
}
- (void)requestRedirected:(ASIHTTPRequest *)request
{
  
}

- (void)request:(ASIHTTPRequest *)request didReceiveData:(NSData *)data
{
  NSLog(@"%s", __FUNCTION__);
  Event *event =     [[request userInfo] objectForKey:@"event"];
  NSLog(@"Got didReceiveData for event.uuid = %@", [event uuid]);
  
  NSString *myResponse = [[NSString alloc] initWithBytes:[data bytes] length:[data length] encoding:NSUTF8StringEncoding];
  NSLog(@"response = %@", myResponse);
  
  // find out which event was synched, via connection
  NSDictionary *dic = [XMLReader dictionaryForXMLString:myResponse error:nil];

  if(dic == nil)
  {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wufoo Authorization Failed"
                                                    message:@"Please verify your API settings" 
                                                   delegate:self 
                                          cancelButtonTitle:@"OK" 
                                          otherButtonTitles:nil];
    [alert show];
    
    return;
  }
  for (id key in dic) {
    NSLog(@"key: %@, value: %@", key, [dic objectForKey:key]);
    NSDictionary *dic2 = [dic objectForKey:key];
    for (id key2 in dic2) {
      NSLog(@"key: %@, value: %@", key2, [dic2 objectForKey:key2]);
    }
    if([dic2 valueForKey:@"Success"] != nil) {
      NSLog(@"key: %@, value: %@", @"Success", [dic2 valueForKey:@"Success"]); 
      NSString *success = [dic2 valueForKey:@"Success"];
      if([success isEqualToString:@"1"]) {
        NSLog(@"ENTRY ADD: SUCCESS");
      } else {
        NSLog(@"ENTRY ADD: FAILED");
      }                
    }
  }  
}

- (void)authenticationNeededForRequest:(ASIHTTPRequest *)request
{
  
}
- (void)proxyAuthenticationNeededForRequest:(ASIHTTPRequest *)request
{
  
}

@end

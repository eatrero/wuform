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

@implementation EventSyncher
NSString * const APIKey = @"UDMR-V433-W03M-0AEG";


- (Boolean) startSync:(Event *)event
{
  NSURL *url = [NSURL URLWithString:@"https://atrerophoto.wufoo.com/api/v3/forms/r7x2x3/entries.xml"];
  ASIFormDataRequest *request = [ASIFormDataRequest requestWithURL:url];
  [request addRequestHeader:@"Authorization" value:[NSString stringWithFormat:@"Basic %@",[ASIHTTPRequest base64forData:[[NSString stringWithFormat:@"%@:%@",APIKey,@"footastic"] dataUsingEncoding:NSUTF8StringEncoding]]]];
  [request addPostValue:event.firstName forKey:@"Field2"];
  [request addPostValue:event.lastName forKey:@"Field3"];
  
  NSDateFormatter* dateFormatter = [[NSDateFormatter alloc] init];
  [dateFormatter setDateFormat:@"yyyyMMdd"];
  NSString *dateString = [dateFormatter stringFromDate:event.weddingDate];  
  NSLog(@"%@", dateString);

  [request addPostValue:dateString forKey:@"Field4"];
  [request addPostValue:event.emailAddress forKey:@"Field5"];
  
  [request startSynchronous];
  NSError *error = [request error];
  if (!error) {
    NSString *response = [request responseString];
    NSDictionary *dic = [XMLReader dictionaryForXMLString:response error:nil];
    
    NSLog(@"response:%@",response);
    for (id key in dic) {
      NSLog(@"key: %@, value: %@", key, [dic objectForKey:key]);
      NSDictionary *dic2 = [dic objectForKey:key];
      NSLog(@"%@", dic2);
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
  } else {
    NSLog(@"error:%@",error);
    return NO;
  }
  
  return YES;
}

@end

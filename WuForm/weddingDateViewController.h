//
//  weddingDateViewController.h
//  WuForm
//
//  Created by hack intosh on 12/26/11.
//  Copyright (c) 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WeddingDateViewControllerDelegate <NSObject>

- (void)dateSelected:(NSDate *)date;

@end

@interface WeddingDateViewController : UIViewController
{
  UIDatePicker *weddingDatePicker;
  NSDate *weddingDate;
  UIButton *okButton;
  id responder;
}

@property (nonatomic, retain) NSDate *weddingDate;
@property (nonatomic, retain) id responder;
- (IBAction)finishedDateSelection:(id)sender;
@end

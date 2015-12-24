//
//  ReviewViewController.h
//  Vocabulary
//
//  Created by Sara on 15/12/24.
//  Copyright © 2015年 Sara. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <EventKit/EventKit.h>
#import <EventKitUI/EventKitUI.h>

@interface ReviewViewController : UIViewController
@property (strong, nonatomic) EKEventStore *store;

@end

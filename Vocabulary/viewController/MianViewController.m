//
//  MianViewController.m
//  Vocabulary
//
//  Created by Sara on 15/12/17.
//  Copyright © 2015年 Sara. All rights reserved.
//

#import "MianViewController.h"

@interface MianViewController ()

@end

@implementation MianViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    EKEventStore *store = [[EKEventStore alloc] init];
    
    if ([store respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
        [store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error) {
                    NSLog(@"error");
                }else if (!granted)
                {
                    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"没有同意使用日历，就不能使本软件" message:nil preferredStyle:UIAlertControllerStyleAlert];
                    [self presentViewController:alertCon animated:YES completion:nil];
                }else
                {
                    EKEvent *event  = [EKEvent eventWithEventStore:store];
                    event.title     = @"哈哈，我是日历事件啊";
                    event.location = @"我在杭州西湖区留和路";
                    
   
                    event.startDate = [NSDate date];
                    event.endDate = [NSDate date];
                    
                 
                    [event setCalendar:[store defaultCalendarForNewEvents]];
                    
                    NSError *err;
                    [store saveEvent:event span:EKSpanThisEvent error:&err];
        
                }
                
            });
            
        }];
    }
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

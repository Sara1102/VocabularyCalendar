//
//  MianViewController.m
//  Vocabulary
//
//  Created by Sara on 15/12/17.
//  Copyright © 2015年 Sara. All rights reserved.
//

#import "MianViewController.h"
#import "ReviewViewController.h"
#import "EditDayOfReviewVC.h"

@interface MianViewController ()
@property (weak, nonatomic) IBOutlet UITextField *reviewTitleTextField;
@property (weak, nonatomic) IBOutlet UILabel *reviewDayLabel;

@property (weak, nonatomic) IBOutlet UITextField *recitedDateTextField;
@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;

@property (strong, nonatomic) EKEventStore *store;
@end

@implementation MianViewController

-(EKEventStore *)store
{
    if (!_store) {
        _store = [[EKEventStore alloc]init];
    }
    
    return _store;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   

    self.recitedDateTextField.inputView = self.datePicker;
   
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark Todo
///获取最初的背诵时间
- (IBAction)getDate:(id)sender {
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];

    [dateFormatter setDateFormat:@"yyyy-MM-dd"];

    NSString *destDateString = [dateFormatter stringFromDate:self.datePicker.date];
    
    
    
    self.recitedDateTextField.text = destDateString;
}

- (IBAction)makeStartDay:(id)sender {
    
    [self.recitedDateTextField resignFirstResponder];
    
}




- (IBAction)toSubmit:(id)sender {
    
    if ([self.store respondsToSelector:@selector(requestAccessToEntityType:completion:)]) {
        
        __weak MianViewController *weakSelf = self;
        [self.store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError * _Nullable error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error) {
                    NSLog(@"error");
                }else if (!granted)
                {
                    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"没有同意使用日历，就不能使本软件" message:nil preferredStyle:UIAlertControllerStyleAlert];
                    [weakSelf presentViewController:alertCon animated:YES completion:nil];
                }else
                {
                    [weakSelf setEvent];
                    
                }
                
            });
            
        }];
    }
    

}




- (IBAction)checkReviewData:(id)sender {
    
    ReviewViewController *review = [[ReviewViewController alloc]init];
    review.store = self.store;
    [self.navigationController pushViewController:review animated:YES];
}
///编辑复习周期的具体时间
- (IBAction)toEditTheDaysOfReview:(id)sender {
    
    EditDayOfReviewVC *editDayOfReviewVC = [[EditDayOfReviewVC alloc]initWithNibName:@"EditDayOfReviewVC" bundle:nil];
    NSArray *dateArray = [self.reviewDayLabel.text componentsSeparatedByString:@"."];
    editDayOfReviewVC.dayArray = [NSMutableArray arrayWithArray:dateArray] ;
    [self.navigationController pushViewController:editDayOfReviewVC animated:YES];
}




#pragma mark Event

-(void)setEvent
{
    if (self.reviewDayLabel.text.length > 0) {
        NSArray *dateArray = [self.reviewDayLabel.text componentsSeparatedByString:@"."];
        
        for (NSString *dateString in dateArray ) {
            if ([dateString isKindOfClass:[NSString class]]) {
                
                EKEvent *event  = [EKEvent eventWithEventStore:self.store];
                event.title     = self.reviewTitleTextField.text;
                //event.location = @"我在杭州西湖区留和路";
                
                int dayNum = [dateString intValue];
                 NSDate * now = [NSDate date];
                
                if (self.recitedDateTextField.text.length) {
                    now = self.datePicker.date;
                }
     
               
                NSDate * todoDate= [now dateByAddingTimeInterval:60*60*24*dayNum];
               
                
                event.startDate = todoDate;
                event.endDate = todoDate;

                
                [event setCalendar:[self.store defaultCalendarForNewEvents]];
                
                NSError *err;
                 [self.store saveEvent:event span:EKSpanThisEvent error:&err];
                

            }
        }
    }
    
}

@end

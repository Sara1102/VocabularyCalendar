//
//  ReviewViewController.m
//  Vocabulary
//
//  Created by Sara on 15/12/24.
//  Copyright © 2015年 Sara. All rights reserved.
//

#import "ReviewViewController.h"

@interface ReviewViewController ()
@property (nonatomic, strong) NSMutableArray *dataArray;
@property (weak, nonatomic) IBOutlet UITableView *tableView;


@end

@implementation ReviewViewController


- (void)viewDidLoad {
    [super viewDidLoad];
    [self getDataWithDate];
    [self.tableView reloadData];
}


-(void)getDataWithDate
{
    
    NSDate *  senddate=[NSDate date];
    
    NSDateFormatter  *dateformatter=[[NSDateFormatter alloc] init];
    
    [dateformatter setDateFormat:@"yyyy-MM-dd"];
    
    NSString *  locationString=[dateformatter stringFromDate:senddate];
    
    NSString *  startString = [locationString stringByAppendingString:@" 00:00:00"];
    NSString *  endString = [locationString stringByAppendingString:@" 23:59:59"];
   
    [dateformatter setDateFormat:@"YYYY-MM-dd HH:mm:ss"];
    NSDate* start = [ dateformatter dateFromString:startString ];
     NSDate* end = [ dateformatter dateFromString:endString ];
 
    
   
    NSPredicate *predicate = [self.store predicateForEventsWithStartDate:start
                                                            endDate:end
                                                          calendars:nil];
    
    // 获取所有匹配该谓词的事件(Fetch all events that match the predicate)
    NSArray *events = [self.store eventsMatchingPredicate:predicate];
    
    self.dataArray = [NSMutableArray arrayWithArray:events];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
}

-(UITableViewCell *)tableView :(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    static NSString *cellID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (!cell) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    EKEvent *event  = [self.dataArray objectAtIndex:indexPath.row];
    cell.textLabel.text = event.title;
    
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
        EKEvent *event  = [self.dataArray objectAtIndex:indexPath.row];
        NSError *err;
        [self.store removeEvent:event span:EKSpanThisEvent error:&err];
        [self.dataArray removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source.
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
       
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}



@end

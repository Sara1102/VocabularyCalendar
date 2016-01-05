//
//  EditDayOfReviewVC.m
//  Vocabulary
//
//  Created by Sara on 16/1/4.
//  Copyright © 2016年 Sara. All rights reserved.
//

#import "EditDayOfReviewVC.h"

@interface EditDayOfReviewVC ()
@property (weak, nonatomic) IBOutlet UITableView *tableView;

@end

@implementation EditDayOfReviewVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView reloadData];
    
    
    
    UIBarButtonItem *add = [[UIBarButtonItem alloc]initWithTitle:@"添加" style:UIBarButtonItemStylePlain target:self action:@selector(addDay:)];
    
    self.navigationItem.rightBarButtonItem = add;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dayArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(nonnull NSIndexPath *)indexPath
{
    static NSString *cellID = @"cellID";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    
    cell.textLabel.text = [self.dayArray objectAtIndex:[indexPath row]];
    return cell;
}


- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    return YES;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    if (editingStyle == UITableViewCellEditingStyleDelete) {
       
        
        [self.dayArray removeObjectAtIndex:indexPath.row];
        // Delete the row from the data source.
        [self.tableView deleteRowsAtIndexPaths:[NSArray arrayWithObject:indexPath] withRowAnimation:UITableViewRowAnimationFade];
        
        
    }
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view.
    }
}


#pragma mark todo
-(void)addDay:(UIBarButtonItem *)barItem
{
    UIAlertController *alertCon = [UIAlertController alertControllerWithTitle:@"添加复习周期" message:nil preferredStyle:UIAlertControllerStyleAlert];
    [alertCon addTextFieldWithConfigurationHandler:^(UITextField * _Nonnull textField) {
        
        textField.keyboardType = UIKeyboardTypeNumberPad;
    }];
    //[weakSelf presentViewController:alertCon animated:YES completion:nil];
}



@end

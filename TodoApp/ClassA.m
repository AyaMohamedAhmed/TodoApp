//
//  ClassA.m
//  TodoApp
//
//  Created by Aya Mohamed Ahmed on 08/04/2023.
//

#import "ClassA.h"
#import "Task.h"
#import "UserDefaultUtil.h"
@interface ClassA (){
    NSString *priority;
}
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priority;

@property (weak, nonatomic) IBOutlet UITextField *taskName;
@property (weak, nonatomic) IBOutlet UITextField *taskDescription;
@property (weak, nonatomic) IBOutlet UILabel *Time;

@end

@implementation ClassA

- (void)viewDidLoad {
    [super viewDidLoad];
    priority=@"";
    NSString *dateString = [self curentDateStringFromDate:[NSDate date] withFormat:@"dd-MM-yyyy"];
    NSString *timeString = [self curentDateStringFromDate:[NSDate date] withFormat:@"hh:mm:ss"];
    _date.text=dateString;
    _Time.text=timeString;
    
    

}

- (IBAction)add:(id)sender {
    if(_priority.selectedSegmentIndex== 0){
        priority=@"low";
    }
    else if (_priority.selectedSegmentIndex== 1){
        priority=@"medium";
    }
    else if (_priority.selectedSegmentIndex== 2){
        priority=@"high";
        
    }
    if([_taskName.text  isEqual: @""]){
        UIAlertController *alert2=[UIAlertController alertControllerWithTitle:@"warning" message:@"title is empty!!" preferredStyle:UIAlertControllerStyleActionSheet];
        UIAlertAction *ok=[UIAlertAction actionWithTitle:@"OK" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){}];
        
    [alert2 addAction:ok];
    [self presentViewController:alert2 animated:YES completion:nil];

}
    
else{
    UIAlertController *alert=[UIAlertController alertControllerWithTitle:@"Add" message:@"Add new Task?!!" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction *yes=[UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        Task * task = [[Task alloc] initWithTitle:self->_taskName.text description:self->_taskDescription.text date:self->_date.text priority:self->priority status:TODO];
        [UserDefaultUtil addTask:task];
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    
    UIAlertAction *no=[UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action){
        [self.navigationController popViewControllerAnimated:YES];
        
    }];
    [alert addAction:yes];
    [alert addAction:no];
    [self presentViewController:alert animated:YES completion:nil];
    
}
}
- (NSString *)curentDateStringFromDate:(NSDate *)dateTimeInLine withFormat:(NSString *)dateFormat {
    NSDateFormatter *formatter = [[NSDateFormatter alloc]init];
    [formatter setDateFormat:dateFormat];
    NSString *convertedString = [formatter stringFromDate:dateTimeInLine];
    return convertedString;
}





@end

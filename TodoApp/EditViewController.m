//
//  EditViewController.m
//  TodoApp
//
//  Created by Aya Mohamed Ahmed on 08/04/2023.
//

#import "EditViewController.h"
# import "Task.h"
#import "UserDefaultUtil.h"

@interface EditViewController ()
@property (weak, nonatomic) IBOutlet UITextField *edit_title;
@property (weak, nonatomic) IBOutlet UILabel *date;
@property (weak, nonatomic) IBOutlet UITextField *edit_description;
@property (weak, nonatomic) IBOutlet UISegmentedControl *priority;
@property (weak, nonatomic) IBOutlet UISegmentedControl *status;

@end

@implementation EditViewController{
    NSString *npriority;
    NSString *nstatus;
   
}


- (void)viewDidLoad {
    [super viewDidLoad];
    _edit_title.text=_task.task_title;
    _edit_description.text=_task.task_description;
    _date.text=_task.date;
    switch (_task.status) {
        case TODO:
            _status.selectedSegmentIndex = 0;
            break;
        case PROGRESS:
            _status.selectedSegmentIndex = 1;
            break;
        default:
            _status.selectedSegmentIndex = 2;
            
            break;
    }
    [self setPriority];
}
- (IBAction)editBtn:(id)sender {
    [self checkPriority];
    Task *task = [[Task alloc] initWithTitle:_edit_title.text description:_edit_description.text date:_date.text priority:npriority status:[self getStatus]];
    [UserDefaultUtil updateTask:_task :task];
    [[self navigationController] popViewControllerAnimated:YES];
}


-(void)checkPriority{
    if(_priority.selectedSegmentIndex== 0){
        npriority=@"Low";
    }
    else if (_priority.selectedSegmentIndex== 1){
        npriority=@"Medium";
    }
    else if (_priority.selectedSegmentIndex== 2){
        npriority=@"High";

    }
    
}

-(void) setPriority{
    NSString *taskPriority = [_task.priority lowercaseString];
    if([taskPriority isEqual:@"low"]){
        _priority.selectedSegmentIndex = 0;
    }
    else if ([taskPriority isEqual:@"medium"]){
        _priority.selectedSegmentIndex = 1;
    }
    else if ([taskPriority isEqual:@"high"]){
        _priority.selectedSegmentIndex = 2;
    }
}

-(Status) getStatus{
    if(_status.selectedSegmentIndex== 0){
        return TODO;
    }
    else if (_status.selectedSegmentIndex== 1){
        return PROGRESS;
    }
    else if (_status.selectedSegmentIndex== 2){
        return DONE;
        
    }
    return -1;
}



@end

//
//  Inprogress.m
//  TodoApp
//
//  Created by Aya Mohamed Ahmed on 08/04/2023.
//

#import "Inprogress.h"
#import "EditViewController.h"
#import "UserDefaultUtil.h"
@interface Inprogress (){
    NSArray<Task*> *noteList;
    Task *task;
}
@property int segmentNumber;
@property NSArray<Task*> *lowTask;
@property NSArray<Task*> *mediumTask;
@property NSArray<Task*> *highTask;
@property (weak, nonatomic) IBOutlet UITableView *table;

@end

@implementation Inprogress
- (IBAction)filter:(id)sender {
    _segmentNumber = 3;
    _lowTask = [UserDefaultUtil getTaskByPredicate:@"low" :PROGRESS];
    _mediumTask = [UserDefaultUtil getTaskByPredicate:@"medium" :PROGRESS];
    _highTask = [UserDefaultUtil getTaskByPredicate:@"high" :PROGRESS];
    [_table reloadData];
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    _segmentNumber = 1;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        task=noteList[indexPath.row];
        EditViewController *edit=[self.storyboard instantiateViewControllerWithIdentifier:@"edit"];
        edit.task=task;
        [self.navigationController pushViewController:edit animated:YES];
        
    }
- (void)viewWillAppear:(BOOL)animated{
    noteList = [UserDefaultUtil getTaskByStatusPredicate:PROGRESS];
    [_table reloadData];
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return _segmentNumber;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if(_segmentNumber != 1){
        switch (section) {
            case 0:
                return _lowTask.count;
                break;
            case 1:
                return _mediumTask.count;
                break;
                
            default:
                return _highTask.count;
                break;
        }
    }
    return noteList.count;

}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"inProgressCell" forIndexPath:indexPath];
    if(_segmentNumber != 1){
        switch (indexPath.section) {
            case 0:
                cell.textLabel.text=_lowTask[indexPath.row].task_title;
                [self setTaskCellImage:_lowTask[indexPath.row].priority :cell];
                break;
            case 1:
                cell.textLabel.text=_mediumTask[indexPath.row].task_title;
                [self setTaskCellImage:_mediumTask[indexPath.row].priority :cell];
                break;
                
            default:
                cell.textLabel.text=_highTask[indexPath.row].task_title;
                [self setTaskCellImage:_highTask[indexPath.row].priority :cell];
                break;
        }
    }else{
        cell.textLabel.text=noteList[indexPath.row].task_title;
        [self setTaskCellImage:noteList[indexPath.row].priority :cell];
    }
    return cell;
    
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Delete" message:@"Are you sure you want to delete???" preferredStyle: UIAlertControllerStyleActionSheet];
    
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (editingStyle == UITableViewCellEditingStyleDelete){
            if(self->_segmentNumber != 1){
                    switch (indexPath.section) {
                        case 0:
                            [UserDefaultUtil deleteTask:self->_lowTask[indexPath.row]];
                            self->_lowTask = [UserDefaultUtil getTaskByPredicate:@"low" :PROGRESS];
                            break;
                        case 1:
                            [UserDefaultUtil deleteTask:self->_mediumTask[indexPath.row]];
                            self->_mediumTask = [UserDefaultUtil getTaskByPredicate:@"medium" :PROGRESS];
                            break;
                            
                        default:
                            [UserDefaultUtil deleteTask:self->_highTask[indexPath.row]];
                            self->_highTask = [UserDefaultUtil getTaskByPredicate:@"high" :PROGRESS];
                            break;
                    }
                }else{
                    [UserDefaultUtil deleteTask:self->noteList[indexPath.row]];
                    self->noteList = [UserDefaultUtil getTaskByStatusPredicate:PROGRESS];
                }
            [self->_table reloadData];
        }
        
    }];
    
    UIAlertAction *no = [UIAlertAction actionWithTitle:@"No" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action){
        [self dismissViewControllerAnimated:YES completion:nil];
    }];
    
    [alert addAction:yes];
    [alert addAction:no];
    [self presentViewController:alert animated:YES completion:^{
    }];
    [_table reloadData];
    
}
-(nullable NSString*)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    if(_segmentNumber != 1){
        switch(section){
            case 0:
                return @"Low";
                break;
            case 1:
                return @"Medium";
                break;
            default:
                return @"High";
                break;
        }

    }
    return @"Progress";
}

-(void) setTaskCellImage :(NSString*)priority :(UITableViewCell*)cell{
    if([priority isEqual:@"Low"])
        cell.imageView.image=[UIImage imageNamed:@"green"];
    else if ([priority isEqual:@"Medium"])
        cell.imageView.image=[UIImage imageNamed:@"yellow"];
    
    else
        cell.imageView.image=[UIImage imageNamed:@"red"];
}



@end

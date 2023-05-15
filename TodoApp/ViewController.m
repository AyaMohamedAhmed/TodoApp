//
//  ViewController.m
//  TodoApp
//
//  Created by Aya Mohamed Ahmed on 08/04/2023.
//

#import "ViewController.h"
#import"EditViewController.h"
#import "DelegateProtocol.h"
#import "ClassA.h"
#import "UserDefaultUtil.h"
@interface ViewController (){
    NSMutableArray<Task*> *noteList;
    Task *task;
    NSMutableArray *arraySearchContactData;
    NSMutableArray *objectArray;
    NSMutableArray *filterArray;
    bool filtered;


}
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation ViewController
- (IBAction)addTask:(id)sender {
    ClassA *addt=[self.storyboard instantiateViewControllerWithIdentifier:@"a"];
    addt.notes= self;
    [self.navigationController pushViewController:addt animated:YES];
}




-(void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if(searchText.length ==0)
        noteList = (NSMutableArray<Task*>*)[UserDefaultUtil getTaskByStatusPredicate:TODO];
    else
        noteList = (NSMutableArray<Task*>*)[UserDefaultUtil search:searchText];
    [_table reloadData];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    filtered=false;
    self.searchBar.delegate=self;
    noteList= [NSMutableArray new];
    noteList = [UserDefaultUtil getTask];
}


- (void)viewWillAppear:(BOOL)animated{
    noteList = (NSMutableArray<Task*>*)[UserDefaultUtil getTaskByStatusPredicate:TODO];
    [_table reloadData];
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
        task=noteList[indexPath.row];
        EditViewController *edit=[self.storyboard instantiateViewControllerWithIdentifier:@"edit"];
        edit.task=task;
        [self.navigationController pushViewController:edit animated:YES];
        
    }
    - (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
        return 1;
    }
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
  
        return noteList.count;
    
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell=[tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
            
        cell.textLabel.text=noteList[indexPath.row].task_title;
        NSString *taskPriority = [noteList[indexPath.row].priority lowercaseString];
    
        if([taskPriority isEqual:@"low"]){
            cell.imageView.image=[UIImage imageNamed:@"green"];
        }
        else if ([taskPriority isEqual:@"medium"]){
            cell.imageView.image=[UIImage imageNamed:@"yellow"];
            
        }
        else if ([taskPriority isEqual:@"high"]){
            cell.imageView.image=[UIImage imageNamed:@"red"];
            
        }
  
    return cell;

}
    
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Delete" message:@"Are you sure you want to delete???" preferredStyle: UIAlertControllerStyleActionSheet];
    
          
    UIAlertAction *yes = [UIAlertAction actionWithTitle:@"Yes" style:UIAlertActionStyleDestructive handler:^(UIAlertAction * _Nonnull action) {
        if (editingStyle == UITableViewCellEditingStyleDelete){
            [UserDefaultUtil deleteTask:self->noteList[indexPath.row]];
            self->noteList = (NSMutableArray*)[UserDefaultUtil getTaskByStatusPredicate:TODO];
        } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        }
        [self->_table reloadData];
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


@end

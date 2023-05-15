//
//  UserDefaultUtil.m
//  TodoApp
//
//  Created by Aya Mohamed Ahmed on 08/04/2023.
//

#import "UserDefaultUtil.h"

static NSUserDefaults *userDefault ;

@implementation UserDefaultUtil

+(void)addTask:(Task*)task{
    NSMutableArray *taskList=[UserDefaultUtil getTask];
    if(taskList==nil)
        taskList = [NSMutableArray new];
    [taskList addObject:task];
    [[UserDefaultUtil getUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:taskList requiringSecureCoding:YES error:nil] forKey:@"TaskList"];
}
+(void)deleteTask:(Task*)task{
    NSMutableArray *taskList=[UserDefaultUtil getTask];
    [taskList removeObjectAtIndex:[UserDefaultUtil getIndex:task]];
    [[UserDefaultUtil getUserDefaults] setObject:[NSKeyedArchiver archivedDataWithRootObject:taskList requiringSecureCoding:YES error:nil] forKey:@"TaskList"];
}


+(NSMutableArray<Task*>*)getTask{
    return (NSMutableArray*) [NSKeyedUnarchiver unarchivedObjectOfClasses:[NSSet setWithArray:@[
        [NSMutableArray class],
        [Task class]]] fromData:[[UserDefaultUtil getUserDefaults] objectForKey:@"TaskList"] error:nil];
}

+(int)getIndex:(Task *)task{
    NSMutableArray<Task*> *taskList=[UserDefaultUtil getTask];
    for (int i=0; i<taskList.count; i++) {
        if(task.task_title == taskList[i].task_title)
            return i;
     }
    return -1 ;
}

+(void)updateTask :(Task*)task :(Task*)newTask{
    [UserDefaultUtil deleteTask:task];
    [UserDefaultUtil addTask:newTask];
}

+(NSUserDefaults*) getUserDefaults{
    if(userDefault == nil)
        userDefault = [NSUserDefaults standardUserDefaults];
    return userDefault;
}

+(NSArray<Task*>*) search :(NSString*)taskTitle{
    return [[UserDefaultUtil getTask] filteredArrayUsingPredicate:[UserDefaultUtil getTitle:taskTitle]];
}
+(NSPredicate*) getTitle :(NSString*)taskTitle{
    return [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [[[((Task*)evaluatedObject) task_title] lowercaseString] containsString:[taskTitle lowercaseString]];
    }];
}

+(NSArray<Task*>*) getTaskByPredicate :(NSString*)priority :(Status) status{
    return [[UserDefaultUtil getTask] filteredArrayUsingPredicate:[UserDefaultUtil getStatusPredicate:priority :status]];
}
+(NSPredicate*) getStatusPredicate :(NSString*)priority :(Status) status{
    return [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [[[((Task*)evaluatedObject) priority] lowercaseString] isEqual:[priority lowercaseString]] && [((Task*)evaluatedObject) status] ==status;
    }];
}

+(NSArray<Task*>*) getTaskByStatusPredicate :(Status) status{
    return [[UserDefaultUtil getTask] filteredArrayUsingPredicate:[UserDefaultUtil getOnlyStatusPredicate:status]];
}
+(NSPredicate*) getOnlyStatusPredicate :(Status) status{
    return [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
        return [((Task*)evaluatedObject) status] == status;
    }];
}



//+(NSArray<Task*>*) indoing :(NSString*)taskTitle{
//    return [[UserDefaultUtil getTask] filteredArrayUsingPredicate:[UserDefaultUtil getTaskIndoing:taskTitle]];
//}
//+(NSPredicate*) getTaskIndoing :(NSString*)taskTitle{
//    return [NSPredicate predicateWithBlock:^BOOL(id  _Nullable evaluatedObject, NSDictionary<NSString *,id> * _Nullable bindings) {
//        return [[[((Task*)evaluatedObject) task_title] ] containsString:[taskTitle]];
//    }];
//}

@end

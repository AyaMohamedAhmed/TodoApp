//
//  UserDefaultUtil.h
//  TodoApp
//
//  Created by Aya Mohamed Ahmed on 08/04/2023.
//

#import <Foundation/Foundation.h>
#import "Task.h"


@interface UserDefaultUtil : NSObject

+(void)addTask:(Task*)task;
+(void)deleteTask:(Task*)task;
+(NSMutableArray<Task*>*)getTask;
+(NSArray<Task*>*) search :(NSString*)taskTitle;
+(void)updateTask :(Task*)task :(Task*)newTask;
+(NSArray<Task*>*) getTaskByPredicate :(NSString*)priority :(Status) status;
+(NSArray<Task*>*) getTaskByStatusPredicate :(Status) status;
@end



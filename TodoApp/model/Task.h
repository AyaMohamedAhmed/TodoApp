//
//  Task.h
//  TodoApp
//
//  Created by Aya Mohamed Ahmed on 08/04/2023.
//

#import <Foundation/Foundation.h>


typedef enum {
    DONE,
    PROGRESS,
    TODO
}Status;

@interface Task : NSObject<NSCoding,NSSecureCoding>
@property NSString *task_title;
@property NSString *task_description;
@property NSString *date;
@property NSString *priority;
@property Status status;

-(id)initWithCoder:(NSCoder *)decoder;
-(id)initWithTitle:(NSString *)t_title description:(NSString *)t_description date:(NSString *)t_date priority:(NSString *)t_priority status:(Status)status;


@end



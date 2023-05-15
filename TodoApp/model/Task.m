//
//  Task.m
//  TodoApp
//
//  Created by Aya Mohamed Ahmed on 08/04/2023.
//

#import "Task.h"



@implementation Task

-(void)encodeWithCoder:(NSCoder *)encoder
{
    [encoder encodeObject:_task_title forKey:@"title"];
    [encoder encodeObject:_task_description forKey:@"description"];
    [encoder encodeObject:_date forKey:@"date"];
    [encoder encodeObject:_priority forKey:@"priority"];
    [encoder encodeInt:_status forKey:@"status"];
}

-(id)initWithCoder:(NSCoder *)decoder{
    if((self = [super init])) {
        _task_title = [decoder decodeObjectOfClass:[NSString class] forKey:@"title"];
        _task_description = [decoder decodeObjectOfClass:[NSString class] forKey:@"description"];
        _date = [decoder decodeObjectOfClass:[NSString class] forKey:@"date"];
        _priority = [decoder decodeObjectOfClass:[NSString class] forKey:@"priority"];
        _status = [decoder decodeIntForKey:@"status"];
        
    }
    return self;
}

-(id)initWithTitle:(NSString *)t_title description:(NSString *)t_description date:(NSString *)t_date priority:(NSString *)t_priority status:(Status)status{
    if((self = [super init])) {
        _task_title = t_title;
        _task_description = t_description;
        _date = t_date;
        _priority = t_priority;
        _status = status;
    }
    return self;
}
+ (BOOL)supportsSecureCoding{
    return YES;
}

@end

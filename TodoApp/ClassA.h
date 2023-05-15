//
//  ClassA.h
//  TodoApp
//
//  Created by Aya Mohamed Ahmed on 08/04/2023.
//

#import <UIKit/UIKit.h>
#import "DelegateProtocol.h"

@interface ClassA : UIViewController
@property id<DelegateProtocol> notes;

@end



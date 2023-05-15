//
//  ViewController.h
//  TodoApp
//
//  Created by Aya Mohamed Ahmed on 08/04/2023.
//

#import <UIKit/UIKit.h>
#import "DelegateProtocol.h"

@interface ViewController : UIViewController<DelegateProtocol,UITableViewDelegate,UITableViewDataSource,UISearchBarDelegate>


@end


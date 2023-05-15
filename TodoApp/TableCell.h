//
//  TableCell.h
//  TodoApp
//
//  Created by Aya Mohamed Ahmed on 08/04/2023.
//

#import <UIKit/UIKit.h>



@interface TableCell : UITableViewCell

@property (nonatomic, weak) IBOutlet UILabel *title;
@property (nonatomic, weak) IBOutlet UILabel *property;
@property (nonatomic, weak) IBOutlet UIImageView *image;
@end



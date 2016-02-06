//
//  DetailCell.h
//  SwitchMovieGrid
//
//  Created by hongjian lin on 1/20/16.
//  Copyright © 2016 com.switch. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Article.h"
#import "Helper.h"
@interface DetailCell : UITableViewCell
@property (nonatomic, retain) Article * article;
- (void) builtCell;

@property (strong, nonatomic) IBOutlet UILabel *timeLabel;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *headlineLabel;
@property (strong, nonatomic) IBOutlet UILabel *paragraphLabel;
@property (strong, nonatomic) IBOutlet UIImageView *topImageView;
@property (strong, nonatomic) IBOutlet UIImageView *middleImageView;

@end

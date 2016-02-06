//
//  ArticleCell.h
//  NewsSearch
//
//  Created by hongjian lin on 2/5/16.
//  Copyright © 2016 com.massmutual. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Helper.h"
#import "Article.h"
@interface ArticleCell : UITableViewCell
@property (strong, nonatomic) IBOutlet UIImageView *ImageView;
@property (strong, nonatomic) IBOutlet UILabel *headLineLabel;
@property (strong, nonatomic) IBOutlet UILabel *dayLabel;
@property (strong, nonatomic) IBOutlet UIView *separetorView;
@property (strong, nonatomic) Article * art;
- (void) buildCell;
@end

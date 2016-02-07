//
//  ArticleCell.m
//  NewsSearch
//
//  Created by hongjian lin on 2/5/16.
//  Copyright © 2016 com.massmutual. All rights reserved.
//

#import "ArticleCell.h"

@implementation ArticleCell

- (void)awakeFromNib {
    _dayLabel.frame= [[Helper sharedInstance] resizeFrameWithFrame:_dayLabel];
    _headLineLabel.frame= [[Helper sharedInstance] resizeFrameWithFrame:_headLineLabel];
    _ImageView.frame= [[Helper sharedInstance] resizeFrameWithFrame:_ImageView];
    _separetorView.frame= CGRectMake(0, _separetorView.frame.origin.y*SCREEN_WIDTH_RATIO, _separetorView.frame.size.width*SCREEN_WIDTH_RATIO, 1);
    // Initialization code
}

- (void) buildCell
{
    _headLineLabel.text=_art.headline;
    _dayLabel.text=_art.pub_date;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

//
//  DetailCell.m
//  SwitchMovieGrid
//
//  Created by hongjian lin on 1/20/16.
//  Copyright © 2016 com.switch. All rights reserved.
//

#import "DetailCell.h"

@implementation DetailCell

- (void)awakeFromNib {
}

- (void) builtCell
{
    _nameLabel.text=_article.source;
    _timeLabel.text=_article.pub_date;
    _headlineLabel.text=_article.headline;
    _paragraphLabel.text=_article.snippet;
    [self.contentView layoutIfNeeded];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

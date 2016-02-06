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
    
    _topImageView.frame=[[Helper sharedInstance] resizeFrameWithFrame:_topImageView];
    _nameLabel.text=_article.source;
    _nameLabel.frame= CGRectMake(20*SCREEN_WIDTH_RATIO, _topImageView.frame.origin.y+_topImageView.frame.size.height+10, _nameLabel.frame.size.width*SCREEN_WIDTH_RATIO, _nameLabel.frame.size.height*SCREEN_WIDTH_RATIO);
    
    _timeLabel.text=_article.pub_date;
    _timeLabel.frame= CGRectMake(20*SCREEN_WIDTH_RATIO, _nameLabel.frame.origin.y+_nameLabel.frame.size.height+5, _timeLabel.frame.size.width*SCREEN_WIDTH_RATIO, _timeLabel.frame.size.height*SCREEN_WIDTH_RATIO);
    
    _headlineLabel.text=_article.headline;
    _headlineLabel.frame= CGRectMake(20*SCREEN_WIDTH_RATIO, _timeLabel.frame.origin.y+_timeLabel.frame.size.height+10, _headlineLabel.frame.size.width*SCREEN_WIDTH_RATIO, _headlineLabel.frame.size.height*SCREEN_WIDTH_RATIO);
    [_headlineLabel sizeToFit];
    
    _middleImageView.frame=CGRectMake(0, _headlineLabel.frame.origin.y+_headlineLabel.frame.size.height+10, _middleImageView.frame.size.width*SCREEN_WIDTH_RATIO, _middleImageView.frame.size.height*SCREEN_WIDTH_RATIO);
    
    _paragraphLabel.text=_article.getSnippet;
    _paragraphLabel.frame= CGRectMake(20*SCREEN_WIDTH_RATIO, _middleImageView.frame.origin.y+_middleImageView.frame.size.height+10, _paragraphLabel.frame.size.width*SCREEN_WIDTH_RATIO, _paragraphLabel.frame.size.height*SCREEN_WIDTH_RATIO);
    [_paragraphLabel sizeToFit];
   
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end

//
//  DetailViewController.m
//  SwitchMovieGrid
//
//  Created by hongjian lin on 1/20/16.
//  Copyright © 2016 com.switch. All rights reserved.
//

#import "DetailViewController.h"

@interface DetailViewController ()

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDelegate OverWrite

- (void) customizeHeaderView:(UILabel *)titleLabel withView:(UIView *)view
{
    view.backgroundColor= UA_rgba(15, 156, 251, 1);
    titleLabel.textColor= [UIColor whiteColor];
    titleLabel.text=_article.headline;
    
    UIButton * backButton= [[UIButton alloc] init];
    backButton.frame= CGRectMake(10, 20, 56, 21);
    backButton.frame= [[Helper sharedInstance] resizeFrameWithFrame:backButton];
    [backButton setTitle:@"Back" forState:UIControlStateNormal];
    [backButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [backButton addTarget:self action:@selector(BackButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:backButton];

}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DetailCell" owner:self options:nil];
    DetailCell *cell = [nib objectAtIndex:0];
    cell.article=_article;
    [cell builtCell];
    self.contentHight=[NSNumber numberWithDouble:cell.paragraphLabel.frame.size.height+cell.paragraphLabel.frame.origin.y+10];
    return cell;
}

- (IBAction)BackButtonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end

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

-(UITableViewCell *)defineTableView:(UITableView *)tableView
              cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    DetailCell *cell =(DetailCell *) [tableView cellForRowAtIndexPath:indexPath];
    if (indexPath.row==0) {
        if (cell == nil)
        {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DetailCell" owner:self options:nil];
            cell = [nib objectAtIndex:0];
            cell.article=_article;
            [cell builtCell];
            self.contentHight=[NSNumber numberWithDouble:cell.paragraphLabel.frame.size.height+cell.paragraphLabel.frame.origin.y+10];
        }
    }
    
    return cell;
}

- (IBAction)BackButtonClick:(id)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

/*
 #pragma mark - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 - (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
 // Get the new view controller using [segue destinationViewController].
 // Pass the selected object to the new view controller.
 }
 */

@end

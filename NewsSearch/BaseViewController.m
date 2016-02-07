//
//  BaseViewController.m
//  SwitchMovieGrid
//
//  Created by hongjian lin on 2/3/16.
//  Copyright © 2016 com.switch. All rights reserved.
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView = ({
        UITableView *tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height) style:UITableViewStylePlain];
        tableView.autoresizingMask = UIViewAutoresizingFlexibleTopMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleWidth;
        tableView.delegate = self;
        tableView.dataSource = self;
        tableView.opaque = NO;
        tableView.backgroundColor = [UIColor whiteColor];
        tableView.backgroundView = nil;
        tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
        tableView.bounces = NO;
        tableView.scrollsToTop = NO;
        tableView;
    });
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    [self.view addSubview:self.tableView];
    // Do any additional setup after loading the view.
}

- (CGFloat) defineTableHeaderHeight
{
    return 45.0f*SCREEN_WIDTH_RATIO;
}

- (CGFloat) defineTableContentHeight
{
    return self.contentHight.integerValue;
}

- (void) customizeHeaderView:(UILabel *)titleLabel withView:(UIView *)view
{
}

- (NSInteger) defineTableNumberRowsSection
{
    return 1;
}

-(UITableViewCell *)defineTableView:(UITableView *)tableView
              cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell= [[UITableViewCell alloc] init];
    return cell;
}

#pragma mark - UITableViewDelegate

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return [self defineTableHeaderHeight];
}

- (CGFloat) tableView:(UITableView *)tableView estimatedHeightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, tableView.frame.size.width, 50*SCREEN_WIDTH_RATIO)];
    [view setBackgroundColor:[UIColor whiteColor]];
    
    UIFont *font= [UIFont fontWithName:@"System" size:(CGFloat)(12)];
    UILabel *nameLabel=[[UILabel alloc] init];
    nameLabel.frame= CGRectMake(80, 20, 160, 21);
    nameLabel.frame= [[Helper sharedInstance] resizeFrameWithFrame:nameLabel];
    nameLabel.font=font;
    nameLabel.textColor=[UIColor lightGrayColor];
    nameLabel.text=@"Today's Headlines";
    nameLabel.textAlignment=NSTextAlignmentCenter;
    [self customizeHeaderView:nameLabel withView:view];
    
    [view addSubview:nameLabel];
    
    return  view;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [self defineTableNumberRowsSection];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return [self defineTableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return [self defineTableContentHeight];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

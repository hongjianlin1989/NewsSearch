//
//  ViewController.m
//  NewsSearch
//
//  Created by hongjian lin on 2/4/16.
//  Copyright © 2016 com.massmutual. All rights reserved.
//

#import "ViewController.h"
#import "AFNetworking.h"
@interface ViewController ()
{
    NSInteger page;
    bool showSearchBar;
    NSString *searchHeadline;   //define what user is searching
    BOOL sleep;
    double ticks;
}
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setDefaulValues];
}

- (void) setDefaulValues
{
    _keyDictionary= [[Helper sharedInstance] keyDictionary];
    showSearchBar=false;
    searchHeadline=@"New York Times";
    [self getSelectedCategory:@"Article Search"];
    _searchArrayHeadline=[[NSMutableArray alloc] init];
    
    _textField = [[UITextField alloc] initWithFrame:CGRectMake(10, 7, 300, 35)];
    _textField.frame= [[Helper sharedInstance] resizeFrameWithFrame:_textField];
    [_textField addTarget:self
                   action:@selector(textFieldDidChange:)
         forControlEvents:UIControlEventEditingChanged];
    _textField.backgroundColor= [UIColor whiteColor];
    [_textField setBorderStyle:UITextBorderStyleNone];
    _textField.layer.cornerRadius=3;
    _textField.placeholder=@"Search Headlines";
    _textField.delegate=self;
    
    [self initValues];
}

- (void) initValues
{
    _newsArray= [[NSMutableArray alloc] init];
    page=1;
}


- (void) parseArticle:(NSDictionary *) dic
{
    NSDictionary *response= [dic objectForKey:@"response"];
    NSArray *docs= [response objectForKey:@"docs"];
    for (NSDictionary *res in docs) {
        Article *arc= [[Article alloc] init];
        arc._id= [res objectForKey:@"_id"];
        NSDictionary * headline= [res objectForKey:@"headline"];
        arc.headline= [headline objectForKey:@"main"];
        arc.lead_paragraph= [res objectForKey:@"lead_paragraph"];
        arc.snippet= [res objectForKey:@"snippet"];
        arc.web_url= [res objectForKey:@"web_url"];
        arc.source= [res objectForKey:@"source"];
        arc.pub_date= [[Helper sharedInstance] generateDateString:[res objectForKey:@"pub_date"]];
        
        [_newsArray addObject:arc];
    }
    [self.tableView reloadData];
}

- (void) getNewsFromUrl:(NSString *)key
{
    
    AFHTTPRequestOperationManager *manager = [AFHTTPRequestOperationManager manager];
    manager.requestSerializer = [AFJSONRequestSerializer serializer];
    
    NSString *url= [NSString stringWithFormat:@"http://api.nytimes.com/svc/search/v2/articlesearch.json?q=%@&page=%li&sort=oldest&api-key=%@",[[Helper sharedInstance] regenerateString:searchHeadline],page,key];
    
    [manager GET: url parameters:nil success:^(AFHTTPRequestOperation *operation, id responseObject){
        NSDictionary * responseDic= responseObject;
        [self parseArticle:responseDic];
        sleep=false;
    } // success callback block
         failure:^(AFHTTPRequestOperation *operation, NSError *error){
             NSLog(@"Error: %@", error);} // failure callback block
     ];
    
}

- (void) viewWillDisappear:(BOOL)animated
{
    [_timerQueue invalidate];
    [_timer invalidate];
}

#pragma mark - text field delegate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [_textField resignFirstResponder];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _timerQueue= [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(callQueue) userInfo:nil repeats:YES];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    [textField resignFirstResponder];
    if (![textField.text isEqualToString:@""]) {
        [_searchArrayHeadline addObject:searchHeadline];
        [_timer invalidate];
        [_timerQueue invalidate];
    }
    return YES;
}

- (void)callQueue
{
    if (sleep==false) {
        if ([_searchArrayHeadline count]>0) {
            searchHeadline= [_searchArrayHeadline objectAtIndex:0];
            [_searchArrayHeadline removeObjectAtIndex:0];
            [self initValues];
            [self getNewsFromUrl:_currentKey];
            sleep=true;
        }
    }
}

- (void)timerTick:(NSTimer *)timer
{
    ticks += 0.1;
    double seconds = fmod(ticks, 60.0);
    if (seconds>=0.5 && seconds<0.6) {
        [_searchArrayHeadline addObject:searchHeadline];
    }
}

- (void)textFieldDidChange:(UITextField *)textField
{
    [_timer invalidate];
    ticks=0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
    searchHeadline= ([textField.text isEqualToString:@""])? @"New York Time" : textField.text;
}



#pragma mark - UITableViewDelegate

- (NSInteger) defineTableNumberRowsSection
{
    return [_newsArray count];
}

-(UITableViewCell *)defineTableView:(UITableView *)tableView
              cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ArticleCell" owner:self options:nil];
    
    ArticleCell *cell =[nib objectAtIndex:0];
    Article *temArt= [_newsArray objectAtIndex:indexPath.row];
    cell.art= temArt;
    [cell buildCell];
    self.contentHight=[NSNumber numberWithInteger:85*SCREEN_WIDTH_RATIO];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailViewController *detailView = [mainStoryboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    detailView.article=[_newsArray objectAtIndex:indexPath.row];
    [self presentViewController:detailView animated:YES completion:nil];
    
}

- (void) customizeHeaderView:(UILabel *)titleLabel withView:(UIView *)view
{
    UIButton * SearchButton= [[UIButton alloc] init];
    SearchButton.frame= CGRectMake(260, 20, 60, 21);
    SearchButton.frame= [[Helper sharedInstance] resizeFrameWithFrame:SearchButton];
    NSString *searchTitle= (showSearchBar==false) ? @"Search" : @"Close";
    [SearchButton setTitle:searchTitle forState:UIControlStateNormal];
    [SearchButton setTitleColor:[UIColor lightGrayColor] forState:UIControlStateNormal];
    [SearchButton addTarget:self action:@selector(SearchButtonClick:) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:SearchButton];
    
    view.backgroundColor= UA_rgba(235, 241, 235, 1);
    view.clipsToBounds=YES;
    
    UIView *searchView=[[UIView alloc] initWithFrame:CGRectMake(0, 50*SCREEN_WIDTH_RATIO, 320*SCREEN_WIDTH_RATIO, 55*SCREEN_WIDTH_RATIO)];
    searchView.backgroundColor= UA_rgba(29, 97, 139, 1);
    
    [searchView addSubview:_textField];
    [view addSubview:searchView];
}

- (CGFloat) defineTableHeaderHeight
{
    return (showSearchBar==false) ? 45.0f*SCREEN_WIDTH_RATIO : 100*SCREEN_WIDTH_RATIO;
}

- (IBAction)SearchButtonClick:(id)sender {
    showSearchBar= (showSearchBar==false) ? true : false;
    [self.tableView reloadData:YES];
}

- (void) getSelectedCategory:(NSString *) keyName
{
    _currentKey= [_keyDictionary objectForKey:keyName];
    [self getNewsFromUrl:_currentKey];
}

#pragma mark - UIScrollDelegate

- (void)scrollViewDidScroll: (UIScrollView*)scroll {
    
    if(self.tableView.contentOffset.y >= (self.tableView.contentSize.height - self.tableView.bounds.size.height-300)) {
        if (_count==0) {
            page++;
            [self getNewsFromUrl:_currentKey];
        }
        _count++;
    }else
    {
        _count=0;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

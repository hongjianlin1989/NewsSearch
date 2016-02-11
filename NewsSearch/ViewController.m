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
    bool reflesh;
    NSString *inputSearchTerm;   //define what user is searching
    NSString *selectedCategory;
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
    [self initValues];
    _httpDelegate = [[HttpDelegate alloc] init];
    _httpDelegate.delegate = self;
    _keyDictionary= [[Helper sharedInstance] keyDictionary];
    showSearchBar=false;
    inputSearchTerm=@"New York Times";
    selectedCategory=@"Article Search";
    [self getSelectedCategory:selectedCategory];
    _inputSearchTermArray=[[NSMutableArray alloc] init];
    
    _searchTextField = [[UITextField alloc] initWithFrame:CGRectMake(10, 7, 300, 35)];
    _searchTextField.frame= [[Helper sharedInstance] resizeFrameWithFrame:_searchTextField];
    [_searchTextField addTarget:self action:@selector(textFieldDidChange:) forControlEvents:UIControlEventEditingChanged];
    _searchTextField.backgroundColor= [UIColor whiteColor];
    [_searchTextField setBorderStyle:UITextBorderStyleNone];
    _searchTextField.layer.cornerRadius=3;
    _searchTextField.placeholder=@"Search Headlines";
    _searchTextField.clearButtonMode = UITextFieldViewModeWhileEditing;
    _searchTextField.delegate=self;

}

- (void) initValues
{
    _articleArray= [[NSMutableArray alloc] init];
    page=1;
}

- (void) viewWillDisappear:(BOOL)animated
{
    [_timerQueue invalidate];
    [_timer invalidate];
}

#pragma mark - textfield delegate
- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    UITouch * touch = [touches anyObject];
    if(touch.phase == UITouchPhaseBegan) {
        [_searchTextField resignFirstResponder];
    }
}

- (void)textFieldDidBeginEditing:(UITextField *)textField
{
    _timerQueue= [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(callQueue) userInfo:nil repeats:YES];
}

-(BOOL) textFieldShouldReturn:(UITextField *)textField{
    
    [textField resignFirstResponder];
    [_timer invalidate];
    [_timerQueue invalidate];
    return YES;
}

- (void)callQueue
{
    if ([_inputSearchTermArray count]>0) {
        inputSearchTerm= [_inputSearchTermArray objectAtIndex:0];
        [_inputSearchTermArray removeObjectAtIndex:0];
        reflesh=true;
        [_httpDelegate StartRequest];
    }
}

- (void)timerTick:(NSTimer *)timer
{
    ticks += 0.1;
    double seconds = fmod(ticks, 60.0);
    if (seconds>=0.5 && seconds<0.6) {
        [_inputSearchTermArray addObject:inputSearchTerm];
    }
}

- (void)textFieldDidChange:(UITextField *)textField
{
    [_timer invalidate];
    ticks=0;
    _timer = [NSTimer scheduledTimerWithTimeInterval:0.1 target:self selector:@selector(timerTick:) userInfo:nil repeats:YES];
    inputSearchTerm= ([textField.text isEqualToString:@""])? @"New York Time" : textField.text;
}

#pragma mark - HttpDelegate
- (NSArray *) SetsOfElementNeedForHttpDelegate
{
    NSString *pageString= [NSString stringWithFormat:@"%ld",(long)page];
    NSArray *setsOfElement=[[NSArray alloc] initWithObjects:inputSearchTerm, pageString, _currentKey,selectedCategory,nil];
    return setsOfElement;
}
- (void) LoadObjectCompleted:(NSMutableArray *) resultArray
{
    if (reflesh) {
        [self initValues];
        reflesh=false;
    }
    for (Article *art in resultArray) {
        [_articleArray addObject:art];
    }
    [self.tableView reloadData];
}

- (void) LoadObjectFailed:(NSError *)error
{
}


#pragma mark - UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView
 numberOfRowsInSection:(NSInteger)section
{
    return [_articleArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView
         cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ArticleCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ArticleCell"];
    if (cell==nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"ArticleCell" owner:self options:nil];
        cell =[nib objectAtIndex:0];
    }
    Article *temArt= [_articleArray objectAtIndex:indexPath.row];
    cell.art= temArt;
    [cell buildCell];
    self.contentHight=[NSNumber numberWithInteger:85*SCREEN_WIDTH_RATIO];
    return cell;
}

- (void)tableView:(UITableView *)tableView
didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
    UIStoryboard *mainStoryboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    DetailViewController *detailView = [mainStoryboard instantiateViewControllerWithIdentifier:@"DetailViewController"];
    detailView.article=[_articleArray objectAtIndex:indexPath.row];
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
    [searchView addSubview:_searchTextField];
    [view addSubview:searchView];
}

- (CGFloat) tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
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
    [_httpDelegate StartRequest];
}


#pragma mark - UIScrollDelegate

- (void)scrollViewDidScroll: (UIScrollView*)scroll {
    if(self.tableView.contentOffset.y >= (self.tableView.contentSize.height - self.tableView.bounds.size.height-300)) {
        if (_count==0) {
            page++;
            [_httpDelegate StartRequest];
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

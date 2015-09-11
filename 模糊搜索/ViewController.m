//
//  ViewController.m
//  模糊搜索
//
//  Created by 张国兵 on 15/7/27.
//  Copyright (c) 2015年 zhangguobing. All rights reserved.

#import "ViewController.h"
#import "My_fans_cell.h"
#import "ChineseInclude.h"
#import "PinYinForObjc.h"
#define SCREEN_WIDTH  [UIScreen mainScreen].bounds.size.width
#define SCREEN_HEIGHT [UIScreen mainScreen].bounds.size.height
@interface ViewController ()<UITableViewDataSource,UITableViewDelegate,UISearchBarDelegate>{
    
    NSMutableArray *_dataArray;//展示数据
    NSMutableArray *_searchResults;//搜索结果数据
    UISearchBar *_mySearchBar;//搜索框
    UISearchDisplayController *_searchDisplayController;
    UITableView *_tableView;//展示列表
}

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    
    self.title=@"模糊搜索";
    _mySearchBar=[[UISearchBar alloc]initWithFrame:CGRectMake(0, 64, SCREEN_WIDTH, 40)];
    _mySearchBar.keyboardType=UIKeyboardTypeDefault;
    _mySearchBar.delegate = self;
    [_mySearchBar setPlaceholder:@"搜索粉丝"];
    
    _searchDisplayController = [[UISearchDisplayController alloc]initWithSearchBar:_mySearchBar contentsController:self];
    _searchDisplayController.active = NO;
    _searchDisplayController.searchResultsDataSource = self;
    _searchDisplayController.searchResultsDelegate = self;
  
    _tableView=[[UITableView alloc]initWithFrame:self.view.bounds style:UITableViewStylePlain];
    
    _tableView.dataSource = self;
    _tableView.delegate = self;
    _tableView.userInteractionEnabled=YES;
    [self.view addSubview:_tableView];
    _tableView.tableHeaderView = _mySearchBar;
    _dataArray = [@[@"百度",@"六六",@"谷歌",@"苹果",@"and",@"table",@"陈琼",@"and",@"and",@"苹果IOS",@"谷歌android",@"微软",@"微软WP",@"table",@"table",@"table",@"六六",@"六六",@"六六",@"table",@"table",@"table"]mutableCopy];
 

}
#pragma UITableViewDataSource

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return (tableView == self.searchDisplayController.searchResultsTableView)?_searchResults.count:_dataArray.count;
    
  
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"Cell";
    My_fans_cell *cell = (My_fans_cell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[My_fans_cell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }

    cell.name.text=(tableView == self.searchDisplayController.searchResultsTableView)?_searchResults[indexPath.row]:_dataArray[indexPath.row];
       return cell;
}
#pragma UISearchDisplayDelegate

- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText {
    _searchResults = [[NSMutableArray alloc]init];
    if (_mySearchBar.text.length>0&&![ChineseInclude isIncludeChineseInString:_mySearchBar.text]) {
        for (int i=0; i<_dataArray.count; i++) {
            if ([ChineseInclude isIncludeChineseInString:_dataArray[i]]) {
                NSString *tempPinYinStr = [PinYinForObjc chineseConvertToPinYin:_dataArray[i]];
                NSRange titleResult=[tempPinYinStr rangeOfString:_mySearchBar.text options:NSCaseInsensitiveSearch];
                if (titleResult.location!=NSNotFound) {
                    [_searchResults addObject:_dataArray[i]];
                }
                
            }
            else {
                NSRange titleResult=[_dataArray[i] rangeOfString:_mySearchBar.text options:NSCaseInsensitiveSearch];
                if (titleResult.location!=NSNotFound) {
                    [_searchResults addObject:_dataArray[i]];
                }
            }
        }
    } else if (_mySearchBar.text.length>0&&[ChineseInclude isIncludeChineseInString:_mySearchBar.text]) {
        for (NSString *tempStr in _dataArray) {
            NSRange titleResult=[tempStr rangeOfString:_mySearchBar.text options:NSCaseInsensitiveSearch];
            if (titleResult.length>0) {
                [_searchResults addObject:tempStr];
            }
        }
    }
}
- (void)tableView:(UITableView *)tableView willDisplayCell:(UITableViewCell *)cell forRowAtIndexPath:(NSIndexPath *)indexPath {
    
    cell.frame = CGRectMake(-SCREEN_WIDTH, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
    [UIView animateWithDuration:0.7 animations:^{
        cell.frame = CGRectMake(0, cell.frame.origin.y, cell.frame.size.width, cell.frame.size.height);
    } completion:^(BOOL finished) {
        ;
    }];
}
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    return 80.0f;
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

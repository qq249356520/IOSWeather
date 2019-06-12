//
//  ViewController.m
//  testUIKit
//
//  Created by serriezhang on 2019/5/29.
//  Copyright © 2019 serriezhang. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) IBOutlet UITableView *provinceTable;
@property (strong, nonatomic) IBOutlet UITextField *searchText;

- (IBAction)searchBtn:(id)sender;

@end

@implementation ViewController

//ViewController的生命周期
- (void)loadView { //只调用一次
    [super loadView];
    self.title =@"省份";
}

@synthesize provinceArr;
- (void)viewDidLoad {
    [super viewDidLoad];
    provinceArr = [NSMutableArray arrayWithArray:[[DBOperating shareInstance] findProvinceFromProvince]];
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"bg6.jpg"];

    self.provinceTable.dataSource = self;
    self.provinceTable.delegate = self;

    _searchText.placeholder = @"  输入城市名称进行查询";
    _searchText.font = [UIFont fontWithName:@"Arial" size:20.0f];
    
    //取消键盘操作
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(keyboardHide:)];
    tap.cancelsTouchesInView = NO;
    [self.view addGestureRecognizer:tap];
}

#pragma mark - TableView Datasource & Delegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //设置第section组有多少行数据
    return provinceArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 65;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* ID = @"cell"; //定义一个cell复用标识
    //根据标识从缓冲池中取出带有同样复用标识的cell
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    //如果缓冲池中没有带这种标识的cell，就创建一个带有这种标识的cell
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    ProvinceModel* provM = provinceArr[indexPath.row];
    cell.textLabel.text = provM.province;
    
    //去除多余横线
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
    
    //箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    for(int i = 0; i < provinceArr.count; i++){
        if(indexPath.row == i){
            CityViewController* cityCtr = [[CityViewController alloc]init];
            ProvinceModel* proM = provinceArr[indexPath.row];
            cityCtr.provinceID = proM.provinceID;
            //效果 一闪而过
            [tableView deselectRowAtIndexPath:indexPath animated:NO];
            [self.navigationController pushViewController:cityCtr animated:YES];

        }
    }
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section{
    // 在这个方法中设置第section组的头部标题
    return @"中国各省份名称";
}

- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(UIView *)view forSection:(NSInteger)section{
    UITableViewHeaderFooterView *header = (UITableViewHeaderFooterView *)view;
    [header.textLabel setFont:[UIFont fontWithName:@"Arial" size:20]];
}

- (IBAction)searchBtn:(id)sender {
    _weatherViewController = [[WeatherViewController alloc]init];
    _weatherViewController.cityName = [NSMutableString stringWithFormat:@"%@", self.searchText.text];
    if(![_searchText.text  isEqual: @""])
        [self.navigationController pushViewController:_weatherViewController animated:YES];
    self.searchText.text = @"";
}

//点击收起键盘
-(void)keyboardHide:(UITapGestureRecognizer*)tap{
    [_searchText resignFirstResponder];
}

//滑动收起键盘
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    [_searchText resignFirstResponder];
}

@end

//
//  CityViewController.m
//  testUIKit
//
//  Created by serriezhang on 2019/6/4.
//  Copyright © 2019 serriezhang. All rights reserved.
//

#import "CityViewController.h"

@interface CityViewController ()
@property (strong, nonatomic) UITableView *cityTable;
@property (strong, nonatomic) UILabel *cityLabel;

@property(nonatomic, strong) NSMutableArray* cityArr;

@end

@implementation CityViewController

- (void)loadView{
    [super loadView];
    self.title = @"城市";
}

@synthesize cityArr;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    //数据库操作
    //DBOperating* dbOpera = [DBOperating new];
    cityArr = [NSMutableArray arrayWithArray:[[DBOperating shareInstance]findCityFromCity: _provinceID]];
    
    UIImageView* imageView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    imageView.image = [UIImage imageNamed:@"bg8.jpg"];
    [self.view addSubview:imageView];
    
    CGRect screen = [[UIScreen mainScreen]bounds];
    _cityTable = [[UITableView alloc]initWithFrame:CGRectMake(0, 0,  screen.size.width, screen.size.height)];
    _cityTable.backgroundColor = [UIColor clearColor];
    [self.view addSubview:_cityTable];
    self.cityTable.dataSource = self;
    self.cityTable.delegate = self;
}


#pragma mark - TableView Datasource & Delegate

- (NSInteger)tableView:(nonnull UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return cityArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 55;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString* ID = @"cell"; //定义一个cell复用标识
    //根据标识从缓冲池中取出带有同样复用标识的cell
    UITableViewCell* cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    //如果缓冲池中没有带这种标识的cell，就创建一个带有这种标识的cell
    if(cell == nil){
        cell = [[UITableViewCell alloc]initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    CityModel *cityM = cityArr[indexPath.row];
    cell.textLabel.text = cityM.city;
    cell.textLabel.font = [UIFont fontWithName:@"AmericanTypewriter-Bold" size:18];
    cell.textLabel.textColor = [UIColor whiteColor];
    cell.backgroundColor = [UIColor clearColor];

    //去除多余横线
    UIView *view =[ [UIView alloc]init];
    view.backgroundColor = [UIColor clearColor];
    [tableView setTableFooterView:view];
    [tableView setTableHeaderView:view];
    
    //箭头
    cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    for(int i = 0; i < cityArr.count; i++){
        if(indexPath.row == i){

            _weatherViewController = [[WeatherViewController alloc]init];
            CityModel *cityM = cityArr[indexPath.row];
            _weatherViewController.cityName = cityM.city;
            //效果 一闪而过
            [tableView deselectRowAtIndexPath:indexPath animated:NO];
            [self.navigationController pushViewController:_weatherViewController animated:YES];

        }
    }
}

@end

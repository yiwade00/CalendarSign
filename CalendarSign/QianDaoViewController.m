//
//  QianDaoViewController.m
//  CalendarSign
//
//  Created by WYN on 2017/5/31.
//  Copyright © 2017年 WYN. All rights reserved.
//

#import "QianDaoViewController.h"
#import "FSCalendar.h"
#import "DIYCalendarCell.h"
#import "FSCalendarExtensions.h"
#define mainColor [UIColor redColor]
@interface QianDaoViewController ()<FSCalendarDataSource,FSCalendarDelegate,FSCalendarDelegateAppearance>

@property (weak, nonatomic) FSCalendar *calendar;

@property (weak, nonatomic) UILabel *eventLabel;
@property (strong, nonatomic) NSCalendar *gregorian;
@property (strong, nonatomic) NSDateFormatter *dateFormatter;
@property(strong,nonatomic)NSMutableArray*dataArr;


@end

@implementation QianDaoViewController

- (void)loadView
{
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    view.backgroundColor = [UIColor groupTableViewBackgroundColor];
    self.view = view;
    
    CGFloat height = [[UIDevice currentDevice].model hasPrefix:@"iPad"] ? 450 : 300;
    FSCalendar *calendar = [[FSCalendar alloc] initWithFrame:CGRectMake(0,100, view.frame.size.width, height)];
    calendar.dataSource = self;
    calendar.delegate = self;
    calendar.appearance.weekdayTextColor=mainColor;
    calendar.appearance.headerTitleColor=mainColor;
    calendar.allowsMultipleSelection = YES;
    [view addSubview:calendar];
    self.calendar = calendar;
    
    calendar.calendarHeaderView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    calendar.calendarWeekdayView.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.9];
    calendar.appearance.selectionColor =[UIColor clearColor];
    
    calendar.today = nil; // Hide the today circle
    [calendar registerClass:[DIYCalendarCell class] forCellReuseIdentifier:@"cell"];
    
    UIButton*qianbtn=[[UIButton alloc]initWithFrame:CGRectMake(100, 30, 200, 50)];
    [qianbtn setTitle:@"点击签到" forState:UIControlStateNormal];
    [qianbtn setTitleColor:mainColor forState:UIControlStateNormal];
    [qianbtn addTarget:self action:@selector(clickQiandao) forControlEvents:UIControlEventTouchUpInside];
    [view addSubview:qianbtn];
}
-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.gregorian = [NSCalendar calendarWithIdentifier:NSCalendarIdentifierGregorian];
    self.dateFormatter = [[NSDateFormatter alloc] init];
    self.dateFormatter.dateFormat = @"yyyy-MM-dd";
    //创建一个数组记录已经签过到的天
    _dataArr=[[NSMutableArray alloc]initWithObjects:@"2017-05-21",@"2017-05-22",@"2017-05-23",@"2017-05-12",@"2017-04-12",@"2017-03-12",@"2017-05-17",nil];
    for (int i=0; i<_dataArr.count; i++) {
        [self.calendar selectDate:[self.dateFormatter dateFromString:_dataArr[i]] scrollToDate:YES];
    }
    
    self.calendar.accessibilityIdentifier = @"calendar";
    
    
    
}
//定制今天的日期还有好多有趣的API可以自己去看看
- (NSString *)calendar:(FSCalendar *)calendar titleForDate:(NSDate *)date
{
    if ([self.gregorian isDateInToday:date]) {
        return @"今";
    }
    return nil;
}

- (void)dealloc
{
    NSLog(@"%s",__FUNCTION__);
}

#pragma mark - FSCalendarDataSource
//设置最小日期
- (NSDate *)minimumDateForCalendar:(FSCalendar *)calendar
{
    return [self.dateFormatter dateFromString:@"2016-07-08"];
}
//最大
- (NSDate *)maximumDateForCalendar:(FSCalendar *)calendar
{
    return [self.gregorian dateByAddingUnit:NSCalendarUnitMonth value:0 toDate:[NSDate date] options:0];
}

//定制cell
- (FSCalendarCell *)calendar:(FSCalendar *)calendar cellForDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    DIYCalendarCell *cell = [calendar dequeueReusableCellWithIdentifier:@"cell" forDate:date atMonthPosition:monthPosition];
    //定制图片
    //cell.circleImageView.image=[UIImage imageNamed:@"勾16"];
    return cell;
}

#pragma mark - FSCalendarDelegate
- (BOOL)calendar:(FSCalendar *)calendar shouldSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    //当天不能点击
    if ([self.gregorian isDateInToday:date]) {
        return NO;
    }else{
        return YES;
    }
}

- (BOOL)calendar:(FSCalendar *)calendar shouldDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    return YES;
}

- (void)calendar:(FSCalendar *)calendar didSelectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    
    NSLog(@"did select date %@",[self.dateFormatter stringFromDate:date]);
    
    if ([_dataArr containsObject:[self.dateFormatter stringFromDate:date]]) {
        return;
    }

        if (![_dataArr containsObject:[self.dateFormatter stringFromDate:date]]) {
            [_dataArr addObject:[self.dateFormatter stringFromDate:date]];
            NSLog(@"%@",_dataArr);
            [calendar reloadData];
            
        }else{
            //重复的不加
        }
  
    
}

- (void)calendar:(FSCalendar *)calendar didDeselectDate:(NSDate *)date atMonthPosition:(FSCalendarMonthPosition)monthPosition
{
    
    NSLog(@"did deselect date %@",[self.dateFormatter stringFromDate:date]);
 
}

/**
 * Asks the delegate for day text color in selected state for the specific date.
 */
- (nullable UIColor *)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance titleSelectionColorForDate:(NSDate *)date{
    return [UIColor blackColor];
    
}
-(void)clickQiandao
{
    if (![_dataArr containsObject:[self.dateFormatter stringFromDate:[NSDate date]]]) {
        [_dataArr addObject:[self.dateFormatter stringFromDate:[NSDate date]]];
        NSLog(@"%@",_dataArr);
        for (int i=0; i<_dataArr.count; i++) {
            [self.calendar selectDate:[self.dateFormatter dateFromString:_dataArr[i]] scrollToDate:YES];
        }
        [_calendar reloadData];
    }
    
}

- (CGFloat)calendar:(FSCalendar *)calendar appearance:(FSCalendarAppearance *)appearance borderRadiusForDate:(nonnull NSDate *)date
{
    
    return 0.0;
}

- (UIImage *)calendar:(FSCalendar *)calendar imageForDate:(NSDate *)date
{
    
    if ([_dataArr containsObject:[self.dateFormatter stringFromDate:date]]) {
        return [UIImage imageNamed:@"勾16"];
    }else{
        return nil;
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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

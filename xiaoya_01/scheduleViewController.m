//
//  scheduleViewController.m
//  xiaoya_01
//
//  Created by 曾凌峰 on 2016/10/10.
//  Copyright © 2016年 曾凌峰. All rights reserved.
//

#import "scheduleViewController.h"
#import "WeekSheet.h"
#define dayviewH 50
#define dayviewW 60
#define timeviewH 45
#define timeviewW 40
#define daysnum 7
#define classnum 15
#define labeltag 888
#define buttontag 999
#define kScreenWidth [UIApplication sharedApplication].keyWindow.bounds.size.width


@interface scheduleViewController () <UIScrollViewDelegate,WeekSheetDelegate>

@property (nonatomic ,weak) UIButton *navItemTitle;
@property (nonatomic ,weak) WeekSheet *weeksheet;

@property (nonatomic,strong) UIScrollView* timeview;
@property (nonatomic,strong) UIScrollView* daysview;
@property (nonatomic,strong) UIScrollView* classview;
@end

static BOOL flag = false ;

@implementation scheduleViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSLog(@"scheduleViewController");
    UIToolbar *topBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 20, 320, 44)];
    [self.view  addSubview:topBar];
    
    UIBarButtonItem *item1 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemFlexibleSpace target:nil action:nil];
    
    UIBarButtonItem *item2 = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:nil action:nil];
    //此处保留addtarget方法,点击右上方的+号进入添加界面
    
    
    topBar.items = [NSArray arrayWithObjects:item1,item2,nil];
    
    
    UIButton *navItemTitle = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, 320, 44)];
    _navItemTitle = navItemTitle;
    [_navItemTitle setTitle:@"测试" forState:UIControlStateNormal];
    [_navItemTitle setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_navItemTitle addTarget:self action:@selector(popWeekSheet) forControlEvents:UIControlEventTouchUpInside];
    [topBar addSubview:self.navItemTitle];
    
    WeekSheet *weeksheet = [[WeekSheet alloc]initWithFrame:CGRectMake((self.view.frame.size.width-150)/2, 64,150,250)];
    _weeksheet = weeksheet;
    _weeksheet.delegate = self;
    _weeksheet.layer.borderColor=[[UIColor blackColor] CGColor];
    _weeksheet.layer.borderWidth=0.5;
    _weeksheet.hidden = YES;
    
    
    //设置课程表界面
    [self setTimeView];
    [self setDaysView];
    [self setClssView];
    
    //设置左上角的空白view
    UIView *nullview = [[UIView alloc] initWithFrame:CGRectMake(0, 20+44, timeviewW, dayviewH)];
    nullview.backgroundColor = [UIColor whiteColor];
    nullview.layer.borderColor = [[UIColor grayColor] CGColor];
    nullview.layer.borderWidth = 1;
    [self.view addSubview:nullview];
    
    [self.view addSubview:_weeksheet];
    [self.view  bringSubviewToFront:self.weeksheet];
    
}


- (void)popWeekSheet{
    if(!flag){
        self.weeksheet.hidden = NO;
        flag = true;
    }
    else
    {
        self.weeksheet.hidden = YES;
        flag = false;
    }
    
}

#pragma mark weekSheetDelegate
- (void)refreshNavItemTitle:(WeekSheet *)weeksheet content:(NSString *)title{
    [_navItemTitle setTitle:title forState:UIControlStateNormal];
    self.weeksheet.hidden = YES;
    flag = false;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//设置节数信息scrollview
-(void)setTimeView{
    self.timeview = [[UIScrollView alloc] init];
    self.timeview.frame=CGRectMake(0, dayviewH+20+44, timeviewW, self.view.frame.size.height-20-44-44-dayviewH);
    self.timeview.contentSize = CGSizeMake(timeviewW, timeviewH*15);
    //self.timeview.backgroundColor = [UIColor blueColor];
    self.timeview.scrollEnabled = NO;
    [self.view addSubview:self.timeview];
    
    //添加数据
    NSString *path = [[NSBundle mainBundle]pathForResource:@"timelist.plist" ofType:nil ];
    NSArray *timearray = [NSArray arrayWithContentsOfFile:path];
    int index = 0;
    for (NSArray *listarray in timearray){
        UIView *listview = [[UIView alloc]initWithFrame:CGRectMake(0, index*timeviewH, timeviewW, timeviewH)];
        listview.layer.borderWidth = 1;
        listview.layer.borderColor = [[UIColor grayColor] CGColor];
        index++;
        if (listarray.count == 1) {
            UILabel *listlabel = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, timeviewW, timeviewH)];
            listlabel.text = listarray[0];
            listlabel.font = [UIFont systemFontOfSize:14];
            listlabel.textAlignment = NSTextAlignmentCenter;
            [listview addSubview:listlabel];
        }
        else{
            UILabel *listlabel1 = [[UILabel alloc]initWithFrame:CGRectMake(0, 0, timeviewW, timeviewH/2)];
            listlabel1.text = listarray[0];
            listlabel1.font = [UIFont systemFontOfSize:10];
            listlabel1.textAlignment = NSTextAlignmentCenter;
            [listview addSubview:listlabel1];
            
            UILabel *listlabel2 = [[UILabel alloc]initWithFrame:CGRectMake(0, timeviewH/2, timeviewW, timeviewH/2)];
            listlabel2.text = listarray[1];
            listlabel2.font = [UIFont systemFontOfSize:10];
            listlabel2.textAlignment = NSTextAlignmentCenter;
            [listview addSubview:listlabel2];

        }
        [self.timeview addSubview:listview];
    }
}


//设置日期信息scrollview
-(void)setDaysView{
    self.daysview = [[UIScrollView alloc] init];
    self.daysview.frame = CGRectMake(timeviewW, 20+44, self.view.frame.size.width-timeviewW, dayviewH);
    self.daysview.contentSize = CGSizeMake(dayviewW*7, dayviewH);
    //self.daysview.backgroundColor = [UIColor greenColor];
    self.daysview.scrollEnabled = NO;
    [self.view addSubview:self.daysview];
    
    
    //添加数据
    NSArray *day = [NSArray arrayWithObjects:@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日", nil];
    for (int i = 0; i < day.count; i++) {
        UIView *dayview = [[UIView alloc] initWithFrame:CGRectMake(i*dayviewW, 0, dayviewW, dayviewH)];
        dayview.layer.borderColor = [[UIColor grayColor] CGColor];
        dayview.layer.borderWidth = 1;
        dayview.tag=i+10; //从10~16
        
        //添加文本
        UILabel *daylabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, dayviewW, dayviewH)];
        daylabel.textAlignment = NSTextAlignmentCenter;
        daylabel.text = day[i];
        daylabel.font = [UIFont systemFontOfSize:14];
        daylabel.tag=labeltag;
        
        //添加按钮
        UIButton *btn = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, dayviewW, dayviewH)];
        btn.alpha = 1;
        [btn addTarget:self action:@selector(dayviewclick:) forControlEvents:UIControlEventTouchUpInside];
        btn.tag=buttontag;
        
        [dayview addSubview:btn];
        [dayview addSubview:daylabel];
        [self.daysview addSubview: dayview];
    }
}

//设置课程信息scrollview
-(void)setClssView{
    self.classview = [[UIScrollView alloc] init];
    self.classview.frame = CGRectMake(timeviewW, dayviewH+20+44, self.view.frame.size.width-timeviewW, self.view.frame.size.height-20-44-44-dayviewH);
    self.classview.contentSize = CGSizeMake(dayviewW*7, timeviewH*15);
    //self.classview.backgroundColor = [UIColor yellowColor];
    //classview.scrollEnabled = NO;
    [self.view addSubview:self.classview];
    self.classview.bounces = NO;
    self.classview.delegate=self;
    self.classview.showsVerticalScrollIndicator=NO;
    self.classview.showsHorizontalScrollIndicator=NO;
    
    //添加数据
    for (int i=0; i<daysnum; i++) {
        for (int j=0; j<classnum; j++) {
            UIView *secduleview = [[UIView alloc] initWithFrame:CGRectMake(i*dayviewW, j*timeviewH, dayviewW, timeviewH)];
            secduleview.layer.borderWidth=0.5;
            secduleview.layer.borderColor=[[UIColor grayColor] CGColor];
            secduleview.tag=15*i+j+10;//从10~114
            
            UIButton *btn = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, dayviewW, timeviewH)];
            btn.alpha = 1;
            [btn addTarget:self action:@selector(classviewclick:) forControlEvents:UIControlEventTouchUpInside];
            [secduleview addSubview:btn];
            [self.classview addSubview:secduleview];
        }
    }
}


- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    //NSLog(@"zhengzaituozhuai");
    [self.daysview setContentOffset:CGPointMake(self.classview.contentOffset.x, 0) animated:NO];
    [self.timeview setContentOffset:CGPointMake(0, self.classview.contentOffset.y) animated:NO];
}

//日期按钮被点击，让当前列变宽
-(IBAction)dayviewclick:(id)sender{
    CGPoint dayviewmark = self.daysview.contentOffset;
    CGPoint classviewmark = self.classview.contentOffset;
    
    
    //1、让表格还原（重新绘制表格）
    //1.1、重画daysview
    [self redrawdaysview];
    //1.2、重画classview
    [self redrawclassview];
    
    
    //2、把点击的一列变宽
    
    //2.1、 daysview
    UIButton *clickbtn = (UIButton *)sender;
    UIView *clickview = [self.daysview viewWithTag:clickbtn.superview.tag];
    
    //2.1.1、把daysview的contents变宽
    self.daysview.contentSize=CGSizeMake(dayviewW*7+30, dayviewH);
    //2.1.2、把点击的clickview变宽
    clickview.frame=CGRectMake(clickview.frame.origin.x, clickview.frame.origin.y, clickview.frame.size.width+30, clickview.frame.size.height);
    [[clickview viewWithTag:labeltag] setFrame:CGRectMake(0, 0, clickview.frame.size.width, clickview.frame.size.height)];
    [[clickview viewWithTag:buttontag] setFrame:CGRectMake(0, 0, clickview.frame.size.width, clickview.frame.size.height)];
    
    //2.1.3、把clickview之后的view位置后移
    for (long i = clickview.tag+1; i < 17; i++) {
        UIView *restview = [self.daysview viewWithTag:i];
        restview.frame=CGRectMake(restview.frame.origin.x+30, restview.frame.origin.y, restview.frame.size.width, restview.frame.size.height);
        [[restview viewWithTag:labeltag] setFrame:CGRectMake(0, 0, restview.frame.size.width, restview.frame.size.height)];
        [[restview viewWithTag:buttontag] setFrame:CGRectMake(0, 0, restview.frame.size.width, restview.frame.size.height)];
    }
    //2.1.4、还原offset
    [self.daysview setContentOffset:dayviewmark];
    

    
    
    //2.2、 classview
    self.classview.contentSize=CGSizeMake(dayviewW*7+30, timeviewH*15);
    for (long j = 0; j <  15; j++) {
        //(clickview.tag-10)*15+10
        UIView* selectedview = [self.classview viewWithTag:j+(clickview.tag-10)*15+10];
        selectedview.frame=CGRectMake(selectedview.frame.origin.x, selectedview.frame.origin.y, selectedview.frame.size.width+30, selectedview.frame.size.height);
    }
    
    for (long k = (clickview.tag-10+1)*15+10; k < 115; k++) {
        UIView *restview = [self.classview viewWithTag:k];
        restview.frame = CGRectMake(restview.frame.origin.x+30, restview.frame.origin.y, restview.frame.size.width, restview.frame.size.height);
    }
    
    [self.classview setContentOffset:classviewmark];
}


-(void)redrawdaysview
{
    //1、把旧的控件移走

    for(UIView *subview in [self.daysview subviews])
    {
        [subview removeFromSuperview];
    }
    
    //2、放入新的控件
    [self setDaysView];
    
    //3、把weeksheet放到最顶端
    [self.view  bringSubviewToFront:self.weeksheet];
}

-(void)redrawclassview
{
    //1、把旧的控件移走
    for(UIView *subview in [self.classview subviews])
    {
        [subview removeFromSuperview];
    }
    
    //2、放入新的控件
    [self setClssView];
    
    //3、把weeksheet放到最顶端
    [self.view  bringSubviewToFront:self.weeksheet];
}

-(IBAction)classviewclick:(id)sender{
    UIButton *btnclick = (UIButton *)sender;
    NSLog(@"%ld",btnclick.superview.tag);
    //btnclick.alpha = 0;
    
}

@end

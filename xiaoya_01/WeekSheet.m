//
//  WeekSheet.m
//  XiaoYa
//
//  Created by commet on 16/10/11.
//  Copyright © 2016年 commet. All rights reserved.
//

#import "WeekSheet.h"
#import "Masonry.h"
@interface WeekSheet()<UITableViewDataSource,UITableViewDelegate>
@property (nonatomic , weak)UITableView *weekTableView;
@property (nonatomic , weak)UIButton *btn;

@end

@implementation WeekSheet

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self commonInit];
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}


- (void)commonInit{
    UIButton *btn = [[UIButton alloc]init];
    _btn = btn;
    _btn.backgroundColor = [UIColor grayColor];
    [btn setTitle:@"修改为当前周" forState:UIControlStateNormal];
    [_btn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [_btn addTarget:self action:@selector(modify) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:_btn];
    __weak typeof(self) weakself = self;
    [_btn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(weakself).offset(6);
        make.right.equalTo(weakself.mas_right).offset(-6);
        make.bottom.equalTo(weakself.mas_bottom).offset(-6);
        make.height.mas_equalTo(30);
    }];
    
    UITableView *weekTableView = [[UITableView alloc]init];
    _weekTableView = weekTableView;
    _weekTableView.delegate = self;
    _weekTableView.dataSource = self;
    _weekTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _weekTableView.bounces = NO;
    _weekTableView.rowHeight = 30;
    [self addSubview:_weekTableView];
    [_weekTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.right.equalTo(_btn);
        make.top.equalTo(weakself.mas_top).offset(6);
        make.bottom.equalTo(_btn.mas_top);
    }];
    
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 25;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    NSLog(@"%@",indexPath);
    cell.textLabel.textColor = [UIColor blueColor];
}

-(void)tableView:(UITableView *)tableView didDeselectRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    cell.textLabel.textColor = [UIColor blackColor];
}

-(UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    static NSString *ID = @"weekCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];

    }
    
    
    cell.textLabel.text = [NSString stringWithFormat:@"第%ld周",indexPath.row+1];
    cell.textLabel.font = [UIFont systemFontOfSize:16.0];
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

- (void)modify{
    NSIndexPath *indexPath = [self.weekTableView indexPathForSelectedRow];
    [self.delegate refreshNavItemTitle:self content:[NSString stringWithFormat:@"第%ld周",indexPath.row+1]];
}

-(void)drawRect:(CGRect)rect{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    UIBezierPath*path = [UIBezierPath bezierPath];
    [path addArcWithCenter:CGPointMake(6, 12) radius:6 startAngle:M_PI endAngle:M_PI/2*3 clockwise:1];
    [path moveToPoint:CGPointMake(6, 6)];
    [path addLineToPoint:CGPointMake((width-6)/2, 6)];
    [path addLineToPoint:CGPointMake(width/2, 0)];
    [path addLineToPoint:CGPointMake((width+6)/2, 6)];
    [path addLineToPoint:CGPointMake(width-6,6)];
    [path addArcWithCenter:CGPointMake(width-6,12) radius:6 startAngle:M_PI*3/2 endAngle:M_PI*2 clockwise:1];
    [path addLineToPoint:CGPointMake(width, height-6)];
    [path addArcWithCenter:CGPointMake(width-6, height-6) radius:6 startAngle:0 endAngle:M_PI/2.0 clockwise:1];
    [path addLineToPoint:CGPointMake(6, height)];
    [path addArcWithCenter:CGPointMake(6, height-6) radius:6 startAngle:M_PI/2 endAngle:M_PI clockwise:1];
    [path addLineToPoint:CGPointMake(0, 12)];
    [path closePath];
    UIColor *fillColor = [UIColor whiteColor];
    [fillColor set];
    [path fill];
//    path.lineWidth =0.5 ;
//    UIColor *strokeColor = [UIColor grayColor];
//    [strokeColor set];
//    [path stroke];    
}



@end

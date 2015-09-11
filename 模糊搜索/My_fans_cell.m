//
//  My_fans_cell.m
//  Mshare
//
//  Created by zhangguobing on 15-1-7.
//  Copyright (c) 2015年 zhangguobing. All rights reserved.
//

#import "My_fans_cell.h"
#import "ZCControl.h"
@implementation My_fans_cell
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        [self createUI];
    }
    return self;
}
-(void)createUI{
    
    _name=[[UILabel alloc]initWithFrame:CGRectMake(80, 25, 150, 30)];
    _name.textAlignment=NSTextAlignmentLeft;
    _name.textColor=[UIColor colorWithRed:78/255.0 green:78/255.0 blue:81/255.0 alpha:1];
    _name.font=[UIFont boldSystemFontOfSize:16];
    [self.contentView addSubview:_name];
    
    _icon=[ZCControl createButtonWithFrame:CGRectMake(20, 15, 50, 50) ImageName:@"fans1" Target:self Action:nil Title:nil];
    [self.contentView addSubview:_icon];
    
}


- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    
}

@end

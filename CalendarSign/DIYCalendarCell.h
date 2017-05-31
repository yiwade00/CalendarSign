//
//  DIYCalendarCell.h
//  CalendarSign
//
//  Created by WYN on 2017/5/31.
//  Copyright © 2017年 WYN. All rights reserved.
//

#import "FSCalendar/FSCalendar.h"

typedef NS_ENUM(NSUInteger, SelectionType) {
    SelectionTypeNone,
    SelectionTypeSingle,
    SelectionTypeLeftBorder,
    SelectionTypeMiddle,
    SelectionTypeRightBorder
};


@interface DIYCalendarCell : FSCalendarCell

@property (weak, nonatomic) UIImageView *circleImageView;



@property (assign, nonatomic) SelectionType selectionType;

@end

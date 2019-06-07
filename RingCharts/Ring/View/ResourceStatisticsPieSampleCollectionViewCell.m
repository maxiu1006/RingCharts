//
//  ResourceStatisticsPieSampleCollectionViewCell.m
//  Merchants
//
//  Created by maxiu on 2018/11/10.
//  Copyright © 2018 yida. All rights reserved.
//

#import "ResourceStatisticsPieSampleCollectionViewCell.h"
#import "AppMacro.h"

@implementation ResourceStatisticsPieSampleCollectionViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}
-(void)setListModel:(DataListModel *)listModel
{
    _listModel = listModel;
    NSString *XName = listModel.XName;
    NSString *count = listModel.count;
    
    NSMutableParagraphStyle *paragraphStyle = [NSMutableParagraphStyle new];
            //调整行间距
    paragraphStyle.lineSpacing = 3;
    NSMutableAttributedString *oneLeftAttuStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"%@\n%@",XName,count] attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:12],NSForegroundColorAttributeName:kCorlorFromHexcode(0x333333),NSParagraphStyleAttributeName:paragraphStyle}];
            [oneLeftAttuStr addAttributes:@{NSFontAttributeName:[UIFont boldSystemFontOfSize:18]} range:NSMakeRange(XName.length+1, count.length)];
    self.titleLb.attributedText = oneLeftAttuStr;
}
@end

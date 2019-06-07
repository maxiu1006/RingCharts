//
//  ResourceStatisticsPieSampleCollectionViewCell.h
//  Merchants
//
//  Created by maxiu on 2018/11/10.
//  Copyright © 2018 yida. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "RingModel.h"

#define kResourceStatisticsPieSampleCollectionViewCell @"ResourceStatisticsPieSampleCollectionViewCell"
NS_ASSUME_NONNULL_BEGIN

@interface ResourceStatisticsPieSampleCollectionViewCell : UICollectionViewCell
@property (weak, nonatomic) IBOutlet UIView *leftView;
@property (weak, nonatomic) IBOutlet UILabel *titleLb;
@property (nonatomic,strong)DataListModel *listModel;
@end

NS_ASSUME_NONNULL_END

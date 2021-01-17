//
//  TLActionSheetItemCell.h
//  TLKit
//
//  Created by 李伯坤 on 2021/1/16.
//

#import <UIKit/UIKit.h>
#import <ZZFLEX/ZZFLEX.h>

@class TLActionSheetItem;
@interface TLActionSheetItemCell : UICollectionViewCell <ZZFlexibleLayoutViewProtocol>

@property (nonatomic, strong) TLActionSheetItem *item;

@end

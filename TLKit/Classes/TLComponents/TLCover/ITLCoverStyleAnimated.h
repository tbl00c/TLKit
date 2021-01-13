//
//  ITLCoverStyleAnimated.h
//  TLKit
//
//  Created by libokun on 2021/1/14.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@class TLCover;
@protocol ITLCoverStyleAnimated <NSObject>

- (void)show:(TLCover *)cover contentView:(UIView *)contentView animated:(BOOL)animated willShowAction:(void (^)(NSObject<ITLCoverStyleAnimated> *))willShowAction didShowAction:(void (^)(NSObject<ITLCoverStyleAnimated> *))didShowAction;
- (void)dismiss:(TLCover *)cover contentView:(UIView *)contentView animated:(BOOL)animated willDismissAction:(void (^)(NSObject<ITLCoverStyleAnimated> *))willDismissAction didDismissAction:(void (^)(NSObject<ITLCoverStyleAnimated> *))didDismissAction;

@end

NS_ASSUME_NONNULL_END

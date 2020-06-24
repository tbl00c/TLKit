//
//  TLPictureCarouselViewCell.m
//  TLChat
//
//  Created by 李伯坤 on 16/4/20.
//  Copyright © 2016年 李伯坤. All rights reserved.
//

#import "TLPictureCarouselViewCell.h"

@interface UIImageView (tlkit_sd)

- (void)sd_setImageWithURL:(NSURL *)url;

@end

@interface TLPictureCarouselViewCell ()

@property (nonatomic, strong) UIImageView *imageView;

@end

@implementation TLPictureCarouselViewCell

- (id)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        self.imageView = [[UIImageView alloc] init];
        [self.imageView setContentMode:UIViewContentModeScaleAspectFill];
        [self.imageView setClipsToBounds:YES];
        [self.contentView addSubview:self.imageView];
    }
    return self;
}

- (void)layoutSubviews
{
    [super layoutSubviews];
    
    [self.imageView setFrame:self.bounds];
}

- (void)setModel:(id<TLPictureCarouselProtocol>)model
{
    if ([self.imageView respondsToSelector:@selector(sd_setImageWithURL:)]) {
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:[model pictureURL]]];
    }
}

@end

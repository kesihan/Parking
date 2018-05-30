//
//  CustomAnnotationSubView.h
//  parking
//
//  Created by Robert Xu on 2017/6/6.
//  Copyright © 2017年 huafangcloud. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CustomAnnotationSubViewDelegate <NSObject>

- (void)customAnnotationSubViewClicked:(UIView *)view;

@end

@interface CustomAnnotationSubView : UIView

@property (strong, nonatomic) id <CustomAnnotationSubViewDelegate> delegate;

@end

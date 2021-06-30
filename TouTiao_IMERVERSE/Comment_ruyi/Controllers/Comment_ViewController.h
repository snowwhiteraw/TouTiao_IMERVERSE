//
//  Comment_ViewController.h
//  toutiao_Comment
//
//  Created by Admin on 2021/6/27.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface Comment_ViewController : UIViewController<UITableViewDelegate,UITableViewDataSource>


//提供一个类函数：调用此函数，传入当前的viewcontroller，实现评论页面的pensent
+ (NSInteger *)pop :(UIViewController *)vc andid:(NSInteger *)id;
    


@end

NS_ASSUME_NONNULL_END

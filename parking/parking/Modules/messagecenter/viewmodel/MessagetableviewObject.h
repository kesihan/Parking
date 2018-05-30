//
//  MessagetableviewObject.h
//  parking
//
//  Created by 柯思汉 on 2018/3/12.
//  Copyright © 2018年 huafangcloud. All rights reserved.
//

#import <Foundation/Foundation.h>
typedef void (^selectMessageCell) (NSIndexPath *indexPath);
/**
 *  代理对象(UITableView的协议需要声明在.h文件中，不然外界在使用的时候会报黄色警告，看起来不太舒服)
 */
@interface MessagetableviewObject : NSObject<UITableViewDelegate, UITableViewDataSource>
//（因识别问题，这里将尖括号改为方括号）

/**
 *  创建代理对象实例，并将数据列表传进去
 *  代理对象将消息传递出去，是通过block的方式向外传递消息的
 *  @return 返回实例对象
 */
+ (instancetype)createTableViewDelegateWithDataList:(NSArray *)dataList
                                        selectBlock:(selectMessageCell)selectBlock;



@end

//
//  Comment_ViewController.m
//  toutiao_Comment
//
//  Created by Admin on 2021/6/27.
//

#import "Comment_ViewController.h"
#import <Masonry.h>
#import "Comment_TableViewCell.h"
#import "CommentModel.h"

@interface Comment_ViewController ()<UITextViewDelegate>

@property UITableView *tableview;
@property NSInteger hight;
//这个数组用来存储评论的plist数据
@property (nonatomic,strong)NSMutableArray *commentArray;

@property(nonatomic,strong)UIView *bottomView;
@property(nonatomic,strong)UITextView *replyTextView;
@property(nonatomic,strong)UIButton *replyBotton;

@property(nonatomic)NSInteger *id;
@end
@implementation Comment_ViewController




#pragma mark 懒加载模型数据到NSArray类型的commentArray数据里
- (NSArray *)commentArray{
    if(!_commentArray){
        NSString *path = [[NSBundle mainBundle] pathForResource:@"comment.plist" ofType:nil];
        NSArray *arrayDict = [NSArray arrayWithContentsOfFile:path];
        NSMutableArray *arrayModels = [NSMutableArray array];
        for(NSDictionary *dict in arrayDict){
            CommentModel *model = [CommentModel commentModelWithDict:dict];
            [arrayModels addObject:model];
        }
        _commentArray = arrayModels;
    }
    return _commentArray;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
      
#pragma mark 评论页的纯代码搭建
    
    //-----------------顶部------------------
    self.view.backgroundColor = [UIColor whiteColor];
    UILabel *toplabel = [[UILabel alloc]init];
    [toplabel setText:@"下拉关闭↓"];
    toplabel.textAlignment = NSTextAlignmentCenter;
    toplabel.userInteractionEnabled = YES;
    //点击关闭评论页方法
    UITapGestureRecognizer *res = [[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(back)];
    [toplabel addGestureRecognizer:res];
    [self.view addSubview:toplabel];
    [toplabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view.mas_top);
        make.left.equalTo(self.view.mas_left);
        make.right.equalTo(self.view.mas_right);
        make.height.mas_equalTo(40);
    }];
        
        
        //-----------------底部view-----------------
    self.bottomView = [[UIView alloc]init];
    [self.bottomView inputAccessoryView];
    [self.view addSubview:self.bottomView];
    [self.bottomView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.bottom.equalTo(self.view.mas_bottom);
            make.height.mas_equalTo(60);
    }];
    //发布评论按钮
    self.replyBotton = [[UIButton alloc]init];
    [self.replyBotton setEnabled:NO];
    [self.replyBotton setTitle:@"发布" forState:UIControlStateNormal];
    self.replyBotton.titleLabel.font = [UIFont systemFontOfSize:13];
    [self.replyBotton.titleLabel setTextAlignment:NSTextAlignmentRight];
    [self.replyBotton setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
    
    
    [self.replyBotton addTarget:self action:@selector(replybtaction:) forControlEvents:UIControlEventAllEvents];
    [self.bottomView addSubview:self.replyBotton];
    [self.replyBotton mas_makeConstraints:^(MASConstraintMaker *make) {
            make.right.equalTo(self.bottomView.mas_right).with.offset(-5);
            make.top.equalTo(self.bottomView.mas_top).with.offset(5);
            make.size.mas_equalTo(CGSizeMake(40, 30));
    }];
    //发布评论输入框
    self.replyTextView = [[UITextView alloc]init];
    //
    self.replyTextView.delegate = self;
    //
    self.replyTextView.layer.backgroundColor = [[UIColor clearColor]CGColor];
    self.replyTextView.layer.borderWidth = 1.0;
    self.replyTextView.layer.borderColor = [UIColor grayColor].CGColor;
    self.replyTextView.layer.cornerRadius = 15.0;
    //注册通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [self.bottomView addSubview:self.replyTextView];
    [self.replyTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.bottomView).with.offset(3);
        make.bottom.equalTo(self.bottomView).with.offset(-5);
        make.left.equalTo(self.bottomView).with.offset(5);
        make.right.equalTo(self.replyBotton.mas_left);
    }];
    
 
    
    
    
    //-----------------中间tabelview部分----------------------
    self.tableview = [[UITableView alloc]init];
    //键盘收起方式
    self.tableview.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    [self.view addSubview:self.tableview];
    [self.tableview mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.view.mas_left);
            make.right.equalTo(self.view.mas_right);
            make.top.equalTo(toplabel.mas_bottom);
            make.bottom.equalTo(self.bottomView.mas_top);
    }];
    //
    self.tableview.delegate = self;
    self.tableview.dataSource = self;
    [self.tableview registerClass:[Comment_TableViewCell class] forCellReuseIdentifier:@"123"];
    [self.view addSubview:self.tableview];
    
}

//     tableviw的数据源方法
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    CommentModel *model = self.commentArray[indexPath.row];
    //cell的重用
    Comment_TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"123"];
    if(!cell){
        cell = [[Comment_TableViewCell alloc]initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"123"];
        cell.selectionStyle = UITableViewCellSelectionStyleGray;
    }
#pragma mark 这里给cell页面传了本vc的底部输入框textview的地址与用户名，慎用
    [cell getMSG:self.replyTextView andName:model.name];
    
    //通过模型赋值到cell的控件里
    cell.touXiang.image = [UIImage imageNamed:@"tou.png"];
    cell.name.text = model.name;
    cell.comment.text = model.comment;
    cell.time.text = model.time;
    cell.dz_count.text = model.dz_count;
    self.hight = ((cell.comment.text.length)/27+2)*14+65;
    
    return cell;
}
//tableview行数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.commentArray.count;
}
//tableview行高
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.hight;
}


//顶部的点击关闭评论页面方法
- (void)back{
    [self dismissViewControllerAnimated:YES completion:nil];
}

+ (NSInteger *)pop :(UIViewController *)vc andid:(NSInteger *)id{
    Comment_ViewController *pl1 = [[Comment_ViewController alloc]init];
    pl1.id = id;
    [vc presentViewController:pl1 animated:YES completion:nil];
    return pl1.commentArray.count;
}




//实现键盘监听方法使输入框不被遮挡
- (void)keyboardWillShow:(NSNotification *)notification{
    CGFloat kbhight = [[notification.userInfo objectForKey:UIKeyboardFrameEndUserInfoKey]CGRectValue].size.height;
    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-kbhight);
    }];
    
    [UIView animateWithDuration:0.5 animations:^{
            [self.view layoutIfNeeded];
    }];
}
//实现键盘监听方法使输入框回到底部
- (void)keyboardWillHide:(NSNotification *)notification{
    
    [self.bottomView mas_updateConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view);
    }];
}

//发布按钮的响应shijian
- (void)replybtaction:(UIButton *)bt{
    [self.replyTextView setText:@""];
    [self.replyTextView resignFirstResponder];
    
    UIAlertController *alerk = [UIAlertController alertControllerWithTitle:@"" message:@"发布成功" preferredStyle:UIAlertControllerStyleAlert];
    [alerk addAction:[UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:nil]];
    [self presentViewController:alerk animated:YES completion:nil];
}

//规定发布按钮的可用性
- (void)textViewDidChange:(UITextView *)textView{
    if(![textView hasText]){
        self.replyBotton.titleLabel.textColor = [UIColor grayColor];
        [self.replyBotton setEnabled:NO];
        
    }else{
        self.replyBotton.titleLabel.textColor = [UIColor blueColor];
        [self.replyBotton setEnabled:YES];
        
    }
}




/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/
@end

//
//  TableViewController.m
//  DaftTestProject
//
//  Created by daiyuzhang on 29/07/2015.
//  Copyright (c) 2015 daiyuzhang. All rights reserved.
//

#import "TableViewController.h"
#import "SVProgressHUD.h"
#import "DaftPropertyService.h"
#import "UIImageView+WebCache.h"
#import "NSString+tools.h"

static const int kAddressLabelTag = 101;
static const int kImageViewTag = 102;

@interface TableViewController ()
{
    NSMutableArray *_propertiesArray;
    NSOperationQueue *_queue;
}
@end

@implementation TableViewController

#pragma mark - data initial
-(void)initData
{
    _propertiesArray = [[NSMutableArray alloc] init];
    _queue = [[NSOperationQueue alloc] init];
}

#pragma mark - viewDidLoad
- (void)viewDidLoad {
    [super viewDidLoad];
    [self initData];
    [self retriveData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - network request

- (void)retriveData
{
    NSMutableDictionary * parameters = [[NSMutableDictionary alloc] init];
    [parameters setObject:API_KEY forKey:@"api_key"];
    [parameters setObject:@{@"perpage":@50} forKey:@"query"];
    NSString *parametersJSON = [NSString convertToJson:parameters];
    
    [parameters removeAllObjects];
    [parameters setObject:parametersJSON forKey:@"parameters"];
    
    [SVProgressHUD showInView:self.view status:nil networkIndicator:YES posY:-1 maskType:SVProgressHUDMaskTypeGradient];
    void (^onSuccess)(NSArray *) = ^(NSArray *responsedArray) {
        [_propertiesArray setArray:responsedArray];
        [SVProgressHUD dismiss];
        [self.tableView reloadData];
     };
    void (^onFailure)(NSError *error) = ^(NSError *error) {
        [SVProgressHUD dismissWithError:@"Error"];
    };
    
    NSString *path = @"search_sale";
    DaftPropertyService *service = [[DaftPropertyService alloc] init];
    [service getPath:path parameters:parameters success:onSuccess failure:onFailure];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [_propertiesArray count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *identifer = @"propertyCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifer forIndexPath:indexPath];
    
    UILabel *addressLabel = (UILabel *)[cell.contentView viewWithTag:kAddressLabelTag];
    NSDictionary *propertyDictionary = _propertiesArray[indexPath.row];
    addressLabel.text = propertyDictionary[@"full_address"];
    UIImageView *imageView = (UIImageView *)[cell.contentView viewWithTag:kImageViewTag];
    [imageView sd_setImageWithURL:[NSURL URLWithString:propertyDictionary[@"small_thumbnail_url"]]];
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

-(void)dealloc
{
    NSLog(@"%s dealloc", __FILE__);
}

@end

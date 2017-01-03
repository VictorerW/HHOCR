//
//  ISBankCardResultViewController.m
//  ISBankCardDemo
//
//  Created by Felix on 15/9/1.
//  Copyright (c) 2015年 IntSig. All rights reserved.
//

#import "ISBankCardResultViewController.h"
#import "UIImage+BackgroundColorForState.h"


#define UIColorFromRGB(rgbValue) \
[UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0x00FF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0x0000FF))/255.0 \
alpha:1.0]

@implementation ISBankCardResultItem

-(id) init
{
    self = [super init];
    if (self) {
        _typeText = nil;
        _resultText = nil;
    }
    return self;
}

@end


@interface ISBankCardResultViewController () <UITableViewDataSource, UITableViewDelegate>
@property (weak, nonatomic) IBOutlet UIImageView *bgImageView;

@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (strong, nonatomic) IBOutlet UIButton *doneButton;

@property (strong, nonatomic) UILabel *titleLabel;
@property (strong, nonatomic) UIView *tableHeaderView;
@property (strong, nonatomic) UIImageView *cardNumberImageView;

@property (strong, nonatomic) NSDictionary *infoDic;
@property (strong, nonatomic) NSMutableArray *dataSource;

@property (assign, nonatomic) ISCreditCardType creditCardType;


@end

@implementation ISBankCardResultViewController

- (instancetype)initWithInfo:(NSDictionary*) info
{
    self = [super init];
    if (self)
    {
        _infoDic = info;
        _dataSource = [NSMutableArray array];
    }
    
    return self;
}
- (IBAction)doneButtonDidClicked:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:^
    {
        
    }];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.'
    CGSize ScreenSize = [[UIScreen mainScreen] bounds].size;
    
    self.bgImageView.image = [UIImage imageNamed:@"bg"];
    self.tableHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, ScreenSize.width, 114)];
    self.tableHeaderView.backgroundColor = UIColorFromRGB(0x13334A);
    
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 34, ScreenSize.width, 20)];
    self.titleLabel.textColor = [UIColor whiteColor];
    self.titleLabel.textAlignment = NSTextAlignmentCenter;
    [self.tableHeaderView addSubview:self.titleLabel];
    
    self.cardNumberImageView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 64, ScreenSize.width, 50)];
    self.cardNumberImageView.contentMode = UIViewContentModeScaleAspectFit;
    [self.tableHeaderView addSubview:self.cardNumberImageView];
    
    self.tableView.tableHeaderView = self.tableHeaderView;
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    self.tableView.backgroundColor = [UIColor clearColor];
    
    [self.doneButton setBackgroundColor:UIColorFromRGB(0x18B8F5)];
    self.doneButton.layer.cornerRadius = 4.0f;
    [self setupDataSource];
}

- (void)setupDataSource
{
    {
        UIImage *cardNumberImage = [self.infoDic valueForKey:kBankNumberImage];
        self.cardNumberImageView.image = cardNumberImage;
    }
    
    self.titleLabel.text = NSLocalizedString(@"银行卡识别", @"银行卡识别");
    [self.doneButton setTitle:NSLocalizedString(@"确定", @"确定") forState:UIControlStateNormal];
    
    {
        ISCreditCardType creditType = [[self.infoDic valueForKey:kCreditCardType] integerValue];
        self.creditCardType = creditType;
        NSString *creditCardTypeStr = [self getCreditCardTypeString:creditType];
        if (creditCardTypeStr) {
            [self.dataSource addObject:creditCardTypeStr];
        }
    }
    
    {
        NSString *cardNumber = [self.infoDic valueForKey:kCardNumber];
        if (cardNumber) {
            ISBankCardResultItem *item = [[ISBankCardResultItem alloc] init];
            item.typeText = NSLocalizedString(@"Card number:", @"Card number:");
            item.resultText = cardNumber;
            [self.dataSource addObject:item];
        }
    }
    
    {
        NSString *expiryDate = [self.infoDic valueForKey:kExpiryDate];
        if (expiryDate) {
            ISBankCardResultItem *item = [[ISBankCardResultItem alloc] init];
            item.typeText = NSLocalizedString(@"Valid Thru:", @"Valid Thru");
            item.resultText = expiryDate;
            [self.dataSource addObject:item];
        }
    }

    {
        NSString *bankName = [self.infoDic valueForKey:kBankName];
        NSString *bankID = [self.infoDic valueForKey:kBankID];
        if (bankID == nil) {
            bankID = NSLocalizedString(@"Unknown Bank", @"Unknown Bank");
        }
        if (bankName) {
            ISBankCardResultItem *item = [[ISBankCardResultItem alloc] init];
            item.typeText = NSLocalizedString(@"Issued bank:", @"Bank");
            NSString *bankNameString = [NSString stringWithFormat:@"%@(%@)", bankName, bankID];
            item.resultText = bankNameString;
            [self.dataSource addObject:item];
        }
    }
    
    {
        ISBankCardType bankCardType = [[self.infoDic valueForKey:kBankCardType] integerValue];
        NSString *bankCardTypeStr = [self getBankCardTypeString:bankCardType];
        if (bankCardTypeStr) {
            ISBankCardResultItem *item = [[ISBankCardResultItem alloc] init];
            item.typeText = NSLocalizedString(@"Card type:", @"Card type:");
            item.resultText = bankCardTypeStr;
            [self.dataSource addObject:item];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)dealloc
{
    NSLog(@"dealloc");
}

- (UIImage *) croppedImage:(UIImage*)image withRect: (CGRect) bounds
{
    CGImageRef imageRef = CGImageCreateWithImageInRect([image CGImage], bounds);
    UIImage *croppedImage = [UIImage imageWithCGImage:imageRef];
    CGImageRelease(imageRef);
    return croppedImage;
}

#pragma mark - UITableViewDataSource & UITableViewDelegate

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataSource.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString * const ISIDReaderResultTableViewCellIdentifier = @"ISIDReaderResultTableViewCellIdentifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ISIDReaderResultTableViewCellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:ISIDReaderResultTableViewCellIdentifier];
        cell.backgroundColor = [UIColor clearColor];
        cell.contentView.backgroundColor = [UIColor clearColor];
        cell.textLabel.textColor = UIColorFromRGB(0xE1E1E1);
        cell.detailTextLabel.textColor = UIColorFromRGB(0xFFFFFF);
        cell.detailTextLabel.textAlignment = NSTextAlignmentLeft;
    }
    
    if (indexPath.row == 0) {
        cell.imageView.image = [self getCreditCardTypeIcon:self.creditCardType];
    }
    
    if (indexPath.row < self.dataSource.count) {
        NSObject *data = self.dataSource[indexPath.row];
        if ([data isKindOfClass:[NSString class]]) {
            cell.textLabel.text = (NSString *)data;
        } else if ([data isKindOfClass:[ISBankCardResultItem class]]) {
            ISBankCardResultItem *item = (ISBankCardResultItem*)data;
            cell.textLabel.text = item.typeText;
            cell.detailTextLabel.text = item.resultText;
        }
    }
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}


- (NSString*) getBankCardTypeString:(ISBankCardType)type
{
    NSString *cardString = nil;
    switch (type) {
        case ISBankCardTypeCreditCard:
            cardString = NSLocalizedString(@"CreditCard", @"CreditCard");
            break;
        case ISBankCardTypeDebitCard:
            cardString = NSLocalizedString(@"DebitCard", @"DebitCard");
            break;
        case ISBankCardTypeQuasiCreditCard:
            cardString = NSLocalizedString(@"QuasiCreditCard", @"QuasiCreditCard");
            break;
        default:
            break;
    }
    return cardString;
}

- (UIImage*) getCreditCardTypeIcon:(ISCreditCardType)type
{
    UIImage *image = nil;
    switch (type) {
        case ISCreditCardTypeVISA:
            image = [UIImage imageNamed:@"VISA"];
            break;
        case ISCreditCardTypeMASTER:
            image = [UIImage imageNamed:@"mastercard"];
            break;
        case ISCreditCardTypeAMEX:
            image = [UIImage imageNamed:@"AMERICAN"];
            break;
        case ISCreditCardTypeJCB:
            image = [UIImage imageNamed:@"JCB"];
            break;
        case ISCreditCardTypeUNIONPAY:
            image = [UIImage imageNamed:@"Unionpay"];
            break;
        default:
            break;
    }
    return image;
}

- (NSString*) getCreditCardTypeString:(ISCreditCardType)type
{
    NSString *cardString = nil;
    switch (type) {
        case ISCreditCardTypeVISA:
            cardString = NSLocalizedString(@"VISA", @"VISA");
            break;
        case ISCreditCardTypeMASTER:
            cardString = NSLocalizedString(@"MASTER", @"MASTER");
            break;
        case ISCreditCardTypeMAESTRO:
            cardString = NSLocalizedString(@"MAESTRO", @"MAESTRO");
            break;
        case ISCreditCardTypeAMEX:
            cardString = NSLocalizedString(@"AMEX", @"AMEX");
            break;
        case ISCreditCardTypeDINERS:
            cardString = NSLocalizedString(@"DINERS", @"DINERS");
            break;
        case ISCreditCardTypeDISCOVER:
            cardString = NSLocalizedString(@"DISCOVER", @"DISCOVER");
            break;
        case ISCreditCardTypeJCB:
            cardString = NSLocalizedString(@"JCB", @"JCB");
            break;
        case ISCreditCardTypeUNIONPAY:
            cardString = NSLocalizedString(@"UNIONPAY", @"UNIONPAY");
            break;
        default:
            break;
    }
    return cardString;
}


@end

//
//  TeamListVC.m
//  FootballManager
//
//  Created by KIENND on 4/17/13.
//  Copyright (c) 2013 KIENND. All rights reserved.
//

#import "TeamListVC.h"

@interface TeamListVC ()
@property (strong) UITableView* tableTeam;
@property (strong) NSMutableArray* teamList;
@property (strong) UIButton* bttmp;
@property (assign) int* teamChoice;
@end

@implementation TeamListVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        _teamChoice = malloc(sizeof(int)*100);
        DataManager* dt = [DataManager ShareData];
        self.title = @"Team List";
        _teamList = [[NSMutableArray alloc] initWithArray:dt.dataTeam];
        NSLog(@"team count %d",[_teamList count]);
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];

   // NSLog(@"%d",[t.players count]);
	// Do any additional setup after loading the view.
}

- (void)loadView
{
    [super loadView];
    self.view.backgroundColor =  [UIColor redColor];
    _tableTeam = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableTeam.delegate = self;
    _tableTeam.dataSource = self;
    [self.view addSubview:_tableTeam];
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_teamList count];
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = nil;
    static NSString *cellID = @"Cell";
    cell = [_tableTeam dequeueReusableCellWithIdentifier:cellID];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    Team* team =_teamList[indexPath.row];
    
    cell.textLabel.text = team.teamName;
    cell.imageView.image = [UIImage imageNamed:team.logoName];
    cell.accessoryType = UITableViewCellSelectionStyleBlue;
    
    _teamChoice[indexPath.row] = team.teamId;
    
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TeamDetailVC* _teamDetailVC;
    Team* teamJustChoice = _teamList[_teamChoice[indexPath.row]-1];
    if (!_teamDetailVC) {  //kiem tra neu Null thi khoi tao
        _teamDetailVC = [[TeamDetailVC alloc] initWithNibName:nil bundle:nil];
    }
    [_teamDetailVC initWithTeam:teamJustChoice];
    
    [self.navigationController pushViewController:_teamDetailVC animated:YES];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

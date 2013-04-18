//
//  PlayerListVC.m
//  QLBongDa
//
//  Created by KIENND on 4/18/13.
//  Copyright (c) 2013 KIENND. All rights reserved.
//

#import "PlayerListVC.h"
#import "Team.h"
@interface PlayerListVC ()
{
    UITableView* _tablePlayer;
    NSArray* _dataPlayer;
    NSArray* _dataTeam;
    int* _playerChoice;
}
@end

@implementation PlayerListVC

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        DataManager* dt = [DataManager ShareData];
        _dataPlayer = dt.dataPlayer;
        _playerChoice = malloc(sizeof(int)*100);
        _dataTeam = dt.dataTeam;
        // Custom initialization
    }
    return self;
}

- (void) loadView
{
    [super loadView];
    _tablePlayer  = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tablePlayer.dataSource = self;
    _tablePlayer.delegate = self;
    [self.view addSubview:_tablePlayer];
}

- (NSInteger) tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    NSLog(@"player count%d",[_dataPlayer count]);
    return [_dataPlayer count];
}

- (UITableViewCell*) tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *cell = nil;
    static NSString *cellID = @"Cell";
    cell = [_tablePlayer dequeueReusableCellWithIdentifier:cellID];
    if (!cell){
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellID];
    }
    Player* player = _dataPlayer[indexPath.row];
    cell.textLabel.text = player.playerName;
    // cell.accessoryType = UITableViewCellSelectionStyleBlue;
    
    cell.tag = player.playerId;
    cell.backgroundColor = [UIColor clearColor];
    
    _playerChoice[indexPath.row] = player.playerId;
    //  NSLog(@"tag%d", cell.tag);
    return cell;
}

- (void) tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"%@",[NSString stringWithFormat:@"Cell %d in Section %d is selected",indexPath.row, _playerChoice[indexPath.row]]);
    
    Player* playerView = _dataPlayer[_playerChoice[indexPath.row]-1];
    
    PlayerDetailVC* dpvc;
    if(!dpvc){
        dpvc = [[PlayerDetailVC alloc] initWithNibName:nil bundle:nil];
    }
    
    Team* team = _dataTeam[playerView.ownerTeamId - 1];
    [dpvc initWithPlayer: playerView Team:team];
    
    [self.navigationController pushViewController:dpvc animated:YES];
    
}


- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

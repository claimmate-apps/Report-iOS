//
//  AddValueVC.m
//

#import "AddValueVC.h"

@implementation AddValueVC

#pragma mark - Synthesize

#pragma mark - ViewController Methods
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    arrData = [[NSArray alloc] initWithObjects:@"roof_edge_metal",@"roof_type",@"dwl_first",@"dwl_second",@"dwl_third",@"dwl_fourth",@"dwl_fifth",@"dmg_interior_damage",@"dmg_roof",@"dmg_elevation",@"dmg_notes",@"misc_title", nil];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    
    [[UIApplication sharedApplication] setStatusBarStyle: UIStatusBarStyleLightContent];
}

#pragma mark - UI Methods

#pragma mark - IBAction Methods
- (IBAction)onClickBack:(id)sender {
    [self.navigationController popViewControllerAnimated:TRUE];
}

#pragma mark - Delegate Methods
#pragma mark UITableView
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [arrData count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    static NSString *CellIdentifier = @"ReportsVCCell";
    
    ReportsVCCell *cell = (ReportsVCCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.delegate = self;
    cell.idx = indexPath.row;
    cell.lblTitle.text = [NSString stringWithFormat:@"%@",[arrData objectAtIndex:indexPath.row]];
    
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}

#pragma mark ReportsVCCell
- (void)didPressDetails:(NSInteger)index {    
    SubValueVC *objVC = (SubValueVC *)[STORYBOARD instantiateViewControllerWithIdentifier:@"SubValueVC"];
    objVC.strTitle = [arrData objectAtIndex:index];
    [self.navigationController pushViewController:objVC animated:YES];
}

@end

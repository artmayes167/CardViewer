//
//  CardChooserViewController.m
//  CardViewer
//
//  Created by Arthur Mayes on 2/15/13.
//  Copyright (c) 2013 Arthur Mayes. All rights reserved.
//

#import "CardChooserViewController.h"
#import "CardDisplayViewController.h"

@interface CardChooserViewController ()
@property (weak, nonatomic) IBOutlet UISegmentedControl *suitSegmentedControl;
@property (weak, nonatomic) IBOutlet UILabel *rankLabel;
@property (nonatomic) NSUInteger rank;
@property (nonatomic, readonly) NSString *suit;
@property (nonatomic, readonly) NSString *suitString;
@end

@implementation CardChooserViewController

-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:@"ShowCard"]) {
        if ([segue.destinationViewController isKindOfClass:[CardDisplayViewController class]]) {
            CardDisplayViewController *cdvc = (CardDisplayViewController *)segue.destinationViewController;
            cdvc.suit = [self suitAsWord];
            cdvc.rank = self.rank;
            if (![[self rankAsString] isEqualToString:@"joker"]) {
                cdvc.title = [[self rankAsString] stringByAppendingString:self.suit];
            } else {
                cdvc.title = @"Joker";
            }
        }
    }
}
-(NSString *)rankAsString
{
    return @[@"joker", @"a", @"2", @"3", @"4", @"5", @"6", @"7", @"8", @"9",@"10", @"j", @"q", @"k"][self.rank];
}
-(NSString *)suitAsWord
{
    return @[@"spades", @"clubs", @"hearts", @"diamonds"][self.suitSegmentedControl.selectedSegmentIndex];
}


-(void) setRank:(NSUInteger)rank
{
    _rank = rank;
    if (![[self rankAsString] isEqualToString:@"joker"]) {
        self.rankLabel.text = [self rankAsString];
    } else {
        self.rankLabel.text = @"Joker";
    }
}
-(NSString *)suit
{
    return [self.suitSegmentedControl titleForSegmentAtIndex:self.suitSegmentedControl.selectedSegmentIndex];
}
- (IBAction)changeRank:(UISlider *)sender
{
    self.rank = round(sender.value);
}


@end

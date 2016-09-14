//
//  ViewController.m
//  Quiz
//
//  Created by Princess Sampson on 9/14/16.
//  Copyright © 2016 Princess Sampson. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong, nonatomic) IBOutlet UILabel *currentQuestionLabel;
@property (strong, nonatomic) IBOutlet UILabel *nextQuestionLabel;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *currentQuestionLabelCenterXConstaint;
@property (strong, nonatomic) IBOutlet NSLayoutConstraint *nextQuestionLabelCenterXConstraint;
@property (strong, nonatomic) IBOutlet UILabel *answerLabel;
@property(nonatomic) NSArray *questions;
@property(nonatomic) NSArray *answers;
@property(nonatomic) NSUInteger currentQuestionIndex;

@end

@implementation ViewController

- (IBAction)showNextQuestion:(id)sender {
    self.currentQuestionIndex++;
    if(self.currentQuestionIndex == self.questions.count) {
        self.currentQuestionIndex = 0;
    }
    
    NSString *question = self.questions[self.currentQuestionIndex];
    self.nextQuestionLabel.text = question;
    self.answerLabel.text = @"???";
    
    [self animateLabelTransitions];
}
- (IBAction)showNextAnswer:(id)sender {
    NSString *answer = self.answers[self.currentQuestionIndex];
    self.answerLabel.text = answer;
}

- (void)animateLabelTransitions {
    
    [self.view layoutIfNeeded];
    
    CGFloat screenWidth = self.view.frame.size.width;
    self.nextQuestionLabelCenterXConstraint.constant = 0;
    self.currentQuestionLabelCenterXConstaint.constant += screenWidth;
    
    NSLog(@"BeforeCurrent:%@, %f", self.currentQuestionLabel.text, self.currentQuestionLabel.alpha);
    NSLog(@"BeforeNext:%@, %f", self.nextQuestionLabel.text, self.currentQuestionLabel.alpha);
    
    [UIView  animateWithDuration:01
                           delay:0.0
          usingSpringWithDamping:.1
           initialSpringVelocity:.5
                         options:UIViewAnimationOptionCurveLinear
                      animations:^{
                          self.currentQuestionLabel.alpha = 0.0;
                          self.nextQuestionLabel.alpha = 1.0;
                          [self.view layoutIfNeeded];
                      }
                      completion:^(BOOL finished) {
                          UILabel *tempLabel = self.currentQuestionLabel;
                          self.currentQuestionLabel = self.nextQuestionLabel;
                          self.nextQuestionLabel = tempLabel;
                          
                          NSLayoutConstraint *tempConstraint = self.currentQuestionLabelCenterXConstaint;
                          self.currentQuestionLabelCenterXConstaint = self.nextQuestionLabelCenterXConstraint;
                          self.nextQuestionLabelCenterXConstraint = tempConstraint;
                          
                          [self updateOffScreenLabel];
                      }];
    
    NSLog(@"AfterCurrent:%@", self.currentQuestionLabel.text);
    NSLog(@"AfterNext:%@", self.nextQuestionLabel.text);
    
    
}

- (void)updateOffScreenLabel {
    CGFloat screenWidth = self.view.frame.size.width;
    self.nextQuestionLabelCenterXConstraint.constant = -screenWidth;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.questions = @[@"What is your name?",
                       @"What is your quest?",
                       @"What is your favorite color?"];
    
    self.answers = @[@"Sir Galahad of Camelot",
                     @"I seek the Grail",
                     @"Blue. No, yel–"];
    
    self.currentQuestionLabel.text = self.questions[self.currentQuestionIndex];
    
    [self updateOffScreenLabel];
}

- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.nextQuestionLabel.alpha = 0.0;
}


@end

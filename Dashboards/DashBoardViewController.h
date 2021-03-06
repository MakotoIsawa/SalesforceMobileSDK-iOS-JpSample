/*
 Copyright (c) 2013, salesforce.com Co.,Ltd. inc. All rights reserved.
 
 Redistribution and use of this software in source and binary forms, with or without modification,
 are permitted provided that the following conditions are met:
 * Redistributions of source code must retain the above copyright notice, this list of conditions
 and the following disclaimer.
 * Redistributions in binary form must reproduce the above copyright notice, this list of
 conditions and the following disclaimer in the documentation and/or other materials provided
 with the distribution.
 * Neither the name of salesforce.com, inc. nor the names of its contributors may be used to
 endorse or promote products derived from this software without specific prior written
 permission of salesforce.com, inc.
 
 THIS SOFTWARE IS PROVIDED BY THE COPYRIGHT HOLDERS AND CONTRIBUTORS "AS IS" AND ANY EXPRESS OR
 IMPLIED WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL THE COPYRIGHT OWNER OR
 CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR CONSEQUENTIAL
 DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR SERVICES; LOSS OF USE,
 DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON ANY THEORY OF LIABILITY,
 WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING NEGLIGENCE OR OTHERWISE) ARISING IN ANY
 WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 */


#import <UIKit/UIKit.h>
#import "SFNativeRestAppDelegate.h"
#import "PublicDatas.h"
#import "Company.h"
#import "CompanyProfiles.h"
#import "UtilManager.h"
#import "DashBoardNaviMenuViewController.h"
#import "GraphDataManager.h"

@interface DashBoardViewController : UIViewController<SFRestDelegate, UIPopoverControllerDelegate, DashBoardNaviMenuDelegate>
{
	PublicDatas *pData;
	Company *comp;
	NSMutableArray *groupList;
	NSMutableArray *groupIdList;
	NSMutableArray *feedList;
	NSString *dashboardId;
	UIPopoverController *pop;
	NSMutableArray *attachList;
	UtilManager *um;
  GraphDataManager *gm;
}


@property (strong, nonatomic) IBOutlet UIView *graphView;
@property (strong, nonatomic) IBOutlet UIView *badgesView;

@property (strong, nonatomic) IBOutlet UIView *uiview1;
@property (strong, nonatomic) IBOutlet UIView *uiview2;
@property (strong, nonatomic) IBOutlet UIView *uiview3;


@property (strong, nonatomic) IBOutlet CompanyProfiles *companyProfile;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil company:(Company*)cp;


@property (strong, nonatomic) IBOutlet UIView *graphTitleView;
@property (strong, nonatomic) IBOutlet UILabel *graphTitleLabel;

@property (strong, nonatomic) IBOutlet UIView *badgeTitleView;
@property (strong, nonatomic) IBOutlet UILabel *badgeTitleLabel;

@property (strong, nonatomic) IBOutlet UIButton *badge1;
@property (strong, nonatomic) IBOutlet UIButton *badge2;
@property (strong, nonatomic) IBOutlet UIButton *badge3;
@property (strong, nonatomic) IBOutlet UIButton *badge4;
@property (strong, nonatomic) IBOutlet UIButton *badge5;
@property (strong, nonatomic) IBOutlet UIButton *badge6;

@end

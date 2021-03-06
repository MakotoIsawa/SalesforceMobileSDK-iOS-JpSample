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

#import "LineGrapth.h"

@implementation LineGrapth


static inline float radians(double degrees) { return degrees * M_PI / 180.0; }

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
	CGFloat x,y,xx,yy;

	//背景色
	self.backgroundColor = [UIColor clearColor];
	
	//グラフ色
	UIColor *col[26] = {
		[UIColor colorWithRed:0.04 green:0.47 blue:0.71 alpha:1.0],
		[UIColor colorWithRed:0.12 green:0.32 blue:0.58 alpha:1.0],
		[UIColor colorWithRed:0.22 green:0.67 blue:0.33 alpha:1.0],
		[UIColor colorWithRed:0.50 green:0.66 blue:0.04 alpha:1.0],
		[UIColor colorWithRed:0.78 green:0.58 blue:0.11 alpha:1.0],
		[UIColor colorWithRed:0.02 green:0.74 blue:0.73 alpha:1.0],
		[UIColor colorWithRed:0.07 green:0.64 blue:0.94 alpha:1.0],
		[UIColor orangeColor],
		[UIColor lightGrayColor],
		[UIColor darkGrayColor],
    
    [UIColor blackColor], //	黒
    [UIColor blueColor], // 	青
    [UIColor brownColor], // 	茶
    //    [UIColor clearColor], // 	透明
    [UIColor cyanColor], // 	シアン
    [UIColor darkGrayColor], // 	濃い灰
    [UIColor grayColor], // 	灰
    [UIColor greenColor], // 	緑
    //    [UIColor lightGrayColor], // 	薄い灰
    [UIColor magentaColor], // 	マゼンダ
    //    [UIColor orangeColor], // 	オレンジ
    [UIColor purpleColor], // 	パープル
    [UIColor redColor], // 	赤
    //    [UIColor whiteColor], // 	白
    [UIColor yellowColor], // 	黄
    [UIColor lightTextColor], // 	灰色
    [UIColor darkTextColor], // 	黒
    [UIColor groupTableViewBackgroundColor], // 	灰色のストライプ
    [UIColor viewFlipsideBackgroundColor], // 	灰色の斑
    [UIColor scrollViewTexturedBackgroundColor] // 	布みたいな模様
	};

	//Y軸左ラベル最大値
	NSNumber *wrk =[self.maxValAry objectAtIndex:0];
	self.yLblMax1 = [wrk intValue];
	if ( [self.maxValAry count] >= 2) {
		wrk =[self.maxValAry objectAtIndex:1];
		self.yLblMax2 = [wrk intValue];
	}

	//原点位置
	orgX = (self.bounds.size.width - _graphSizeX) / 2;
	orgY = self.bounds.size.height - (self.bounds.size.height - _graphSizeY - 30);
		
	CGContextRef context = UIGraphicsGetCurrentContext();

	//X,Y軸
	CGContextSetRGBStrokeColor(context,  0.5 ,0.5 ,0.5 ,1.0);
	CGContextSetLineWidth(context, 2);
	CGContextBeginPath(context);
	CGContextMoveToPoint(context, orgX, orgY );
	CGContextAddLineToPoint(context, orgX,orgY - _graphSizeY);
	CGContextMoveToPoint(context, orgX, orgY );
	CGContextAddLineToPoint(context, orgX+_graphSizeX,orgY);
	CGContextStrokePath(context);

	//目盛点線
	CGContextSaveGState(context);
	CGFloat dashPattern[2] = { 3.0f, 3.0f };
	CGContextSetLineDash(context,0, dashPattern,2);				//点線のパターンをセット
	for( int i = 1; i <= self.y_section; i++ ){
		y = orgY - ( i * (_graphSizeY / self.y_section));
		CGContextMoveToPoint(context, orgX, y );
		CGContextAddLineToPoint(context, orgX + _graphSizeX, y);
		CGContextStrokePath(context);

		//Y軸左側ラベル
		UILabel *yLbl1 = [[UILabel alloc]initWithFrame:CGRectMake(0, y - 10, orgX - 10, 20)];
		//yLbl1.text = [NSString stringWithFormat:@"%.0f",((float)self.yLblMax1 / (float)self.y_section)*(float)i];
    
    NSString *_textL = [NSString stringWithFormat:@"%.0f",((float)self.yLblMax1 / (float)self.y_section)*i];
    int mL = [_textL intValue];
    
    // 桁数
    int _digitL = (int)log10( [[[NSNumber alloc]initWithInt:mL] doubleValue] ) + 1;
    float _bL = (float)(mL/pow(10, _digitL));
    // 1000 K
    if(_digitL>3) _textL = [NSString stringWithFormat:@"%@K",[[NSNumber alloc] initWithFloat:_bL *(pow(10, _digitL-3))]];
    // 1000000 M
    if(_digitL>6) _textL = [NSString stringWithFormat:@"%@M",[[NSNumber alloc] initWithFloat:_bL *(pow(10, _digitL-6))]];
    yLbl1.text = _textL;
    //NSLog(@"yLbl1.text %@", yLbl1.text);
    
		yLbl1.font = [UIFont systemFontOfSize:10.0];
		yLbl1.backgroundColor = [UIColor clearColor];
		yLbl1.textAlignment = NSTextAlignmentRight;
		[self addSubview:yLbl1];

		//Y軸右側ラベル
		UILabel *yLbl2 = [[UILabel alloc]initWithFrame:CGRectMake( orgX + _graphSizeX + 10, y - 10, orgX, 20)];
		//yLbl2.text = [NSString stringWithFormat:@"%.0f",((float)self.yLblMax2 / (float)self.y_section)*i];
    
    NSString *_text = [NSString stringWithFormat:@"%.0f",((float)self.yLblMax2 / (float)self.y_section)*i];
    int m = [_text intValue];
    
    // 桁数
    int _digit = (int)log10( [[[NSNumber alloc]initWithInt:m] doubleValue] ) + 1;
    float _b = (float)(m/pow(10, _digit));
    // 1000 K
    if(_digit>3) _text = [NSString stringWithFormat:@"%@K",[[NSNumber alloc] initWithFloat:_b *(pow(10, _digit-3))]];
    // 1000000 M
    if(_digit>6) _text = [NSString stringWithFormat:@"%@M",[[NSNumber alloc] initWithFloat:_b *(pow(10, _digit-6))]];
    yLbl2.text = _text;
    //NSLog(@"yLbl2.text %@", yLbl2.text);

		yLbl2.font = [UIFont systemFontOfSize:10.0];
		yLbl2.backgroundColor = [UIColor clearColor];
		yLbl2.textAlignment = NSTextAlignmentLeft;
		[self addSubview:yLbl2];
	}

	//X軸ラベル
	for ( int i = 0 ; i < [_xLblAry count]; i++) {
		x = orgX + i * ( _graphSizeX / ([_xLblAry count]-1) );
		UILabel *xLbl = [[UILabel alloc]initWithFrame:CGRectMake(x-20, orgY, 40, 20)];
		xLbl.font = [UIFont systemFontOfSize:10.0];
		xLbl.backgroundColor = [UIColor clearColor];
		xLbl.text = [_xLblAry objectAtIndex:i];
		xLbl.textAlignment = NSTextAlignmentCenter;
		[self addSubview:xLbl];
	}
	
	//データ色、名称表示
	for ( int i = 0; i < [_nameAry count]; i++) {

		//表示基準位置
		x = orgX + ( _graphSizeX / 3 ) * (i % 3);
		y = ( i / 3 ) * 20 + orgY+ 15;
		UIView *colView = [[UIView alloc]initWithFrame:CGRectMake(x,y+2,16, 16)];
		colView.backgroundColor = col[i];
		[self addSubview:colView];

		UILabel *name = [[UILabel alloc]initWithFrame:CGRectMake(x+18, y+2, (_graphSizeX / 3) - 18, 16 )];
		name.textAlignment = NSTextAlignmentLeft;
		name.font = [UIFont systemFontOfSize:10.0];
		name.text = [_nameAry objectAtIndex:i];
		[self addSubview:name];
	}
	
	//点線から復帰
	CGContextRestoreGState(context);

	//データ線の太さ
	CGContextSetLineWidth(context, 4);

	int numofLine = [_datAry count];
	
	for ( int i = 0; i < numofLine; i++){

		//縦軸1Dotあたりの数値を求める
		float max = [[self.maxValAry objectAtIndex:i]floatValue];
		CGFloat valPerDot = max / (float)_graphSizeY;
		
		CGContextSetStrokeColorWithColor(context, col[i].CGColor );
		
		//折れ線データ取得
		NSMutableArray *lineDat = [_datAry objectAtIndex:i];

		//データのポイント数
		int num = [lineDat count];
	
		//折れ線描画
		x = orgX;
		NSNumber *pointDat = [lineDat objectAtIndex:0];
		y = (CGFloat)orgY - ([pointDat floatValue] / valPerDot);
		for ( int ii = 1; ii < num; ii++) {
			xx = orgX + (ii * (_graphSizeX/(num-1)));
			pointDat = [lineDat objectAtIndex:ii];
			yy = (CGFloat)orgY - ([pointDat floatValue] / valPerDot );
      
      // ゼロの場合Yの値を下辺にする
      NSString *strY = [NSString stringWithFormat:@"%f", y];
      NSString *strYY = [NSString stringWithFormat:@"%f", yy];
      
      //NSLog(@" y:%@  yy:%@", strY , strYY);
      if([strY isEqual:@"nan"] || [strY isEqual:@""] || strY==nil || !y) y =(CGFloat)orgY;
      if([strYY isEqual:@"nan"] || [strYY isEqual:@""] || strYY==nil || !yy) yy =(CGFloat)orgY;
      
			CGContextMoveToPoint(context, x, y );
			CGContextAddLineToPoint(context, xx,yy);
			CGContextStrokePath(context);
			y = yy;
			x = xx;
		}
		
		//各ポイントに円を描画
		CGContextSetFillColorWithColor(context, col[i].CGColor);
//		CGContextSetFillColorWithColor(context, [UIColor whiteColor].CGColor);
		for ( int ii = 0; ii < num; ii++) {
            if((num-1)==0){
                xx = orgX;
            }else{
                xx = orgX + (ii * (_graphSizeX/(num-1)));
            }
			pointDat = [lineDat objectAtIndex:ii];
			yy = (CGFloat)orgY - ([pointDat floatValue] / valPerDot );
      
      // ゼロの場合Yの値を下辺にする
      NSString *strYY = [NSString stringWithFormat:@"%f", yy];
      if([strYY isEqual:@"nan"] || [strYY isEqual:@""] || strYY==nil || !yy) yy =(CGFloat)orgY;
      
			CGContextAddArc(context, xx, yy, 5, radians(0), radians(360), 0);
			CGContextClosePath(context);
			CGContextFillPath(context);
		}
	}
}
@end

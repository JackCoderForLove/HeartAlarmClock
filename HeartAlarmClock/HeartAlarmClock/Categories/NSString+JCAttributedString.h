//
//  NSString+JCAttributedString.h
//  CanCan
//
//  Created by xingjian on 2017/3/15.
//  Copyright © 2017年 xingjian. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface NSString (JCAttributedString)
/********************************************************************
 *  设置段落样式
 *  lineSpacing 行高
 *  textcolor      字体颜色
 *  font              字体
 *  number          段落首行缩进
 *  返回富文本字体
 *******************************************************************/
-(NSAttributedString *)jcHeadstringWithParagraphlineSpeace:(CGFloat)lineSpacing
                                                 textColor:(UIColor *)textcolor
                                                  textFont:(UIFont *)font
                                            headlineNumber:(NSInteger)number;

/********************************************************************
*  设置段落样式
*  lineSpacing 行高
*  textcolor      字体颜色
*  font              字体
*
*  返回富文本字体
*******************************************************************/
-(NSAttributedString *)stringWithParagraphlineSpeace:(CGFloat)lineSpacing
                                           textColor:(UIColor *)textcolor
                                            textFont:(UIFont *)font ;


/********************************************************************
 *  设置段落样式
 *  lineSpacing 行高
 *  textcolor      字体颜色
 *  font              字体
 *  alignment      对齐格式
 *  返回富文本字体
 *******************************************************************/
-(NSAttributedString *)jcAlignmentStringWithParagraphlineSpeace:(CGFloat)lineSpacing
                                                      textColor:(UIColor *)textcolor
                                                       textFont:(UIFont *)font
                                                      alignment:(NSTextAlignment)alignment;


/********************************************************************
 *  返回包含关键字的富文本编辑
 *
 *  @param lineSpacing 行高
 *  @param textcolor   字体颜色
 *  @param font        字体
 *  @param KeyColor    关键字字体颜色
 *  @param KeyFont     关键字字体
 *  @param KeyWords    关键字数组
 *
 *  @return
 ********************************************************************/
-(NSAttributedString *)stringWithParagraphlineSpeace:(CGFloat)lineSpacing
                                           textColor:(UIColor *)textcolor
                                            textFont:(UIFont *)font
                                    withKeyTextColor:(UIColor *)KeyColor
                                             keyFont:(UIFont *)KeyFont
                                            keyWords:(NSArray *)KeyWords;

/********************************************************************
 *  返回包含关键字的富文本编辑
 *
 *  @param lineSpacing 行高
 *  @param NormalAttributeFC   普通文字的属性字典
 *  @param withKeyTextColor    关键字数组
 *  @param KeyAttributeFC        关键字的属性字典
 *
 *  @return
 ********************************************************************/
-(NSAttributedString *)stringWithParagraphlineSpeace:(CGFloat)lineSpacing
                                   NormalAttributeFC:(NSDictionary *)NormalFC
                                    withKeyTextColor:(NSArray *)KeyWords
                                      KeyAttributeFC:(NSDictionary *)keyFC ;



/********************************************************************
 *  计算富文本字体高度
 *
 *  lineSpeace 行高
 *  param font              字体
 *  param width            字体所占宽度
 *
 *  @return 富文本高度
 ********************************************************************/
-(CGFloat)HeightParagraphSpeace:(CGFloat)lineSpeace withFont:(UIFont*)font AndWidth:(CGFloat)width;

/********************************************************************
 *  计算富文本字体宽度
 *
 *  lineSpeace 行高
 *  param font              字体
 *  param width            字体所占宽度
 *
 *  @return 富文本高度
 ********************************************************************/
-(CGFloat)WidthParagraphSpeace:(CGFloat)lineSpeace withFont:(UIFont*)font AndWidth:(CGFloat)width;
/********************************************************************
 *  计算富文本字体高度
 *
 *  lineSpeace 行高
 *  param font              字体
 *  param width            字体所占宽度
 *  param number           首行缩进字数
 *  @return 富文本高度
 ********************************************************************/
-(CGFloat)HeightParagraphSpeace:(CGFloat)lineSpeace withFont:(UIFont*)font AndWidth:(CGFloat)width withfirstLineHeadNumber:(NSInteger)number;

/********************************************************************
 *  返回包含关键字的富文本编辑
 *
 *  @param lineSpacing 行高
 *  @param textcolor   字体颜色
 *  @param font        字体
 *  @param KeyColor    关键字字体颜色
 *  @param KeyFont     关键字字体
 *  @param KeyWords    关键字数组
 *
 *  @return
 *******************************************************************/
-(NSAttributedString *)jcstringWithParagraphlineSpeace:(CGFloat)lineSpacing
                                             textColor:(UIColor *)textcolor
                                              textFont:(UIFont *)font
                                      withKeyTextColor:(UIColor *)KeyColor
                                               keyFont:(UIFont *)KeyFont
                                              keyWords:(NSArray *)KeyWords;

-(NSAttributedString *)jcABCstringWithParagraphlineSpeace:(CGFloat)lineSpacing
                                                textColor:(UIColor *)textcolor
                                                 textFont:(UIFont *)font
                                         withKeyTextColor:(UIColor *)KeyColor
                                                  keyFont:(UIFont *)KeyFont
                                            textAlignment:(NSTextAlignment)alignment
                                                 keyWords:(NSArray *)KeyWords;
@end

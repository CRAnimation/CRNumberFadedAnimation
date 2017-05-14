> 欢迎同样喜爱动效的你加入
iOS动效特攻队–>QQ群：547897182 
iOS动效特攻队–>熊熊：648070256
CRAnimation开源项目：[https://github.com/CRAnimation/CRAnimation](https://github.com/CRAnimation/CRAnimation)

## gitHub：[CRNumberFadedAnimation](https://github.com/CRAnimation/CRNumberFadedAnimation)
#### 断断续续3周的时间，把这个动效还原出来了。
#### 原型是这样的。

![048D2384C794BDF62E9D8145002217B0.gif](http://upload-images.jianshu.io/upload_images/4748593-fe697a10572b2738.gif?imageMogr2/auto-orient/strip)

#### 最终的实现效果是这样的

![CRNumberFaded.gif](http://upload-images.jianshu.io/upload_images/4748593-345b25b6bc2c0f14.gif?imageMogr2/auto-orient/strip)

##### 当然了，这个动效里面的部分控件还是可以使用的。大家英文都辣么好，除非特别难理解的，一般的我就不写注释了。

## 数字切换控件 CRNumberFaded
`CRNumberFaded `控件实际上只有三个`Label `在一直复用。所以可以不用担心内存的问题哦。

```
//基本用法
CRNumberFaded *_numberFadedView = [[CRNumberFaded alloc] initWithFrame:CGRectMake(0, 0, 200, 200)];
_numberFadedView.font = [UIFont fontWithName:@"Helvetica-Bold" size:150];
_numberFadedView.textColor = [UIColor whiteColor];
_numberFadedView.strings = strings;
_numberFadedView.delegate = self;
_numberFadedView.backgroundColor = [UIColor clearColor];
[_sliderIndicator addSubview:_numberFadedView];

//可使用参数和方法
@property (weak, nonatomic) id <CRNumberFadedDelegate> delegate;
@property (strong, nonatomic) NSArray   *strings;
@property (strong, nonatomic) UIFont    *font;
@property (strong, nonatomic) UIColor   *textColor;
@property (assign, nonatomic) BOOL      allowCircle;    //是否允许无限滚动

- (void)showNextView;
- (void)showLastView;
- (void)showToIndex:(int)toIndex;

//支持的代理方法
@protocol CRNumberFadedDelegate <NSObject>

- (void)willShowLastOneFadeAnimationWithString:(NSString *)string index:(int)index;
- (void)willStartFirstAnimationWithString:(NSString *)string index:(int)index;
- (void)fadingAnimationWithString:(NSString *)string index:(int)index;

@end
```

## 滑杆控件 CRSlider
`CRSlider `继承自`UIControl `，支持`UIControlEventValueChanged `监听事件。
原生的`UISlider`可自定义的属性满足不了这个动效的需求，只能自己重新写了。
```
//基本用法
CRSlider *_slider = [[CRSlider alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
_slider.delegate = self;
_slider.minimumValue = 0;
_slider.maximumValue = _maxNum;
_slider.poleImageVOffX = _poleImageVOffX;
[_slider addTarget:self action:@selector(testSliderChanged:) forControlEvents:UIControlEventValueChanged];
[self.view addSubview:_slider];

//可使用参数和方法
@property(nonatomic) float value;
@property(nonatomic) float minimumValue;
@property(nonatomic) float maximumValue;

@property(nonatomic) float poleImageVOffX;
@property (strong, nonatomic) UIImageView *poleImageV;
@property (strong, nonatomic) UIImageView *thumbImageV;

//支持的代理方法
@protocol CRSliderDelegate <NSObject>
- (void)thumbImageVDidSlided:(CRSlider *)slider;
@end
```

## 滑杆指示器控件 CRSliderIndicator
指示器里面的这个圆槽是折腾了一段时间才出来的。主要考虑到适配的问题，想想还是用比例来做的，通过Sketch临摹出曲线，然后把贝塞尔曲线的几个控制点挑出来，通过比例来做适配。图示如下，只点出来了左半边的几个点，右半边的同理。

![CRSliderIndicatorMind.png](http://upload-images.jianshu.io/upload_images/4748593-48eb6c250e5b4169.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
```
//基本用法
CRSliderIndicator *_sliderIndicator = [[CRSliderIndicator alloc] initWithFrame:CGRectMake(0, _customNaviBarView.maxY, WIDTH, sliderIndicatorHeight) withStrings:strings];
_sliderIndicator.chipOffX = _poleImageVOffX;
[self.view addSubview:_sliderIndicator];

//可使用参数和方法
@property (assign, nonatomic) CGFloat   circleCenterX;              //Slider按钮的CenterX
@property (assign, nonatomic) CGFloat   r;                          //Slider按钮的半径
@property (assign, nonatomic) CGFloat   toCircleCenterYDistance;    //Slider按钮的垂直距离
@property (strong, nonatomic) NSArray   *gradientColors;            //背景渐变色数组
@property (assign, nonatomic) CGFloat   chipOffX;

- (instancetype)initWithFrame:(CGRect)frame withStrings:(NSArray *)strings;
```

撸动效揪心的还是细节的不断调试，因为想尽可能的还原出来还是需要慢慢打磨的。不过希望大家能喜欢，也能真正的用在项目中。
如果各位在使用过程中遇到问题或者bug，欢迎在github上提出issue。





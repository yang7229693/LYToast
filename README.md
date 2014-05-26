LYToast
=======

Self-Adaption Text Toast And Image Toast For IOS


Like Android Toast, This`s For IOS, You Can Use Text Toast And Image Toast Like Below, It`s Easy To Use

[LYMessageToast toastWithText:@"Pop Me In Current View\n\nWidth And Height Self-Adaption!"
                  backgroundColor:[UIColor blackColor]
                             font:[UIFont systemFontOfSize:15.0f]
                        fontColor:[UIColor whiteColor]
                         duration:1.5f
                           inView:self.view];

LYImageToast toastWithImage:@"test.png"
                     inView:self.view
                   duration:1.5f];
                   

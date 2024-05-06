@Entry
@Component
struct About {
  @State message: string = 'Hello World'

  @Builder LongText(value: string) {
    Text(value)
      .fontSize(16)
      .margin({bottom: 10})
  }

  pageTransition() {
    // 定义页面进入时的效果，从左侧滑入，时长为1200ms，无论页面栈发生push还是pop操作均可生效
    PageTransitionEnter({ type: RouteType.Push, duration: 500, curve: Curve.Ease })
      .slide(SlideEffect.Right)
    // 定义页面退出时的效果，向左侧滑出，时长为1000ms，无论页面栈发生push还是pop操作均可生效
    // PageTransitionExit({ type: RouteType.Pop, duration: 1000, curve: Curve.Ease })
    //   .slide(SlideEffect.Right)
  }

  build() {
    Column(){
      Navigation() {
        Column() {
          Column() {
            Image($rawfile('sr_my_app_icon.png'))
              .height(80)
              .margin({bottom: 20})
              .borderRadius(16)
            this.LongText('作业清单 Alpha 版')
            this.LongText('由 WangJX 开发')
          }
          Column() {
            this.LongText('反馈 & 建议 欢迎在 GitHub 上发布 Issues：')
            Text('https://github.com/WJX2001/LifeTaskList')
              .fontSize(14)
          }
        }
        .margin({top: 20})
        .justifyContent(FlexAlign.SpaceEvenly)
        .height('80%')
      }
      .titleMode(NavigationTitleMode.Mini)
      .title('关于')
      .mode(NavigationMode.Stack)

    }
    .height('100%')
    .width('100%')
  }
}

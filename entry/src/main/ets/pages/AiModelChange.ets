@Entry
@Component
struct AiModelChange {
  @State message: string = '模型微调页面'
  @State outSetValueOne: number = 0.5
  @State selectedDomain: string = 'general'
  @State selectedCloud: string = 'knowledge'

  pageTransition() {
    // 定义页面进入时的效果，从左侧滑入，时长为1200ms，无论页面栈发生push还是pop操作均可生效
    PageTransitionEnter({ type: RouteType.Push, duration: 500, curve: Curve.Ease })
      .slide(SlideEffect.Right)
  }

  build() {
    Column() {
      Navigation() {
        Column() {
          Row() {
            Text("核采样阈值")
              .fontSize(20)
              .alignSelf(ItemAlign.Center)
            Slider({
              value: this.outSetValueOne,
              min: 0,
              max: 1,
              step: 0.1 // 确保滑动条步长为0.01
            })
              .width("55%")
              .margin({ left: 10, right: 10 })
              .showTips(true)
              .onChange((value: number, mode: SliderChangeMode) => {
                this.outSetValueOne = value
                console.info('value:' + value + 'mode:' + mode.toString())
              })
            Text(this.outSetValueOne.toFixed(1))
              .fontSize(20)
              .alignSelf(ItemAlign.Center)
          }.width("100%").margin({ bottom: 20 })

          Row() {
            Text("使用领域")
              .fontSize(20)
              .alignSelf(ItemAlign.Center)
            Select([{ value: 'general' },
              { value: 'normal', },
            ])
              .selected(2)
              .value(this.selectedDomain)
              .font({ size: 16, weight: 500 })
              .fontColor('#182431')
                // .selectedOptionFont({ size: 16, weight: 400 })
              .optionFont({ size: 16, weight: 400 })
              .onSelect((index: number) => {
                console.info('Select:' + index)
              })
              .margin({ left: 30 })

          }.width("100%").margin({ bottom: 20 })

          Row() {
            Text("是否关闭云端搜索")
              .fontSize(20)
              .alignSelf(ItemAlign.Center)
            Select([{ value: 'knowledge' },
              { value: 'medical', },
            ])
              .selected(2)
              .value(this.selectedCloud)
              .font({ size: 16, weight: 500 })
              .fontColor('#182431')
                // .selectedOptionFont({ size: 16, weight: 400 })
              .optionFont({ size: 16, weight: 400 })
              .onSelect((index: number) => {
                console.info('Select:' + index)
              })
              .margin({ left: 30 })

          }.width("100%").margin({ bottom: 20 })

          Button("上传微调数据").margin({top:90})
        }
        .padding(20)
      }
      .titleMode(NavigationTitleMode.Mini)
      .title('模型微调')
      .mode(NavigationMode.Stack)
    }
    .width("100%")
    .borderRadius(24)
    .padding(10)
  }
}

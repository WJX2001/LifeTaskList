@Entry
@Component
struct AiChatComp {
  @State message: string = 'AI 聊天界面'

  build() {
    Row() {
      Column() {
        Text(this.message)
          .fontSize(50)
          .fontWeight(FontWeight.Bold)
      }
      .width('100%')
    }
    .height('100%')
  }
}
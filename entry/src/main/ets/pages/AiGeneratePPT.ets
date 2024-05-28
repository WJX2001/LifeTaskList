@Entry
@Component
struct AiGeneratePPT {
  @State message: string = 'AI生成PPT文档'

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
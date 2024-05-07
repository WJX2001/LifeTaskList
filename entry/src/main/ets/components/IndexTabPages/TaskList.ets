@Component
@Preview
export default struct TaskList {
  @State isEditing: boolean = false

  build() {
    Stack({alignContent: Alignment.Bottom}) {
      Stack({ alignContent: (this.isEditing ? Alignment.Bottom : Alignment.BottomEnd) }) {
        Navigation() {
          Column() {
            Column() {
              Scroll() {
                Column() {
                  Text('未办事项')
                    .textTitle()

                  Text('已办事项')
                    .textTitle()
                }
              }
              .edgeEffect(EdgeEffect.Spring)
              .scrollBar(BarState.Off)
            }
            .margin({ top: 0 })
          }.height('100%')
        }
        .titleMode(NavigationTitleMode.Full)
        .title('作业清单')
        .menus([{
          value: "",
          icon: '../../../resources/base/media/ic_public_folder.svg',
          action: () => {
            // this.dialogCategoryList.open()
          }
        }, {
          value: "",
          icon: (this.isEditing ? '../../../resources/base/media/ic_public_edit_filled.svg' : '../../../resources/base/media/ic_public_edit.svg'),
          action: () => {
            // animateTo({duration: 200, curve: Curve.EaseOut}, () => {
            //   this.deleteTarget = []
            //   this.isEditing = !this.isEditing
            // })
          }
        }])
        .height('100%')
        .mode(NavigationMode.Stack)


        // UI 右下角的 Fab
        Button({ type: ButtonType.Circle }) {
          if (!this.isEditing) Image($r('app.media.ic_public_list_add_light'))
          else {
            Image($r('app.media.ic_public_delete'))
              .height(28)
              .width(28)
          }
        }
        .backgroundColor(!this.isEditing ? 0x0A59F7 : 0xE84026)
        .width(60)
        .height(60)
        .margin({ bottom: 12, right: (this.isEditing ? 0 : 12) })
      }
    }

  }
}


@Extend(Text) function textTitle() {
  .fontSize(20)
  .width('100%')
  .margin({ left: 12, bottom: 10, top: 20 })
  .textAlign(TextAlign.Start)
}

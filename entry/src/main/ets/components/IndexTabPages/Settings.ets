import router from '@ohos.router';
import picker from '@ohos.file.picker';

import CommonConstants from '../../common/constants/CommonConsts';

@Component
@Preview
export struct Settings {


  @Styles listItemStyle() {
    .height(60)
    .backgroundColor(0xffffff)
    .borderRadius(24)
    .width('100%')
    .margin({bottom: 12})
  }
  @Builder settingsListItem(name: string) {
    Row() {
      Text(name)
        .fontSize(18)
    }.margin({ left: 18 })
    .width('100%')
    .justifyContent(FlexAlign.Start)
  }

  build() {
    Column() {
      Navigation(){
        List() {
          ListItem() {
            this.settingsListItem('关于')
          }
          .listItemStyle()
          .onClick(() => {
            // future_todo: animation
            router.pushUrl({
              url: "pages/About"
            }, router.RouterMode.Single, (err) => {
              if (err) {
                console.error(`Invoke pushUrl failed, code is ${err.code}, message is ${err.message}`);
              }
            })
          })
          ListItem() {
            this.settingsListItem('重新进入新手引导')
          }.listItemStyle()
          .onClick(() => {
            // future_todo: animation
            router.pushUrl({
              url: "pages/Guide"
            }, router.RouterMode.Single, (err) => {
              if (err) {
                console.error(`Invoke pushUrl failed, code is ${err.code}, message is ${err.message}`);
              }
            })
          })

          // ListItem() {
          //   Row() {
          //     Text('切换颜色：' + this.prefData.color)
          //       .fontSize(18)
          //   }.margin({ left: 18 })
          //   .width('100%')
          //   .justifyContent(FlexAlign.Start)
          // }.height(60)
          // .backgroundColor(0xffffff)
          // .borderRadius(24)
          // .width('100%')
          // .onClick(() => {
          //   this.prefData.color = (this.prefData.color == '#ffffff' ? '#66ccff' : '#ffffff')
          //   this.PrefDB.updateData(this.prefData, () => {})
          // })
        }
        .padding({ left: 12, right: 12, bottom: 10, top: 10 })

      }.title('设置')
      .titleMode(NavigationTitleMode.Full)
      .mode(NavigationMode.Stack)
    }.width('100%')
    .height('100%')

  }
}

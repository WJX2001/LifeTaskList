import router from '@ohos.router'
import CommonConstants from '../common/constants/CommonConsts'
import PreferenceDB from '../common/database/PreferenceDB'
import Logger from '../common/utils/Logger'

@Entry
@Component
struct Index {

  async aboutToAppear() {
    await PreferenceDB.getPreferenceStorage()
    // 获取初次打开标签
    let prefFirstTimeOpen = await PreferenceDB.getPreference('firstOpen')
    Logger.debug(`PrefDB: query = ${prefFirstTimeOpen}`)

    // 这里会根据是否初次进入 展示不同的页面
    if (prefFirstTimeOpen === '') {
      // 当初次进入的时候，打一个标签，作为初始进入的标志
      await PreferenceDB.putPreference('firstOpen', 'true')
      /**
       * 将数据库的初始化信息存入初始化信息
       *  用于当用户 完成新手指引之后，将数据库信息进行初始化
       */
      await PreferenceDB.putPreference('nowVerColumn', JSON.stringify(CommonConstants.TASK_TABLE_INIT.columns))
      // 如果没有完成新手指引 跳转到Guide页面
      router.pushUrl({
        url: "pages/Guide"
      }, router.RouterMode.Single, (err) => {
        if (err) {
          console.error(`Invoke pushUrl failed, code is ${err.code}, message is ${err.message}`);
        }
      })
    }
  }

  build() {
    Row() {
      Column() {

      }
      .width('100%')
    }
    .height('100%')
  }
}
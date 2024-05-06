import relationalStore from '@ohos.data.relationalStore'
import Logger from '../utils/Logger';

// DB 工具类

export default class TaskDB {
  private rdbStore: relationalStore.RdbStore | null = null
  private sqlCreateTable: string
  private tableName: string
  private RDB_TAG: string = '[DEBUG_RDB]'
  private StoreConfig: relationalStore.StoreConfig

  getRdbStore(callback: Function = () => {
  }) {
    if (!callback || typeof callback === 'undefined' || callback === undefined) {
      Logger.info(this.RDB_TAG, 'getRdbStore() has no callback!');
      return;
    }
    if (this.rdbStore !== null) {
      callback();
      return;
    }
    let context: Context = getContext(this) as Context
    relationalStore.getRdbStore(context, this.StoreConfig, (err, rdb) => {
      if (err) {
        Logger.error(this.RDB_TAG, `gerRdbStore() failed, err: ${err}`);
        return;
      }
      this.rdbStore = rdb
      this.rdbStore.executeSql(this.sqlCreateTable)
      // 假定这里 execute 之后不会出事
      callback();
    })
  }

  // 添加一列
  updateColumns(newColumn: string, newColumnData: string) {
    this.rdbStore.executeSql(`ALTER TABLE ${this.tableName} ADD COLUMN ${newColumn} ${newColumnData}`)
  }

  // 插入数据
  insertData(data: relationalStore.ValuesBucket, callback: Function = () => {
  }) {
    if (!callback || typeof callback === 'undefined' || callback === undefined) {
      Logger.info(this.RDB_TAG, 'insertData() has no callback!');
      return;
    }
    const valueBucket: relationalStore.ValuesBucket = data
    if (this.rdbStore) {
      Logger.debug(this.RDB_TAG, this.tableName)
      this.rdbStore.insert(this.tableName, valueBucket, (err, ret) => {
        if (err) {
          Logger.error(this.RDB_TAG, `insertData() failed, err: ${err.code}, ${err.name}, ${err.message}, valueB = ${JSON.stringify(valueBucket)}, ret = ${ret}`);
          callback(false)
          return
        }
        Logger.debug(this.RDB_TAG, `insert finished: ${ret}`)
        callback(ret)
      })
    }
  }

  // 删除
  deleteData(predicates: relationalStore.RdbPredicates, callback: Function = () => {
  }) {
    if (!callback || typeof callback === 'undefined' || callback === undefined) {
      Logger.info(this.RDB_TAG, 'deleteData() has no callback!');
      return;
    }
    if (this.rdbStore) {
      this.rdbStore.delete(predicates, (err, ret) => {
        if (err) {
          Logger.error(this.RDB_TAG, `deleteData() failed, err: ${err}`);
          callback(false);
          return;
        }
        Logger.info(this.RDB_TAG, `deleteData() finished: ${ret}`);
        callback(true);
      })
    }
  }

  // 修改数据
  updateData(predicates: relationalStore.RdbPredicates, data: relationalStore.ValuesBucket, callback: Function = () => {
  }) {
    // 根据RdbPredicates 指定的实例对象更新数据库中的数据
    if (!callback || typeof callback === 'undefined' || callback === undefined) {
      Logger.info(this.RDB_TAG, 'updateDate() has no callback!');
      return;
    }
    const valueBucket: relationalStore.ValuesBucket = data
    if (this.rdbStore) {
      this.rdbStore.update(valueBucket, predicates, (err, ret) => {
        if (err) {
          Logger.error(this.RDB_TAG, `updateData() failed, err: ${err}`);
          callback(false);
          return;
        }
        Logger.info(this.RDB_TAG, `updateData() finished: ${ret}`);
        callback(true);
      })
    }
  }

  // 查询数据
  query(predicates: relationalStore.RdbPredicates, callback: Function = () => {
  }) {
    if (!callback || typeof callback === 'undefined' || callback === undefined) {
      Logger.info(this.RDB_TAG, 'queryTaskName() has no callback!');
      return;
    }
    if (this.rdbStore) {
      this.rdbStore.query(predicates).then((resultSet) => {
        Logger.debug(this.RDB_TAG, `query finished.`)
        callback(resultSet)
        resultSet.close()
      }).catch((err) => {
        if (err) {
          Logger.error(this.RDB_TAG, `query() failed, err:  ${err}`);
          return;
        }
      })
    }
  }
}
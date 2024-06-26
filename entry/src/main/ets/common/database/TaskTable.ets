// convert task-data to/from database

import relationalStore from '@ohos.data.relationalStore';
import { TaskListItemData } from '../bean/TaskListItemData'
import TaskDB from './TaskDB'
import CommonConstants from '../constants/CommonConsts'
import Logger from '../utils/Logger'

export default class TaskTable {
  private taskTable = new TaskDB(CommonConstants.TASK_TABLE_INIT.tableName, CommonConstants.TASK_TABLE_INIT.sqlCreate,
    CommonConstants.TASK_TABLE_INIT.columns)

  constructor(callback: Function = () => {}) {
    this.taskTable.getRdbStore(callback);
  }

  // test() { this.cateTable.test() }
  getRdbStore(callback: Function = () => {}) {
    this.taskTable.getRdbStore(callback)
  }

  updateColumns(newColumn: string, newColumnType: string) {
    let newColumnData: string = ''
    switch (newColumnType) {
      case 'double':
        newColumnData = 'INTEGER'
        break;
      case 'string':
        newColumnData = 'TEXT'
        break;
      case 'boolean':
        newColumnData = 'BOOLEAN'
      default:
        newColumnData = 'INTEGER'
    }
    Logger.debug(`UpdateColumns: ${newColumn} ${newColumnData}`)
    this.taskTable.updateColumns(newColumn, newColumnData)
  }

  insertData(taskData: TaskListItemData, callback: Function) {
    const valueBucket: relationalStore.ValuesBucket = generateBucket(taskData)
    this.taskTable.insertData(valueBucket, callback)
  }

  deleteData(taskData: TaskListItemData, callback: Function) {
    let predicates = new relationalStore.RdbPredicates(CommonConstants.TASK_TABLE_INIT.tableName)
    predicates.equalTo('id', taskData.id)
    this.taskTable.deleteData(predicates, callback)
  }

  updateData(taskData: TaskListItemData, callback: Function) {
    const valueBucket: relationalStore.ValuesBucket = generateBucket(taskData)
    let predicates = new relationalStore.RdbPredicates(CommonConstants.TASK_TABLE_INIT.tableName)
    predicates.equalTo('id', taskData.id)
    this.taskTable.updateData(predicates, valueBucket, callback)
  }
  queryTaskName(task_name: string, callback: Function, isAll: boolean = true) {
    let submit: TaskListItemData = new TaskListItemData(); submit.task_name = task_name
    this.basic_query("task_name", submit, callback, isAll)
    // this.query_dup(task_name, callback, isAll)
  }
  // supports multiple type all-in-one
  // 数据库查询
  basic_query(query_type: string, queryData: TaskListItemData, callback: Function, isAll: boolean = true) {
    Logger.debug(`TaskTable query_type: ${query_type}, query_data: ${JSON.stringify(queryData)}, visit: ${queryData[query_type]}`)
    let predicates = new relationalStore.RdbPredicates(CommonConstants.TASK_TABLE_INIT.tableName)
    if (!isAll) {
        if (CommonConstants.COLUMN_TYPE[query_type] == 'string') predicates.like(query_type, queryData[query_type])
      else predicates.equalTo(query_type, queryData[query_type])
    }
    this.taskTable.query(predicates, (resultSet: relationalStore.ResultSet) => {
      let count: number = resultSet.rowCount
      Logger.debug(`TaskTable number: ${count}`)
      if (count === 0 || typeof count === 'string') {
        // empty
        callback([])
      } else {
        resultSet.goToFirstRow()
        // get results
        const result: TaskListItemData[] = []
        for (let i = 0; i < count; ++i) {
          let tmp: TaskListItemData = new TaskListItemData()
          for (let t = 0; t < CommonConstants.TASK_TABLE_INIT.columns.length; ++t) {
            let nowColumn = CommonConstants.TASK_TABLE_INIT.columns[t]
            let nowIndex = resultSet.getColumnIndex(nowColumn)

            switch (CommonConstants.COLUMN_TYPE[nowColumn]) {
              case 'double':
                tmp[nowColumn] = resultSet.getDouble(nowIndex)
                break
              case 'string':
                tmp[nowColumn] = resultSet.getString(nowIndex)
                break
              case 'boolean':
                tmp[nowColumn] = Boolean(resultSet.getDouble(nowIndex))
            }

            Logger.debug(`TaskTable READING: nowC = ${nowColumn}, data = ${tmp[nowColumn]}`)
          }
          result[i] = tmp
          Logger.debug(`TaskTable Reading DATA: ${JSON.stringify(tmp)}`)
          resultSet.goToNextRow()
        }
        callback(result)
      }
    })
  }
}

function generateBucket(taskData: TaskListItemData): relationalStore.ValuesBucket {
  let obj: relationalStore.ValuesBucket = {}
  for (let i = 1; i < CommonConstants.TASK_TABLE_INIT.columns.length; ++i) {
    let nowCol = CommonConstants.TASK_TABLE_INIT.columns[i]
    obj[nowCol] = taskData[nowCol]
  }
  return obj
}

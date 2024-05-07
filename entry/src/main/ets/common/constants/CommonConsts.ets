// 定义常量变量集合
import relationalStore from '@ohos.data.relationalStore'

export default class CommonConstants {
  static readonly STORE_CONFIG: relationalStore.StoreConfig = {
    name: 'database.db',
    securityLevel: relationalStore.SecurityLevel.S1
  }
  static readonly TASK_TABLE_INIT = {
    tableName: 'taskTable',
    sqlCreate: 'CREATE TABLE IF NOT EXISTS taskTable' +
    '(id INTEGER PRIMARY KEY AUTOINCREMENT, task_name TEXT, ' +
    'subject INTEGER, start_date_stamp INTEGER, due_date_stamp INTEGER, ' +
    'is_completed BOOLEAN, detail TEXT, ddl_detail TEXT, category INTEGER, topped BOOLEAN)',
    columns: ['id', 'due_date_stamp', 'start_date_stamp', 'subject', 'detail', 'task_name', 'is_completed', 'ddl_detail', 'category', 'topped']
  }
  static readonly COLUMN_TYPE = {
    id: 'double',
    due_date_stamp: 'double',
    start_date_stamp: 'double',
    category: 'double',
    subject: 'string',
    detail: 'string',
    task_name: 'string',
    is_completed: 'boolean',
    ddl_detail: 'string',
    topped: 'boolean',
  }
}
import { AppItemModel } from 'base'

/**
 * 我的常用模拟数据
 */
const MyAppMock: AppItemModel[] = [
  {
    appId: 'app008',
    appName: '打卡',
    imageUrl: $r('app.media.app_clock'),
    pathUrl: '/pages/app/punch/clock'
  },
  {
    appId: 'app001',
    appName: '周报',
    imageUrl: $r('app.media.app_weekly'),
    pathUrl: '/pages/app/weekly/list'
  },
  {
    appId: 'app002',
    appName: '日报',
    imageUrl: $r('app.media.app_day'),
    pathUrl: '/pages/app/daily/list'
  },
]

/**
 * 所有应用
 */
const AllAppMock: AppItemModel[] = [
  {
    appId: 'app008',
    appName: '打卡',
    imageUrl: $r('app.media.app_clock'),
    pathUrl: '/pages/app/punch/clock'
  },
  {
    appId: 'app009',
    appName: '任务中心',
    imageUrl: $r('app.media.app_task'),
    pathUrl: '/pages/app/punch/clock'
  },
  {
    appId: 'app001',
    appName: '周报',
    imageUrl: $r('app.media.app_weekly'),
    pathUrl: '/pages/app/weekly/list'
  },
  {
    appId: 'app002',
    appName: '日报',
    imageUrl: $r('app.media.app_day'),
    pathUrl: '/pages/app/daily/list'
  },
  {
    appId: 'app003',
    appName: '出差报备',
    imageUrl: $r('app.media.app_goout'),
    pathUrl: '/pages/app/goOut/list'
  },
  {
    appId: 'app004',
    appName: '外出报备',
    imageUrl: $r('app.media.app_goout'),
    pathUrl: '/pages/app/goOut/list'
  },
  {
    appId: 'app005',
    appName: '迟到',
    imageUrl: $r('app.media.app_belate'),
    pathUrl: '/pages/app/lateLeave/list'
  },
  {
    appId: 'app006',
    appName: '请假',
    imageUrl: $r('app.media.app_leave'),
    pathUrl: '/pages/flow/leaveApply/list'
  },
  {
    appId: 'app007',
    appName: '加班',
    imageUrl: $r('app.media.app_overtime'),
    pathUrl: '/pages/app/workOvertime/list'
  },
  {
    appId: 'app010',
    appName: '通知公告',
    imageUrl: $r('app.media.app_notice'),
    pathUrl: '/pages/app/notice/list'
  },
  {
    appId: 'app012',
    appName: '工作日志',
    imageUrl: $r('app.media.app_schedule'),
    pathUrl: '/pages/app/schedule/list'
  }
]

export { MyAppMock, AllAppMock }
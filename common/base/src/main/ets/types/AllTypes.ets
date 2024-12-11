
/**
 * 通知栏数据
 */
interface NoticeBarModel {
  title: string;
  id: string;
  code: string;
}

/**
 * 应用项
 */
interface AppItemModel {
  appId: string;
  appName: string;
  imageUrl: string | Resource;
  pathUrl: string;
}

export { NoticeBarModel, AppItemModel }
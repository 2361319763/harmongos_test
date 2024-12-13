
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

/**
 * 联系人数据
 */
interface ContactsDataModel {
  name: Resource | string;
  code: string
  en_name: string;
  icon: Resource;
}

/**
 * 联系人首字母
 */
const Alphabets: string[] = ['#', '☆', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K',
  'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']

export { NoticeBarModel, AppItemModel, ContactsDataModel, Alphabets }
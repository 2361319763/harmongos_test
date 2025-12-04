
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
 * 语言数据
 */
interface LanguageModel {
  name: Resource | string;
  code: string;
}

/**
 * 应用配置信息
 */
interface AppConfigModel {
  baseUrl: string;
  appName: string;
  customUserAgent: string;
  appLogo: Resource | string;
  loginTitle: string;
  loginLogo: Resource | string;
  copyRight: string;
  aiRootUrl?: string;
}

/**
 * 联系人首字母
 */
const Alphabets: string[] = ['#', 'A', 'B', 'C', 'D', 'E', 'F', 'G', 'H', 'I', 'J', 'K',
  'L', 'M', 'N', 'O', 'P', 'Q', 'R', 'S', 'T', 'U', 'V', 'W', 'X', 'Y', 'Z']

export { NoticeBarModel, AppItemModel, LanguageModel, AppConfigModel, Alphabets }
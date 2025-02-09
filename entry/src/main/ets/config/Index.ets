import { AppConfigModel, StringUtils } from "jbase";

/**
 * 配置信息
 */
export const AppConfig: AppConfigModel = {
  // baseUrl: 'https://vue.ruoyi.vip/prod-api',
  baseUrl: 'http://192.168.3.27:8080',
  appLogo: $r('app.media.app_logo'),
  appName: 'JHM-OFFICE',
  loginTitle: `${StringUtils.getResStr($r('app.string.welcome_login'))}JHM`,
  loginLogo: $r('app.media.logo'),
  copyRight: `${StringUtils.getResStr($r('app.string.copy_right'))} © 2025 476743842@qq.com`
}
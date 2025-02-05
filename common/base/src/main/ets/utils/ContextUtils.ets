import { font, window } from "@kit.ArkUI";
import { hilog } from '@kit.PerformanceAnalysisKit';
import { setAppColorMode } from "./ColorModeUtils";
import { setAppLanguage } from "./LanguageUtils";
import { common } from "@kit.AbilityKit";
import { preferences } from '@kit.ArkData';
import { UserConstants } from "../constants/UserConstants";
import { BusinessError } from "@kit.BasicServicesKit";

let dataPreferences: preferences.Preferences | null = null
let windowStageObj: window.WindowStage
let appContext: common.UIAbilityContext
/**
 * 设置全局存储
 */
export const setJoaData = (key: string, value: string) => {
  if (!dataPreferences) {
    return false
  }
  dataPreferences.putSync(key, value)
  console.debug('setJoaData: ' + key + ' ' + value)
  dataPreferences.flush((err: BusinessError) => {
    if (err) {
      console.error(`Failed to flush. Code:${err.code}, message:${err.message}`)
      return
    }
    console.info('Succeeded in flushing.')
  })
  return true
}

/**
 * 获取全局存储
 */
export const getJoaData = (key: string, defaultValue: string) => {
  if (!dataPreferences) {
    return ''
  }
  return dataPreferences.getSync(key, defaultValue)
}

/**
 * 删除全局存储
 */
export const delJoaData = (key: string) => {
  if (!dataPreferences) {
    return false
  }
  dataPreferences.deleteSync(key)
  dataPreferences.flush((err: BusinessError) => {
    if (err) {
      console.error(`Failed to flush. Code:${err.code}, message:${err.message}`)
      return
    }
    console.info('Succeeded in flushing.')
  })
  return true
}


const systemCreated = (err: BusinessError, context: common.UIAbilityContext) => {
  if (err.code) {
    hilog.error(0x0000, 'testTag', 'Failed to load the content. Cause: %{public}s', JSON.stringify(err) ?? '')
    return
  }
  font.registerFont({
    familyName: 'iconfont',
    familySrc: '/fonts/iconfont.ttf'
  })
  hilog.info(0x0000, 'registerFont', '注册字体成功')
  hilog.info(0x0000, 'testTag', 'Succeeded in loading the content.')
  // 设置深色模式
  setAppColorMode(context)
  // 设置语言
  setAppLanguage(context)
}

/**
 * 初始化系统
 */
export const initSystem = (windowStage: window.WindowStage, context: common.UIAbilityContext) => {
  // 初始化全局存储
  dataPreferences = preferences.getPreferencesSync(context, { name: 'JoaStore' });
  windowStageObj = windowStage;
  appContext = context;
  let token = getJoaData(UserConstants.TOKEN_KEY, '');
  console.log('token: ' + token);
  if (!!token) {
    toIndex()
  } else {
    toLogin()
  }
}

/**
 * 跳转到首页
 */
export const toIndex = () => {
  if (!!windowStageObj) {
    windowStageObj.loadContent('pages/Index', (err) => {
      let windowClass: window.Window = windowStageObj.getMainWindowSync()
      windowClass.setWindowLayoutFullScreen(false)
      systemCreated(err, appContext)
    })
  } else {
    console.error('windowStageObj is null')
  }
}

/**
 * 跳转到登录页
 */
export const toLogin = () => {
  if (!!windowStageObj) {
    windowStageObj.loadContent('pages/Login', (err) => {
      let windowClass: window.Window = windowStageObj.getMainWindowSync()
      windowClass.setWindowLayoutFullScreen(true)
      systemCreated(err, appContext)
    })
  } else {
    console.error('windowStageObj is null')
  }
}
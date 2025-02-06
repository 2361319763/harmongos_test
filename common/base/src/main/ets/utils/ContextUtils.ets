import { UserConstants } from "../constants/UserConstants"
import { CoreUtils } from "./CoreUtils"
import preferences from "@ohos.data.preferences"

export class ContextUtils {
  static setToken = (token: string) => {
    CoreUtils.setJhmData(UserConstants.TOKEN_KEY, token);
  }
  static getToken = (): preferences.ValueType => {
    return CoreUtils.getJhmData(UserConstants.TOKEN_KEY, '');
  }
}
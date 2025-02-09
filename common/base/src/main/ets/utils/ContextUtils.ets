import { UserConstants } from "../constants/UserConstants"
import { CoreUtils } from "./CoreUtils"
import preferences from "@ohos.data.preferences"

// 用户信息
export interface UserInfo {
  avatar: string
  userId: string;
  deptId: string;
  userName: string;
  nickName: string;
  email: string;
  phonenumber: string;
  sex: string;
  roleIds: Array<string> | null;
  postIds: Array<string> | null;
  admin: boolean;
  remark: string;
  createTime: string;
}

export class ContextUtils {
  // token信息
  static setToken = (token: string) => {
    CoreUtils.setJhmData(UserConstants.TOKEN_KEY, token);
  }
  static getToken = (): preferences.ValueType => {
    return CoreUtils.getJhmData(UserConstants.TOKEN_KEY, '');
  }
  // 上下文信息
  static setUserInfo = (userInfo: UserInfo) => {
    CoreUtils.setJhmData(UserConstants.CTT_KEY, userInfo);
  }
  static getUserInfo = (): UserInfo | null => {
    const userInfoStr: string = JSON.stringify(CoreUtils.getJhmData(UserConstants.CTT_KEY, ''));
    const userInfo: UserInfo = JSON.parse(userInfoStr);
    return userInfo;
  }
}
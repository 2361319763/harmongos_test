import { RequestUtils } from "base"
import { AppConfig } from "../config/Index"
import { http } from "@kit.NetworkKit"

export interface LoginParams {
  username: string;
  password: string;
  code: string;
  uuid: string;
}

// 登录方法
export const login = (params: LoginParams): Promise<object> => {
  return RequestUtils.request({
    url: AppConfig.baseUrl + '/login',
    method: http.RequestMethod.POST,
    headers: {
      isToken: false
    },
    data: params
  })
}

// 获取用户详细信息
export const getUserInfo = (): Promise<object> => {
  return RequestUtils.request({
    url: AppConfig.baseUrl + '/getInfo',
    method: http.RequestMethod.GET
  })
}

// 退出方法
export const logout = (): Promise<object> => {
  return RequestUtils.request({
    url: AppConfig.baseUrl + '/logout',
    method: http.RequestMethod.POST
  })
}

// 获取验证码
export const getCodeImg = (): Promise<object> => {
  return RequestUtils.request({
    url: AppConfig.baseUrl + '/captchaImage',
    method: http.RequestMethod.GET,
    headers: {
      isToken: false
    },
    timeout: 20000
  })
}

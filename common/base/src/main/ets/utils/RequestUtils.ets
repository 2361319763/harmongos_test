import { http } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { ContextUtils } from './ContextUtils';
import { CoreUtils } from './CoreUtils';
import { StringUtils } from './StringUtils';
import { BaseConstants } from '../constants/BaseConstants';
import { UserConstants } from '../constants/UserConstants';
/**
 * 请求工具类
 */
export interface RequestConfig {
  url: string;
  headers?: RequestHeaders;
  method: http.RequestMethod;
  data?: object;
  timeout?: number;
}

export interface RequestHeaders {
  isToken?: boolean;
  Authorization?: string;
  'Content-Type'?: string;
}

export class RequestUtils {

  static request = (config: RequestConfig) => {
    // 是否需要设置 token
    let isToken = true;
    let headerObj: RequestHeaders = {};
    if (!!config.headers && config.headers?.isToken === false) {
      isToken = false;
    } else {
      headerObj.Authorization = 'Bearer ' + ContextUtils.getToken();
      console.log('Authorization:' + headerObj.Authorization)
    }
    let httpRequest = http.createHttp();
    const promise: Promise<object> = new Promise((resolve: Function, reject: Function) => {
      httpRequest.request(
        config.url,
        {
          method: config.method,
          header: headerObj,
          expectDataType: http.HttpDataType.OBJECT,
          extraData: config.data ? config.data : null,
          connectTimeout: config.timeout ? config.timeout : 30000,
          readTimeout: config.timeout ? config.timeout : 30000
        },
        (err: BusinessError, data: http.HttpResponse) => {
          if (!err) {
            console.info(config.url + ', result:' + JSON.stringify(data.result));
            httpRequest.destroy();
            let code: number = data.result['code'] || 200;
            let defaultMsg = StringUtils.getResStr($r('app.string.request_err_none'));
            let msg: string = getErrorMessage(code) || data.result['msg'] || defaultMsg;
            if (code == 401) {
              AlertDialog.show(
                {
                  title: $r('app.string.tips'),
                  message: $r('app.string.to_login_tips'),
                  cornerRadius: BaseConstants.BORDER_RADIUS,
                  height: 200,
                  primaryButton: { value: $r('app.string.nobtn'), action: () => { }},
                  secondaryButton: {
                    value: $r('app.string.re_login'),
                    action: () => {
                      CoreUtils.delStorageData(UserConstants.TOKEN_KEY)
                      CoreUtils.toLogin()
                    }
                  }
                }
              )
              reject($r('app.string.login_timeout'))
            } else if (code === 500) {
              CoreUtils.toast(msg)
              reject('500')
            } else if (code !== 200) {
              CoreUtils.toast(msg)
              reject(code)
            }
            resolve(data.result);
          } else {
            console.error( config.url + ', error:' + JSON.stringify(err));
            httpRequest.off('headersReceive');
            httpRequest.destroy();
            const message = StringUtils.getResStr($r('app.string.request_error')) + '[' + err.code + ']';
            CoreUtils.toast(message);
            reject(err);
          }
        }
      );
    })
    return promise;
  }

}

const getErrorMessage = (code: number) => {
  let message = '';
  switch (code) {
    case 401:
      message = StringUtils.getResStr($r('app.string.request_err_401'));
      break;
    case 403:
      message = StringUtils.getResStr($r('app.string.request_err_403'));
      break;
    case 404:
      message = StringUtils.getResStr($r('app.string.request_err_404'));
      break;
  }
  return message
}
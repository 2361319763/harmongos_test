import { http } from '@kit.NetworkKit';
import { BusinessError } from '@kit.BasicServicesKit';
import { ContextUtils } from './ContextUtils';
import { CoreUtils } from './CoreUtils';
import { StringUtils } from './StringUtils';

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

/**
 * 请求工具类
 */
export class RequestUtils {

  static request = (config: RequestConfig) => {
    // 是否需要设置 token
    let isToken = true;
    let headerObj: RequestHeaders = {};
    if (!!config.headers && config.headers?.isToken === false) {
      isToken = false;
    } else {
      headerObj.Authorization = 'Bearer ' + ContextUtils.getToken();
    }
    let httpRequest = http.createHttp();
    const promise: Promise<object> = new Promise((resolve: Function, reject: Function) => {
      httpRequest.request(
        config.url,
        {
          method: config.method,
          header: headerObj,
          expectDataType: http.HttpDataType.OBJECT,
          extraData: config.data ? config.data : '',
          connectTimeout: config.timeout ? config.timeout : 30000,
          readTimeout: config.timeout ? config.timeout : 30000
        },
        (err: BusinessError, data: http.HttpResponse) => {
          if (!err) {
            console.info('result:' + JSON.stringify(data.result));
            httpRequest.destroy();
            resolve(data.result);
          } else {
            console.error('error:' + JSON.stringify(err));
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

export class StringUtils {

  /**
   * 获取资源字符串
   * @param str 资源
   * @param compThis this对象
   */
  static getResStr(str: Resource) {
    return getContext().resourceManager.getStringSync(str.id);
  }

  /**
   * 解析字符串参数
   * @param url
   * @param key
   * @returns
   */
  static getQueryParam(url: string, key: string): string | null {
    const params = url.split('?')[1] ?? url; // 兼容可能已有 ?
    const pairs = params.split('&');

    for (const pair of pairs) {
      const GeneratedDestructArray = pair.split('=');
      const k = GeneratedDestructArray[0];
      const v = GeneratedDestructArray[1];
      if (k === key) {
        return decodeURIComponent(v);
      }
    }
    return null;
  }

}
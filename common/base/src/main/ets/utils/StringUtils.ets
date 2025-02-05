
export class StringUtils {

  /**
   * 获取资源字符串
   * @param str 资源
   * @param compThis this对象
   */
  static getResStr(str: Resource, compThis: Object) {
    return getContext(compThis).resourceManager.getStringSync(str.id);
  }

}
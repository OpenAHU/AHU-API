import got from "got";

export const handler = async (event, context) => {
  const xh = event.queryString.xh;
  if (xh == undefined) throw new Error("请检查是否已经登录");
  return new Promise(async (resolve, _) => {
    try {
      const result = await got(`http://kskw.ahu.edu.cn/bkcx.asp?xh=${xh}`).text();
      resolve({ statusCode: 200, body: result });
    } catch (err) { throw new Error(err) }
  })
}

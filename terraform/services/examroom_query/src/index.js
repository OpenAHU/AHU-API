import axios from "axios";

export const handler = async (event, context) => {
  console.log(event);
  console.log(context);
  const xh = event.queryString.xh;
  if (xh == undefined) {
    throw new Error("请检查是否已经登录")
  }
  return new Promise((resolve, _) => {
    axios.get(`http://kskw.ahu.edu.cn/bkcx.asp?xh=${xh}`).then(res => {
      resolve({
        statusCode: 200,
        body: res.data
      });
    }).catch(err => {
      throw new Error(err)
    });
  })
};

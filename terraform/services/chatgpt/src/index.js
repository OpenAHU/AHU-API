require('isomorphic-unfetch');

const condition = [
  '如果以下问题超出校园日常使用的目的，直接回答BADAPPLE',
  '如果以下问题有任何政治风险，直接回答BADAPPLE',
  '如果以下问题有任何违法风险，直接回答BADAPPLE',
  '如果以下问题可能会伤害到任何人，直接回答BADAPPLE',
  '如果以上都不符合，用中文回答[Q：]后面的问题',
];

exports.handler = async (event, context) => {
  console.log(event);
  const { ChatGPTAPI } = await import('chatgpt');
  const { q, more } = JSON.parse(event.body);
  if (q == undefined) {
    return {
      statusCode: 400,
      body: 'QwQ，我这里没有收到问题呢',
    };
  }

  const api = new ChatGPTAPI({
    apiKey: process.env.OpenAI_API_KEY,
  });

  const question_text = condition.join('\n') + '\n' + `Q：${q}` + (more ? `\n，补充信息是${more}` : '') + '200字以内';

  try {
    const res = await api.sendMessage(question_text);
    if (res.text.includes('BADAPPLE')) {
      return {
        statusCode: 200,
        body: 'QwQ，也许是我误会了什么，但是这个问题好像不太合适呢',
      };
    }
    return {
      statusCode: 200,
      body: res.text,
    };
  } catch (err) {
    return {
      statusCode: 500,
      body: '神秘的未知错误~',
    };
  }
};

import fs from 'fs';
import path from 'path';

const quotes = [
  "デジタルギフト。それは24四半期連続で広がり続ける新しい価値の証明。",
  "四半期で63億を突破したその巨大な流れは単なる数字の記録ではない。",
  "株主への優待という既存の枠を超え、企業と人の関わり方を根底から静かに変えてゆく。",
  "2028年に500社が導入する国内最大規模の未来の還元。",
  "この静かな金融の変革を見逃さないよう、今すぐ保存しておいてください。"
];

const VOICEVOX_HOST = 'http://127.0.0.1:50021';
const FALLBACK_SPEAKER_ID = 2; // 四国めたん ノーマル

async function getSpeakerId(nameLike) {
  try {
    const res = await fetch(`${VOICEVOX_HOST}/speakers`);
    const speakers = await res.json();
    for (const speaker of speakers) {
      if (speaker.name.includes(nameLike)) {
        return speaker.styles[0].id;
      }
    }
  } catch (e) {
    console.warn("Could not fetch speakers automatically, using fallback ID.");
  }
  return null;
}

async function generateAudio() {
  console.log("VOICEVOXを検索中...");
  // 「東北ずん子」を自動検索
  const speakerId = await getSpeakerId('ずん子') || FALLBACK_SPEAKER_ID;
  console.log(`Using VOICEVOX speaker ID: ${speakerId}`);

  let audioDurations = {};
  
  for (let i = 0; i < quotes.length; i++) {
    const text = quotes[i];
    console.log(`[${i+1}/${quotes.length}] 生成中: ${text}`);

    const queryUrl = `${VOICEVOX_HOST}/audio_query?text=${encodeURIComponent(text)}&speaker=${speakerId}`;
    let queryRes;
    try {
      queryRes = await fetch(queryUrl, { method: 'POST' });
    } catch(e) {
      console.error("\n❌ VOICEVOXアプリが起動していません！VOICEVOXを起動してから再度実行してください。");
      process.exit(1);
    }
    const queryJson = await queryRes.json();
    
    // 超ハイテンポ（ショート動画向け）に振り切る
    queryJson.speedScale = 1.35; 
    queryJson.pitchScale = 0.02;
    
    const synthUrl = `${VOICEVOX_HOST}/synthesis?speaker=${speakerId}`;
    const synthRes = await fetch(synthUrl, {
      method: 'POST',
      headers: { 'Content-Type': 'application/json' },
      body: JSON.stringify(queryJson)
    });
    
    const arrayBuffer = await synthRes.arrayBuffer();
    const buffer = Buffer.from(arrayBuffer);
    
    const outPath = path.join(process.cwd(), 'public', `voice_${i}.wav`);
    fs.writeFileSync(outPath, buffer);
    
    // 正確な秒数をWAVバイナリのヘッダから計算 (dataSize / byteRate)
    const byteRate = buffer.readUInt32LE(28);
    let dataSize = buffer.readUInt32LE(40);
    if(dataSize === 0) dataSize = buffer.length - 44; 
    const durationSeconds = dataSize / byteRate;
    audioDurations[i] = durationSeconds;
    
    console.log(` => 保存完了: ${outPath} (尺: ${durationSeconds.toFixed(2)}秒)`);
  }
  
  const metaPath = path.join(process.cwd(), 'public', 'audio_metadata.json');
  fs.writeFileSync(metaPath, JSON.stringify(audioDurations, null, 2));
  console.log('\n✨ 全てのナレーション音声の生成と尺の計算が完了しました！');
}

generateAudio();

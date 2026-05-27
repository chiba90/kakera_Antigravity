import { AbsoluteFill, Sequence, Audio, staticFile } from "remotion";
import { ArticleQuote } from "./components/ArticleQuote";
import { Outro } from "./components/Outro";
import audioDurations from "../public/audio_metadata.json";

export const KakeraJournalVideo: React.FC = () => {
  const quotes = [
    { text: "デジタルギフト。それは24四半期連続で広がり続ける新しい価値の証明。", image: "ako_dantsu_eyecatch.png" },
    { text: "四半期で63億を突破したその巨大な流れは単なる数字の記録ではない。", image: "ako_dantsu_h2_technique.png" },
    { text: "株主への優待という既存の枠を超え、企業と人の関わり方を根底から静かに変えてゆく。", image: "ako_dantsu_h2_concept.png" },
    { text: "2028年に500社が導入する国内最大規模の未来の還元。", image: "ako_dantsu_h3_diagram.png" },
    { text: "この静かな金融の変革を見逃さないよう、今すぐ保存しておいてください。", image: "ako_dantsu_h2_future.png" }
  ];

  // Dynamic calculation of ArticleQuote length based on voiceover metadata
  let articleDuration = 0;
  const transitionDuration = 15; // half second overlap for short rhythm
  for (let i = 0; i < quotes.length; i++) {
    const audioLenSeconds = (audioDurations as any)[i] || 5;
    const quoteDuration = Math.ceil(audioLenSeconds * 30) + 30;
    articleDuration += quoteDuration;
  }
  articleDuration -= (quotes.length - 1) * transitionDuration;

  return (
    <AbsoluteFill className="bg-kakera-bg">
      <Audio src={staticFile("bgm.mp3")} volume={0.15} />

      <Sequence from={0} durationInFrames={articleDuration}>
        <ArticleQuote quotes={quotes} />
      </Sequence>

      <Sequence from={articleDuration} durationInFrames={90}>
        <Outro />
      </Sequence>
    </AbsoluteFill>
  );
};

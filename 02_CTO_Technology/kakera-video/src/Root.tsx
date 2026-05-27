import "./index.css";
import { Composition } from "remotion";
import { KakeraJournalVideo } from "./Composition";
import audioDurations from "../public/audio_metadata.json";

export const RemotionRoot: React.FC = () => {
  // calculate dynamic length 
  let articleDuration = 0;
  const numQuotes = Object.keys(audioDurations).length; // normally 6-7
  const transitionDuration = 15; // 0.5s overlap

  for (let i = 0; i < numQuotes; i++) {
    const audioLenSeconds = (audioDurations as any)[i] || 5;
    const quoteDuration = Math.ceil(audioLenSeconds * 30) + 30;
    articleDuration += quoteDuration;
  }
  // subtract overlaps
  articleDuration -= (numQuotes - 1) * transitionDuration;
  
  // No slow intro. Direct to Article, then 90 frames of Outro.
  const totalDuration = articleDuration + 90;

  return (
    <>
      <Composition
        id="KakeraJournalVideo"
        component={KakeraJournalVideo}
        durationInFrames={totalDuration}
        fps={30}
        width={1080}
        height={1920}
      />
    </>
  );
};

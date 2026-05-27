import { AbsoluteFill, useCurrentFrame, useVideoConfig, interpolate, Img, staticFile, Sequence, Audio } from "remotion";
import audioDurations from "../../public/audio_metadata.json";

export const ArticleQuote: React.FC<{ quotes: { text: string; image: string }[] }> = ({ quotes }) => {
  const transitionDuration = 15; // 0.5s rapid crossfade
  
  let currentStartFrame = 0;

  return (
    <AbsoluteFill className="bg-kakera-bg">
      {quotes.map((quote, i) => {
        const audioLenSeconds = (audioDurations as any)[i] || 5;
        const quoteDuration = Math.ceil(audioLenSeconds * 30) + 30; // Increased padding to prevent audio clipping
        
        const sequenceStart = currentStartFrame;
        currentStartFrame = sequenceStart + quoteDuration - transitionDuration;

        return (
          <Sequence key={i} from={sequenceStart} durationInFrames={quoteDuration}>
            <QuoteItem quote={quote} duration={quoteDuration} index={i} transition={transitionDuration} />
          </Sequence>
        );
      })}
    </AbsoluteFill>
  );
};

const QuoteItem: React.FC<{ quote: { text: string; image: string }; duration: number; index: number; transition: number }> = ({ quote, duration, index, transition }) => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();

  // Majestic slow fade
  const opacity = interpolate(
    frame,
    [0, fps * 1.5, duration - transition, duration],
    [0, 1, 1, 0],
    { extrapolateLeft: "clamp", extrapolateRight: "clamp" }
  );

  const imageScale = interpolate(
    frame,
    [0, duration],
    [1.0, 1.15],
    { extrapolateLeft: "clamp", extrapolateRight: "clamp" }
  );
  
  const textTranslateY = interpolate(
    frame,
    [0, duration],
    [30, -30],
    { extrapolateLeft: "clamp", extrapolateRight: "clamp" }
  );
  const textBlur = interpolate(
    frame,
    [0, fps, duration - transition, duration],
    [10, 0, 0, 10], // faster focus
    { extrapolateLeft: "clamp", extrapolateRight: "clamp" }
  );

  return (
    <AbsoluteFill>
      <Audio src={staticFile(`voice_${index}.wav`)} volume={0.8} />
      <Img 
        src={staticFile(quote.image)} 
        style={{
          width: '100%',
          height: '100%',
          objectFit: 'cover', // Automatically centers and scales for vertical
          transform: `scale(${imageScale})`,
          opacity: opacity * 0.55 // slightly brighter for mobile
        }}
      />
      <AbsoluteFill className="items-center justify-center flex px-12 pb-20">
        <div 
          style={{ 
            opacity, 
            transform: `translateY(${textTranslateY}px)`,
            filter: `blur(${textBlur}px)`
          }}
          className="text-kakera-text font-serif text-6xl leading-[1.8] tracking-widest font-normal drop-shadow-2xl text-center w-full"
        >
          {quote.text.split("。").filter(Boolean).map((sentence, j) => (
            <p key={j} className="mb-6">{sentence}。</p>
          ))}
        </div>
      </AbsoluteFill>
    </AbsoluteFill>
  );
};

import { AbsoluteFill, useCurrentFrame, useVideoConfig, spring, interpolate } from "remotion";

export const Intro: React.FC = () => {
  const frame = useCurrentFrame();
  const { fps } = useVideoConfig();

  const opacity = interpolate(
    frame,
    [0, fps * 1.5, fps * 2.5, fps * 3],
    [0, 1, 1, 0],
    { extrapolateLeft: "clamp", extrapolateRight: "clamp" }
  );

  const scale = interpolate(
    frame,
    [0, fps * 3],
    [0.95, 1.05]
  );

  return (
    <AbsoluteFill className="bg-kakera-bg items-center justify-center flex">
      <div 
        style={{ opacity, transform: `scale(${scale})` }}
        className="text-kakera-text font-serif text-5xl tracking-[0.3em] font-light"
      >
        Kakera JOURNAL
      </div>
    </AbsoluteFill>
  );
};

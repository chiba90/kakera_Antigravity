import { AbsoluteFill, useCurrentFrame, useVideoConfig, spring, interpolate } from "remotion";

export const Outro: React.FC = () => {
  const frame = useCurrentFrame();
  const { fps, durationInFrames } = useVideoConfig();

  const opacity = interpolate(
    frame,
    [0, fps * 1.5, durationInFrames - fps, durationInFrames],
    [0, 1, 1, 0],
    { extrapolateLeft: "clamp", extrapolateRight: "clamp" }
  );

  return (
    <AbsoluteFill className="bg-kakera-bg items-center justify-center flex flex-col">
      <div 
        style={{ opacity }}
        className="text-kakera-text font-serif flex flex-col items-center"
      >
        <div className="text-3xl tracking-[0.4em] font-light mb-6">
          Kakera
        </div>
        <div className="text-sm tracking-[0.2em] font-light opacity-60">
          kakera.inc
        </div>
      </div>
    </AbsoluteFill>
  );
};

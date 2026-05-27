import { AbsoluteFill, useCurrentFrame, useVideoConfig, spring, interpolate } from "remotion";

export const TitleCard: React.FC<{ title: string; subtitle?: string }> = ({ title, subtitle }) => {
  const frame = useCurrentFrame();
  const { fps, durationInFrames } = useVideoConfig();

  const opacity = interpolate(
    frame,
    [0, fps, durationInFrames - fps, durationInFrames],
    [0, 1, 1, 0],
    { extrapolateLeft: "clamp", extrapolateRight: "clamp" }
  );

  const translateY = interpolate(
    frame,
    [0, durationInFrames],
    [20, -20]
  );

  return (
    <AbsoluteFill className="bg-kakera-bg items-center justify-center flex px-12">
      <div 
        style={{ opacity, transform: `translateY(${translateY}px)` }}
        className="text-kakera-text font-serif text-center"
      >
        {subtitle && (
          <p className="text-xl tracking-widest mb-8 opacity-70">{subtitle}</p>
        )}
        <h1 className="text-5xl leading-relaxed tracking-widest font-light" style={{ wordBreak: 'keep-all' }}>
          {title}
        </h1>
      </div>
    </AbsoluteFill>
  );
};

const googleTrends = require('google-trends-api');

googleTrends.interestOverTime({
  keyword: ['唐紙', '能面', '伊勢大神楽'],
  startTime: new Date(Date.now() - 30 * 24 * 60 * 60 * 1000), // 直近30日
  geo: 'JP',
})
.then((res) => {
  const data = JSON.parse(res);
  console.log("=== GOOGLE TRENDS COMPARISON (30 DAYS, JP) ===");
  
  const timelineData = data.default.timelineData;
  if (!timelineData || timelineData.length === 0) {
    console.log("No data found.");
    return;
  }
  
  console.log("\
--- Timeline Data (Last 10 Days) ---");
  const last10 = timelineData.slice(-10);
  last10.forEach(day => {
    const date = new Date(day.time * 1000).toISOString().split('T')[0];
    const vals = day.value;
    console.log(`Date: ${date} | 唐紙: ${vals[0]} | 能面: ${vals[1]} | 伊勢大神楽: ${vals[2]}`);
  });
  
  const averages = [0, 0, 0];
  timelineData.forEach(day => {
    averages[0] += day.value[0];
    averages[1] += day.value[1];
    averages[2] += day.value[2];
  });
  averages[0] = Math.round(averages[0] / timelineData.length);
  averages[1] = Math.round(averages[1] / timelineData.length);
  averages[2] = Math.round(averages[2] / timelineData.length);
  
  console.log("\
--- 30-Day Averages (Relative Score 0-100) ---");
  console.log(`唐紙        : ${averages[0]}`);
  console.log(`能面        : ${averages[1]}`);
  console.log(`伊勢大神楽   : ${averages[2]}`);
  
  const peaks = [0, 0, 0];
  timelineData.forEach(day => {
    if (day.value[0] > peaks[0]) peaks[0] = day.value[0];
    if (day.value[1] > peaks[1]) peaks[1] = day.value[1];
    if (day.value[2] > peaks[2]) peaks[2] = day.value[2];
  });
  console.log("\
--- 30-Day Peak Scores (Relative Score 0-100) ---");
  console.log(`唐紙        : ${peaks[0]}`);
  console.log(`能面        : ${peaks[1]}`);
  console.log(`伊勢大神楽   : ${peaks[2]}`);
})
.catch((err) => {
  console.error("Error fetching data from Google Trends:", err);
});

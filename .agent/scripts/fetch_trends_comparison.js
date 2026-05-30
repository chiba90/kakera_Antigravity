const googleTrends = require('google-trends-api');

googleTrends.interestOverTime({
  keyword: ['東京手仕事', '萬翠楼福住', 'い草'],
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
  
  console.log("\n--- Timeline Data (Last 10 Days) ---");
  const last10 = timelineData.slice(-10);
  last10.forEach(day => {
    const date = new Date(day.time * 1000).toISOString().split('T')[0];
    const vals = day.value;
    console.log(`Date: ${date} | 東京手仕事: ${vals[0]} | 萬翠楼福住: ${vals[1]} | い草: ${vals[2]}`);
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
  
  console.log("\n--- 30-Day Averages (Relative Score 0-100) ---");
  console.log(`東京手仕事   : ${averages[0]}`);
  console.log(`萬翠楼福住   : ${averages[1]}`);
  console.log(`い草         : ${averages[2]}`);
  
  const peaks = [0, 0, 0];
  timelineData.forEach(day => {
    if (day.value[0] > peaks[0]) peaks[0] = day.value[0];
    if (day.value[1] > peaks[1]) peaks[1] = day.value[1];
    if (day.value[2] > peaks[2]) peaks[2] = day.value[2];
  });
  console.log("\n--- 30-Day Peak Scores (Relative Score 0-100) ---");
  console.log(`東京手仕事   : ${peaks[0]}`);
  console.log(`萬翠楼福住   : ${peaks[1]}`);
  console.log(`い草         : ${peaks[2]}`);
})
.catch((err) => {
  console.error("Error fetching data from Google Trends:", err);
});

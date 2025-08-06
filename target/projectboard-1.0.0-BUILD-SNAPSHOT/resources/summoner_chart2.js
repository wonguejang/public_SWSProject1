window.addEventListener('DOMContentLoaded', () => {
	const ctx2 = document.getElementById('summoner_chart2').getContext('2d');
	
	const wins = 11;
	const losses = 9;
	const totalGames = wins + losses;
	const winRate = Math.round((wins / totalGames) * 100);
	
	// 차트 생성
	new Chart(ctx2, {
	  type: 'doughnut',
	  data: {
	    labels: ['승', '패'],
	    datasets: [{
	      data: [wins, losses],
	      backgroundColor: ['rgb(11, 137, 207)', 'rgba(255, 255, 255, 0.05)'],
	      borderWidth: 1
	    }]
	  },
	  options: {
	    cutout: '80%',
	    responsive: false,
	    plugins: {
	      legend: {
	        display: false
	      }
	    }
	  },
	  plugins: [{
	    id: 'centerText',
	    afterDraw(chart) {
	      const {width, height, ctx} = chart;
	      ctx.save();
	      ctx.font = 'bold 15px sans-serif';
	      ctx.textAlign = 'center';
	      ctx.textBaseline = 'middle';
	
	      // 동적으로 색상 결정
	      ctx.fillStyle = winRate >= 50 ? 'rgb(11, 137, 207)' : 'rgb(200, 50, 50)';
	
	      ctx.fillText(`${winRate}%`, width / 2, height / 2);
	      ctx.restore();
	    }
	  }]
	});
});
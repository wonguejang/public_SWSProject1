window.addEventListener('DOMContentLoaded', () => {
	const ctx = document.getElementById('summoner_chart').getContext('2d');
	
	// 원본 데이터
	const labels = ['05.11', '05.12', '05.13', '05.14', '05.15', '05,16'];
	const winrates = [50.2, 47.1, 53.0, 50.3, 52.5, 50.8];
	
	// 최대/최소 계산
	const maxValue = Math.max(...winrates);
	const minValue = Math.min(...winrates);
	
	// 여유 비율 설정
	const marginRatio = 0.05;
	const range = maxValue - minValue;
	const margin = range * marginRatio;
	
	// 상하 한계 설정
	const topLimit = Math.ceil((maxValue + margin) * 10) / 10;
	const bottomLimit = Math.floor((minValue - margin) * 10) / 10;
	
	// Chart.js 설정
	const data = {
	  labels: labels,
	  datasets: [{
	    label: '승률 (%)',
	    data: winrates,
	    fill: false,
	    borderColor: 'rgba(75, 192, 192, 1)',
	    tension: 0.3,
	    pointBackgroundColor: 'rgba(75, 192, 192, 1)', // 점 색
	    pointRadius: 4
	  }]
	};
	
	const config = {
	  type: 'line',
	  data: data,
	  options: {
	    plugins: {
	      legend: {
	        labels: {
	          color: '#fff', // 글자색 (필요하면 배경색 대비 맞춰서 수정)
	          usePointStyle: true,
	          pointStyle: 'line'
	        }
	      }
	    },
	    scales: {
	      y: {
	        beginAtZero: false,
	        min: bottomLimit,
	        max: topLimit,
	        ticks: {
	          callback: function(value) {
	            return value + '%';
	          },
	          color: '#ccc'
	        },
	        grid: {
	          color: '#444'
	        }
	      },
	      x: {
	        ticks: {
	          color: '#ccc'
	        },
	        grid: {
	          color: '#444'
	        }
	      }
	    }
	  }
	};
	
	new Chart(ctx, config);
});
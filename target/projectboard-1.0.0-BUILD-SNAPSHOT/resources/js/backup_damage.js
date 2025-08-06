(function () {
    const redCtx = document.getElementById('redChart').getContext('2d');
    const blueCtx = document.getElementById('blueChart').getContext('2d');

    const redPlayers = [
        { name: "BornAnew#1225", damage: 22604 },
        { name: "DK Sharvel#KR1", damage: 9895 },
        { name: "vital#0916", damage: 15523 },
        { name: "Archer#0504", damage: 10714 },
        { name: "훌러덩#KR4", damage: 7343 }
    ];

   const bluePlayers = [
        { name: "akdakkdl#4992", damage: 17275 },
        { name: "can see you#66666", damage: 8687 },
        { name: "온 재#KR1", damage: 13183 },
        { name: "화이팅가보자#KR1", damage: 9364 },
        { name: "몽글몽글#하리보", damage: 4077 }
    ];

    function createRedChart(ctx, players) {
        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: players.map(p => p.name),
                datasets: [{
                    data: players.map(p => p.damage),
                    backgroundColor: 'rgba(255, 99, 132, 0.7)',
                    borderRadius: 1,
                    barThickness: 2,
                }]
            },
            options: {
                indexAxis: 'y',
                scales: {
                    x: {
                        beginAtZero: true,
                        ticks: { color: '#fff', font: { size: 10 } },
                        grid: { color: 'rgba(255,255,255,0.2)' }
                    },
                    y: {
                        ticks: { color: '#fff', font: { size: 10 } }
                    }
                },
                plugins: {
                    legend: { display: false },
                    tooltip: {
                        callbacks: {
                            label: ctx => `딜량: ${ctx.raw.toLocaleString()}`
                        }
                    },
                    datalabels: {
                        color: '#fff',
                        anchor: 'end',
                        align: 'end',
                        font: { weight: 'bold', size: 10 },
                        formatter: (_, ctx) => ctx.chart.data.labels[ctx.dataIndex]
                    }
                }
            },
            plugins: [ChartDataLabels]
        });
    }

    function createBlueChart(ctx, players) {
        const maxDamage = Math.max(...players.map(p => p.damage));
        const negativeDamages = players.map(p => -p.damage);

        new Chart(ctx, {
            type: 'bar',
            data: {
                labels: players.map(p => p.name),
                datasets: [{
                    data: negativeDamages,
                    backgroundColor: 'rgba(54, 162, 235, 0.7)',
                    borderRadius: 1,
                    barThickness: 1,
                }]
            },
            options: {
                indexAxis: 'y',
                scales: {
                    x: {
                        min: -maxDamage,
                        max: 0,
                        ticks: {
                            color: '#fff',
                            font: { size: 12 },
                            callback: val => Math.abs(val)
                        },
                        grid: { color: 'rgba(255,255,255,0.2)' }
                    },
                    y: {
                        ticks: { color: '#fff', font: { size: 10 } }
                    }
                },
                plugins: {
                    legend: { display: false },
                    tooltip: {
                        callbacks: {
                            label: ctx => `딜량: ${Math.abs(ctx.raw).toLocaleString()}`
                        }
                    },
                    datalabels: {
                        color: '#fff',
                        anchor: 'start',
                        align: 'start',
                        font: { weight: 'bold', size: 1 },
                        formatter: (_, ctx) => ctx.chart.data.labels[ctx.dataIndex]
                    }
                }
            },
            plugins: [ChartDataLabels]
        });
    }

    createRedChart(redCtx, redPlayers);
    createBlueChart(blueCtx, bluePlayers);
})();
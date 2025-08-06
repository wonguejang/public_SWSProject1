const bluebarNameLabelPlugin = {
    id: 'barNameLabel',
    afterDatasetsDraw(chart) {
        const { ctx, data } = chart;
        const dataset = chart.getDatasetMeta(0).data;

        dataset.forEach((bar, index) => {
            const name = data.labels[index];

            ctx.save();
            ctx.font = '11px sans-serif';
            ctx.fillStyle = 'white';
            ctx.textAlign = 'right';
            ctx.textBaseline = 'bottom';

            const textX = bar.base - 4;
            const textY = bar.y - bar.height / 2 - 2;

            ctx.fillText(name, textX, textY);
            ctx.restore();
        });
    }
};

function createBlueChart(ctx, players) {
    const maxDamage = Math.max(...players.map(p => p.damage));
    const negativeDamages = players.map(p => -p.damage);

    new Chart(ctx, {
        type: 'bar',
        data: {
            labels: players.map(p => p.nickname),
            datasets: [{
                data: negativeDamages,
                backgroundColor: 'rgba(54, 162, 235, 0.7)',
                borderRadius: 1,
                barThickness: 2,
                barPercentage: 0.4,
                categoryPercentage: 0.4,
            }]
        },
        options: {
            layout: { padding: { top: 20 } },
            indexAxis: 'y',
            interaction: {
                mode: 'index',
                intersect: false,
                axis: 'y'
            },
            scales: {
                y: { ticks: { display: false }, grid: { display: false } },
                x: {
                    min: -maxDamage,
                    max: 0,
                    ticks: { display: false },
                    grid: { display: false }
                }
            },
            plugins: {
                legend: { display: false },
                tooltip: {
                    callbacks: {
                        label: ctx => `딜량: ${Math.abs(ctx.raw).toLocaleString()}`
                    }
                }
            }
        },
        plugins: [bluebarNameLabelPlugin]
    });
}
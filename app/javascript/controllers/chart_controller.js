import { Controller } from "@hotwired/stimulus"

// Admin dashboard chart controller
// Renders Chart.js charts from JSON data attributes.
// Usage: <canvas data-controller="chart"
//               data-chart-type-value="line"
//               data-chart-data-value='{"labels":[...],"datasets":[...]}'>
//        </canvas>
export default class extends Controller {
  static values = {
    type: { type: String, default: "line" },
    data: Object,
    options: { type: Object, default: {} }
  }

  async connect() {
    // Dynamically import Chart.js (loaded via importmap or CDN)
    const { Chart, registerables } = await import("chart.js")
    Chart.register(...registerables)

    this.chart = new Chart(this.element, {
      type: this.typeValue,
      data: this.dataValue,
      options: this.mergedOptions()
    })
  }

  disconnect() {
    this.chart?.destroy()
  }

  // Re-render when data changes (e.g. via Turbo Frame updates)
  dataValueChanged() {
    if (this.chart) {
      this.chart.data = this.dataValue
      this.chart.update()
    }
  }

  mergedOptions() {
    const defaults = {
      responsive: true,
      maintainAspectRatio: false,
      interaction: {
        intersect: false,
        mode: "index"
      },
      plugins: {
        legend: {
          position: "bottom",
          labels: {
            color: "#94a3b8",
            font: { family: "Inter", size: 12 },
            padding: 16,
            usePointStyle: true
          }
        },
        tooltip: {
          backgroundColor: "rgba(15, 23, 42, 0.9)",
          titleFont: { family: "Inter", weight: "600" },
          bodyFont: { family: "Inter" },
          padding: 12,
          cornerRadius: 8,
          borderColor: "rgba(148, 163, 184, 0.1)",
          borderWidth: 1
        }
      },
      scales: this.typeValue !== "doughnut" && this.typeValue !== "pie" ? {
        x: {
          grid: { color: "rgba(148, 163, 184, 0.08)" },
          ticks: { color: "#94a3b8", font: { family: "Inter", size: 11 } }
        },
        y: {
          grid: { color: "rgba(148, 163, 184, 0.08)" },
          ticks: { color: "#94a3b8", font: { family: "Inter", size: 11 } },
          beginAtZero: true
        }
      } : undefined
    }

    return this.deepMerge(defaults, this.optionsValue)
  }

  deepMerge(target, source) {
    const result = { ...target }
    for (const key of Object.keys(source)) {
      if (source[key] && typeof source[key] === "object" && !Array.isArray(source[key])) {
        result[key] = this.deepMerge(result[key] || {}, source[key])
      } else {
        result[key] = source[key]
      }
    }
    return result
  }
}

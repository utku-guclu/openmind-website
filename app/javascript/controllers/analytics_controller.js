import { Controller } from "@hotwired/stimulus"

// Lightweight analytics beacon controller
// Automatically tracks page views on connect and exposes an action for custom events.
// Usage: <body data-controller="analytics">
export default class extends Controller {
  connect() {
    this.sessionId = this.getOrCreateSessionId()
    this.trackPageView()
  }

  // Track a page view on initial load
  trackPageView() {
    this.sendEvent("page_view", {
      page_path: window.location.pathname,
      referrer: document.referrer || null
    })
  }

  // Track custom interactions (e.g. button clicks)
  // Usage: data-action="click->analytics#trackEvent"
  //        data-analytics-event-type-param="apply_click"
  trackEvent(event) {
    const eventType = event.params.eventType || "interaction"
    const props = event.params.properties ? JSON.parse(event.params.properties) : {}

    this.sendEvent(eventType, {
      page_path: window.location.pathname,
      ...props
    })
  }

  // Send event to the Rails analytics endpoint
  sendEvent(eventType, properties = {}) {
    const payload = {
      event_type: eventType,
      page_path: properties.page_path || window.location.pathname,
      referrer: properties.referrer || null,
      session_id: this.sessionId,
      properties: properties
    }

    // Use sendBeacon for reliability (doesn't block navigation)
    if (navigator.sendBeacon) {
      const blob = new Blob([JSON.stringify(payload)], { type: "application/json" })
      navigator.sendBeacon("/analytics/track", blob)
    } else {
      fetch("/analytics/track", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          "X-CSRF-Token": document.querySelector('meta[name="csrf-token"]')?.content
        },
        body: JSON.stringify(payload),
        keepalive: true
      }).catch(() => {})
    }
  }

  // Generate or retrieve a session-scoped ID for unique visitor tracking
  getOrCreateSessionId() {
    let id = sessionStorage.getItem("omp_session_id")
    if (!id) {
      id = crypto.randomUUID ? crypto.randomUUID() : `${Date.now()}-${Math.random().toString(36).slice(2)}`
      sessionStorage.setItem("omp_session_id", id)
    }
    return id
  }
}

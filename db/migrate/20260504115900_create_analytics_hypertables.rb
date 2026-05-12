class CreateAnalyticsHypertables < ActiveRecord::Migration[8.1]
  def up
    # Analytics events hypertable
    execute <<-SQL
      CREATE TABLE analytics_events (
        recorded_at TIMESTAMPTZ NOT NULL,
        event_type VARCHAR NOT NULL,
        page_path VARCHAR,
        referrer VARCHAR,
        country VARCHAR,
        device_type VARCHAR,
        session_id VARCHAR,
        properties JSONB DEFAULT '{}'
      );
    SQL
    execute "SELECT create_hypertable('analytics_events', 'recorded_at');" rescue ActiveRecord::StatementInvalid
    execute "CREATE INDEX idx_analytics_event_type ON analytics_events (event_type, recorded_at DESC);"
    execute "CREATE INDEX idx_analytics_session ON analytics_events (session_id, recorded_at DESC);"

    # Impact metrics hypertable
    execute <<-SQL
      CREATE TABLE impact_metrics (
        recorded_at TIMESTAMPTZ NOT NULL,
        metric_name VARCHAR NOT NULL,
        value NUMERIC NOT NULL,
        unit VARCHAR,
        source VARCHAR,
        meta JSONB DEFAULT '{}'
      );
    SQL
    execute "SELECT create_hypertable('impact_metrics', 'recorded_at');" rescue ActiveRecord::StatementInvalid
    execute "CREATE INDEX idx_impact_metric_name ON impact_metrics (metric_name, recorded_at DESC);"
  end

  def down
    execute "DROP TABLE IF EXISTS impact_metrics;"
    execute "DROP TABLE IF EXISTS analytics_events;"
  end
end

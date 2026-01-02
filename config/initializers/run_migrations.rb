if ENV["RUN_MIGRATIONS_ON_STARTUP"] == "true"
  Rails.logger.info "Running database migrations on startup"

  begin
    ActiveRecord::Migration.maintain_test_schema!

    ActiveRecord::Base.connection.migration_context.migrate
  rescue => e
    Rails.logger.error "Migration failed: #{e.message}"
    raise e
  end
end


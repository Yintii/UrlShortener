# config/initializers/run_migrations.rb
if ENV['RUN_MIGRATIONS_ON_STARTUP'] == 'true'
  Rails.application.config.after_initialize do
    begin
      puts "🟢 Running database migrations..."

      # Rails 7.2 way to get the migration context
      migration_context = ActiveRecord::Base.connection.migration_context

      # Run all pending migrations
      migration_context.migrate

      puts "✅ Migrations complete"
    rescue => e
      puts "❌ Migration failed: #{e.message}"
      raise e
    end
  end
end





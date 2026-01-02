# config/initializers/run_migrations.rb
if ENV['RUN_MIGRATIONS_ON_STARTUP'] == 'true'
  Rails.application.config.after_initialize do
    begin
      puts "🟢 Running database migrations..."

      # Get the migration paths (usually db/migrate)
      migrations_paths = ActiveRecord::Migrator.migrations_paths

      # Create a MigrationContext from paths and the schema migration class
      migration_context = ActiveRecord::MigrationContext.new(
        migrations_paths,
        ActiveRecord::Base.connection.schema_migration
      )

      # Run all pending migrations
      migration_context.migrate

      puts "✅ Migrations complete"
    rescue => e
      puts "❌ Migration failed: #{e.message}"
      raise e
    end
  end
end





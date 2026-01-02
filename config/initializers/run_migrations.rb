# config/initializers/run_migrations.rb

if ENV['RUN_MIGRATIONS_ON_STARTUP'] == 'true'
  Rails.application.config.after_initialize do
    begin
      puts "🟢 Running database migrations..."

      # Use MigrationContext directly from ActiveRecord::Base
      migrations_paths = ActiveRecord::Migrator.migrations_paths
      ActiveRecord::MigrationContext.new(
        migrations_paths,
        ActiveRecord::SchemaMigration
      ).migrate

      puts "✅ Migrations complete"
    rescue => e
      puts "❌ Migration failed: #{e.message}"
      raise e
    end
  end
end





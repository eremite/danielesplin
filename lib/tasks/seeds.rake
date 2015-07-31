namespace :db do
  namespace :seed do

    desc 'Create YAML fixtures from data in the database. TABLES=x[,y,z] SKIP_TABLES=x[,y,z].'
    task :dump => :environment do
      fixtures_dir = ENV['FIXTURES_PATH'] || Rails.root.join('db', 'seeds')
      FileUtils.mkdir_p(fixtures_dir)
      tables = ENV['TABLES'].to_s.split(',').presence || ActiveRecord::Base.connection.tables
      tables -= ENV['SKIP_TABLES'].to_s.split(',').presence || %w(sessions schema_migrations)
      conditions = '1=1'
      sql = 'SELECT * FROM %s WHERE %s ORDER BY id ASC LIMIT %d OFFSET %d'
      limit = 1000
      tables.each do |table_name|
        puts table_name = table_name.force_encoding('UTF-8')
        file_path = "#{fixtures_dir}/#{table_name}.yml"
        i, offset = 0, 0
        File.open(file_path, 'w' ) do |f|
          while !(data = ActiveRecord::Base.connection.select_all(sql % [table_name, conditions, limit, offset])).empty?
            data.each do |record|
              attributes = {}
              record.sort.each do |key, value|
                key = key.dup.force_encoding('UTF-8') if key.respond_to?(:force_encoding)
                value = value.dup.force_encoding('UTF-8') if value.respond_to?(:force_encoding)
                attributes[key] = value
              end
              f << { "#{table_name}_#{i += 1}" => attributes }.to_yaml.sub(/^---.*\n/, '')
            end
            offset += limit
          end
        end
        File.delete(file_path) if File.zero?(file_path)
      end
    end

  end
end

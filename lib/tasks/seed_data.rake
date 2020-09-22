namespace :seed_data do

  task city: :environment do
    City.unscoped.delete_all

    file_dir = Rails.root.join('data', 'seeds').to_s
    cities = JSON.parse(File.read("#{file_dir}/cities.json"))
    cities.each { |city| City.create! city }
  end

  task area: :environment do
    Area.delete_all

    file_dir = Rails.root.join('data', 'seeds').to_s
    areas = JSON.parse(File.read("#{file_dir}/areas.json"))
    areas.each { |area| Area.create! area }
  end


  task age_group: :environment do
    AgeGroup.delete_all

    file_dir = Rails.root.join('data', 'seeds').to_s
    age_groups = JSON.parse(File.read("#{file_dir}/age_groups.json"))
    age_groups.each { |group| AgeGroup.create! group }
  end

  task ad_categories: :environment do
    file_dir = Rails.root.join('data', 'seeds').to_s
    rows = YAML.load(File.open(Rails.root.join("#{file_dir}/ad_categories.yml")))
    rows.each do |category_name, items|
      category = Ad::Category.find_or_create_by name: category_name
      items.each do |item|
        category.items.create! name: item
      end
    end
  end

  task slat: :environment do
    file_dir = Rails.root.join('data', 'seeds').to_s
    rows = YAML.load(File.open(Rails.root.join("#{file_dir}/slats.json")))
    rows.each do |slat|
      Slat.create slat
    end
  end

end

class RewardsImporter
  attr_reader :errors

  def initialize(file)
    @file = file
    @errors = []
  end

  def import
    return false unless file_present? && valid_format? && titles_unique?

    Reward.transaction do
      CSV.foreach(@file.path, headers: true) do |row|
        reward_hash = row.to_hash
        return false unless category(reward_hash['Category'])

        reward = Reward.find_or_initialize_by(title: reward_hash['Title'])
        reward.description = reward_hash['Description']
        reward.price = reward_hash['Price'].to_f
        reward.category = category(reward_hash['Category'])
        reward.save!
      end
    rescue CSV::MalformedCSVError, ActiveRecord::RecordInvalid => e
      @errors.push("Import failed, #{e.class}, message is #{e.message}")
      false
    end
    true
  end

  private

  def file_present?
    return true if @file.present?

    @errors.push('No file has been uploaded')
    false
  end

  def valid_format?
    return true if File.extname(@file) == '.csv'

    @errors.push('Invalid file format')
    false
  end

  def csv_body
    @csv_body ||= CSV.read(@file.path, headers: true)
  end

  def category(title)
    cat = Category.find_by(title: title)
    @errors.push("Category  '#{title}' does not exist") unless cat
    cat
  end

  def titles_unique?
    titles = csv_body['Title']
    duplicates = titles.select { |title| titles.count(title) > 1 }
    return true if duplicates.empty?

    @errors.push("Duplicated titles detected: #{duplicates.join(',')}")
    false
  end
end

class Magni::V1::Entry

  attr_accessor :id, :raw_data, :type, :created_at

  def initialize(data = {})
    @id         = data.delete(:id) || SecureRandom.uuid
    @type       = data.delete(:type) || self.class.name.parameterize
    @raw_data   = data
    @created_at = data.delete(:created_at) || DateTime.now
  end

  def bucket_name
    self.class.bucket_name
  end

  def self.bucket_name
    self.name.parameterize.pluralize
  end

  def bucket
    STORAGE.bucket(bucket_name)
  end

  def to_hash
    {
      id: @id,
      type: @type,
      raw_data: @raw_data,
      created_at: @created_at
    }
  end

  def to_json
    to_hash.to_json
  end

  def content_type
    'application/json'
  end

  def save
    instance = bucket.get_or_new(self.id)
    instance.raw_data = self.to_json
    instance.content_type = self.content_type
    instance.store
  end

  def self.find(id)
    STORAGE[self.bucket_name][id]
  end

end

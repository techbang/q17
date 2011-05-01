class TagCover < ActiveRecord::Migration
  def self.up
    add_column :tags, :cover_file_name,    :string
    add_column :tags, :cover_content_type, :string
    add_column :tags, :cover_file_size,    :integer
    add_column :tags, :cover_updated_at,   :datetime
    remove_column :tags, :cover
    add_column :tags, :created_at, :datetime
  end

  def self.down
    add_column :tags, :cover, :string
    remove_column :tags, :cover_file_name
    remove_column :tags, :cover_content_type
    remove_column :tags, :cover_file_size
    remove_column :tags, :cover_updated_at
    remove_column :tags, :created_at
  end
end

class AddVideoMd5ToPrograms < ActiveRecord::Migration[6.0]
  def change
    add_column :programs, :video_md5, :string
  end
end

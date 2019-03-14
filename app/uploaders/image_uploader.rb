class ImageUploader < CarrierWave::Uploader::Base
  # Include RMagick or MiniMagick support:
  # リサイズしたり画像形式を変更するのに必要
  if Rails.env.production?
    include Cloudinary::CarrierWave
    
    process :convert => 'jpg' # 画像の保存形式
    process :tags => ['image'] # 保存時に添付されるタグ（管理しやすいように適宜変更しましょう）
  
    process :resize_to_limit => [500, 500] # 任意でリサイズの制限
  
    # 保存する画像の種類をサイズ別に設定
    version :standard do
      process :resize_to_fill => [100, 150, :north]
    end
  
    version :thumb do
      process :resize_to_fit => [300, 300]
    end
    
    def extension_whitelist
     %w(jpg jpeg gif png)
    end
  
    #　「storage :file」　が有効になっているとCloudinaryに画像アップロードできない　↓
  
    # Choose what kind of storage to use for this uploader:
    #storage :file
    # storage :fog
    # アップロードした画像ファイルを任意のフォルダに保存する場合は
    # 下記のように任意のフォルダ名を指定できる 例：「local_test_cloudinary」
    def public_id
      return "arislogos_test_cloudinary/" + Cloudinary::Utils.random_public_id;
    end
  else
    include CarrierWave::RMagick
    # include CarrierWave::MiniMagick
    
    # 画像の上限を700pxにする
    process resize_to_limit: [500,500]
    
    # 保存形式をJPGにする
    process convert: 'jpg'
    
    # サムネイルを生成する設定
    version :thumb do
      process resize_to_limit: [300,300]
    end
  
    # Choose what kind of storage to use for this uploader:
    storage :file
    # storage :fog
  
    # Override the directory where uploaded files will be stored.
    # This is a sensible default for uploaders that are meant to be mounted:
    def store_dir
      "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
    end
  
    # Provide a default URL as a default if there hasn't been a file uploaded:
    # def default_url(*args)
    #   # For Rails 3.1+ asset pipeline compatibility:
    #   # ActionController::Base.helpers.asset_path("fallback/" + [version_name, "default.png"].compact.join('_'))
    #
    #   "/images/fallback/" + [version_name, "default.png"].compact.join('_')
    # end
  
    # Process files as they are uploaded:
    # process scale: [200, 300]
    #
    # def scale(width, height)
    #   # do something
    # end
  
    # Create different versions of your uploaded files:
    # version :thumb do
    #   process resize_to_fit: [50, 50]
    # end
  
    # Add a white list of extensions which are allowed to be uploaded.
    # For images you might use something like this:
    def extension_whitelist
     %w(jpg jpeg gif png)
    end
  
    # Override the filename of the uploaded files:
    # Avoid using model.id or version_name here, see uploader/store.rb for details.
    # def filename
    #   "something.jpg" if original_filename
    # end
    
    # 拡張子が同じでないとGIFをJPGとかにコンバートできないので、ファイル名を変更
    def filename
      super.chomp(File.extname(super)) + '.jpg' if original_filename.present?
    end
    
    # ファイル名は日本語が入ってくると嫌なので、下記のようにしてみてもいい。
    # 日付(20131001.jpgみたいなファイル名)で保存する
    def filename
      time = Time.now
      name = time.strftime('%Y%m%d%H%M%S') + '.jpg'
      name.downcase
    end
  end
end

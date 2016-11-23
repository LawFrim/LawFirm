class Mailboxer::AttachmentUploader < CarrierWave::Uploader::Base

  include CarrierWave::RMagick

  storage :file

  def store_dir
    "uploads/#{model.class.to_s.underscore}/#{mounted_as}/#{model.id}"
  end


  def cover
   manipulate! do |frame, index|
     frame if index.zero? # take only the first page of the file
   end
 end

 version :preview, :if => :previewable? do
    process :cover
    process :resize_to_fit => [300, 300]
    process :convert => :jpg

   def full_filename (for_file = model.source.file)
     super.chomp(File.extname(super)) + '.jpg'
   end
 end

 # the other stuff


  # Add a white list of extensions which are allowed to be uploaded.
  # For images you might use something like this:
   def extension_whitelist
      %w(jpg jpeg gif png pdf doc docx txt mp3 xls xlsx)
   end



   private
    def previewable?(new_file)
      image?(file) || pdf?(file)
    end

    def image?(new_file)

      self.file.content_type.include? 'image'
    end

    def pdf?(new_file)
     self.file.content_type.include? 'pdf'
  end

end

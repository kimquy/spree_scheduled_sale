module Paperclip
  class UploadedFileAdapter
    def stat
      File.stat(@tempfile)
    end
  end
end

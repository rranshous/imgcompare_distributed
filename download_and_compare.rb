require 'httparty'
require 'tempfile'
require 'base64'

class Downloader
  def download *urls, &blk
    fhs = []
    fhs = urls.map{ |url| download_image url }
    paths = fhs.map(&:path)
    blk.call(*paths)
  rescue
    fhs.each(&:unlink)
    raise
  end

  private

  def download_image url
    image_data = HTTParty.get(url).parsed_response
    fh = Tempfile.new Base64.urlsafe_encode64 url
    fh.write image_data
    fh.close
    return fh
  end
end

require 'phashion'
class Comparer
  def compare img_path1, img_path2
    img1 = Phashion::Image.new img_path1
    img2 = Phashion::Image.new img_path2
    img1.distance_from img2
  end
end

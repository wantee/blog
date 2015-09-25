BASE_DIR = 'assets/images/galleries'

module ImageList
  def image_list( name )
    list = Array.new
    dir = Dir.new( File.join(BASE_DIR, name) )
    dir.each do | d |
      image = File.basename(d, File.extname(d))
      unless d =~ /^\./ || d =~ /thumbs/
#        list << %Q{<a href="/images/galleries/#{name}/#{d}" rel="shadowbox" title="#{image}"><img src="/images/galleries/#{name}/thumbs/#{d}" /></a>}
        list << %Q{<a class="fancybox" href="/assets/images/galleries/#{name}/#{d}" rel="#{name}" title="#{image}"><img src="/assets/images/galleries/#{name}/thumbs/#{d}" /></a>}
      end
    end
    list.sort.join( "\n" )
  end
end

Liquid::Template.register_filter(ImageList)

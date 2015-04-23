# encoding: utf-8

module Mozenda::Aws
  class Request
    attr_accessor :file_names

    def initialize
      @config = Mozenda::Aws::Configuration.instance

      @s3 = Aws::S3::Resource.new({
        region: @config.region, 
        credentials: Aws::Credentials.new( @config.access_key, @config.secret_key ) 
      })

      @bucket = @s3.bucket( @config.bucket )

      raise 'The specified bucket does not exist' unless @bucket.exists?

      @file_names = @bucket.objects.map { |o| o.key }
    end

    def download!
      @bucket.objects.each do |obj| to_write!(obj.key, obj) end
    end

    def create_object!(options = {})
      options = options.merge({ bucket: @config.bucket })

      @s3.client.put_object( options )
    end

    def delete_object!(options = {})
      options = options.merge({ bucket: @config.bucket })

      @s3.client.delete_object( options ) 
    end

    def zip_paths
      zips = @file_names.map { |f| 
        f if (f.downcase[(f.length-4)..f.length] == '.zip') 
      }.uniq.compact

      return [] if zips.empty?
      return [get_file_path(zips[0])] if zips.length == 1

      zips.inject([]) { |paths, file| paths += get_file_path( file ) }
    end

    def items_of(file_name, root_name)
      raise 'The specified key does not exist' unless @file_names.include?(file_name)

      raise 'Can only be support XML file' unless (file_name.downcase[(file_name.length-4)..file_name.length] == '.xml')

      to_json( file_name, root_name )
    end

    private
    def to_write!(f_name, obj)
      file_path = get_file_path(f_name)

      File.open(f_name, 'wb') do |file|
        obj.get do |chunk|
          file.write(chunk)
        end 
      end unless file_path.nil? || File.exists?( file_path )
    end

    def to_json(file_name, root_name)
      file_path = get_file_path(file_name)

      return [] if file_path.nil? 

      Mozenda::Infrastructure::File.new(file_path, root_name ).validate!
    end

    def get_file_path(file_name)
      file_path = File.join(File.expand_path('../../../../', __FILE__), file_name)

      return nil unless File.exists?(file_path)

      file_path
    end

    def delete_file(file_name)
      unless (full_path = get_file_path(file_name)).nil?
        File.delete(full_path)
      end
    end

  end
end

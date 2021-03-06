# encoding: utf-8

module Mozenda::Aws
  class Request
    attr_accessor :file_names, :bucket_name, :file_dir

    def initialize
      config = Mozenda::Aws::Configuration.instance

      @s3 = Aws::S3::Resource.new({
        region: config.region, 
        credentials: Aws::Credentials.new( config.access_key, config.secret_key ) 
      })

      @bucket_name = config.bucket
      @file_dir    = config.file_dir

      @bucket = @s3.bucket( config.bucket )

      raise 'The specified bucket does not exist' unless @bucket.exists?

      @file_names = @bucket.objects.map { |o| o.key }
    end

    def download(keys=[])
      @bucket.objects.each do |obj| 
        to_write!(obj.key, obj) if keys.include?(obj.key)
      end
    end

    def get_object(options = {})
      @s3.client.get_object( combine_options(options) ) 
    end

    def create_object!(options = {})
      @s3.client.put_object( combine_options(options) )
    end

    def delete_object!(options = {})
      @s3.client.delete_object( combine_options(options) ) 
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
    def combine_options(options)
      options.merge({ bucket: bucket_name })
    end

    def to_write!(file_name, obj)
      file_path = full_file_path(file_name)

      File.open(file_path, 'wb') do |file|
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
      return nil unless File.exists?( full_file_path(file_name) )

      full_file_path(file_name)
    end

    def delete_file(file_name)
      File.delete(full_path) unless (full_path = get_file_path(file_name)).nil?
    end

    def full_file_path(file_name)
      "#{file_dir}/#{file_name}"
    end

  end
end

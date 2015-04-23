require File.join(File.dirname(__FILE__), "..", "spec_helper.rb")

module Mozenda::Aws
  describe Request do
    aws = Mozenda::Aws::Request.new

    it 'aws server should be return files' do
      puts aws.file_names.join(', ')
      expect(aws.file_names.size).to eq(4)
    end

    it 'download all files' do
      aws.download!
    end

    it 'showing items data' do
      puts "showing items data"

      file_name = aws.file_names[3]
      puts aws.items_of(file_name, "AllItems")

      puts "showing images data"
      file_name = aws.file_names[2]
      puts aws.items_of(file_name, "AllImages")
    end

  end
end
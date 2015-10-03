require 'fileutils'

PWD = Dir.pwd
SOURCE_DIR = File.join(PWD, 'progit2-zh')
IMAGES_DIR = File.join(PWD, 'images')
TMP_DIR = File.join(PWD, 'tmp')

def mk_images_dir
  return if Dir.exist?(IMAGES_DIR)

  FileUtils.mkdir_p(IMAGES_DIR)
end

def mk_tmp_dir
  return if Dir.exist?(TMP_DIR)

  FileUtils.mkdir_p(TMP_DIR)
end

desc 'Delete doc attributions and some included files'
task :modify_progit do
  from = File.join(SOURCE_DIR, 'progit.asc')
  to   = File.join(TMP_DIR, 'progit.adoc')

  sep = 'include::book/preface.asc[]'.freeze
  content = File.read(from).split(sep).last.gsub('book', '../progit2-zh/book')

  mk_tmp_dir
  File.write(to, content)
  puts 'progit.adoc generated'
end

desc 'Delete doc attributions at the first few lines'
task :modify_preface do
  from = File.join(SOURCE_DIR, 'book', 'preface.asc')
  preface = File.join(TMP_DIR, 'preface.adoc')
  dedication = File.join(TMP_DIR, 'dedication.adoc')

  sep = '[preface]'.freeze
  parts = File.read(from).split(sep)
  prefaces = parts[1..-2].join(sep) # the last part is dedication actually

  mk_tmp_dir

  File.write(preface, sep + prefaces)
  puts 'preface.adoc generated'

  File.write(dedication, "[dedication]#{parts.last}")
  puts 'dedication.adoc generated'
end

desc 'Copy all images into one directory'
task :copy_images do
  mk_images_dir
  pattern = File.join(SOURCE_DIR, 'book', '*', 'images')
  Dir.glob(pattern) do |entry|
    FileUtils.cp Dir.glob("#{entry}/*"), File.join(PWD, 'images')
  end
  puts 'Images copied'
end

task :preprocess => [:modify_progit, :modify_preface]

namespace :build do
  desc 'Build PDF format ebook'
  task :pdf => [:preprocess] do
    system 'bundle exec persie build pdf'
    puts 'PDF generated'
  end
end

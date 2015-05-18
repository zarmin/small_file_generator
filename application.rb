
require 'trollop'
require 'fileutils'

# opts = Trollop::options do
#  opt :
# end

path = File.dirname( __FILE__ )
Dir.chdir( path )

target = 'files'

# number_of_files = 9000
$max_depth = 4
$max_files_in_dir = 100
$avg_files_in_dir = 9
$max_subdir_in_dir = 20
$avg_subdir_in_dir = 5

if File.exists?( target )
  raise "Target directory already exists: #{target}"
end

FileUtils.mkdir target

# Dir.chdir( target ) 

def rn( avg, max )
  if( Random.rand > 0.9 )
    Random.rand(avg..max)
  else
    Random.rand(1..(avg*2))
  end  
end

def generate_tree( root, depth )
  return if depth == 0

  rn( $avg_files_in_dir, $max_files_in_dir ).times do |i|
    _file = "#{root}/file_#{i}_#{i.hash ^ i ^ i.object_id}"
    File.write( _file, 'content template' )
  end

  rn( $avg_subdir_in_dir, $max_subdir_in_dir ).times do |i|
    _dir = "#{root}/dir_#{i}_#{i.hash ^ i ^ i.object_id}"
    FileUtils.mkdir( _dir )

    generate_tree( _dir, depth - 1 )
  end
end

generate_tree( target, $max_depth )






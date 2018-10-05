# check dir /data exists?
require 'pathname'

DATA_DIR = Pathname.new '/pg_data'

def check_data_dir
  return if DATA_DIR.directory?
  
  `mkdir #{DATA_DIR}`
end

def init_data_dir
  files = Dir.glob(DATA_DIR.join '*')
  return if files.size > 0

  `runuser postgres -c "initdb #{DATA_DIR}"`
end

def main
  check_data_dir
  `chown postgres #{DATA_DIR}`
  init_data_dir

  `cp /*.conf #{DATA_DIR}`
end

main()

exec "runuser postgres -c 'postgres -D /pg_data'"

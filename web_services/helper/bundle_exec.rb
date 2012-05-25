module BundleExec
  def cucumber(options)
    return "" if options.nil?
    Dir.chdir("/home/tworker/work/livesale-automation")
    command   = `bundle exec cucumber #{options}`
  end
end
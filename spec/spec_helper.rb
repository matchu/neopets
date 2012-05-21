WEB_SAMPLE_BASE = File.expand_path('../_samples', __FILE__)
def web_sample(path)
  File.read(File.join(WEB_SAMPLE_BASE, path))
end

Pod::Spec.new do |spec|
  spec.name = 'Snippets'
  spec.version = '0.16.0'
  spec.summary = 'Snippets in Swift'
  spec.description = <<-DESCRIPTION.gsub(/\s+/, ' ').chomp
  A collection of Swift snippets for enhancing standard Apple frameworks. The
  snippets have no non-standard dependencies, by design.
  DESCRIPTION
  spec.homepage = 'https://github.com/royratcliffe/Snippets'
  spec.license = { type: 'MIT', file: 'MIT-LICENSE.txt' }
  spec.author = { 'Roy Ratcliffe' => 'roy@pioneeringsoftware.co.uk' }
  spec.source = {
    git: 'https://github.com/royratcliffe/Snippets.git',
    tag: spec.version.to_s }
  spec.source_files = 'Sources/**/*.{swift,h}'
  spec.platform = :ios, '9.0'
  spec.requires_arc = true
end

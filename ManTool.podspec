
Pod::Spec.new do |s|
s.name         = 'ManTool'
s.version      = '0.0.2'
s.summary      = 'Swift工具库'
s.homepage     = 'https://github.com/Nefuln/ManTool'
s.license      = 'MIT'
s.authors      = {'MrMan' => 'Nolan_li@icloud.com'}
s.platform     = :ios, '8.0'
s.source       = {:git => 'https://github.com/Nefuln/ManTool.git', :tag => s.version}
s.source_files = 'ManTool/*.{h,m}'
s.requires_arc = true
end

namespace :appmap do
  desc 'Generate Swagger docs from AppMaps'
  task :swagger do
    template = YAML.load <<~TEMPLATE
    openapi: 3.0.1
    info:
      title: Rails Sample App API
      version: v6
    paths:
    servers:
    - url: http://{defaultHost}
      variables:
        defaultHost:
          default: localhost:3000
    TEMPLATE
    swagger_paths = `node ./node_modules/@appland/appmap-swagger/index.js generate --directory tmp/appmap`
    template['paths'] = YAML.load(swagger_paths)
    FileUtils.mkdir_p 'swagger/appmap'
    File.write 'swagger/appmap/swagger.yaml', YAML.dump(template)
  end
end

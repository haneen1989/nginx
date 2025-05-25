resource containerAppEnv 'Microsoft.App/managedEnvironments@2023-05-01' = {
  name: 'nginx-env'
  location: resourceGroup().location
  properties: {}
}

resource nginxApp 'Microsoft.App/containerApps@2023-05-01' = {
  name: 'nginx-app'
  location: resourceGroup().location
  properties: {
    managedEnvironmentId: containerAppEnv.id
    configuration: {
      ingress: {
        external: true
        targetPort: 80
        transport: 'auto'
      }
    }
    template: {
      containers: [
        {
          name: 'nginx'
          image: 'nginx:latest'
        }
      ]
    }
  }
}

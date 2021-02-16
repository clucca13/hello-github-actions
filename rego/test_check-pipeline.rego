pipeline = `
harnessApiVersion: '1.0'
type: PIPELINE
description: Example Pipeiline that deploys with OPA Checks
pipelineStages:
- type: ENV_STATE
  name: Check OPA Running
  parallel: false
  skipCondition:
    type: DO_NOT_SKIP
  stageName: STAGE 1
  workflowName: Check OPA
- type: ENV_STATE
  name: OPA Deploy Svc
  parallel: false
  skipCondition:
    type: DO_NOT_SKIP
  stageName: STAGE 2
  workflowName: opa_deploy
  workflowVariables:
  - entityType: ENVIRONMENT
    name: Environment
    value: robin_local_kube_dev
  - entityType: SERVICE
    name: Service
    value: nginx
  - entityType: INFRASTRUCTURE_DEFINITION
    name: InfraDefinition_KUBERNETES
    value: robin_kube_dev
`

pipeline_yaml = yaml.unmarshal(pipeline)

deny with input as pipeline_yaml

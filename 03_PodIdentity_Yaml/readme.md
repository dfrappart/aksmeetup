# Pod Identity Demo

This folder contains the yaml file taken from Pod Identity OSS [site](https://azure.github.io/aad-pod-identity/docs/getting-started/installation/)
It is used to install the last available version of pod identity with the appropriatemodification for the solution to work on AKS with kubenet.
A change has been made to the deployment methods, instead of using yaml manifest the helm chart is used throught a terraform configuration

## Installation steps with yaml

Refer to Pod identity documentation for additional details.
The installation is done in 2 steps: 

- The Pod Identity infrastructure
- The Pod Identity Exceptions

## Specific config for kubenet installation

For pod identity to be able to work, we need to add a specific arg in the container: 

```yaml

      containers:
      - name: nmi
        image: "mcr.microsoft.com/oss/azure/aad-pod-identity/nmi:v1.7.3"
        imagePullPolicy: Always
        args:
          - "--node=$(NODE_NAME)"
          - "--http-probe-port=8085"
          - "--allow-network-plugin-kubenet=true"

```

In the terraform configuration with helm, it appears as below:

```bash

resource "helm_release" "podidentity" {
  name                                = "podidentity"
  repository                          = "https://raw.githubusercontent.com/Azure/aad-pod-identity/master/charts"
  chart                               = "aad-pod-identity"
  version                             = var.PodIdChartVer
  namespace                           = "podid"
  create_namespace                    = true


  dynamic "set" {
    for_each                          = var.HelmPodIdentityParam
    iterator                          = each
    content {
      name                            = each.value.ParamName
      value                           = each.value.ParamValue
    }

  }


}

```

Note that the version of the helm chart is configured through the variable `PodIdCharter`
Also a namespace is created with the parameters `namespace` and `create_namespace`
Allowing the installation on kubenet is configured through the variable `HelmPodIdentityParam`:

```bash

variable "HelmPodIdentityParam" {
  type                  = map
  description            = "A map used to feed the dynamic blocks of the pod identity helm chart"
  default                = {

      "set1" = {
        ParamName             = "nmi.allowNetworkPluginKubenet"
        ParamValue            = "true"

    }
      "set2" = {
        ParamName             = "installCRDs"
        ParamValue            = "true"

    }

  }

}

```
Once completed, the installation can be checked

## Check installation

After installation, check the pods are running:

```powershell

PS C:\Users\AKSPodIdMeetup\02_PodIdentity_Yaml> kubectl get pods -n podid                            
NAME                                   READY   STATUS    RESTARTS   AGE
aad-pod-identity-mic-dfdcc77d4-sjlnh   1/1     Running   0          55m
aad-pod-identity-mic-dfdcc77d4-szbv4   1/1     Running   0          60m
aad-pod-identity-nmi-5q78p             1/1     Running   2          22h
aad-pod-identity-nmi-wtmdp             1/1     Running   3          22h

```

A deployment and a daemonset should be found in the appropriate namespace

```powershell

PS C:\Users\AKSPodIdMeetup\02_PodIdentity_Yaml> kubectl get deployment -n podid
NAME                   READY   UP-TO-DATE   AVAILABLE   AGE
aad-pod-identity-mic   2/2     2            2           22h
PS C:\Users\AKSPodIdMeetup\02_PodIdentity_Yaml\02_TFForKube> kubectl get ds -n podid
NAME                   DESIRED   CURRENT   READY   UP-TO-DATE   AVAILABLE   NODE SELECTOR            AGE
aad-pod-identity-nmi   2         2         2       2            2           kubernetes.io/os=linux   22h

```

Check the logs after installation:

```powershell

PS C:\Users\AKSPodIdMeetup\02_PodIdentity_Yaml> kubectl logs deployment/aad-pod-identity-mic -n podid             
Found 2 pods, using pod/aad-pod-identity-mic-dfdcc77d4-szbv4
I0623 07:34:33.449414       1 main.go:114] starting mic process. Version: v1.7.3. Build date: 2021-02-05-22:16
W0623 07:34:33.449632       1 main.go:119] --kubeconfig not passed will use InClusterConfig
I0623 07:34:33.449765       1 main.go:136] kubeconfig () cloudconfig (/etc/kubernetes/azure.json)
I0623 07:34:33.450069       1 main.go:144] running MIC in namespaced mode: false
I0623 07:34:33.450161       1 main.go:148] client QPS set to: 5. Burst to: 5
I0623 07:34:33.450891       1 mic.go:139] starting to create the pod identity client. Version: v1.7.3. Build date: 2021-02-05-22:16   
I0623 07:34:48.927152       1 mic.go:145] Kubernetes server version: v1.19.11
I0623 07:34:48.928739       1 cloudprovider.go:123] MIC using user assigned identity: 4c6e##### REDACTED #####f2c9 for authentication.
I0623 07:34:48.933492       1 probes.go:41] initialized health probe on port 8080
I0623 07:34:48.933510       1 probes.go:44] started health probe
I0623 07:34:48.933678       1 metrics.go:341] registered views for metric
I0623 07:34:48.933730       1 prometheus_exporter.go:21] starting Prometheus exporter
I0623 07:34:48.933778       1 metrics.go:347] registered and exported metrics on port 8888
I0623 07:34:48.933804       1 mic.go:240] initiating MIC Leader election
I0623 07:34:48.933852       1 leaderelection.go:243] attempting to acquire leader lease  default/aad-pod-identity-mic...
I0623 07:40:17.017939       1 leaderelection.go:253] successfully acquired lease default/aad-pod-identity-mic
I0623 07:40:17.023761       1 mic.go:328] type upgrade status configmap found from version: v1.7.3. Skipping type upgrade!
I0623 07:40:17.124067       1 crd.go:456] CRD informers started
I0623 07:40:17.224936       1 pod.go:72] pod cache synchronized. Took 201.111265ms
I0623 07:40:17.224955       1 pod.go:79] pod watcher started !!
I0623 07:40:17.425045       1 mic.go:398] sync thread started.

```

deploy the pod identity and its binding in kubernetes: 

```powershell

PS C:\Users\AKSPodIdMeetup\02_PodIdentity_Yaml> kubectl apply -f .\PodId\uailab1.yaml      
azureidentity.aadpodidentity.k8s.io/uailab1 created
PS C:\Users\davidfrappart\Documents\IaC\Azure\AKSPodIdMeetup\02_PodIdentity_Yaml> kubectl apply -f .\PodId\uailab1_Binding.yaml
azureidentitybinding.aadpodidentity.k8s.io/uailab1-binding created
PS C:\Users\AKSPodIdMeetup\02_PodIdentity_Yaml>

```

Check again the logs: 

```powershell

PS C:\Users\davidfrappart\Documents\IaC\Azure\AKSPodIdMeetup\02_PodIdentity_Yaml> kubectl logs daemonset/nmi 
Found 2 pods, using pod/nmi-xdwxc
I0207 02:22:32.980871       1 main.go:84] starting nmi process. Version: v1.7.3. Build date: 2021-02-05-22:17.
I0207 02:22:33.125753       1 crd.go:447] CRD lite informers started
I0207 02:22:33.125780       1 main.go:111] running NMI in namespaced mode: false
I0207 02:22:33.125797       1 nmi.go:53] initializing in standard mode
I0207 02:22:33.125805       1 probes.go:41] initialized health probe on port 8085
I0207 02:22:33.125812       1 probes.go:44] started health probe
I0207 02:22:33.125887       1 metrics.go:341] registered views for metric
I0207 02:22:33.125933       1 prometheus_exporter.go:21] starting Prometheus exporter
I0207 02:22:33.125950       1 metrics.go:347] registered and exported metrics on port 9090
I0207 02:22:33.125959       1 server.go:98] listening on port 2579
W0207 02:22:33.249556       1 iptables.go:123] flushing iptables to add aad-metadata custom chains
I0207 02:30:55.976115       1 server.go:358] exception pod kube-system/omsagent-jgwp6 token handling
I0207 02:30:55.976227       1 server.go:301] fetching token for user assigned MSI for resource: https://monitoring.azure.com/
I0207 02:30:56.097646       1 server.go:192] status (200) took 121660003 ns for req.method=GET reg.path=/metadata/identity/oauth2/token req.remote=10.244.1.2

```

Now next steps is to try out the feature, with a pod using csi driver for example.

## Deploying CSI for secret

Deploying CSI for secret store:

```bash

kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/secrets-store-csi-driver/master/deploy/rbac-secretproviderclass.yaml

kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/secrets-store-csi-driver/master/deploy/csidriver.yaml

kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/secrets-store-csi-driver/master/deploy/secrets-store.csi.x-k8s.io_secretproviderclasses.yaml

kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/secrets-store-csi-driver/master/deploy/secrets-store.csi.x-k8s.io_secretproviderclasspodstatuses.yaml

kubectl apply -f https://raw.githubusercontent.com/kubernetes-sigs/secrets-store-csi-driver/master/deploy/secrets-store-csi-driver.yaml

```

## Installing the Azure Key Vault provider

```bash

kubectl apply -f https://raw.githubusercontent.com/Azure/secrets-store-csi-driver-provider-azure/master/deployment/provider-azure-installer.yaml


```

Afterward, we need to install a secret store which refers to an existing keyvault. This secret store is created througha yaml manifest like this:

```yaml

apiVersion: secrets-store.csi.x-k8s.io/v1alpha1
kind: SecretProviderClass
metadata:
  name: ${KVName}
spec:
  provider: azure
  parameters:
    usePodIdentity: "true"               
    userAssignedIdentityID: ${UAIClientId}
    keyvaultName: ${KVName}
    cloudName: ""                               
    objects:  |
      array:
        - |
          objectName: ${SecretName}
          objectAlias: ${SecretName}            
          objectType: secret                    
          objectVersion: ${SecretVersion}       
    tenantId: ${TenantId}    


```

This file is generated with the proper value in the 01_Infra folder with a local_file resource: 

```bash

resource "local_file" "secretprovider1" {
  content                                 = templatefile("./yamltemplate/secretprovider-template.yaml",
    {
      UAIClientId                         = module.UAI1.ClientId
      KVName                              = module.AKSKeyVault.Name
      SecretName                          = module.SecretTest_to_KV.SecretFullOutput.name
      SecretVersion                       = ""
      TenantId                            = data.azurerm_subscription.current.tenant_id
    }
  )
  filename = "../03_PodIdentity_Yaml/SecretStore/${lower(module.AKSKeyVault.Name)}-secretstore.yaml"
}

```

Once the secret store is also created, it is time to try it with a pod on which the secret is mounted, again from a template yaml:

```yaml

apiVersion: v1
kind: Pod
metadata:
  name: nginx-secrets-store-inline
  labels:
    aadpodidbinding: ${UAIName}-binding
spec:
  containers:
    - name: nginx
      image: nginx
      volumeMounts:
        - name: secrets-store-inline
          mountPath: "/mnt/secrets-store"
          readOnly: true
  volumes:
    - name: secrets-store-inline
      csi:
        driver: secrets-store.csi.k8s.io
        readOnly: true
        volumeAttributes:
          secretProviderClass: ${KVName}

```
And afterward created from a localfile resource:

```bash

resource "local_file" "podexample" {
  content                                 = templatefile("./yamltemplate/TestPod-template.yaml",
    {
      UAIName                             = module.UAI1.Name
      KVName                              = module.AKSKeyVault.Name
    }
  )
  filename = "../02_PodIdentity_Yaml/demo-pod.yaml"
}

```
Get the pod info status: 

```powershell

PS C:\Users\davidfrappart\Documents\IaC\Azure\AKSPodIdMeetup\02_PodIdentity_Yaml> kubectl describe pods nginx-secrets-store-inline 
Name:         nginx-secrets-store-inline
Namespace:    default
Priority:     0
Node:         aks-aksnp0terraa-28115117-vmss000002/172.20.0.134
Start Time:   Sun, 07 Feb 2021 21:52:37 +0100
Labels:       aadpodidbinding=uailab1-binding
Annotations:  cni.projectcalico.org/podIP: 10.244.1.9/32
Status:       Running
IP:           10.244.1.9
IPs:
  IP:  10.244.1.9
Containers:
  nginx:
    Container ID:   docker://6059d3f5ea325674fdd612b41dd68103794037a7b8d6c5b4c26372abbf68ccc2
    Image:          nginx
    Image ID:       docker-pullable://nginx@sha256:10b8cc432d56da8b61b070f4c7d2543a9ed17c2b23010b43af434fd40e2ca4aa
    Port:           <none>
    Host Port:      <none>
    State:          Running
      Started:      Sun, 07 Feb 2021 21:53:28 +0100
    Ready:          True
    Restart Count:  0
    Environment:    <none>
    Mounts:
      /mnt/secrets-store from secrets-store-inline (ro)
      /var/run/secrets/kubernetes.io/serviceaccount from default-token-gdr98 (ro)
Conditions:
  Type              Status
  Initialized       True
  Ready             True
  ContainersReady   True
  PodScheduled      True
Volumes:
  secrets-store-inline:
    Type:              CSI (a Container Storage Interface (CSI) volume source)
    Driver:            secrets-store.csi.k8s.io
    FSType:
    ReadOnly:          true
    VolumeAttributes:      secretProviderClass=azure-kvname
  default-token-gdr98:
    Type:        Secret (a volume populated by a Secret)
    SecretName:  default-token-gdr98
    Optional:    false
QoS Class:       BestEffort
Node-Selectors:  <none>
Tolerations:     node.kubernetes.io/not-ready:NoExecute op=Exists for 300s
                 node.kubernetes.io/unreachable:NoExecute op=Exists for 300s
Events:
  Type    Reason     Age   From               Message
  ----    ------     ----  ----               -------
  Normal  Scheduled  15m   default-scheduler  Successfully assigned default/nginx-secrets-store-inline to aks-aksnp0terraa-28115117-vmss000002
  Normal  Pulling    14m   kubelet            Pulling image "nginx"
  Normal  Pulled     14m   kubelet            Successfully pulled image "nginx"
  Normal  Created    14m   kubelet            Created container nginx
  Normal  Started    14m   kubelet            Started container nginx


```

Everything seems alright, check the access to the keyvault: 

```bash

PS C:\Users\AKSPodIdMeetup\03_PodIdentity_Yaml> kubectl exec nginx-secrets-store-inline -- ls /mnt/secrets-store
kvs-demo1
PS C:\Users\AKSPodIdMeetup\03_PodIdentity_Yaml> kubectl exec nginx-secrets-store-inline -- cat /mnt/secrets-store/kvs-demo1
e&D}:6+<)fM!n=@!

```

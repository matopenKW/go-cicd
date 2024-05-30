# terraform


## gcp
- setup cmd

setup project
```bash
gcloud config set project wallon-go-cicd
```

```bash
gcloud auth application-default login
```

init
```bash
terraform init
```

import project
```bash
terraform import google_project.go_cicd wallon-go-cicd
```

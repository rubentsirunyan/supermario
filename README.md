# supermario
Automation for supermario sample app

## Requirements
This project has been developed and tested using the following software versions.
- Terraform `v0.13.5`
- Ansible `v2.9.15`
- GNU Make `v3.81`

## Deployment steps

1. Clone the repository.
```
git clone https://github.com/rubentsirunyan/supermario.git
```
2. `cd` to the reposotry directory.
```
cd supermario
```
3. Export AWS keys.
```
export AWS_ACCESS_KEY_ID=<YOUR ACCESS KEY ID>
export AWS_SECRET_ACCESS_KEY=<YOUR SECRET ACCESS KEY>
```
4. Run make deploy and specify the environment name. The environment name can be any value. A terraform workspace with the specified name will be created.
```
make deploy ENV=test
```

## Steps to cleanup
1. `cd` to the reposotry directory.
```
cd supermario
```
2. Export AWS keys.
```
export AWS_ACCESS_KEY_ID=<YOUR ACCESS KEY ID>
export AWS_SECRET_ACCESS_KEY=<YOUR SECRET ACCESS KEY>
```
3. Run make clean and specify the environment name that you want to destroy.
```
make clean ENV=test
```

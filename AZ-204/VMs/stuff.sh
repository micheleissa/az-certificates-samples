ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAACAQDICzU1YKyLxyFaRpJCjZHMD0hPtzk+Lt6zR+otBsp+W0CbXVkt38k/IuayLdrJg0I8lmaZ/XVRGgSV4PZ0gyG6IZiG/pI5PIVSOe9VdkevSQES3pqTcKb5/cM+6BWe7MR1n1XFYc5iFyHzKmvOt9IsJf4hD34jre5Ile4LETQP2NFgvqTDXjIjJExn+pL6+Z/u+bpDE6ouURYKIfgAGcxdPFf7qvjvL7y5TRkyDasqpw3sMRiG4FhDL6IfCj00F4NxXLgwKKMjeLQwzsEDpNpTnHfzF7nLoVwp/E4ktWB0q70qE9ava3uIDw1aGQLkj4kr5bHi6UIM/yTExWO3PqIbz3lN1mgvq/LNK6fxWiZh1ySj8rX7cxcLWyg2b/wUm8uuehzr0Zd4YsVMqT6bf+3boVAHnpMgklCDBtTUP1jtBrgW9lNDeM83HcwdEb3zS2JcqqrebwCr8s/ErxT4PU/BiPEaQszHFCcRouyGXqnMDOy7tgDqLw2mqeJwUMf/Mr9sh0QgT76r4Kb5K/Nmyk9pYkKSfB9hDtCI86+Bg+cX6exQxplBmSLmCa6/aN6mvaiX+5GcIRVDSNyPs9JVSFgpc047+kqGyRvz/uvX4AOXmlkIZcwirjf0+rgZ3uEVgzYMrCzktmXZuogdfzLdHfgcsq9zsrWtXYrCUNw2SqihJQ== michel_eissa85@cc-6f000d09-ccc8c68c-ddkqc



meazureuser


me-test-web-scus-vm1
me-test-web-eus-vm1


meazureuser
me-test-vp-vm2
@EiS0985eHa@


# Create MEAN stack VM
az vm create \
  --resource-group learn-13e5171e-1957-40a9-abaf-0e9fc62c0251 \
  --name MeanStack \
  --image Canonical:UbuntuServer:16.04-LTS:latest \
  --admin-username azureuser \
  --generate-ssh-keys

# Open ports
  az vm open-port \
  --port 80 \
  --resource-group learn-13e5171e-1957-40a9-abaf-0e9fc62c0251 \
  --name MeanStack

# Store public IP in a local bash var
ipaddress=$(az vm show \
  --name MeanStack \
  --resource-group learn-13e5171e-1957-40a9-abaf-0e9fc62c0251 \
  --show-details \
  --query [publicIps] \
  --output tsv)

# Upgrade apt
sudo apt update && sudo apt upgrade -y

# Install MongoDB package
sudo apt-get install -y mongodb

# Check if MongoDB is up and running
sudo systemctl status mongodb

# Register Node.js repository so package manager can locate packages.
curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -

# Install nodejs
sudo apt-get install nodejs

# Example of how to add AngularJS from a CDN
<script src="https://ajax.googleapis.com/ajax/libs/angularjs/1.7.2/angular.min.js"></script>
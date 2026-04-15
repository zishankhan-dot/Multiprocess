resource "azurerm_resource_group" "rmg" {
  name = "${var.resource_group_name}"
  location = "${var.location}"
}


resource "azurerm_virtual_network" "vnet" {
  name                = "myVnet"
  address_space       = ["10.0.0.0/24"]
  location = azurerm_resource_group.rmg.location
  resource_group_name = azurerm_resource_group.rmg.name
  }

resource "azurerm_subnet" "subnet" {
    name = "subnet1"
    resource_group_name = azurerm_resource_group.rmg.name
    virtual_network_name = azurerm_virtual_network.vnet.name
    address_prefixes = ["10.0.0.0/24"]
}

resource "azurerm_public_ip" "public_ip" {
    name="mypublicip"
    location = azurerm_resource_group.rmg.location  
    resource_group_name = azurerm_resource_group.rmg.name
    allocation_method = "Static"
}
resource "azurerm_network_security_group" "nsg" {
  name = "mynsg"
 location = azurerm_resource_group.rmg.location  
  resource_group_name = azurerm_resource_group.rmg.name 
  #for ssh 
  security_rule{
    name = "SSH"
    priority = 1001
    direction = "Inbound"
    access = "Allow"
    protocol = "Tcp"
    source_port_range = "*"
    destination_port_range = "22"
    source_address_prefix = "*"
    destination_address_prefix = "*"
  }
}

resource "azurerm_network_interface" "nic" {
  name = "mynic"
  location = azurerm_resource_group.rmg.location  
  resource_group_name = azurerm_resource_group.rmg.name 
  ip_configuration {
    name = "myipconfig"
    subnet_id = azurerm_subnet.subnet.id
    private_ip_address_allocation = "Dynamic"
    public_ip_address_id = azurerm_public_ip.public_ip.id
  }
}

resource "azurerm_network_interface_security_group_association" "nsg_assoc" {
  network_interface_id = azurerm_network_interface.nic.id
  network_security_group_id = azurerm_network_security_group.nsg.id
}

resource "azurerm_linux_virtual_machine" "vm" {
  name = var.vm_name
  location = azurerm_resource_group.rmg.location  
  resource_group_name = azurerm_resource_group.rmg.name 
  network_interface_ids = [azurerm_network_interface.nic.id]
  size = "Standard_B1s"
  admin_username = "azureuser"
  disable_password_authentication = true
  admin_ssh_key {
    username = "azureuser"
    public_key = file("~/.ssh/id_rsa.pub")
  }
  os_disk {
    caching              = "ReadWrite"
    storage_account_type = "Standard_LRS"
  }
  source_image_reference {
    publisher = "Canonical"
    offer     = "ubuntu-24_04-lts"
    sku       = "server"
    version   = "latest"
  }
}

resource "local_file" "ssh_key" {
  content  = file("~/.ssh/id_rsa")
  filename = "${path.root}/../ansible/private_key.pem"
}
resource "local_file" "ssh_pub_key" {
  content  = file("~/.ssh/id_rsa.pub")
  filename = "${path.root}/../ansible/public_key.pem"
}

resource "local_file"  "publicIp"{
  content=azurerm_public_ip.public_ip.ip_address
  filename="${path.root}/../ansible/public_ip.txt"
}
# Godot-server-lobby-tutorial
This is client host demo but published into a container (docker), this container used menip lobby tutorial as a demo. And this is the original repo :

`https://gitlab.com/menip/godot-multiplayer-tutorials`

Please not that to run this example you need to have docker installed. and use the following commands :

` docker pull mani144/godot-server-lobby-tutorial `

Then to run the server use this :

`docker run -p 8888:44444/tcp -p 8888:44444/udp mani144/godot-server-lobby-tutorial `

The host is running on port 44444 so i forwared the port to 80 , and i opened the port in tcp and udp.

Now all you have to do is to run the clinet the existed in src/client 
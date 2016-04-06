** INSTALL STUFF
sudo apt-get -y install python2.7-dev
sudo apt-get install libhdf5-dev
curl -s https://raw.githubusercontent.com/torch/ezinstall/master/install-deps | bash
git clone https://github.com/torch/distro.git ~/torch --recursive
cd ~/torch;
./install.sh      # and enter "yes" at the end to modify your bashrc
source ~/.bashrc
pip install epc lupa

luarocks install torch
luarocks install nn
luarocks install optim
luarocks install lua-cjson
luarocks install async
git clone https://github.com/deepmind/torch-hdf5
cd torch-hdf5
luarocks make hdf5-0-0.rockspec
*** INSTALL LUPA
apt-get install liblua5.2-dev
pip install lupa

*** CUDA support (Optional)
luarocks install cutorch
luarocks install cunn

** REMOVE STUFF
If you ever need to uninstall torch, simply run the command:
rm -rf ~/torch

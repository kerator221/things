личные дотс никсосu  
по флейкам собираешь и все
скриптик install.sh ставит конфиги хипра и тд и тп

git clone https://github.com/kerator221/things.git ~/nixos-dots  
cd ~/nixos-dots  
sudo nixos-rebuild switch --flake .#nixos  
chmod +x install.sh  
./install.sh  


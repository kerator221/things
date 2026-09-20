**личные дотс никсосu**  

**ВАЖНО**:  
* ***система базируется на hyprland + xwayland***  
* ***имя пользователя это hardcode во флейке***  
* ***запускать обязательно с уже предустановленной системы***  
* ***НЕ ЗАПУСКАТЬ ОТ sudo***  

**INSTALLING:**  
* git clone https://github.com/kerator221/things.git ~/nixos-dots  
* cd ~/nixos-dots  
* ./rebuild.sh  

**TODO LIST:**  
* ~~избавиться от install.sh~~  
* ~~максимально упростить установку~~   
* ~~добиться репродуцируемости хоть какойто~~  
* дорасти до полной автоматизации установки вплоть до разметки дисков(disko + nixos-anywhere)
* убрать barebones вид системы и привести к одному стилю и цветовой палитре  
* доделать waybar  
* в будующем написать бар на quickshell  
* скачать армяне  

**PROBLEMS:**  
* rebuild.sh (ручная генерация hardware-configuration)  
* waybar это hardcode + ужасный функционал  
* config/hypr/monitors.lua это hardcode  
* точно есть что то еще что я забыл!!  

**COOL THINGS:**  
* автогенерация секрета tg-ws-proxy
* ~~чото~~
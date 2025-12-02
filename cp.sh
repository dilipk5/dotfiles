cp -f /home/panda/.config/hypr/hyprland.conf hypr/hyprland.conf
cp -f /home/panda/.config/hypr/hyprpaper.conf hypr/hyprpaper.conf 
cp -f /home/panda/.config/hypr/start-chat-layout.sh hypr/start-chat-layout.sh

cp -f /home/panda/.config/waybar/config.jsonc waybar/config.jsonc
cp -f /home/panda/.config/waybar/gpu-usage.sh waybar/gpu-usage.sh

cp -f /home/panda/.config/waybar/scripts/pomodoro.sh waybar/scripts/pomodoro.sh
cp -f /home/panda/.config/waybar/scripts/vbox-usage.sh waybar/scripts/vbox-usage.sh
cp -f /home/panda/.config/waybar/style.css waybar/style.css

git add /home/panda/projects/dotfiles/.
git commit -m "cron commint"
git push origin main

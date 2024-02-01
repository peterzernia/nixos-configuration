function kill-gpu
    # ps aux | grep gpu-process | grep $argv | egrep -o -e "[0-9]+" | head -n 1 | xargs -p kill
    kill (ps aux | grep gpu-process | grep /opt/google/chrome/chrome | egrep -o -e "[0-9]+" | head -n 1)
    kill (ps aux | grep gpu-process | grep vscodium-bin | egrep -o -e "[0-9]+" | head -n 1)
    kill (ps aux | grep gpu-process | grep signal-desktop | egrep -o -e "[0-9]+" | head -n 1)
    kill (ps aux | grep gpu-process | grep spotify | egrep -o -e "[0-9]+" | head -n 1)
end

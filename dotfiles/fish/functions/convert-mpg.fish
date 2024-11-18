function convert-mpg
  for file in *.MPG
    ffmpeg -i "$file" (basename "$file" .MPG).mp4
  end
end

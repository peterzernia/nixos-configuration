function convert-flac
  set prev (pwd)
  cd '/Users/peterzernia/soulseek/_flac/'
  for f in *.flac;
    echo $f;
    set filename $(string replace flac aiff $f);
    echo $filename;
    ffmpeg -i $f -write_id3v2 1 ../_checked/$filename
  end
  cd $prev
end

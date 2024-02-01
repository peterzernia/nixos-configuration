function newpr
  open -a "Google Chrome" (git config --get remote.origin.url | sed "s/:/\//" | sed "s/git@/https:\/\//" | sed "s/\.git/*/" | sed "s/*/\/compare\/master.../")""(git rev-parse --abbrev-ref HEAD)
end

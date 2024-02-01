function fc --description "helper function for running commands in docker ssh"
  command docker -H "ssh://$argv[1].fc" $argv[2..-1]
end

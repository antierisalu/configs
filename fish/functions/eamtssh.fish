function eamtssh --wraps='ssh 193.40.128.4 -p 5656 -l anti' --description 'alias eamtssh=ssh 193.40.128.4 -p 5656 -l anti'
  ssh 193.40.128.4 -p 5656 -l anti $argv
        
end

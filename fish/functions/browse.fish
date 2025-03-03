function browse --wraps='fzf --preview "bat --color=always{}"' --wraps='fzf --preview "bat --color=always {}"' --description 'alias browse=fzf --preview "bat --color=always {}"'
  fzf --preview "bat --color=always {}" $argv
        
end

function mountsrv --wraps='sudo mount -t nfs -o vers=4 192.168.2.3:/srv /mnt/srv/' --description 'alias mountsrv=sudo mount -t nfs -o vers=4 192.168.2.3:/srv /mnt/srv/'
  sudo mount -t nfs -o vers=4 192.168.2.3:/srv /mnt/srv/ $argv
        
end

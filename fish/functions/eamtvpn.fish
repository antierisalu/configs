function eamtvpn --wraps='sudo openvpn --config ~/EAMTVPN/vpnconf.ovpn --auth-user-pass ~/EAMTVPN/gpw' --description 'alias eamtvpn=sudo openvpn --config ~/EAMTVPN/vpnconf.ovpn --auth-user-pass ~/EAMTVPN/gpw'
  sudo openvpn --config ~/EAMTVPN/vpnconf.ovpn --auth-user-pass ~/EAMTVPN/gpw $argv
        
end

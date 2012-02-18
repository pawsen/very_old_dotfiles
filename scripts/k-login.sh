#!/usr/bin/expect -f 
#Written by Steffen M. Hansen,  steffen a zervus.dk
#This script can be used to login to K-net's new firewall(6.2004). It
# will reopen the connection if the firewall logs you out.
#
# Time-stamp: <2004-06-20 12:42:03 zervus>
# k-login.sh,v 1.2 2004/06/20 10:42:50 zervus Exp
set numargs [llength $argv]
if {$numargs != 2} {
    send_user "Error: Expected 2 arguments got $numargs\n"
    send_user "Usage: k-login.sh username firewallhost < passwordfile\n"
    send_user "\nusername: your K-net username\n"
    send_user "firewallhost: the firewall to login to. \n\t(eg. fw1.k-net.dk or fw2.k-net.dk)\n"
    send_user "passwordfile: The program reads the password from stdin. \n\t You can put the password in a file and redirect it to this program. \n\t This prevents the password from showing up in the process list\n"
    exit
}
set username [lindex $argv 0]
#host: firewall to login to. (fw1.k-net.dk or fw2.k-net.dk)
set host [lindex $argv 1]
set password [read -nonewline stdin ]

proc touser {str} {
    send_user "[clock format [clock seconds]]: $str"
}

#sleeptime:  number of seconds to wait between 2 ssh login attempts
set sleeptime 30

log_user 0 ;#do not echo output from ssh
while {1} {
    sleep 2 ;#wait for 2 sec between two ssh connects.
    set timeout $sleeptime
    spawn -noecho ssh -T -o ServerAliveInterval=15 -l $username $host
    touser "Connecting to $host\n"
    expect {
	assword: {
	    send  "$password\r"
	    touser "Connected to $host (password sent)\n"
	    expect {
		"ind!" {
		    touser "Login successful: \
			User $username logged in on $host\n"
		    #we are now logged in and only need to do anything 
		    # if the connection is closed.
		    set timeout -1
		    expect eof {
			touser "Connection closed by remote host\n" 
			exp_wait;continue
		    }
		} "Permission denied, please try again." {
		    touser "Login failed: Username or password incorrect!  \
			<-- Notice!!!\n"
		    exp_close;exp_wait
		    touser "Connection closed\n"
		    touser "Exiting program\n"
		    exit
		} timeout {
		    touser "Login failed: \
			Timeout waiting for remote host to confirm\n"
		    close;wait
		    touser "Connection closed\n"
		    continue
		} eof {
		    touser "got end of file exiting\n";
		    wait;continue
		}
	    } ;# expect ind!
	} eof {
	    touser "Connection failed: \
		Remote host($host) closed connection\n";
	    wait;continue 
	} timeout {
	    touser "Connection failed: \
		Timeout waiting for remote host($host)\n";
	    close;wait;continue
	}
    } ;#expect password
    exit
} ;#while

exit


From: "Pete Barnard" <petebarnard@tiscali.co.uk>
Subject: modprobe question
Date: Tue, 1 Apr 2003 23:23:49 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <001b01c2f89d$5f215890$0100a8c0@Pblaptop>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

I'm a little bit confused with loading modules and if anybody could give me
an idiots guide explanation to the confusion/mystery I'm having it would be
much appreciated as I cannot seem to find what I'm after by browsing the
net.  I am using one computer with a cs46xx card and I do not need to load
the modules when the computer restarts for ALSA stuff to work, but I have
another computer using an intel8x0 card and every time I reboot the machine
I need to do a "modprobe snd-intel8x0" for ALSA stuff to work (else put it
in startup script).  As I know ALSA uses modules, how is the first computer
successfuly using the ALSA drivers when I have not done any modprobes after
rebooting.

I hope this makes sense.

Regards,

Pete



-------------------------------------------------------
This SF.net email is sponsored by: ValueWeb: 
Dedicated Hosting for just $79/mo with 500 GB of bandwidth! 
No other company gives more support or power for your dedicated server
http://click.atdmt.com/AFF/go/sdnxxaff00300020aff/direct/01/

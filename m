From: Harold Martin <cocoadev@earthlink.net>
Subject: ALSA module will not load into kernel
Date: Mon, 11 Aug 2003 11:52:25 -0700
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <1060627945.4453.3238.camel@silver>
Mime-Version: 1.0
Content-Type: text/plain
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

Hello,
I'm trying to install the snd-cs46xx module for my Turtle Beach  Santa
Cruz. As per the instructions I compile everything successfully. But
when I attempt to load the module (modprobe snd-cs46xx) I get the
errors:
/lib/modules/2.4.20-19.9/kernel/sound/pci/cs46xx/snd-cs46xx.o:
init_module: No such device
Hint: insmod errors can be caused by incorrect module parameters,
including invalid IO or IRQ parameters.
      You may find more information in syslog or the output from dmesg
/lib/modules/2.4.20-19.9/kernel/sound/pci/cs46xx/snd-cs46xx.o: insmod
/lib/modules/2.4.20-19.9/kernel/sound/pci/cs46xx/snd-cs46xx.o failed
/lib/modules/2.4.20-19.9/kernel/sound/pci/cs46xx/snd-cs46xx.o: insmod
snd-cs46xx failed

I know this might be OT, but I asked on the users mailing list and got
no answer,

Thanks,
Harold



-------------------------------------------------------
This SF.Net email sponsored by: Free pre-built ASP.NET sites including
Data Reports, E-commerce, Portals, and Forums are available now.
Download today and enter to win an XBOX or Visual Studio .NET.
http://aspnet.click-url.com/go/psa00100003ave/direct;at.aspnet_072303_01/01

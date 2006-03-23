From: Paul Davis <paul@linuxaudiosystems.com>
Subject: he's back/HDSP issues
Date: Wed, 22 Mar 2006 19:43:57 -0500
Message-ID: <1143074638.4344.4.camel@localhost.localdomain>
Reply-To: paul@linuxaudiosystems.com
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Well, after a long absence from this list, I return. I will admit, its
mostly a result of deep confusion about changes that seem to have been
made with respect to the HDSP driver/support. 

What is that status of the "package" called "alsa-firmware" ? Is it now
deprecated or should distributions be including it? What is the status
of the hdsploader program? Its not necessarily needed during boot,
thanks to hotplug/udev, but those devices don't help if you want to
reload the "firmware" after the system has already been up. The problem
here is that the firmware isn't require for the PCI/PCMCIA cards to
operate, only for the external boxes.

I hope to get back into the hdsp drivers a little over the next few
months.

--p




-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642

From: "rwd" <rwd@arcor.de>
Subject: maestro3 hardware volume control
Date: Mon, 18 Apr 2005 15:22:58 +0200
Message-ID: <000e01c54419$bd8665a0$6502a8c0@SCA600>
Mime-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
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

Hi,

the maestro3 runs fine on my compaq evo n400c (ES1988). Just one thing
remains unsolved - the 2 nice volume control buttons that seem to be wired
directly to the ES1988 won't work until now. 

I'm relatively new to linux and not a driver programmer, but scrolling
through the documentation of the chip & the driver source quickly revealed
that the volume can be controlled directly by two buttons, but the driver
doesn't seem make use of that. 

Can anybody give me a hint how to use/enable the hardware volume control on
that chip? Is a major rewrite of the driver required? Maybe some other
driver could do that? The es1968 seems to support hw vol, might that driver
run also on the ES1988?

Thanks & best regards, Ruediger



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

From: James Courtier-Dutton <James@superbug.co.uk>
Subject: [PATCH] Adds 24bit, 96khz support for multichannel playback on the
 Audigy 2 sound cards.
Date: Sat, 12 Mar 2005 19:57:25 +0000
Message-ID: <423349A5.8020001@superbug.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from anchor-post-32.mail.demon.net (anchor-post-32.mail.demon.net [194.217.242.90])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id 858381BD
	for <alsa-devel@alsa-project.org>; Sat, 12 Mar 2005 20:57:26 +0100 (MET)
Received: from superbug.demon.co.uk ([80.176.146.252] helo=[192.168.1.10])
	by anchor-post-32.mail.demon.net with esmtp (Exim 4.42)
	id 1DACjl-0006G1-9I
	for alsa-devel@alsa-project.org; Sat, 12 Mar 2005 19:57:26 +0000
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: ALSA development <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Please see readme.txt at 
http://www.alsa-project.org/~james/alsa-driver/p16v/
http://www.alsa-project.org/~james/alsa-driver/p16v/readme.txt

It works with the current alsa CVS.
I would like this to be merged with the CVS quite soon if possible.

Summary:
Add support for the P16V chip (CA0151-DBS) present on Creative Sound 
Blaster 2 ZS and Creative Sound Blaster 4 Pro sound cards.
A new 8 channel playback device appears as device 4.

Signoff: James Courtier-Dutton


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

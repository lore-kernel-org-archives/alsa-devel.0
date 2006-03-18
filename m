From: Adrian McMenamin <adrian@mcmen.demon.co.uk>
Subject: Re: Couple of questions
Date: Sat, 18 Mar 2006 00:22:13 +0000
Message-ID: <1142641333.9449.31.camel@localhost.localdomain>
References: <1142467271.9298.7.camel@localhost.localdomain>
	 <s5hirqer7r5.wl%tiwai@suse.de>
	 <1142552045.9236.9.camel@localhost.localdomain>
	 <1142554597.9395.25.camel@mindpipe> <s5hirqdv0oj.wl%tiwai@suse.de>
	 <1142627252.9449.9.camel@localhost.localdomain>
	 <s5hr750stlr.wl%tiwai@suse.de>
	 <1142638164.9449.16.camel@localhost.localdomain>
	 <1142639182.25258.126.camel@mindpipe>
	 <1142639470.9449.24.camel@localhost.localdomain>
	 <1142639891.25258.134.camel@mindpipe>
	 <1142640536.9449.29.camel@localhost.localdomain>
	 <1142641024.25258.142.camel@mindpipe>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from sc-outsmtp1.homechoice.co.uk (sc-outsmtp1.homechoice.co.uk [81.1.65.35])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with SMTP id 36D451BF
	for <alsa-devel@alsa-project.org>; Sat, 18 Mar 2006 01:22:17 +0100 (MET)
In-Reply-To: <1142641024.25258.142.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

On Fri, 2006-03-17 at 19:17 -0500, Lee Revell wrote:

> Maybe I'm misunderstanding but...
> 
> You wait for one period to play in both channels then transfer one
> period for the left channel and one period for the right.  So each DMA
> transfer moves twice as much data as the mono case.
> 
> Lee


Ah, much clearer now. Thanks



-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642

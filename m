From: Tim Goetze <tim@quitte.de>
Subject: Re: m-audio uc33?
Date: Mon, 22 Dec 2003 20:12:09 +0100 (CET)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.LNX.4.58.0312222004310.532@autumn>
References: <Pine.LNX.4.58.0312221548530.532@autumn> <20031222163400.GA826@tuba.home>
 <20031222181724.GA19302@fliwatut.scifi> <20031222182423.GB19302@fliwatut.scifi>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from natsmtp00.webmailer.de (natsmtp00.rzone.de [81.169.145.165])
	by alsa.alsa-project.org (8.9.3/8.9.3/SuSE Linux 8.9.3-0.1) with ESMTP id UAA04187
	for <alsa-devel@alsa-project.org>; Mon, 22 Dec 2003 20:17:25 +0100
In-Reply-To: <20031222182423.GB19302@fliwatut.scifi>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Frank Barknecht <fbar@footils.org>
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Frank Barknecht wrote:

>> Yeah, it looks like it is exactly the same, only a lot more expensive
>> than the real one, which is available below 200 Euro for example here:
>> http://www.netzmarkt.de/thomann/artikel-160144.html
>
>Well, now I see that there is a difference between the uc33 and the
>uc33e, at least in price:
>http://www.netzmarkt.de/thomann/artikel-166464.html
>
>But I wonder, if there is a difference in the hardware, too??

i think the 'e' variant can dump and receive sysex changing the
controller mappings (and whatever else is programmable). i'd rather
rewrite/map events on the host side than fiddle with sysex anyway.

tim


-------------------------------------------------------
This SF.net email is sponsored by: IBM Linux Tutorials.
Become an expert in LINUX or just sharpen your skills.  Sign up for IBM's
Free Linux Tutorials.  Learn everything from the bash shell to sys admin.
Click now! http://ads.osdn.com/?ad_id=1278&alloc_id=3371&op=click

From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: [ALSA - driver 0000901]: The onboard audigyls	chip
 on msi k8 diamond motherboard not recognized. Path supplied.
Date: Sun, 13 Feb 2005 11:53:18 +0000
Message-ID: <420F3FAE.6010301@superbug.co.uk>
References: <9d29558e3c3fabff090c6db74666f973@bugtrack.alsa-project.org> <1108255628.3273.20.camel@krustophenia.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Received: from anchor-post-35.mail.demon.net (anchor-post-35.mail.demon.net [194.217.242.85])
	by alsa.alsa-project.org (ALSA's E-mail Delivery System) with ESMTP id CC457219
	for <alsa-devel@alsa-project.org>; Sun, 13 Feb 2005 12:53:19 +0100 (MET)
In-Reply-To: <1108255628.3273.20.camel@krustophenia.net>
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
Cc: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

Lee Revell wrote:
> On Sun, 2005-02-13 at 01:21 +0100, bugtrack@alsa-project.org wrote:
> 
>>*nods*, seems to be better:
>>
>>0 [CA0106         ]: CA0106 - CA0106
>>                     Live! by MSI [SB0438] at 0xde00 irq 233
> 
> 
> Since it's been established that the CA0106 based devices have basically
> nothing in common with the SBLive/emu10k1, can we please, please not
> call it "Live!"?  It's obvious from Creative's marketing that they want
> to pass those cheap "software soundcards" off as equivalent to an
> SBLive/Audigy.  Please, let's not help them.
> 
> Lee
> 

I have made the comment line as exact copy of the Creative marketing as 
possible, so that people can provide better feedback.
E.g. I see [SB0438] and know exactly which card the user has and the 
"Live! by MSI" tells the user exactly what they have, and it should 
match the box the sound card came in for easy identification.

In this case, the CA0106 is part of the motherboard.
I suppose I could replace "Live! by MSI" with "MSI motherboard XYZ"

I will ask the bug reporter for that information.

James




-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

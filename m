From: Nish Aravamudan <nish.aravamudan@gmail.com>
Subject: Re: Re: intel 8x0 went silent in 2.6.11
Date: Thu, 3 Mar 2005 11:42:30 -0800
Message-ID: <29495f1d05030311423f4c1ebc@mail.gmail.com>
References: <4227085C.7060104@drzeus.cx>
	 <29495f1d05030309455a990c5b@mail.gmail.com>
	 <Pine.LNX.4.62.0503031342270.19015@krusty.vfxcomputing.com>
	 <1109875926.2908.26.camel@mindpipe>
	 <Pine.LNX.4.62.0503031356150.19015@krusty.vfxcomputing.com>
Reply-To: Nish Aravamudan <nish.aravamudan@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
In-Reply-To: <Pine.LNX.4.62.0503031356150.19015@krusty.vfxcomputing.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Mark Canter <marcus@vfxcomputing.com>
Cc: Lee Revell <rlrevell@joe-job.com>, Pierre Ossman <drzeus-list@drzeus.cx>, LKML <linux-kernel@vger.kernel.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 3 Mar 2005 14:06:38 -0500 (EST), Mark Canter
<marcus@vfxcomputing.com> wrote:
> 
> Correct, but if you want to use your headphones you would have to enable
> headphones on your mixer, which would negate your speaker output through
> your docking station's output.  If you want to use the docking station
> speakers, you would have to disable the headphones in order to get the
> docking station speakers to work; no?  If that is the case, then you would
> still have to enable/disable each time you wanted to change the direction
> of headphones/external speakers.  Again, this is not the case under <=
> 2.6.10 where it works regardless of enabling/disabling headphones.

I am not seeing this behavior. The Sense alsamixer entries do not to
be toggled ever again once they have been muted (for me, at least).
Both the t41p speakers and headphone jack work (with the speakers
being muted when headphones are plugged in).

Thanks,
Nish


-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

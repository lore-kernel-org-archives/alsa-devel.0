From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Re: intel 8x0 went silent in 2.6.11
Date: Fri, 04 Mar 2005 15:44:11 -0500
Message-ID: <1109969051.6710.17.camel@mindpipe>
References: <Pine.LNX.4.62.0503031342270.19015@krusty.vfxcomputing.com>
	 <4227085C.7060104@drzeus.cx> <1109875926.2908.26.camel@mindpipe>
	 <4228C7CE.5010109@tmr.com>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <4228C7CE.5010109@tmr.com>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Bill Davidsen <davidsen@tmr.com>
Cc: Mark Canter <marcus@vfxcomputing.com>, Nish Aravamudan <nish.aravamudan@gmail.com>, Pierre Ossman <drzeus-list@drzeus.cx>, LKML <linux-kernel@vger.kernel.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Fri, 2005-03-04 at 15:40 -0500, Bill Davidsen wrote:
> Lee Revell wrote:
> > On Thu, 2005-03-03 at 13:46 -0500, Mark Canter wrote:
> > 
> >>The same issue exists on a T42p (ICH4).  Doesn't that kind of defeat the 
> >>purpose?  The thought of having to disable the headphone jack and reenable 
> >>it each time is trivial considering you can go with the fact that sound 
> >>did not require the sound system touched under <= 2.6.10.
> > 
> > 
> > You don't have to disable and re-enable it each time, if your system is
> > configured correctly then your mixer settings will be saved.
> 
> I don't think you understand the problem. Saving the settings does help, 
> you have to change the settings every time you switch from headphones to 
> speaker. Assuming I follow the o.p. issue... alsamixer shows no "sense" 
> settings for my ASUS laptop, and I have to boot 2.4 to get sound.
> 

Thanks, I understand it now.  It looked like the same bug but there is
actually something else going on.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

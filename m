From: Rick Knight <rick@rlknight.com>
Subject: Re: Me again
Date: Fri, 09 Apr 2004 07:58:38 -0700
Sender: alsa-user-admin@lists.sourceforge.net
Message-ID: <4076BA1E.6020202@rlknight.com>
References: <4076A358.3050800@nc.rr.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Return-path: <alsa-user-admin@lists.sourceforge.net>
In-Reply-To: <4076A358.3050800@nc.rr.com>
Errors-To: alsa-user-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-user@lists.sourceforge.net>
List-Help: <mailto:alsa-user-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-user>,
	<mailto:alsa-user-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-user>
To: David Barron <dlbarron@nc.rr.com>
Cc: alsa-user@lists.sourceforge.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

David Barron wrote:

> Just to see if it was me doing something wrong I've installed Mandrake 
> 10 and Alsa, both of which use alsa and neither of which are producing 
> any sound in my speakers.
> Since oss works, I'd have to say there is a problem in the 
> snd-intel8x0 that hasn't been resolved since at least 1.0.2.
> I've also done some serious searching on google and it doesn't look 
> like I'm the only person having a problem.  There are hundreds of hits 
> for alsa intel8x0 from people with trouble and no resolution.
>
>
>
> -------------------------------------------------------
> This SF.Net email is sponsored by: IBM Linux Tutorials
> Free Linux tutorial presented by Daniel Robbins, President and CEO of
> GenToo technologies. Learn everything from fundamentals to system
> administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click
> _______________________________________________
> Alsa-user mailing list
> Alsa-user@lists.sourceforge.net
> https://lists.sourceforge.net/lists/listinfo/alsa-user

David,

I too have an Intel8x0 (ICH2) on-board sound card. After trying for 
weeks to get it working, I finally just turned it off in bios and 
installed a SoundBlaster Live. Had it working in about 10 minutes.  I 
bought the SoundBlaster for $6.00 plus $3.00 on eBay. If the Intel8x0 
ALSA driver is ever fixed I can simply turn it back on, but I don't 
think that's likely. As someone explained it to me, the Intel8x0 is kind 
of like a winmodem style soundcard and will probably never work 
correctly under ALSA. So, save yourself some headache and maybe some 
gray hair and go buy a SoundBlaster.

Rick Knight
(rick@rlknight.com)



-------------------------------------------------------
This SF.Net email is sponsored by: IBM Linux Tutorials
Free Linux tutorial presented by Daniel Robbins, President and CEO of
GenToo technologies. Learn everything from fundamentals to system
administration.http://ads.osdn.com/?ad_id=1470&alloc_id=3638&op=click

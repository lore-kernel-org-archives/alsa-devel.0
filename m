From: Brian L Scipioni <brian@gaugetheory.org>
Subject: Re: Re: [Alsa-user] [PATCH] emu10k1 multichannel
	support
Date: Tue, 15 Feb 2005 11:28:28 -0500
Message-ID: <1108484908.5922.33.camel@radium.gaugetheory.org>
References: <200502151448.j1FEmqHo008542@www4.pobox.sk>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <200502151448.j1FEmqHo008542@www4.pobox.sk>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Peter Zubaj <pzad@pobox.sk>
Cc: rlrevell@joe-job.com, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

The Optical Raw Switch changes my output from headphones only, to
headphones plus optical out (which goes to my DD receiver).  In either
case the IEC958 Optical slider does nothing.  In prior versions it used
to work fine.  Fortunately, I don't need optical out attenuated for
anything I'm doing right now, but I thought I'd report it.

thanks,
brian

On Tue, 2005-02-15 at 09:48, Peter Zubaj wrote:
> AFAIK there wasn't any change in DSP code which should affect "IEC958
> Optical". Do you use correct slider ? "IEC958 Optical" and not "IEC958
> Optical Raw". Second is only switch .
> 
> Peter Zubaj
> 
> 
> 
> ____________________________________
> Vsetko o SuperStar
> http://superstar.atlas.sk
> 



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

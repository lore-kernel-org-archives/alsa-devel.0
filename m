From: Manuel Jander <manuel.jander@usm.cl>
Subject: Re: au8830 - front / rear channels swapped after
	first play and Surround40
Date: Wed, 16 Mar 2005 20:57:40 -0400
Message-ID: <1111021060.3239.20.camel@localhost>
References: <42312D3F.2010201@netvigator.com>
	 <1110545886.3216.12.camel@localhost>  <1110676678.13277.7.camel@mindpipe>
Reply-To: mjander@users.sourceforge.net
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <1110676678.13277.7.camel@mindpipe>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Lee Revell <rlrevell@joe-job.com>, alsa-devel <alsa-devel@lists.sourceforge.net>
List-Id: alsa-devel@alsa-project.org

Hi Lee,

On Sat, 2005-03-12 at 20:17 -0500, Lee Revell wrote:
> On Fri, 2005-03-11 at 09:58 -0300, Manuel Jander wrote:
> > Take a look at
> > http://galadriel.mat.utfsm.cl/~mjander/aureal/techdoc/techpaper.html
> > and au8830.pdf in the same folder.
> 
> Looks like this chipset has a wavetable synth.  And I noticed some
> references to a driver on the openvortex list.  Would it be possible for
> ALSA to support it?

Of course, but there are some unresolved hardware issues. The WaveTable
helper hardware is very similar to the trident Wavetable helper
hardware. It does not interpret MIDI directly, but at least does some
effect processing in hardware. If i just had some time to spend on
this ... Grrr !!

Best Regards
-- 
Manuel Jander
Electronic Engineer



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

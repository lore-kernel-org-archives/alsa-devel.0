From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: snd-intel8x0
Date: Thu, 10 Mar 2005 10:43:22 +0100 (MET)
Message-ID: <Pine.HPX.4.33n.0503101042510.20935-100000@studcom.urz.uni-halle.de>
References: <1110418594.5334.7.camel@209.90.108.253.airwired.net>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
In-Reply-To: <1110418594.5334.7.camel@209.90.108.253.airwired.net>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Koby Andersen <koby@razordata.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Koby Andersen wrote:
> I am having trouble with all recent versions of ALSA (currently running
> 1.0.6, but have run all the way up to 1.0.8 with more recent kernels as
> well) and my SIS7012 sound card with the SIS 735 (technically its a SIS
> 650 in a PC Club laptop).
>
> My sound card works properly so long as no headphones are attached.  As
> soon as I plug in headphones all sound is muted to both the speakers and
> the headphones.

Which codec does your sound card use?  (see /proc/asound/cards or the
"Chip" line in alsamixer)


Regards,
Clemens



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

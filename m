From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Broken nforce3 support in ALSA on amd64?
Date: Mon, 07 Mar 2005 15:06:05 -0500
Message-ID: <1110225967.935.12.camel@mindpipe>
References: <1109468746.11523.20.camel@colgate3.iforde.net>
	 <s5hr7irwpjf.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
In-Reply-To: <s5hr7irwpjf.wl@alsa2.suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: Ian Forde <ian@duckland.org>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Mon, 2005-03-07 at 14:31 +0100, Takashi Iwai wrote:
> Unfortunately, the datasheet of nforce is not available at all, so we
> have no chance to fix this problem yet unless you do some reverse
> engineering (but I never recommend to do that, it's a waste of time).

Do you mean reverse engineering Nvidia drivers, or RE in general?  If
it's the latter I have to disagree strongly.  It't not fast or easy, but
many ALSA drivers have gained useful features this way.

I strongly encourage reverse engineering proprietary drivers.  Look at
what James did with the Audigy LS.  And look how much is known about the
EMU DSP instruction set, all that info is reverse engineered.

Lee



-------------------------------------------------------
SF email is sponsored by - The IT Product Guide
Read honest & candid reviews on hundreds of IT Products from real users.
Discover which products truly live up to the hype. Start reading now.
http://ads.osdn.com/?ad_id=6595&alloc_id=14396&op=click

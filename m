From: Lee Revell <rlrevell@joe-job.com>
Subject: Re: Volume per voices [Feature Request]
Date: Tue, 02 Aug 2005 12:00:38 -0400
Message-ID: <1122998438.11253.28.camel@mindpipe>
References: <s5hvf2pmyd8.wl%tiwai@suse.de>
	 <Pine.HPX.4.33n.0508021611380.21750-100000@studcom.urz.uni-halle.de>
	 <s5h1x5cmj5t.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h1x5cmj5t.wl%tiwai@suse.de>
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
Cc: Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Tue, 2005-08-02 at 17:51 +0200, Takashi Iwai wrote:
> But, even before this addition (if we really do), I think it's worthy
> to move iface to PCM since it will clean up the mixer mess a bit.

The multichannel playback controls are already IFACE_PCM, do they need
any update to match this API change (which I have not been following
closely)?

Lee



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click

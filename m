From: James Courtier-Dutton <James@superbug.co.uk>
Subject: Re: spdif setup
Date: Sun, 03 Jul 2005 18:42:57 +0100
Message-ID: <42C823A1.1080409@superbug.co.uk>
References: <Pine.LNX.4.56.0507111229490.12873@www.ithos.nl> <42C808F9.1050200@superbug.co.uk> <1120411011.2722.116.camel@tux.lan>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1120411011.2722.116.camel@tux.lan>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: "Ronald S. Bultje" <rbultje@ronald.bitfreak.net>
Cc: alsa-devel@lists.sf.net
List-Id: alsa-devel@alsa-project.org

Ronald S. Bultje wrote:
> On Sun, 2005-07-03 at 17:49, James Courtier-Dutton wrote:
> 
>>start totem, edit->preferences->audio->audio_output_type=AC3 passthru.
> 
> 
> I'm one of the Totem authors. I'm trying to give that item some meaning
> by making it work. Right now, it just works if you manually select the
> right crypto-like device string in some dark-corner config file in the
> xine backend. In the gst backend, it doesn't work at all. I'm trying to
> understand how to make it work. It's not very obvious to me.
> 
> As said, alsa 1.0.9, it's a Nvidia Nforce (the onboard type thingy)
> using the intel_8x0 driver.
> 
> Ronald
> 

AC3 is not possible with the Nvidia Nforce chipset in Linux due to lack
of datasheets

James



-------------------------------------------------------
SF.Net email is sponsored by: Discover Easy Linux Migration Strategies
from IBM. Find simple to follow Roadmaps, straightforward articles,
informative Webcasts and more! Get everything you need to get up to
speed, fast. http://ads.osdn.com/?ad_id=7477&alloc_id=16492&op=click

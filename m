From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: [Alsa-user] ALSA USB MIDI Input
Date: Fri, 23 Aug 2002 14:17:11 +0200 (METDST)
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <Pine.HPX.4.33n.0208231406150.23751-100000@studcom.urz.uni-halle.de>
References: <20020822203522.GE10066@tuba.home>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Content-Transfer-Encoding: 7BIT
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <20020822203522.GE10066@tuba.home>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://www.geocrawler.com/redir-sf.php3?list=alsa-devel>
To: Martin Langer <martin-langer@gmx.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, 22 Aug 2002, Martin Langer wrote:
> > On Thu, 22 Aug 2002, Michael Martin wrote:
> > > linux # cat /proc/asound/cards
> > > 0 [card0          ]: USB-Audio - USB Audio Driver
> > >                      Evolution Electronics Ltd. MK-249 USB MIDI keyboard
> > > 1 [card1          ]: USB MIDI - Evolution Electronics Ltd. MK-2
> > >                      Evolution Electronics Ltd. MK-249 USB MIDI keyboard at
>
> Isn't it a good argument to force an integration of both drivers to one card.

Yes. I think I'll have finished the patch Monday.


Regards,
Clemens




-------------------------------------------------------
This sf.net email is sponsored by: OSDN - Tired of that same old
cell phone?  Get a new here for FREE!
https://www.inphonic.com/r.asp?r=sourceforge1&refcode1=vs3390

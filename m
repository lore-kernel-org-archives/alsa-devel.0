From: Clemens Ladisch <clemens@ladisch.de>
Subject: Re: writing driver for MOTU PCI 324, 2408 MK-II
Date: Mon, 9 May 2005 13:40:35 +0200 (METDST)
Message-ID: <Pine.HPX.4.33n.0505091337420.19423-100000@studcom.urz.uni-halle.de>
References: <34049.198.36.86.68.1115632182.squirrel@mail.events-for-love.de>
Mime-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <34049.198.36.86.68.1115632182.squirrel@mail.events-for-love.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Eckhard Jokisch <e.jokisch@u-code.de>
Cc: f_a_b@softhome.net, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Eckhard Jokisch wrote:
> > Forest Bond wrote:
> >> Can released ASIO drivers be used to gather technical information on
> >> the hardware?
> >
> > Yes.  Reverse engineering is perfectly legal in this case.
>
> AFAIK - (having an 986HD) they encrypt the datastream somehow.
> But that should also be possible to "guess" if using same
> digitized signals several times.

Or just reverse engineer the algorithm based on the driver; this is
still legal.

> What about a wrapper around the original drivers like they do with
> ndiswrapper. Would that be an option?

It would be possible in theory.  Thank you for volunteering to
implement it.  ;-)


Regards,
Clemens



-------------------------------------------------------
This SF.Net email is sponsored by: NEC IT Guy Games.
Get your fingers limbered up and give it your best shot. 4 great events, 4
opportunities to win big! Highest score wins.NEC IT Guy Games. Play to
win an NEC 61 plasma display. Visit http://www.necitguy.com/?r=20

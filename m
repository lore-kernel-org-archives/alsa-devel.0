From: Remi Bernhard <rgbmlist2@free.fr>
Subject: Re: Xruns with Audiophile 2496 M-audio
Date: Sun, 30 May 2004 16:55:07 +0200
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <20040530165507.21384cd3@pentium233.krystal.net>
References: <20040529114908.2118135c@pentium233.krystal.net>
	<Pine.LNX.4.58.0405291234350.566@autumn>
	<20040529131601.641aa202@pentium233.krystal.net>
	<Pine.LNX.4.58.0405291329280.566@autumn>
	<20040529160048.27d74531@pentium233.krystal.net>
	<Pine.LNX.4.58.0405291631440.566@autumn>
	<20040530110923.5ce0172f@pentium233.krystal.net>
	<1085924121.4235.21.camel@eviltwin>
Mime-Version: 1.0
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <1085924121.4235.21.camel@eviltwin>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Sun, 30 May 2004 08:35:21 -0500
Jan Depner <eviltwin69@cableone.net> wrote:

> On Sun, 2004-05-30 at 04:09, Remi Bernhard wrote:
> > Hi Tim and all,
> >=20
> >=20
> > On Sat, 29 May 2004 16:34:49 +0200 (CEST)
> > Tim Goetze <tim@quitte.de> wrote:
> >=20
> > > [Remi Bernhard]
> > > >I tried with kernel 2.4.25 + lowlatency patch.
> > > >I have the same xruns :-/
> > > >
> > > >Any other idea ?
> > >=20
> > > checklist:
> > >=20
> > > * running jackd as root? with -R option?
> >=20
> > Tried -> failed.
>=20
> 	If this failed, you're not running real-time.  What error
> 	message did
> you get?

Oops, sorry, my mistake. **This** worked.

Regards,
	R=E9mi Bernhard.




-------------------------------------------------------
This SF.Net email is sponsored by: Oracle 10g
Get certified on the hottest thing ever to hit the market... Oracle 10g. 
Take an Oracle 10g class now, and we'll give you the exam FREE.
http://ads.osdn.com/?ad_id=3149&alloc_id=8166&op=click

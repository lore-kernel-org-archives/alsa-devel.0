From: Chow Raymond <usher_raymond82@yahoo.com>
Subject: Re: Compulab sound device
Date: Tue, 23 Aug 2005 02:49:39 -0700 (PDT)
Message-ID: <20050823094939.41220.qmail@web54603.mail.yahoo.com>
References: <s5hoe7p583k.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5hoe7p583k.wl%tiwai@suse.de>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>, Lee Revell <rlrevell@joe-job.com>
Cc: Chow Raymond <usher_raymond82@yahoo.com>, Liam Girdwood <liam.girdwood@wolfsonmicro.com>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

Takashi,

Would appreciate if you can mention the file that has
changes.

Thanks

Regards
--- Takashi Iwai <tiwai@suse.de> wrote:

> At Mon, 22 Aug 2005 23:57:26 -0400,
> Lee Revell wrote:
> >=20
> > On Mon, 2005-08-22 at 00:06 -0700, Chow Raymond
> wrote:
> > > I also wish to port from 2.6.7 to 2.6.12.
> However,
> > > Compulab only supports till 2.6.7. I can't build
> > > 2.6.12 kernel to run on Compulab's board.=20
> >=20
> > Do you mean the vendor won't provide support for
> anything but 2.6.7, or
> > that 2.6.12 literally will not run on the board?
> >=20
> > If it's the former then ask your support rep how
> to get a new ALSA to
> > work with it.  If it's the latter then report the
> bug to the kernel
> > people.
>=20
> IIRC, some of the core part regarding DMA on ARM was
> added recently,
> which is used by pxa2xx driver.  You can backport
> that code, though.
>=20
>=20
> Takashi
>=20


__________________________________________________
Do You Yahoo!?
Tired of spam?  Yahoo! Mail has the best spam protection around=20
http://mail.yahoo.com=20


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

From: asbjs@stud.ntnu.no (Asbjørn Sæbø)
Subject: Re: Lowest latency: JACK, or ALSA directly?
Date: Fri, 12 Nov 2004 10:11:35 +0100
Message-ID: <20041112091135.GB3167@stud.ntnu.no>
References: <20041111144152.GA12443@stud.ntnu.no> <200411111534.iABFY8UK012314@localhost.localdomain>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Content-Disposition: inline
In-Reply-To: <200411111534.iABFY8UK012314@localhost.localdomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Paul Davis <paul@linuxaudiosystems.com>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

On Thu, Nov 11, 2004 at 10:34:08AM -0500, Paul Davis wrote:
> [JACK]
> it doesn't *add* any latency at all. what it might conceivably do is
> to prevent a given application from reaching the lowest possible
> latency, because of the extra context switching involved in JACK. so
> far, however, this doesn't appear to be the case - people have JACK
> running at the same latency settings as they could get with ALSA. so
> the effect is marginal if its measurable at all.

That sounds very good.
=20
> >Although I so far barely have gotten into ALSA programming, it does se=
em
> >to be manageable in difficulty. (Don't laugh, I am an aconcy austican,=
 not a=3D20
> >programmer.)  How is programming against JACK in comparison?
>=20
> JACK is *massively* simpler.

That also sounds very good.  It looks like I am in for a switch to JACK.
(Although I may miss the opportunity to dig myself into a hole digesting=20
the ALSA API. ;-)


Thanks!

Asbj=F8rn


-------------------------------------------------------
This SF.Net email is sponsored by:
Sybase ASE Linux Express Edition - download now for FREE
LinuxWorld Reader's Choice Award Winner for best database on Linux.
http://ads.osdn.com/?ad_id=5588&alloc_id=12065&op=click

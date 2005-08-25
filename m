From: Chow Raymond <usher_raymond82@yahoo.com>
Subject: Re: Compulab sound device
Date: Wed, 24 Aug 2005 18:45:37 -0700 (PDT)
Message-ID: <20050825014537.86810.qmail@web54612.mail.yahoo.com>
References: <s5h8xyr4k2f.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h8xyr4k2f.wl%tiwai@suse.de>
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
Cc: Lee Revell <rlrevell@joe-job.com>, Liam Girdwood <liam.girdwood@wolfsonmicro.com>, Clemens Ladisch <clemens@ladisch.de>, alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org

The exact reason is Compulab only supports till 2.6.7.
They only have 2.6.7 patch in order to support their
board.=20


> > 2) How does remap_pfn_range different compare to
> > remap_page_range?=20
>=20
> The start argument is shifted in page size.
>=20

So does it mean that this might probably cause the
segmentation fault?

Regards,
Raymond


	=09
__________________________________=20
Yahoo! Mail for Mobile=20
Take Yahoo! Mail with you! Check email on your mobile phone.=20
http://mobile.yahoo.com/learn/mail=20


-------------------------------------------------------
SF.Net email is Sponsored by the Better Software Conference & EXPO
September 19-22, 2005 * San Francisco, CA * Development Lifecycle Practic=
es
Agile & Plan-Driven Development * Managing Projects & Teams * Testing & Q=
A
Security * Process Improvement & Measurement * http://www.sqe.com/bsce5sf

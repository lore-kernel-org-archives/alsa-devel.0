From: Ken Moffat <zarniwhoop@ntlworld.com>
Subject: Re: Slab corruptions & Re: 2.6.17-rc1: Oops in sound
 applications
Date: Tue, 4 Apr 2006 21:31:52 +0100 (BST)
Message-ID: <Pine.LNX.4.63.0604042129170.12127__47352.9747491286$1144193870$gmane$org@deepthought.mydomain>
References: <Pine.LNX.4.63.0604032155220.17605@deepthought.mydomain>
 <20060404133814.GA11741@knautsch.gondor.com> <s5hlkul72rv.wl%tiwai@suse.de>
 <20060404190631.GA4895@knautsch.gondor.com> <s5h7j656tpp.wl%tiwai@suse.de>
 <Pine.LNX.4.63.0604042058560.11426@deepthought.mydomain>
Mime-Version: 1.0
Content-Type: MULTIPART/MIXED; BOUNDARY="-1463809536-1041055340-1144182712=:12127"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
Received: from queue03-winn.ispmail.ntl.com (queue03-winn.ispmail.ntl.com [81.103.221.57])
	by alsa.jcu.cz (ALSA's E-mail Delivery System) with ESMTP id 85E6A159
	for <alsa-devel@alsa-project.org>; Wed,  5 Apr 2006 01:33:53 +0200 (MEST)
In-Reply-To: <Pine.LNX.4.63.0604042058560.11426@deepthought.mydomain>
Sender: alsa-devel-admin@lists.sourceforge.net
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Ken Moffat <zarniwhoop@ntlworld.com>
Cc: Takashi Iwai <tiwai@suse.de>, Jan Niehusmann <jan@gondor.com>, linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org

  This message is in MIME format.  The first part should be readable text,
  while the remaining parts are likely unreadable without MIME-aware tools.

---1463809536-1041055340-1144182712=:12127
Content-Type: TEXT/PLAIN; charset=X-UNKNOWN
Content-Transfer-Encoding: quoted-printable

On Tue, 4 Apr 2006, Ken Moffat wrote:

> On Tue, 4 Apr 2006, Takashi Iwai wrote:
>=20
> > What happens if you copy the whole subtree linux/sound and
> > linux/include/sound from 2.6.16?
>=20
>  also needs include/linux/sound.h (building at the moment)
>=20
 I've been using it now to play sound for 15 or 20 minutes while=20
browsing heavily - looks as if the problem is in the sound subtree. =20
Sorry.

Ken
--=20
das eine Mal als Trag=C3=B6die, das andere Mal als Farce
---1463809536-1041055340-1144182712=:12127--


-------------------------------------------------------
This SF.Net email is sponsored by xPML, a groundbreaking scripting language
that extends applications into web and mobile media. Attend the live webcast
and join the prime developer group breaking into this new coding territory!
http://sel.as-us.falkag.net/sel?cmd=lnk&kid=110944&bid=241720&dat=121642

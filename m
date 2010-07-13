From: Peter Ujfalusi <peter.ujfalusi@nokia.com>
Subject: Re: issue with TWL4030
Date: Tue, 13 Jul 2010 10:59:09 +0300
Message-ID: <201007131059.09681.peter.ujfalusi@nokia.com>
References: <AANLkTilwdeNLChInBSaFIpVTLDONLXIIHVpLk3Aibk0v@mail.gmail.com>
	<201007121312.48518.peter.ujfalusi@nokia.com>
	<AANLkTikjSK3tefAqDAH2i2dxe_n91Z1D5mENqd86Woon@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mgw-mx03.nokia.com (smtp.nokia.com [192.100.122.230])
	by alsa0.perex.cz (Postfix) with ESMTP id 5725424348
	for <alsa-devel@alsa-project.org>;
	Tue, 13 Jul 2010 09:59:24 +0200 (CEST)
In-Reply-To: <AANLkTikjSK3tefAqDAH2i2dxe_n91Z1D5mENqd86Woon@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: ext Grazvydas Ignotas <notasas@gmail.com>
Cc: "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, "broonie@opensource.wolfsonmicro.com" <broonie@opensource.wolfsonmicro.com>, Liam Girdwood <lrg@slimlogic.co.uk>
List-Id: alsa-devel@alsa-project.org

On Monday 12 July 2010 23:26:32 ext Grazvydas Ignotas wrote:
> > As of it now, I'm not planning to add workaround to this, since I can n=
ot
> > really test if it is working correctly.
> =

> If you can build a kernel with OSS emulation enabled it's trivial to
> test, just run 'mplayer -ao oss' or build the test I sent before (just
> include linux/souncard.h, no libraries required).

Oh yes, fortunately I do have mplayer laying around :D

> =

> > Also I just came back from holiday, and my mailbox is quite full, so do
> > not expect that I can even take a look at this in the near future.
> > =

> > Having said that.. since I do care about the twl4030 codec driver (and
> > it's users), I will try to allocate time to fix it for you.
> =

> Thanks!

Thank me when it is done ;)
I do have some urgent issues to handle before I can take a look, but I thin=
k it =

can be done.

-- =

P=E9ter

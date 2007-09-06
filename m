From: "Krzysztof Helt" <krzysztof.h1@wp.pl>
Subject: Re: [PATCH] Gallant SC-6000 driver (4th version)
Date: Thu, 06 Sep 2007 16:03:42 +0200
Message-ID: <46e008be72b6c@wp.pl>
References: <46dfa2e7d6be4@wp.pl> <46DFD29A.6020601@gmail.com>
	<46DFE268.7080404@gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-2"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mx1.wp.pl (mx1.wp.pl [212.77.101.5])
	by alsa0.perex.cz (Postfix) with ESMTP id 57BC710393A
	for <alsa-devel@alsa-project.org>;
	Thu,  6 Sep 2007 16:03:43 +0200 (CEST)
In-reply-to: <46dfa2e7d6be4@wp.pl> <46DFD29A.6020601@gmail.com>
	<46DFE268.7080404@gmail.com>
Content-Disposition: inline
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Rene Herman <rene.herman@gmail.com>
Cc: alsa-devel <alsa-devel@alsa-project.org>
List-Id: alsa-devel@alsa-project.org

Dnia 6-09-2007 o godz. 13:20 Rene Herman napisa=B3(a):
> On 09/06/2007 12:12 PM, Rene Herman wrote:
> =

> > Full duplex (simultaneous playback and capture) is something
that =

> > neither Sb Pro nor CS4231 does. I do see that SB Pro doesn't
natively =

> > support S16_LE it seems...
> =

> Sorry, incorrect -- the cs4231 is full duplex. It's only the
cs4248 (ad1848) =

> which is not. Need to figure out how to do full duplex on a
sound galaxy; =

> old driver didn't do so.
> =


The SG Waverider is full duplex (at least Win95 driver says so).

Regards,
Krzysztof


----------------------------------------------------
Walka jakiej nie widzia=B3e=B6! KSW eliminacje, =

nie wszyscy przejd=B1 ca=B3o! =

Zobacz na =BFywo we Wroc=B3awiu ju=BF 15 wrze=B6nia. =

Wi=EAcej -> http://klik.wp.pl/?adr=3Dhttp%3A%2F%2Fadv.reklama.wp.pl%2Fas%2F=
ksweliminacje.html&sid=3D12

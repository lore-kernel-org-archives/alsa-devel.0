From: Juan Pablo Bouza <jpbouza@hotmail.com>
Subject: Re: M-Audio FTU issues
Date: Wed, 13 Jul 2011 18:18:23 -0300
Message-ID: <BAY155-w5801313DA3F263CD8A59C3B6470@phx.gbl>
References: <BANLkTimOjiKwOqSveGvujMJ5uBL-JKsBeA@mail.gmail.com>,
	<4E045058.6000405@showlabor.de>,
	<BANLkTi=Bj7DFbSFs9p1go-ACzCAtZ=ij6w@mail.gmail.com>,
	<4E04B42E.2080906@ladisch.de>,
	<BANLkTinurcpMuPe-99GsaxWk+pF-K4Z_7Q@mail.gmail.com>,
	<BANLkTik+2+WeOH+rcd83g63pq6asxtLAGQ@mail.gmail.com>,
	<BANLkTimz6FPFFmw+-BcmP0jzyy3=gvjcVw@mail.gmail.com>,
	<CACckToXFevhAHt_jC9P=ifZ9X0KVT1S7-KQnrcSna_ineeSyZg@mail.gmail.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from bay0-omc3-s3.bay0.hotmail.com (bay0-omc3-s3.bay0.hotmail.com
	[65.54.190.141])
	by alsa0.perex.cz (Postfix) with ESMTP id 05AB110392D
	for <alsa-devel@alsa-project.org>;
	Wed, 13 Jul 2011 23:18:30 +0200 (CEST)
In-Reply-To: <CACckToXFevhAHt_jC9P=ifZ9X0KVT1S7-KQnrcSna_ineeSyZg@mail.gmail.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


Hi! Sorry for the dull question, but I'm new to this mailing list and to al=
sa development in general.
I was looking for the latest patch for the FTU, can anyone send me the link=
 to it, or point me out to a location where alsa patches are stored?

Thanks!


> Date: Sun, 3 Jul 2011 21:52:06 +1000
> From: gdiffey@gmail.com
> To: zonque@gmail.com
> CC: tiwai@suse.de; blablack@gmail.com; alsa-devel@alsa-project.org; cleme=
ns@ladisch.de; linuxaudio@showlabor.de
> Subject: Re: [alsa-devel] M-Audio FTU issues
> =

> >
> > On Tue, Jun 28, 2011 at 10:37 PM, Aur=E9lien Leblond <blablack@gmail.co=
m>
> > wrote:
> > > Hi Daniel,
> > >
> > > All clicks gone as Felix already said :)
> >
> > Good.
> >
> >
> =

> So it works. yay
> =

> =

> > > And confirmed, the kernel crashed with playback and capture streams
> > > started at the same time :)
> >
> > I'd like to discuss the API for the ALSA/USB decoupling as suggested
> > by Clemens, which will solve this problem then.
> >
> =

> Nobody has any ideas what this interface might look like?
> =

> From what I understand this would lead to re-unifying the ua101 driver in=
to
> snd-usb-audio as well?
> =

> Grant
> _______________________________________________
> Alsa-devel mailing list
> Alsa-devel@alsa-project.org
> http://mailman.alsa-project.org/mailman/listinfo/alsa-devel
 		 	   		  =

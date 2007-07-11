From: "Thibault Le Meur" <Thibault.LeMeur@supelec.fr>
Subject: RE : RE :  RE : RE :  M-Audio Audiophile USB,
	native little endian	 (S16_LE) ?
Date: Wed, 11 Jul 2007 13:39:45 +0200
Message-ID: <013001c7c3b0$3156eff0$161ce4a0@supelec.fr>
References: <s5hwsx7i5e7.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpn.supelec.fr (smtpn.supelec.fr [160.228.120.99])
	by alsa0.perex.cz (Postfix) with ESMTP id 01EC3103807
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jul 2007 13:39:54 +0200 (CEST)
In-Reply-To: <s5hwsx7i5e7.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: 'Takashi Iwai' <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, 'Hakan Lennestal' <Hakan.Lennestal@brfsodrahamn.se>
List-Id: alsa-devel@alsa-project.org



> -----Message d'origine-----
> De : Takashi Iwai [mailto:tiwai@suse.de] =

> Envoy=E9 : mercredi 11 juillet 2007 12:47
> =C0 : Thibault Le Meur
> Cc : alsa-devel@alsa-project.org; 'Hakan Lennestal'
> Objet : Re: RE : [alsa-devel] RE : RE : M-Audio Audiophile =

> USB,native little endian (S16_LE) ?
> =

> =

> At Wed, 11 Jul 2007 12:44:27 +0200,
> Thibault Le Meur wrote:
> > =

> > =

> > >  =

> > > Ok, since Hakan reported a success for this patch, I'll
> > > prepare a new diff including Documentation update.
> > =

> > Takashi,
> > =

> > What is the deadline and what will be the =

> alsa-release/kernel-version =

> > including this patch (info needed for doc update) ?
> =

> We need it ASAP because of the merge window for 2.6.23 =

> kernel.

I'll work on this tonight then.

> The patch should be prepared against the latest HG =

> tree. I guess the patch to 1.0.14 should be applicable to the =

> current version without hitches, though.

I'll generate it against hg-tree as was my last patch.

Thanks,
Thibault.

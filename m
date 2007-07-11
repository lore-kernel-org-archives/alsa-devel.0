From: Hakan Lennestal <Hakan.Lennestal@brfsodrahamn.se>
Subject: Re: RE :  M-Audio Audiophile USB,
 native little endian  (S16_LE) ?
Date: Wed, 11 Jul 2007 12:34:50 +0200
Message-ID: <20070711103450.3AD0B5840A@ip2-138.brfsodrahamn.se>
References: <Thibault.LeMeur@supelec.fr>
Reply-To: Hakan Lennestal <Hakan.Lennestal@brfsodrahamn.se>
Mime-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ip2-138.brfsodrahamn.se (ip2-138.brfsodrahamn.se
	[213.187.199.138])
	by alsa0.perex.cz (Postfix) with ESMTP id 9E3A62437F
	for <alsa-devel@alsa-project.org>;
	Wed, 11 Jul 2007 12:34:39 +0200 (CEST)
In-Reply-To: Message from Thibault Le Meur <Thibault.LeMeur@supelec.fr>
	of "Tue, 10 Jul 2007 23:22:03 +0200."
	<20070710232203.kl84d2l85csco88o@webmail.supelec.fr>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Thibault Le Meur <Thibault.LeMeur@supelec.fr>
Cc: tiwai@suse.de, alsa-devel@alsa-project.org, 'Pavel Polischouk' <pavelp@rogers.com>
List-Id: alsa-devel@alsa-project.org


> You'll find attached an equivalent fix that checks alt-settings  =

> instead of device_setup param: Can you try it Hakan ?

Ok, patch tested now. Seem to work.

/H=E5kan

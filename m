From: Mark Brown <broonie@opensource.wolfsonmicro.com>
Subject: Re: ASoC updates for 3.3
Date: Mon, 6 Feb 2012 11:08:07 +0000
Message-ID: <20120206110807.GB3070@opensource.wolfsonmicro.com>
References: <20120204125527.GC8042@opensource.wolfsonmicro.com>
	<s5hobtcqpcr.wl%tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============6120314026018031295=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from opensource.wolfsonmicro.com (opensource.wolfsonmicro.com
	[80.75.67.52]) by alsa0.perex.cz (Postfix) with ESMTP id 7BD4524382
	for <alsa-devel@alsa-project.org>; Mon,  6 Feb 2012 12:08:08 +0100 (CET)
In-Reply-To: <s5hobtcqpcr.wl%tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lrg@ti.com>
List-Id: alsa-devel@alsa-project.org


--===============6120314026018031295==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="Fba/0zbH8Xs+Fj9o"
Content-Disposition: inline


--Fba/0zbH8Xs+Fj9o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Feb 06, 2012 at 10:32:20AM +0100, Takashi Iwai wrote:
> Mark Brown wrote:

> > The following changes since commit 1ae5cbc52e7c6619a3f44b87809fd25370df31bb:

> >   ASoC: neo1973_wm8753: remove references to the neo1973-gta01 machine (2012-01-30 13:22:13 +0000)

> > are available in the git repository at:

> >   git://git.kernel.org/pub/scm/linux/kernel/git/broonie/sound.git for-3.3

> Would you like to let me pull from asoc-3.3 tag, or for-3.3 branch?
> It seems that both point to the same.  I don't mind either, but I just
> wonder how you get this pull request with a signed tag message below...

The tag.  It's done this because I generated the request too soon after
pushing the tag so the tag wasn't on the server but the branch was and
it's not done the right thing with the error handling.

--Fba/0zbH8Xs+Fj9o
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.11 (GNU/Linux)

iQIcBAEBAgAGBQJPL7SQAAoJEBus8iNuMP3dKzkP/2TjF8Q+YDiwIKkct7rXZUdB
aW+k4J/CSVg1JKj66L4i0qjqN/jaEV06wrCmtKbbPZiVPtb300hdETtgRV3orfNa
eiP9RqYgBvevWs19YSK8w/Ai/KfyeJiDhYIdUSREtlpijbUcEVKQ2tdbZuOlwy9f
Ogxt1muRoC8d3UNQg+8xZenZe4LLlR8UsTRfkWjRbj9KFYenFVEF9JbcTQzsm06x
KAdx1f3RLYSdQBmKE1juQg+C72TrTCIzaQykcJ0yElYZXJPb/XIbxA66lU1KBDyF
TlX1rC+0EWxSq4Ra045q9Z5KNNSkJjoWpzX0t4W3PAcsKEH0B6j3aHj7ndMqNzZA
/igE/TEWUQf+mao6+xjciJUjB+F+vyUlWLySr8kM9TYyZbvliDDTqjA1PcPdjGNg
daS6pKOZKhUiQ/wDujrlYFpjG8lk1ZilHE7P2v3SWeROvFbDyc5Gq9bPnvHNTeoc
PVE3L5J1hnu7u3L+o5qACGUna02DO5CYAaQyCymOOxzHw0C3lbwQ0vHpQviNrBT1
kQ10uPDQf1MoFdr4jTgc4J01vU57Qlzr8EDC/+CkhonR5kUQOSuXpAaqGDoQ3X0U
FQDNE+TWhgBrPaB9XaFjwBA8XrCURC8p3LfqJorD/ipW7qCp0uFV3pECDVKbSjZK
6ynSI//byMrXAJczdMsT
=uliZ
-----END PGP SIGNATURE-----

--Fba/0zbH8Xs+Fj9o--

--===============6120314026018031295==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============6120314026018031295==--

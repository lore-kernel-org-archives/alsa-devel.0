From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 069/102] ASoC: ml26124: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 11:57:42 +0900
Message-ID: <20140223025742.GJ25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-42-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============9129580164734215947=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id 36113261A18
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 03:57:58 +0100 (CET)
In-Reply-To: <1392723517-12772-42-git-send-email-tiwai@suse.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@alsa-project.org, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org


--===============9129580164734215947==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="4aUSi4GuQtquuilV"
Content-Disposition: inline


--4aUSi4GuQtquuilV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:25PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--4aUSi4GuQtquuilV
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCWOjAAoJELSic+t+oim9N8IP/R74QLiXVy/krVhC8yCKjvfN
SItkndgxEjnRm4RtqGvqYm6GVeFEwhvNolKhksx/s7uv2j1EDbOjpXMF4tonaHPf
sFb1CJpp/jqQjvbAgOAt5Fv58kwBhGLw6F9h89Oe22wwHERi+fdR70UQ5QUlLfhA
IWlKiCUtbjhhUGu3b4NrGJJLSBJBmtg/UqCh53MQJWnmaN3cOG3rFMS++Lb4Z4pf
BvfvBz1sP9quASc+H0AMJtSIAwFHdk1oRZ5vF1YjFHwAJ1JeePCl60NKi0TYttbQ
rxP9XLqDY6Dd12n8xWsRsAZRP/jLbeClHNcUBp0vZWwwCP1hIojhaZIEQzBlsBgh
f4aNF2m+CsmXRBKOFQWdNkbXm416bzSb4SBFI727qXoHcXCzLK2b0sNqvZ8HciAg
vkNWBtZWIhiG1WDgUZzBhISN5jgaIK71jtUhIoysWfCxyDLXnzXXCfuFtbPQrPu9
sxNR+en5nD54OeQvlGALGyoI2KLVIgmjhu0WGUQ8K04BdrBQRHjktVQ4i4BCTu7w
Cyrt9QXvokFXglWc60qkWnm2dADSUuUV5E8q6WrpvmHVGSvGqz5OPAPBuoE09Shc
r1qn4/Y+/CY97x84G6IYsVQFW2wTpPDxSBR01S15KGj37VvIx7+QeQCXfJvF2hod
HdXC15138ZLMPmcC876O
=SaNy
-----END PGP SIGNATURE-----

--4aUSi4GuQtquuilV--

--===============9129580164734215947==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============9129580164734215947==--

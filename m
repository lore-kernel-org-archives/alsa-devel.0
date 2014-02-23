From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 052/102] ASoC: wm8903: Use
	SOC_ENUM_SINGLE_DECL()
Date: Sun, 23 Feb 2014 11:36:44 +0900
Message-ID: <20140223023644.GR25940@sirena.org.uk>
References: <1392723517-12772-2-git-send-email-tiwai@suse.de>
 <1392723517-12772-25-git-send-email-tiwai@suse.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5310036817758142640=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id A5E79264F4A
 for <alsa-devel@alsa-project.org>; Sun, 23 Feb 2014 03:37:05 +0100 (CET)
In-Reply-To: <1392723517-12772-25-git-send-email-tiwai@suse.de>
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


--===============5310036817758142640==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="/0GU/Wxy4LypDMTk"
Content-Disposition: inline


--/0GU/Wxy4LypDMTk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 12:38:08PM +0100, Takashi Iwai wrote:
> Just replace with the helper macro.  No functional change at all.

Applied, thanks.

--/0GU/Wxy4LypDMTk
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTCV64AAoJELSic+t+oim9Qm0P/AiANpz8J1g1YXm4zJnHqWgI
mFJGbYWClis7pJgAdJh/2M7FWJsbyUJL+OyTLt40xeLHxA79+QtPsozd8w5vL7sk
yna4p5CsKoctRs4ehvD1L4aiUidmjZdME8NFaPjkA1NHUgJSjgPm2KkE7NLy3guR
3H8FOG8voIB+OOiuz3FgzX9zuRFfr//ashJiJ7SCkoggS6Uj40cP3JcGFF7jjGi+
PfPR3yIWl1g9KB9D1ijcGNjijpP+diBEV8ptgof6T4tjuVm8PXVysiUDojkkcIzo
Z9r53PqhCvNDjiV9wn5pnLKQq/bVDgbvJ+79YNAkrPriwf7jU+AHpSR4UpeXFMKq
Wjm/cO97x8KE4tDeJZ4/s4JtsqskY0b0qitW9yLjwEMwJgGQSIvUqYa3yaDuAiRm
qxeITkr0RGL66uaEN4VKtef/yJ4xov+D+VvTZdeVlI3nhqC+v5uoCVsIa8wBsIo4
OeErqxKItpfAN8A/377o6NpVy0UjiR1KoqRGXDkyw+OiB3a4MWthNbZ0R+e2UaP2
kSk3GoPFDsnCK8NvCOULvokwG1gfecAh2ExBSZ6xIoJidQ3Dt8L3KmbqlTbWNUVi
eT0lBgf41a3hUNNGQBqvhp623v7nChEU81RlksmCEmwaEtsX3epfVOMJ4u68ZYgo
9RS0ihixhO8edkNWWIh7
=PzAX
-----END PGP SIGNATURE-----

--/0GU/Wxy4LypDMTk--

--===============5310036817758142640==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============5310036817758142640==--

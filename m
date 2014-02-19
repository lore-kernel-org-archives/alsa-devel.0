From: Mark Brown <broonie@kernel.org>
Subject: Re: [PATCH 2/2] ASoC: Intel: Add GFP_KERNEL flag to
 firmware DMA buffer.
Date: Wed, 19 Feb 2014 13:26:00 +0900
Message-ID: <20140219042600.GU2669@sirena.org.uk>
References: <1392720110-4278-1-git-send-email-liam.r.girdwood@linux.intel.com>
 <1392720110-4278-2-git-send-email-liam.r.girdwood@linux.intel.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7105067536271690386=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from cassiel.sirena.org.uk (cassiel.sirena.org.uk [80.68.93.111])
 by alsa0.perex.cz (Postfix) with ESMTP id 188842652C1
 for <alsa-devel@alsa-project.org>; Wed, 19 Feb 2014 05:26:41 +0100 (CET)
In-Reply-To: <1392720110-4278-2-git-send-email-liam.r.girdwood@linux.intel.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Liam Girdwood <liam.r.girdwood@linux.intel.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--===============7105067536271690386==
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="oIUK9dbftDTPhBGO"
Content-Disposition: inline


--oIUK9dbftDTPhBGO
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Tue, Feb 18, 2014 at 10:41:50AM +0000, Liam Girdwood wrote:
> Add GFP_KERNEL when allocating firmware DMA buffer.

Applied, thanks.

--oIUK9dbftDTPhBGO
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.22 (GNU/Linux)

iQIcBAEBAgAGBQJTBDJVAAoJELSic+t+oim9QwcP/2BamtszTZZlG4VD6sA2r97j
NF6K3GnVY1mkpOHOUA+MxkVFndhiNUjLOXMWnxpoj7ENyYBxnj+gIqW9YTtLh+UT
4P0eAfYfWI1bs7RXDF91/SoIKb/03H036+CIp2TvngY5SRPKQMmYkUfEzdDhUhxL
76RVlUOVhxv/B6vi2hf54TAD9UWnFMMaSDvCCYCrb08m3TYp14teEDLSSyPWqcj7
OHe+gsD4qKg50KKh1l8DswSsKUbkw9QThbuUC/BgCV5kZP2QDtUaO/2hU+BfaLEr
faQnQ2jhCxEJWdaffoiCW/BX5ReJiUXp11n/jRuIZeP2hKkMdunMwVYrHpAPPv3B
A62BbiwOdz6gEvHB5UcZbBkLmNe5r7Dmd2yfefvro4jlpqD5+wXJpHJdRPrUPnJa
zewf4FHWn5s9QYDZNnQWS8+nLLEwmQhh5bbMlpbdzGSUpwbr7pNBmZiWgfVamDxI
0aZMLHGNDYp7RmcVPh+otQ3aaA8W+8xVwhRkapkB/7Y1UisE1Gj9MEQZfst468qb
oMlOjBawPu5cyV94aplO4yY1YbmLHyRl8Ndzahg7Ax2cPs+rl/G+M9mnIFx+9pCM
b7TmcKfwsQpqzEsaDdchddlCEtZEuguLb5BpYx3VogE+EUe03xBJ93hVrgszb6ej
1wrjPGe1HzoNj1tP4BNb
=CVa5
-----END PGP SIGNATURE-----

--oIUK9dbftDTPhBGO--

--===============7105067536271690386==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7105067536271690386==--

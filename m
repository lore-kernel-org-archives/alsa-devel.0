From: Mark Brown <broonie@kernel.org>
Subject: Re: [RESEND PATCH v2 1/2] device property: Add
 function to search for named child of device
Date: Mon, 13 Jun 2016 09:47:24 +0100
Message-ID: <20160613084724.GB2282@sirena.org.uk>
References: <cover.1464802265.git.Adam.Thomson.Opensource@diasemi.com>
 <7105258db927c65dfa41a8abeef4b9735871d023.1464802265.git.Adam.Thomson.Opensource@diasemi.com>
 <97f80018-7cc4-0a50-498d-89d27dfa2fd1@intel.com>
 <2E89032DDAA8B9408CB92943514A0337D46421B6@SW-EX-MBX01.diasemi.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============7739345747402256594=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from mezzanine.sirena.org.uk (mezzanine.sirena.org.uk
 [106.187.55.193])
 by alsa0.perex.cz (Postfix) with ESMTP id AFB83265328
 for <alsa-devel@alsa-project.org>; Mon, 13 Jun 2016 10:47:56 +0200 (CEST)
In-Reply-To: <2E89032DDAA8B9408CB92943514A0337D46421B6@SW-EX-MBX01.diasemi.com>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: "Opensource [Adam Thomson]" <Adam.Thomson.Opensource@diasemi.com>
Cc: Sathyanarayana Nujella <sathyanarayana.nujella@intel.com>, "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>, Heikki Krogerus <heikki.krogerus@linux.intel.com>, Support Opensource <Support.Opensource@diasemi.com>, "linux-acpi@vger.kernel.org" <linux-acpi@vger.kernel.org>, Greg Kroah-Hartman <gregkh@linuxfoundation.org>, "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>, Liam Girdwood <lgirdwood@gmail.com>, Andrew Morton <akpm@linux-foundation.org>, Robert Moore <robert.moore@intel.com>, Lv Zheng <lv.zheng@intel.com>, Suravee Suthikulpanit <Suravee.Suthikulpanit@amd.com>, Bjorn Helgaas <bhelgaas@google.com>, "devel@acpica.org" <devel@acpica.org>, Takashi Iwai <tiwai@suse.com>, Andy Shevchenko <andriy.shevchenko@linux.intel.com>, Mika Westerberg <mika.westerberg@linux.intel.com>, Hanjun Guo <hanjun.guo@linaro.org>, "linux-kernel@vger.kernel.org" <linux-kernel@vg>
List-Id: alsa-devel@alsa-project.org


--===============7739345747402256594==
Content-Type: multipart/signed; micalg=pgp-sha256;
	protocol="application/pgp-signature"; boundary="S96ff6o5osL9bGCL"
Content-Disposition: inline


--S96ff6o5osL9bGCL
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Fri, Jun 10, 2016 at 09:58:39AM +0000, Opensource [Adam Thomson] wrote:
> On 10 June 2016 00:11, Rafael J. Wysocki wrote:

> > For some reason that didn't make it into the linux-acpi list, or at
> > least I can't see it there.

> That's strange. I'm not a subscriber to that mailing list, but I assume that
> shouldn't matter here? Strangely though the only mailing list these seem to have
> made it to is the ALSA one. :( Will see if I can find out why as I've not
> seen this problem before.

You have a very large number of people on copy, a lot of the lists have
restrictions on the number of recipients.

--S96ff6o5osL9bGCL
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2

iQEcBAEBCAAGBQJXXnMaAAoJECTWi3JdVIfQIPUH/RJm8wH/6FB3CIGgzsA+f0ru
cMUYARou5dK+stqsRtQAqIx0idCEP/IZD1HvcLnj0M8JkJaqjN6xD0xdLQMbjWbs
L8kjHvL9B/0KW2dIdjhy9DuLtr6Ut9ga7zhZF18vFRT2ebADFkxG5HThs3SXk5JY
cErqM0Hyd/T48sN26r/7Gn1RBc0nQOwrhhzpW1rCy+MVDEzZaJQaUl+5OF414OVP
DiJAjXp6+p+wWCVXJQvGcrCv3W2cQRPZDlnOxjn/or6Ixatji+asZrO6GEBu1X9/
DJyHmCO5QXo/P9vlGK64Gt9WBE5ZXRsHR49H7HViOhO0Ga8YlQtwH2uiTKIqjrU=
=QqcN
-----END PGP SIGNATURE-----

--S96ff6o5osL9bGCL--

--===============7739345747402256594==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============7739345747402256594==--

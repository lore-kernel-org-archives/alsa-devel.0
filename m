From: Dominik Brodowski <linux@dominikbrodowski.net>
Subject: Re: [PATCH 2/4] acpi: allow for an override to set _REV
Date: Thu, 14 May 2015 16:18:23 +0200
Message-ID: <20150514141823.GA29030@light.dominikbrodowski.net>
References: <1431610288-26737-1-git-send-email-linux@dominikbrodowski.net>
 <1431610288-26737-3-git-send-email-linux@dominikbrodowski.net>
Mime-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="EeQfGwPcQSOJBaQU"
Return-path: <linux-acpi-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <1431610288-26737-3-git-send-email-linux@dominikbrodowski.net>
Sender: linux-acpi-owner@vger.kernel.org
To: rjw@rjwysocki.net
Cc: linux-acpi@vger.kernel.org, mario_limonciello@dell.com, broonie@kernel.org, matthew.garrett@coreos.com, alsa-devel@alsa-project.org
List-Id: alsa-devel@alsa-project.org


--EeQfGwPcQSOJBaQU
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, May 14, 2015 at 03:31:26PM +0200, Dominik Brodowski wrote:
> By using a module parameter named acpi.supported_rev=<value>, the BIOS

That should be acpi.rev=<value>. Feel free to edit the commit message
accordingly. Thanks!

Best,
	Dominik

--EeQfGwPcQSOJBaQU
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJVVK6vAAoJEJqXYIlMjaMNZ50QAJ4lfX8pkap+J2jSquS/tAxl
VSzmTZKSRilztnLBX8e3QM8XnVaycziTSqZf9PnKTQ56A1wRyXlvHoN6Uha48XSL
0E8UOYelmRRg/wPwjWNtViY+SkC5G9SOf5jx4jVUygkcmIrW9yKNYAvSUW+uP/DG
IAxLlbVzwr8W8/a7gH9twxxSF98u3gZBwJKjkLP6uMOXWPI+jXjX3418qhi6OyhW
FUyhFti5Z8r98rWlvGzn/z2ecuRCp/f+GIDo12k8uREsld8AfwMyN6/CRd9GDVAx
d+6snv6UbMiZ5A069XbcORrleMDICJK5WIbGEo/Hav/CBAQZsrHxih4Kg+WnuIm2
A2TdUimAWCAeeXM6mHcPQiJ0FDwM5bH8q/DzggHaW2M1dSwb6JIT4GGQkqZa6IgK
h+DDFEBx7EHt8gZPOVtVwhmiKimp9+Ts0u7Znxe62zFH0k6Jd9ppQ/MXjJHtoNgE
id8V5uOAJ8sUrNXdRelUQ0zg1hmL/g6m/6o3GJqf03Hh5lfQ47CKqbuagBn07k8S
ULRP9im223SR/62izQSDCiNgjAfDW2PPgS2v1T6JZRJlWYs0B9GSnG8dJ0bi4G3g
sfxOBEiZvGXmrw9f63PKzGALlcn4ueq6h1HD7f07AIAeQgIURZHuVWcM8U7stTWI
G19GM7TGdTB7ymLHzZGP
=0Q/8
-----END PGP SIGNATURE-----

--EeQfGwPcQSOJBaQU--

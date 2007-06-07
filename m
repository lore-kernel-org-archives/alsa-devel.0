From: "Daniel T. Chen" <crimsun@fungus.sh.nu>
Subject: [PATCH] Add quirk for another MSI laptop to
	alc883_cfg_tbl[]
Date: Thu, 07 Jun 2007 18:16:09 -0400
Message-ID: <1181254569.21983.10.camel@Box.ncat.edu>
Reply-To: crimsun@ubuntu.com
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============4131152308168625836=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from ns1.mcdownloads.com (ns1.mcdownloads.com [216.239.132.98])
	by alsa0.perex.cz (Postfix) with ESMTP id 3017C24646
	for <alsa-devel@alsa-project.org>;
	Fri,  8 Jun 2007 00:16:11 +0200 (CEST)
Received: from ns1.mcdownloads.com (localhost [127.0.0.1])
	by ns1.mcdownloads.com (Postfix) with ESMTP id 0739728005142
	for <alsa-devel@alsa-project.org>; Thu,  7 Jun 2007 15:16:08 -0700 (PDT)
Received: from [127.0.0.1] (adhd.irule.net [66.81.0.197])
	(Authenticated sender: crimsun@fungus.sh.nu)
	by ns1.mcdownloads.com (Postfix) with ESMTP
	for <alsa-devel@alsa-project.org>; Thu,  7 Jun 2007 15:16:07 -0700 (PDT)
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


--===============4131152308168625836==
Content-Type: multipart/signed; micalg=pgp-sha1; protocol="application/pgp-signature"; boundary="=-p2qTi20Wd3UC4Zrhjvhv"


--=-p2qTi20Wd3UC4Zrhjvhv
Content-Type: multipart/mixed; boundary="=-CO2cYIy92I37cWALmACf"


--=-CO2cYIy92I37cWALmACf
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

Hi,

Attached please find an hg changeset against current alsa-kernel tip
adding the SSID of another MSI laptop to the quirk list.

Thanks,
Daniel Chen

--=-CO2cYIy92I37cWALmACf
Content-Disposition: attachment; filename=new2.diff
Content-Type: text/x-patch; name=new2.diff; charset=UTF-8
Content-Transfer-Encoding: base64

IyBIRyBjaGFuZ2VzZXQgcGF0Y2gNCiMgVXNlciBjcmltc3VuQEJveC5uY2F0LmVkdQ0KIyBEYXRl
IDExODEyNTM3NjYgMTQ0MDANCiMgTm9kZSBJRCBkNDE5NDI3YzQwNzEzMzQwY2Y1YWI3YjBlNmIx
MjJhODI0NjVkNmJhDQojIFBhcmVudCAgOGJjNjllNzNhNjU1OGQ3MDQyZDVhODZiZDBmNDFmMmQ1
OWFmMzhhMw0KW1BBVENIXSBBZGQgcXVpcmsgZm9yIGFub3RoZXIgTVNJIGxhcHRvcCB0byBhbGM4
ODNfY2ZnX3RibFtdDQoNClRoaXMgaGcgY29tbWl0IGFkZHMgdGhlIFNTSUQgb2YgYW5vdGhlciBN
U0kgbGFwdG9wIHRvIHRoZQ0KYWxjODgzX2NmZ190YmxbXSBxdWlyayBsaXN0LiAgVmVyaWZpZWQg
aW4gI2Fsc2EvRnJlZW5vZGUNCm9uIFRodSwgSnVuIDcsIDIwMDcuDQoNClNpZ25lZC1vZmYtYnk6
IERhbmllbCBUIENoZW4gPGNyaW1zdW5AdWJ1bnR1LmNvbT4NCg0KZGlmZiAtciA4YmM2OWU3M2E2
NTUgLXIgZDQxOTQyN2M0MDcxIHBjaS9oZGEvcGF0Y2hfcmVhbHRlay5jDQotLS0gYS9wY2kvaGRh
L3BhdGNoX3JlYWx0ZWsuYwlXZWQgSnVuIDA2IDE0OjQ4OjUyIDIwMDcgKzAyMDANCisrKyBiL3Bj
aS9oZGEvcGF0Y2hfcmVhbHRlay5jCVRodSBKdW4gMDcgMTg6MDI6NDYgMjAwNyAtMDQwMA0KQEAg
LTYzODgsNiArNjM4OCw3IEBAIHN0YXRpYyBzdHJ1Y3Qgc25kX3BjaV9xdWlyayBhbGM4ODNfY2Zn
X3QNCiAJU05EX1BDSV9RVUlSSygweDE0NjIsIDB4NzE4NywgIk1TSSIsIEFMQzg4M182U1RfRElH
KSwNCiAJU05EX1BDSV9RVUlSSygweDE0NjIsIDB4NzI1MCwgIk1TSSIsIEFMQzg4M182U1RfRElH
KSwNCiAJU05EX1BDSV9RVUlSSygweDE0NjIsIDB4NzI4MCwgIk1TSSIsIEFMQzg4M182U1RfRElH
KSwNCisJU05EX1BDSV9RVUlSSygweDE0NjIsIDB4MDM0OSwgIk1TSSIsIEFMQzg4M19UQVJHQV8y
Y2hfRElHKSwNCiAJU05EX1BDSV9RVUlSSygweDE0NjIsIDB4MDU3OSwgIk1TSSIsIEFMQzg4M19U
QVJHQV8yY2hfRElHKSwNCiAJU05EX1BDSV9RVUlSSygweDE0NjIsIDB4MzcyOSwgIk1TSSBTNDIw
IiwgQUxDODgzX1RBUkdBX0RJRyksDQogCVNORF9QQ0lfUVVJUksoMHgxNDYyLCAweDNlZjksICJN
U0kiLCBBTEM4ODNfVEFSR0FfRElHKSwNCg==


--=-CO2cYIy92I37cWALmACf--

--=-p2qTi20Wd3UC4Zrhjvhv
Content-Type: application/pgp-signature; name=signature.asc
Content-Description: This is a digitally signed message part

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQBGaIOpe9GwFciKvaMRAv5nAJ98LtD863Gzt56NDOi7eNzUbY9dhwCgqaHF
8ygDy8w1i+lg/yOLYdDVUtc=
=bBA9
-----END PGP SIGNATURE-----

--=-p2qTi20Wd3UC4Zrhjvhv--

--===============4131152308168625836==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--===============4131152308168625836==--

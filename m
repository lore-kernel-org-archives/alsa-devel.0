From: "Tais M. Hansen" <tais.hansen@osd.dk>
Subject: Re: Re: [Alsa-user] Upgrade problems -addendum
Date: Thu, 23 Jan 2003 18:50:38 +0100
Sender: alsa-devel-admin@lists.sourceforge.net
Message-ID: <200301231850.44138.tais.hansen@osd.dk>
References: <200301221234.33054.tais.hansen@osd.dk> <200301231337.13089.tais.hansen@osd.dk> <s5h4r7zzyws.wl@alsa2.suse.de>
Mime-Version: 1.0
Content-Type: Multipart/Mixed;
  boundary="------------Boundary-00=_EKH6XQ2FIDZ5Z3T9W1YN"
Return-path: <alsa-devel-admin@lists.sourceforge.net>
In-Reply-To: <s5h4r7zzyws.wl@alsa2.suse.de>
Errors-To: alsa-devel-admin@lists.sourceforge.net
List-Help: <mailto:alsa-devel-request@lists.sourceforge.net?subject=help>
List-Post: <mailto:alsa-devel@lists.sourceforge.net>
List-Subscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=subscribe>
List-Unsubscribe: <https://lists.sourceforge.net/lists/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@lists.sourceforge.net?subject=unsubscribe>
List-Archive: <http://sourceforge.net/mailarchive/forum.php?forum=alsa-devel>
To: Takashi Iwai <tiwai@suse.de>
Cc: alsa-devel@lists.sourceforge.net
List-Id: alsa-devel@alsa-project.org


--------------Boundary-00=_EKH6XQ2FIDZ5Z3T9W1YN
Content-Type: text/plain;
  charset="iso-8859-1"
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

On Thursday 23 January 2003 16:08, Takashi Iwai wrote:
> > Okay, fresh cvs checkout. Enabled POINTER_DEBUG and applied the
> > via-pointer-debug.dif.
> > Ogg123 freezes/stalls without ever making a sound, like with the prev=
ious
> > test and test3 patches. Log output is attached.
> > Aplay plays a wav-file fine. No problems noticed. Log output is attac=
hed.
> thanks.
> it seems really the index value was not updated correctly by the
> chip.
> ok, take 4:  please try the new one...

Same as before, log output attached. :)


- --=20
Regards,
Tais M. Hansen
OSD

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.2.0 (GNU/Linux)

iQIVAwUBPjArcYIvLOJqwYc4AQJQyBAAjSgAESxt/dy8dhIaK1XFUAW4fwdnwgFB
8Ydg+Fac5vlsGLpZ2+VnF/wjo4391ZkgdSQIyViCt996csGv1IuVilkd4Nx77dJU
/+dbnrHfbP/bATFY3zBMiGahgfDyQQnXb6zrrmQPLRLqN9jYkAoOJRKVJRxme6QT
Yc1+S09pxYp9s+wwrf1MQ9k/j5P4KST2jNOfNQsu1nrvpbeHJLxPLps8UJlbz/2O
/ZMhyPRUCJJ+8vqTbReaw5fPt4z+vZUzWmiSQkRaH/zmu0mFjEGn0shLwduokKP7
dykv2VOQJT/rzx9bhmj1fXNLf6Fm7JK36VrckOGlmJ/zgXAvI4hmgE210fiIE+Hl
5eX+XQczas7AmdNpwIsfQBnoEidw+14L3mMweMNS4En3mVzaRixzucddlKZP71rN
EyV30nlmUhUqDRk5QJnwVZwSXKvILLrYMKSmJ1hmfC6MsD0NNZE97mTVn6L4gPDd
SyjElY8q3Ry2OdzaWzIem+fgNK031fzJxVFBNH+zxgNnKocO84wH47vOlweArEkd
4IISZlSMUM78xeCu1DbzFS0BDZkU5vDET0+wQ4sz82Yc1T6nieLOWMMuHrWoztE9
aCj/Hn6KreGdR9jRy+Nt7D+YIQ+NUzFIIohq8nuqvaEOZ3sn5IUV5nSpyUSZsh9F
0nccZ6azGDE=3D
=3DqJIw
-----END PGP SIGNATURE-----

--------------Boundary-00=_EKH6XQ2FIDZ5Z3T9W1YN
Content-Type: application/x-gzip;
  name="alsa-aplay-test4.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="alsa-aplay-test4.txt.gz"

H4sICIMqMD4AA2Fsc2EtYXBsYXktdGVzdDQudHh0AO2cTW+bQBCG7/4Ve2wlJ7B82BipqnKteqt6
jtZ47dJgQIATt7++2GmrxKCuZ2GGkZpLIq+c6MHzeJa8O7HzqConK3ZO/aNuv8Wz2SeVC88XMoqD
IA4jUVbFNk3SQjzoKtdZLLYqbb+mm6P4IOTC8RZzkam6KYu6XXCP2nXduVgftnX6U3vnJZUEwVwU
2/PSeWVzftLfh/L8MCkOefP8Awt3MIeUoaIHcbsc17we/2JYu4MZgnAgg9LQgnQhVte8ENFq85Jj
4b/CkMElxmoSP5MROKT0E3oQBD+XnfcImCGIrnirjspA4mcYuy4HP604MPw0g+D3TxuGsftnyyCZ
iAHnQBLDAEIiBpgBQQx/EjGiaDiHlMuIHoREDDADghgBk44B50DqGAYQEjHADAhihEzEgHMgiWEA
IREDzDCBGET3wAsmfsI5kPw0gJD4CWZA8NNUECI/p8m4ulrYZFwofk6ecdkwIPjJIlyy4kASgz5c
AhelTwyPWgyaxiWZhEsWHDh+mkAo/IQzjO+nsSBEfjLJuCw4kPxkkHHBGcbfWKXHRAw4B5IYBhAS
McAMw8VIoAVBalzRBQaTqM2CYxw/PSAIiZ8MojZjQYg21okSlY4WVomKHgzSrQuDRAXOgOAnj0RF
Lifxc70YziFlMHxqCAxC4ieYAcFPJlGbBQfSjR+DqA3OgHDjx2GcrMWYKPHrbKxWid/wjRUMQpKo
MEj8jAXB8fOyHB6TxM+CA6d/mkAo/IQzjO/nfy8G9J1CsbHaiDG6nEwyWAsOpI5Bn8GCi4LRMS7v
uIwFobnj8phEwRYcSI2LQRQMZ0BoXNPMwXbFsJmDRWlcDOZg4QxvYuB3jDcxrisI0Y7GZBzXggPJ
TwbjuHAGBD+ZzMFacCDtaAxObeAME4hBFC5Nc2rT1cLm1AbFT/pTm64bFqc2o/+paCoI2sY6mzl/
Pp9go9eH7scT9JDdff5yJ25vHZXV6uZ50UmKSjtlsr/P0vVtEkvPj8XXXB9LnTR6I7493ZdFmje6
Eo8qO2jxrm4qrfYnjrnY6KxRsbjx/ai9yr06iu9pc3pue+XS9cL3sXiqinwnzr+hOpSNUMlDXjxl
erPTH83/N38NcbS0IA7cKBpI/HqY8FRisdd1rXZaVLrU6gQTiiZtF82jPJgXOrQ0/cMdzEsTmUrj
9Zam5zAD8UJXw0vTF1bxLs3LntlfGv93aX4Bmv2Sl4JFAAA=

--------------Boundary-00=_EKH6XQ2FIDZ5Z3T9W1YN
Content-Type: application/x-gzip;
  name="alsa-ogg123-test4.txt.gz"
Content-Transfer-Encoding: base64
Content-Disposition: attachment; filename="alsa-ogg123-test4.txt.gz"

H4sICAgqMD4AA2Fsc2Etb2dnMTIzLXRlc3Q0LnR4dADFkl1LwzAUhu/7K87lBtuafqhdYIyBN4pe
qHg90vS0xqVNSdKt89ebdigMhwwrepOT85KP55zz+lumfakK3+yNC9TzblkFYQRBQuOQXhCotcoF
Fwo2qCuUFHIm3CqyFhZA/GQCkhlbK9OlbUAImUDa5Ea8YdhLcS+pvJd6xaWf+8MFrprK9jlPyFCE
KBmGMBQgGtqDbwC6f6BEY1iBoLFGZjGDEKxw4n/PDvkReUTJnyMkSDzP8z9cnWHanGXq1d3TCmYz
n0nDpgfR50qjX/NyLUU64zRIrig8V9jWyLumv+zWtRKVRQ1bJhuEkbEaWdlxTCBDaRmFaUwSV2PJ
WngVtju7gJjML8cUdlpVBfQP6Ka2wPimUjuJWYHL3wEOox8ABySMhwEfz/20Y+Nw/tWzpw1zRqVh
ELjZ1JLtUwflQIVFcJRKw+j6fgUu3jw+gNWqSSUux9472qWn7/cEAAA=

--------------Boundary-00=_EKH6XQ2FIDZ5Z3T9W1YN--



-------------------------------------------------------
This SF.NET email is sponsored by:
SourceForge Enterprise Edition + IBM + LinuxWorld = Something 2 See!
http://www.vasoftware.com

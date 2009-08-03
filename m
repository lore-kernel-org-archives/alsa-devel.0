From: Lukasz Stelmach <stlman@poczta.fm>
Subject: Re: [PATCH - amixer] listen to D-Bus for volume-up,
 volume-down and mute signals.
Date: Mon, 03 Aug 2009 19:34:01 +0200
Message-ID: <4A771F89.3010103@poczta.fm>
References: <1249296201-6930-1-git-send-email-stlman@poczta.fm>
	<s5hocqxcgqb.wl%tiwai@suse.de> <4A76D239.70202@poczta.fm>
	<s5hiqh5ccyr.wl%tiwai@suse.de>
	<20090803121747.GD5959@sirena.org.uk> <4A771774.8040408@poczta.fm>
	<20090803170222.GA23621@rakim.wolfsonmicro.main>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="------------010905030903090703080403"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp239.poczta.interia.pl (smtp239.poczta.interia.pl
	[217.74.64.239]) by alsa0.perex.cz (Postfix) with ESMTP id 63C002434A
	for <alsa-devel@alsa-project.org>;
	Tue,  4 Aug 2009 00:19:05 +0200 (CEST)
In-Reply-To: <20090803170222.GA23621@rakim.wolfsonmicro.main>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@opensource.wolfsonmicro.com>
Cc: Takashi Iwai <tiwai@suse.de>, alsa-devel@alsa-project.org, lrg@slimlogic.co.uk
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format.
--------------010905030903090703080403
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable

-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA1

Mark Brown pisze:
> On Mon, Aug 03, 2009 at 06:59:32PM +0200, Lukasz Stelmach wrote:
>> Mark Brown pisze:
>=20
>>> I tend to agree, merging it into amixer seems kind of arbatrary.  Suc=
h a
>>> daemon (and its dbus interface) may also be useful for handling thing=
s
>>> like scenario management so I can see it growing over time.
>=20
>> Scenario management? Could you please say something more what I
>> have not been missing for so long ;-)
>=20
> See http://www.slimlogic.co.uk/?p=3D40

Thanks. That's definitely not anything I had in mind doing that patch.

- --
By=C5=82o mi bardzo mi=C5=82o.               Czwarta pospolita kl=C4=99sk=
a, [...]
>=C5=81ukasz<                 Ju=C5=BC nie katolicka lecz z=C5=82odziejsk=
a.  (c)PP
-----BEGIN PGP SIGNATURE-----
Version: GnuPG v2.0.11 (GNU/Linux)
Comment: Using GnuPG with Mozilla - http://enigmail.mozdev.org

iEYEARECAAYFAkp3H4gACgkQNdzY8sm9K9xFYwCeM5d8v2VohuO3zSBJ6oAHYuA+
iXMAn3QTazTV/QDtDfveCaHr+wwSeB9G
=3Del5A
-----END PGP SIGNATURE-----


----------------------------------------------------------------------
Zostan Dziewczyna lub Chlopakiem lata!
Wygraj skuter >> http://link.interia.pl/f22a7=20

--------------010905030903090703080403
Content-Type: text/x-vcard; charset=utf-8;
 name="stlman.vcf"
Content-Transfer-Encoding: base64
Content-Disposition: attachment;
 filename="stlman.vcf"

YmVnaW46dmNhcmQNCmZuO3F1b3RlZC1wcmludGFibGU6PUM1PTgxdWthc3ogU3RlbG1hY2gN
Cm47cXVvdGVkLXByaW50YWJsZTpTdGVsbWFjaDs9QzU9ODF1a2Fzeg0KZW1haWw7aW50ZXJu
ZXQ6c3RsbWFuQHBvY3p0YS5mbQ0KeC1tb3ppbGxhLWh0bWw6RkFMU0UNCnZlcnNpb246Mi4x
DQplbmQ6dmNhcmQNCg0K
--------------010905030903090703080403
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

--------------010905030903090703080403--

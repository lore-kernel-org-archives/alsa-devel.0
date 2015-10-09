From: Lars-Peter Clausen <lars@metafoo.de>
Subject: Re: Audio Mini Summit 2015, 8th October, Dublin
Date: Fri, 09 Oct 2015 15:29:23 +0200
Message-ID: <5617C133.1080006@metafoo.de>
References: <20151004231752.GA22609@sirena.org.uk>
 <20151007152047.GQ12635@sirena.org.uk> <561679FE.3060809@metafoo.de>
 <56167DBF.9090106@metafoo.de>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3354673690656543907=="
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtp-out-070.synserver.de (smtp-out-092.synserver.de
 [212.40.185.92])
 by alsa0.perex.cz (Postfix) with ESMTP id 2F0052606E9
 for <alsa-devel@alsa-project.org>; Fri,  9 Oct 2015 15:29:25 +0200 (CEST)
In-Reply-To: <56167DBF.9090106@metafoo.de>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/options/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel/>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
 <mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Errors-To: alsa-devel-bounces@alsa-project.org
Sender: alsa-devel-bounces@alsa-project.org
To: Mark Brown <broonie@kernel.org>, alsa-devel@alsa-project.org
Cc: Takashi Iwai <tiwai@suse.de>, Liam Girdwood <lgirdwood@gmail.com>
List-Id: alsa-devel@alsa-project.org

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--===============3354673690656543907==
Content-Type: multipart/signed; micalg=pgp-sha1;
 protocol="application/pgp-signature";
 boundary="own89PQVcw3hUTbkn6UMasHM42vnMi09e"

This is an OpenPGP/MIME signed message (RFC 4880 and 3156)
--own89PQVcw3hUTbkn6UMasHM42vnMi09e
Content-Type: text/plain; charset=windows-1252
Content-Transfer-Encoding: quoted-printable

On 10/08/2015 04:29 PM, Lars-Peter Clausen wrote:
> On 10/08/2015 04:13 PM, Lars-Peter Clausen wrote:
>> On 10/07/2015 05:20 PM, Mark Brown wrote:
>>> On Mon, Oct 05, 2015 at 12:17:52AM +0100, Mark Brown wrote:
>>>> [This message is BCCed to everyone currently on the signup list]
>>>>
>>>> As previously announce the audio mini-summit for this year will be t=
his
>>>> Thursday (8th August) at CCD in Dublin.  Topics we currently have on=
 the
>>>> list for discussion are:
>>>
>>> Current list:
>>>
>>>  - Power saving and general system design decisions (is what we're do=
ing
>>>    lining up with modern hardware with things like multiple output
>>>    streams?).
>>>  - Documentation.
>>>  - alsa-lib releae plans.
>>>  - What to do with HDMI and its integration with graphics.
>>>  - Test tools (Intel BAT and others).
>>>  - BATCH flag.
>>>  - Fuzz control PCM APIs.
>>>  - Splitting out root only controls.
>>>  - ACPI simple-card and general generic card support.
>>>  - Topology & media controller integration.
>>>  - Kernel tinification.
>>>  - Android <-> alsa-lib configuration translation.
>>>  - HDA restructuring.
>>>   - Support for DisplayPort MST.
>>>  - PCM core simplification - the code is currently quite complex!
>>>  - Soundwire driver support plans.
>>>  - ASoC multichannel.
>>>  - Random DAPM changes.
>>
>> Media controller:
>> http://blogs.s-osg.org/working-complicated-problems-media-controller-w=
orkshop/
>=20
> And to give some more background information on how the constraints
> refinement works: http://metafoo.de/alsa_constraints.html
>=20
> It's not yet complete but should still give you and idea

Btw. when you try to size optimize the kernel have you tried to build stu=
ff
with link-time-optimization? A lot of the constraints refinement code is
helper function that are only used by certain drivers. So with LTO also
those helper function would be removed.



--own89PQVcw3hUTbkn6UMasHM42vnMi09e
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1

iQIcBAEBAgAGBQJWF8EzAAoJEOj3aLScRbOZLnkP/R2JGAlKm4uJThr5R42E0f3T
BIx8lv5w7R0dr2osxiH8QGB8G/N1d62B8+bEnZSSgAM/s0SEuuAJQBkjYj0rZsrt
ajZKle4ejVhi9ZsdsOdheTVIgyEfr8jcLjdNoiUxR6l4BBS/sYhgFr1MjIc6TaZJ
RFNvP8tbZ9cjtLc+mlDj4EjjjKYWFuRb7CTRXb+op4i1bybzZuqggxmJo00Kd20R
YvUuocMk0oPEWpk64pvHJifEnAjCVOBqPSLjLTaQHBsSg+l7Qbvj8QK9Wno+M8xC
823AU66nMHrQvwNOt1VWN7tPgZHyE1NQMk93Mtd3beM2/wlrEVmosgTMTL2aTkl6
6yA5FdyOW9e7oWcVrkqxEQFSdY3t8OlvJlmSQ+Y2LR2p/wF7v6mIfBCwh2IvzdRD
kKLeLt32hB3fpvUFRkQKb3fEZz3i2MgYdf2R1kOgYCDQX5MZDsWkf2UxV887M2aW
/i+KVWZjFFKJ3LRDbQXQJkBqsc+06elYs6aSJLaG3yj/UUBP/10Wb+Pd/eIdIr1l
qh+/NzZN0U7KURvd5O4b4NawQDzMTnVFVfaXfkgOW2VbrXPIW4LBtkkSNSTif4Qj
GPXKAt7JX5tQbAQrN25ZhGGOclppCyBPa+TrSyc/PqXsXDb96LGLuCWAffzNgM8M
4PNWrHEeXZ9aSapp9TwN
=eKvo
-----END PGP SIGNATURE-----

--own89PQVcw3hUTbkn6UMasHM42vnMi09e--

--===============3354673690656543907==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline


--===============3354673690656543907==--

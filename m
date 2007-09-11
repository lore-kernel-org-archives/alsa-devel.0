From: owner@bugs.debian.org (Debian Bug Tracking System)
Subject: Bug#438886: marked as done (alsa-base: alsa modules
 loaded but /proc/asound/cards remains empty)
Date: Tue, 11 Sep 2007 19:27:07 +0000
Message-ID: <handler.438886.D438886.118953869827435.ackdone@bugs.debian.org>
References: <20070911192452.GR17585@frodo.home.lxtec.de>
	<46C9AD6D.1030508@woodwaysolutions.co.uk>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="----------=_1189538827-28956-0"
Return-path: <alsa-devel-bounces@alsa-project.org>
Received: from smtpout.hostsharing.net (smtpout.hostsharing.net [83.223.95.15])
	by alsa0.perex.cz (Postfix) with ESMTP id 760BA24458
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Sep 2007 22:28:26 +0200 (CEST)
Received: from h01.hostsharing.net (h01.hostsharing.net [212.42.230.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtpout.hostsharing.net (Postfix) with ESMTP id EFC1A2000067
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Sep 2007 22:28:25 +0200 (CEST)
Received: from mail.home.lxtec.de (p5B14513F.dip.t-dialin.net [91.20.81.63])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by h01.hostsharing.net (Postfix) with ESMTP id 4E2C6162134B5
	for <alsa-devel@alsa-project.org>;
	Wed, 12 Sep 2007 22:28:25 +0200 (CEST)
Received: from localhost ([127.0.0.1])
	by mail.home.lxtec.de with esmtp (Exim 4.68 1 (LXTEC))
	id 1IVYoy-0007dZ-Is
	for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2007 22:28:24 +0200
Received: from mail.home.lxtec.de ([127.0.0.1])
	by localhost (mail.home.lxtec.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id QB8OcKSHTtqT for <alsa-devel@alsa-project.org>;
	Wed, 12 Sep 2007 22:28:18 +0200 (CEST)
Received: from frodo.home.lxtec.de ([192.168.200.202] ident=Debian-exim)
	by mail.home.lxtec.de with esmtps (Exim 4.68 1 (LXTEC))
	id 1IVYos-0007d2-RM
	for <alsa-devel@alsa-project.org>; Wed, 12 Sep 2007 22:28:18 +0200
Resent-Message-ID: <20070912202818.GC4125@frodo.home.lxtec.de>
Resent-To: alsa-devel <alsa-devel@alsa-project.org>
List-Unsubscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=unsubscribe>
List-Archive: <http://mailman.alsa-project.org/pipermail/alsa-devel>
List-Post: <mailto:alsa-devel@alsa-project.org>
List-Help: <mailto:alsa-devel-request@alsa-project.org?subject=help>
List-Subscribe: <http://mailman.alsa-project.org/mailman/listinfo/alsa-devel>,
	<mailto:alsa-devel-request@alsa-project.org?subject=subscribe>
Sender: alsa-devel-bounces@alsa-project.org
Errors-To: alsa-devel-bounces@alsa-project.org
To: Elimar Riesebieter <riesebie@lxtec.de>
List-Id: alsa-devel@alsa-project.org

This is a multi-part message in MIME format...

------------=_1189538827-28956-0
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=utf-8

Your message dated Tue, 11 Sep 2007 21:24:52 +0200
with message-id <20070911192452.GR17585@frodo.home.lxtec.de>
and subject line Bug#438886: [Pkg-alsa-devel] Bug#438886: alsa-base: alsa m=
odules loaded but /proc/asound/cards remains empty
has caused the attached Bug report to be marked as done.

This means that you claim that the problem has been dealt with.
If this is not the case it is now your responsibility to reopen the
Bug report if necessary, and/or fix the problem forthwith.

(NB: If you are a system administrator and have no idea what I am
talking about this indicates a serious mail system misconfiguration
somewhere.  Please contact me immediately.)

Debian bug tracking system administrator
(administrator, Debian Bugs database)


------------=_1189538827-28956-0
Content-Type: message/rfc822
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Received: (at submit) by bugs.debian.org; 20 Aug 2007 15:04:45 +0000
Return-path: <matt@woodwaysolutions.co.uk>
Received: from mtaout03-winn.ispmail.ntl.com ([81.103.221.49])
	by rietz.debian.org with esmtp (Exim 4.50)
	id 1IN8o9-0001pa-Hc
	for submit@bugs.debian.org; Mon, 20 Aug 2007 15:04:45 +0000
Received: from aamtaout03-winn.ispmail.ntl.com ([81.103.221.35])
          by mtaout03-winn.ispmail.ntl.com with ESMTP
          id <20070820150413.HXOT13.mtaout03-winn.ispmail.ntl.com@aamtaout03-winn.ispmail.ntl.com>
          for <submit@bugs.debian.org>; Mon, 20 Aug 2007 16:04:13 +0100
Received: from [192.168.0.13] (really [82.26.205.32])
          by aamtaout03-winn.ispmail.ntl.com with ESMTP
          id <20070820150413.UXYI26699.aamtaout03-winn.ispmail.ntl.com@[192.168.0.13]>
          for <submit@bugs.debian.org>; Mon, 20 Aug 2007 16:04:13 +0100
Message-ID: <46C9AD6D.1030508@woodwaysolutions.co.uk>
Date: Mon, 20 Aug 2007 16:04:13 +0100
From: Matthew Grice <matt@woodwaysolutions.co.uk>
User-Agent: Icedove 1.5.0.12 (X11/20070606)
MIME-Version: 1.0
To: submit@bugs.debian.org
Subject: alsa-base: alsa modules loaded but /proc/asound/cards remains empty
Content-Type: text/plain; charset=UTF-8; format=flowed
Delivered-To: submit@bugs.debian.org
X-Spam-Checker-Version: SpamAssassin 2.60-bugs.debian.org_2005_01_02
	(1.212-2003-09-23-exp) on rietz.debian.org
X-Spam-Level: 
X-Spam-Status: No, hits=-9.0 required=4.0 tests=BAYES_00,HAS_PACKAGE
	autolearn=ham version=2.60-bugs.debian.org_2005_01_02
Content-Transfer-Encoding: quoted-printable

Package: alsa-base
Version: 1.0.14-1


I'm using Debian Unstable (Lenny) on the AMD64 platform.

  All the correct ALSA modules are loaded for my soundcard:

matt@giant:~$ lsmod | grep snd
snd_via82xx            34600  0
gameport               21264  1 snd_via82xx
snd_ac97_codec        117336  1 snd_via82xx
ac97_bus                7040  1 snd_ac97_codec
snd_pcm                89736  2 snd_via82xx,snd_ac97_codec
snd_timer              28552  1 snd_pcm
snd_page_alloc         15120  2 snd_via82xx,snd_pcm
snd_mpu401_uart        13568  1 snd_via82xx
snd_rawmidi            30880  1 snd_mpu401_uart
snd_seq_device         13076  1 snd_rawmidi
snd                    69104  7=20
snd_via82xx,snd_ac97_codec,snd_pcm,snd_timer,snd_mpu401_uart,snd_rawmidi,=
snd_seq_device
soundcore              15392  3 snd,via82cxxx_audio,sound
matt@giant:~$

But! There is no mention of a soundcard in /proc/asound/cards:

matt@giant:~$ cat /proc/asound/cards
--- no soundcards ---
matt@giant:~$

the kernel reports the soundcards correctly configured:

matt@giant:~$ dmesg | grep [Vv][Ii][Aa]82
via82cxxx: Six channel audio available
via82cxxx: Codec rate locked at 48Khz
via82cxxx: board #1 at 0xDC00, IRQ 193
via82cxxx: Six channel audio available
via82cxxx: Codec rate locked at 48Khz
via82cxxx: board #1 at 0xDC00, IRQ 193
matt@giant:~$

But alsa reports that there are no cards to applications:

matt@giant:~$ xmms
Message: device: default

** WARNING **: alsa_get_mixer(): Attaching to mixer hw:0 failed: No such=20
device
ALSA lib confmisc.c:769:(parse_card) cannot find card '@
                                                         =EF=BF=BD'
ALSA lib conf.c:3510:(_snd_config_evaluate) function=20
snd_func_card_driver returned error: No such device
ALSA lib confmisc.c:392:(snd_func_concat) error evaluating strings
ALSA lib conf.c:3510:(_snd_config_evaluate) function snd_func_concat=20
returned error: No such device
ALSA lib confmisc.c:1251:(snd_func_refer) error evaluating name
ALSA lib conf.c:3510:(_snd_config_evaluate) function snd_func_refer=20
returned error: No such device
ALSA lib conf.c:3982:(snd_config_expand) Evaluate error: No such device
ALSA lib pcm.c:2144:(snd_pcm_open_noupdate) Unknown PCM dmix

** WARNING **: alsa_setup(): Failed to open pcm device (default): No=20
such device
matt@giant:~$

Neverwinter Nights also reports that no card can be found.

gnome-sound-properties fails when ALSA is selected with:

matt@giant:~$ gnome-sound-properties
sound-properties-Message: Error running pipeline 'audiotestsrc wave=3Dsin=
e=20
freq=3D512 ! audioconvert ! audioresample ! gconfaudiosink': Internal=20
GStreamer error: state change failed.  Please file a bug at=20
http://bugzilla.gnome.org/enter_bug.cgi?product=3DGStreamer.=20
[gstswitchsink.c(155): gst_switch_commit_new_kid ():=20
/pipeline0/gconfaudiosink0:
Failed to set state on new child.]
matt@giant:~$

I hope I have provided enough relevant information.

Many thanks,

Matt Grice



------------=_1189538827-28956-0
Content-Type: message/rfc822
Content-Disposition: inline
Content-Transfer-Encoding: 7bit

Received: (at 438886-done) by bugs.debian.org; 11 Sep 2007 19:24:58 +0000
X-Spam-Checker-Version: SpamAssassin 3.1.4-bugs.debian.org_2005_01_02
	(2006-07-26) on rietz.debian.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=4.0 tests=BAYES_00,FORGED_RCVD_HELO,
	HAS_BUG_NUMBER autolearn=no version=3.1.4-bugs.debian.org_2005_01_02
Return-path: <riesebie@lxtec.de>
Received: from smtpout.hostsharing.net ([83.223.95.15])
	by rietz.debian.org with esmtp (Exim 4.50)
	id 1IVBM2-00078B-Ll; Tue, 11 Sep 2007 19:24:58 +0000
Received: from h01.hostsharing.net (h01.hostsharing.net [212.42.230.152])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(No client certificate requested)
	by smtpout.hostsharing.net (Postfix) with ESMTP id D57052000077;
	Tue, 11 Sep 2007 21:24:57 +0200 (CEST)
Received: from mail.home.lxtec.de (p5B145E40.dip.t-dialin.net [91.20.94.64])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(No client certificate requested)
	by h01.hostsharing.net (Postfix) with ESMTP id 962491621406E;
	Tue, 11 Sep 2007 21:24:57 +0200 (CEST)
Received: from localhost ([127.0.0.1])
	by mail.home.lxtec.de with esmtp (Exim 4.68 1 (LXTEC))
	id 1IVBM0-0006X3-RB; Tue, 11 Sep 2007 21:24:56 +0200
X-Virus-Scanned: amavisd-new 2.4.2 (Debian/LXTEC) at mail.home.lxtec.de
Received: from mail.home.lxtec.de ([127.0.0.1])
	by localhost (mail.home.lxtec.de [127.0.0.1]) (amavisd-new, port 10024)
	with ESMTP id JwR-e6Sywca6; Tue, 11 Sep 2007 21:24:53 +0200 (CEST)
Received: from frodo.home.lxtec.de ([192.168.200.202] ident=Debian-exim)
	by mail.home.lxtec.de with esmtps (Exim 4.68 1 (LXTEC))
	id 1IVBLx-0006Wr-3D; Tue, 11 Sep 2007 21:24:53 +0200
Received: from riesebie by frodo.home.lxtec.de with local (Exim 4.68 1 (LXTEC))
	id 1IVBLw-0003X3-Vg; Tue, 11 Sep 2007 21:24:52 +0200
Date: Tue, 11 Sep 2007 21:24:52 +0200
From: Elimar Riesebieter <riesebie@lxtec.de>
To: Matthew Grice <matt@woodwaysolutions.co.uk>
Cc: Dan Chen <crimsunkg@yahoo.com>, 438886@bugs.debian.org,
	438886-done@bugs.debian.org
Subject: Re: Bug#438886: [Pkg-alsa-devel] Bug#438886: alsa-base: alsa
	modules loaded but /proc/asound/cards remains empty
Message-ID: <20070911192452.GR17585@frodo.home.lxtec.de>
References: <413368.59249.qm@web51112.mail.re2.yahoo.com> <46C9CC56.5070401@woodwaysolutions.co.uk>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
	protocol="application/pgp-signature"; boundary="//IivP0gvsAy3Can"
Content-Disposition: inline
In-Reply-To: <46C9CC56.5070401@woodwaysolutions.co.uk>
Organization: LXTEC
X-gnupg-key-fingerprint: BE65 85E4 4867 7E9B 1F2A  B2CE DC88 3C6E C54F 7FB0
X-Editor: VIM - Vi IMproved 7.1 (2007 May 12, compiled Sep  2 2007 20:07:10)
User-Agent: Mutt/1.5.16+lxtec (2007-09-05)


--//IivP0gvsAy3Can
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, 20 Aug 2007 the mental interface of
Matthew Grice told:

> Dan Chen wrote:
>> Ensure the OSS/Free module (via82cxxx_audio) isn't loaded concurrently.
>>
>> -Dan
>>
>> ----- Original Message ----
>> From: Matthew Grice <matt@woodwaysolutions.co.uk>
>> To: submit@bugs.debian.org
>> Sent: Monday, August 20, 2007 11:04:13 AM
>> Subject: [Pkg-alsa-devel] Bug#438886: alsa-base: alsa modules loaded but=
=20
>> /proc/asound/cards remains empty
>> [...]
>> matt@giant:~$ dmesg | grep [Vv][Ii][Aa]82
>> via82cxxx: Six channel audio available
>> via82cxxx: Codec rate locked at 48Khz
>> via82cxxx: board #1 at 0xDC00, IRQ 193
>> via82cxxx: Six channel audio available
>> via82cxxx: Codec rate locked at 48Khz
>> via82cxxx: board #1 at 0xDC00, IRQ 193
>> [...]
>
>
> Many thanks.
>
> It turns out that an external kernel module that I compiled created a=20
> modprobe.conf file to add an alias. This prevented the modprobe system fr=
om=20
> reading the /etc/modprobe.d/ directory and thus the blacklist file that=
=20
> prevented the loading of the OSS drivers.
>
> Deepest thanks for all of your help.

Bug closed ;)

Elimar


--=20
  Experience is something you don't get until=20
  just after you need it!

--//IivP0gvsAy3Can
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: Digital signature
Content-Disposition: inline

-----BEGIN PGP SIGNATURE-----
Version: GnuPG v1.4.6 (GNU/Linux)

iD8DBQFG5uuE3Ig8bsVPf7ARAmweAJ0S8pxpq2gyJXyWBEwQBP7JMnfNewCZAZfP
pD9Wv+2m2mJZVbBNt6fQbt0=
=0k12
-----END PGP SIGNATURE-----

--//IivP0gvsAy3Can--


------------=_1189538827-28956-0
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
Alsa-devel mailing list
Alsa-devel@alsa-project.org
http://mailman.alsa-project.org/mailman/listinfo/alsa-devel

------------=_1189538827-28956-0--
